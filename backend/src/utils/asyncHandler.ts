import { NextFunction, Request, Response } from 'express';

type Handler = (req: Request, res: Response, next: NextFunction) => Promise<unknown>;

/**
 * Wraps an async route handler so a rejection is forwarded to `next()` (and
 * therefore the central error handler) instead of becoming an unhandled
 * rejection. The returned promise always resolves to `undefined`, which makes
 * the wrapper awaitable in tests and never leaks the handler's return value.
 */
export const asyncHandler =
  (fn: Handler) =>
  (req: Request, res: Response, next: NextFunction): Promise<void> =>
    fn(req, res, next)
      .then(() => undefined)
      .catch(next);
