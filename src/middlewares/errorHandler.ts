import { NextFunction, Request, Response } from 'express';
import { ZodError } from 'zod';
import multer from 'multer';
import { ApiError } from '../utils/ApiError';
import { logger } from '../utils/logger';

export function notFoundHandler(req: Request, res: Response) {
  res.status(404).json({ error: { message: `Route not found: ${req.method} ${req.originalUrl}` } });
}

// eslint-disable-next-line @typescript-eslint/no-unused-vars
export function errorHandler(err: unknown, req: Request, res: Response, _next: NextFunction) {
  if (err instanceof ZodError) {
    return res.status(400).json({
      error: { message: 'Validation failed', details: err.flatten() },
    });
  }

  if (err instanceof multer.MulterError) {
    // Upload-limit / unexpected-field problems are the client's doing -> 4xx, never a 500.
    const tooLarge = err.code === 'LIMIT_FILE_SIZE';
    return res.status(tooLarge ? 413 : 400).json({
      error: { message: tooLarge ? 'Uploaded file is too large' : `Upload rejected: ${err.message}` },
    });
  }

  if (err instanceof ApiError) {
    if (!err.isOperational || err.statusCode >= 500) {
      logger.error({ err, path: req.path }, 'Operational API error (5xx)');
    }
    return res.status(err.statusCode).json({
      error: { message: err.message, details: err.details },
    });
  }

  // Postgres-specific error mapping for common integrity violations
  const pgErr = err as { code?: string; detail?: string; constraint?: string };
  if (pgErr?.code === '23505') {
    return res.status(409).json({ error: { message: 'Duplicate resource', details: pgErr.detail } });
  }
  if (pgErr?.code === '23503') {
    return res.status(409).json({ error: { message: 'Referenced resource does not exist', details: pgErr.detail } });
  }
  if (pgErr?.code === '22P02') {
    // invalid_text_representation, e.g. a malformed uuid reaching a uuid column.
    // Client input problem -> 400, not a 500. Detail intentionally not echoed back.
    return res.status(400).json({ error: { message: 'Malformed identifier or value' } });
  }
  if (pgErr?.code === '23514') {
    return res.status(400).json({ error: { message: 'Value violates a database constraint', details: pgErr.detail } });
  }

  logger.error({ err, path: req.path }, 'Unhandled error');
  return res.status(500).json({ error: { message: 'Internal server error' } });
}
