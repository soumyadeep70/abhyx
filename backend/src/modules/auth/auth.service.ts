import { fromNodeHeaders } from 'better-auth/node';
import { auth } from '../../lib/auth';
import { ApiError } from '../../utils/ApiError';
import { logger } from '../../utils/logger';
import * as repo from './auth.repository';
import { RegisterInput, LoginInput } from './auth.schema';

/**
 * better-auth's `auth.api.*` methods throw an internal `APIError` (from
 * `better-auth/api`) rather than this app's `ApiError`. This maps it onto
 * our existing envelope ({ error: { message } }, via middlewares/errorHandler)
 * so callers of this service never need to know better-auth is involved.
 *
 * The exact shape of better-auth's error object can shift between minor
 * versions; this reads defensively off whatever's present rather than
 * assuming one specific field layout.
 */
function toApiError(err: unknown, fallbackMessage: string): ApiError {
  const anyErr = err as {
    status?: string;
    statusCode?: number;
    body?: { message?: string; code?: string };
    message?: string;
  };
  const message = anyErr?.body?.message ?? anyErr?.message ?? fallbackMessage;

  if (typeof anyErr?.statusCode === 'number') {
    return new ApiError(anyErr.statusCode, message);
  }
  switch (anyErr?.status) {
    case 'UNAUTHORIZED':
      return ApiError.unauthorized(message);
    case 'FORBIDDEN':
      return ApiError.forbidden(message);
    case 'NOT_FOUND':
      return ApiError.notFound(message);
    case 'CONFLICT':
    case 'UNPROCESSABLE_ENTITY':
      return ApiError.conflict(message);
    case 'BAD_REQUEST':
      return ApiError.badRequest(message);
    default:
      logger.warn({ err }, 'Unmapped better-auth error status; defaulting to 401');
      return ApiError.unauthorized(message);
  }
}

function toPublicUser(user: {
  id: string;
  email: string;
  name: string;
  role?: 'student' | 'admin';
  college?: string | null;
  graduationYear?: number | null;
}) {
  return {
    id: user.id,
    email: user.email,
    full_name: user.name,
    role: user.role ?? 'student',
    college: user.college ?? null,
    graduation_year: user.graduationYear ?? null,
  };
}

export async function register(input: RegisterInput, requestHeaders: Record<string, string | string[] | undefined>) {
  let result;
  try {
    result = await auth.api.signUpEmail({
      body: {
        email: input.email,
        password: input.password,
        name: input.full_name,
        college: input.college,
        graduationYear: input.graduation_year,
      },
      headers: fromNodeHeaders(requestHeaders as any),
      asResponse: false,
    });
  } catch (err) {
    throw toApiError(err, 'Registration failed');
  }

  const user = result.user as any;
  const token = (result as any).token as string | undefined;
  if (!token) {
    // Should not happen with the `bearer` plugin enabled; surfaced loudly
    // rather than silently returning a user with no usable session.
    logger.error({ userId: user?.id }, 'better-auth signUpEmail did not return a bearer token');
    throw ApiError.internal('Registration succeeded but no session could be issued');
  }

  try {
    await repo.attachOnboarding({ userId: user.id, targetCompanyTierIds: input.target_company_tier_ids });
  } catch (err) {
    logger.error({ err, userId: user.id }, 'Onboarding step failed after user creation');
    throw ApiError.internal('Account created but onboarding failed; please contact support');
  }

  return { user: toPublicUser(user), token };
}

export async function login(input: LoginInput, requestHeaders: Record<string, string | string[] | undefined>) {
  let result;
  try {
    result = await auth.api.signInEmail({
      body: { email: input.email, password: input.password },
      headers: fromNodeHeaders(requestHeaders as any),
      asResponse: false,
    });
  } catch (err) {
    throw toApiError(err, 'Invalid email or password');
  }

  const user = result.user as any;
  const token = (result as any).token as string | undefined;
  if (!token) {
    logger.error({ userId: user?.id }, 'better-auth signInEmail did not return a bearer token');
    throw ApiError.internal('Login succeeded but no session could be issued');
  }

  return { user: toPublicUser(user), token };
}

/**
 * There is no more explicit "rotate my refresh token" step: better-auth
 * sessions are sliding-expiry (see lib/auth.ts `session.updateAge`), so
 * simply asking for the current session via getSession both validates *and*
 * (when it's past updateAge) transparently extends it. This endpoint is
 * kept for API back-compat with clients that poll POST /auth/refresh, and
 * just reports the resulting session state.
 */
export async function refresh(requestHeaders: Record<string, string | string[] | undefined>) {
  const result = await auth.api.getSession({ headers: fromNodeHeaders(requestHeaders as any) });
  if (!result?.session || !result?.user) throw ApiError.unauthorized('No active session to refresh');
  return {
    user: toPublicUser(result.user as any),
    token: result.session.token,
    expires_at: result.session.expiresAt,
  };
}

export async function getCurrentUser(requestHeaders: Record<string, string | string[] | undefined>) {
  const result = await auth.api.getSession({ headers: fromNodeHeaders(requestHeaders as any) });
  if (!result?.user) throw ApiError.unauthorized('No active session');
  return toPublicUser(result.user as any);
}

export async function logout(requestHeaders: Record<string, string | string[] | undefined>) {
  try {
    await auth.api.signOut({ headers: fromNodeHeaders(requestHeaders as any) });
  } catch (err) {
    // signOut on an already-invalid/expired session is a no-op from the
    // caller's point of view -- logging out twice should never 500.
    logger.debug({ err }, 'signOut on an already-invalid session (ignored)');
  }
}
