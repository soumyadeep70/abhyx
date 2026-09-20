import { Request } from 'express';
import { ApiError } from './ApiError';

/**
 * Reads a route parameter as a plain string.
 *
 * Express 5's typings declare `req.params[name]` as `string | string[]`
 * (wildcard segments like `/*splat` resolve to arrays), so passing
 * `req.params.userId` straight into a function that wants a `string` no
 * longer compiles. Every route in this codebase that reads a param goes
 * through `validate({ params })` first, which already guarantees a string,
 * so this helper is mostly a type-narrowing step -- but it also fails
 * closed with a 400 (rather than letting an array or `undefined` reach a
 * SQL query) if a route ever forgets to validate.
 *
 * Throw-safe: call it inside `asyncHandler`, where the rejection is
 * forwarded to the error handler.
 */
export function getParam(req: Request, name: string): string {
  const value = req.params[name];
  if (typeof value !== 'string' || value.length === 0) {
    throw ApiError.badRequest(`Invalid or missing route parameter: ${name}`);
  }
  return value;
}
