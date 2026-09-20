import { NextFunction, Request, Response } from 'express';
import { fromNodeHeaders } from 'better-auth/node';
import { auth } from '../lib/auth';
import { ApiError } from '../utils/ApiError';
import { logger } from '../utils/logger';

/**
 * Requires a valid session, sent either as `Authorization: Bearer <token>`
 * (the `bearer` plugin in lib/auth.ts) or as better-auth's own session
 * cookie. Delegates entirely to better-auth's `getSession` -- no token
 * verification logic lives in this codebase anymore.
 */
export async function requireAuth(req: Request, _res: Response, next: NextFunction) {
  try {
    const result = await auth.api.getSession({ headers: fromNodeHeaders(req.headers) });
    if (!result?.session || !result?.user) {
      return next(ApiError.unauthorized('Missing or invalid session'));
    }

    const user = result.user as typeof result.user & {
      role?: 'student' | 'admin';
      isActive?: boolean;
    };

    if (user.isActive === false) {
      return next(ApiError.unauthorized('Account is no longer active'));
    }

    req.user = {
      sub: user.id,
      role: user.role ?? 'student',
      email: user.email,
      fullName: user.name,
    };
    req.sessionId = result.session.id;
    next();
  } catch (err) {
    logger.warn({ err }, 'Session lookup failed');
    next(ApiError.unauthorized('Invalid or expired session'));
  }
}

/** Restricts a route to one or more roles. Must run after requireAuth. */
export function requireRole(...roles: Array<'student' | 'admin'>) {
  return (req: Request, _res: Response, next: NextFunction) => {
    if (!req.user) return next(ApiError.unauthorized());
    if (!roles.includes(req.user.role)) return next(ApiError.forbidden('Insufficient role'));
    next();
  };
}

/**
 * A student may only act on their own resources unless they're an admin.
 * `paramName` is the route param carrying the target user id.
 */
export function requireSelfOrAdmin(paramName = 'userId') {
  return (req: Request, _res: Response, next: NextFunction) => {
    if (!req.user) return next(ApiError.unauthorized());
    const targetUserId = req.params[paramName];
    if (req.user.role === 'admin' || req.user.sub === targetUserId) return next();
    next(ApiError.forbidden("Cannot access another user's resource"));
  };
}
