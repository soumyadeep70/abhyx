import { describe, it, expect } from 'vitest';
import { ApiError } from '../../../src/utils/ApiError';

describe('ApiError', () => {
  it('badRequest carries 400 and details', () => {
    const err = ApiError.badRequest('bad input', { field: 'email' });
    expect(err.statusCode).toBe(400);
    expect(err.message).toBe('bad input');
    expect(err.details).toEqual({ field: 'email' });
    expect(err.isOperational).toBe(true);
    expect(err).toBeInstanceOf(Error);
  });

  it.each([
    ['unauthorized', 401, 'Unauthorized'],
    ['forbidden', 403, 'Forbidden'],
    ['notFound', 404, 'Not found'],
    ['tooManyRequests', 429, 'Too many requests'],
    ['internal', 500, 'Internal server error'],
    ['badGateway', 502, 'Upstream service error'],
  ] as const)('%s() defaults to status %i with message %j', (factory, status, message) => {
    const err = (ApiError as any)[factory]();
    expect(err.statusCode).toBe(status);
    expect(err.message).toBe(message);
  });

  it('conflict() requires an explicit message', () => {
    const err = ApiError.conflict('duplicate email');
    expect(err.statusCode).toBe(409);
    expect(err.message).toBe('duplicate email');
  });

  it('custom messages override the defaults', () => {
    expect(ApiError.unauthorized('nope').message).toBe('nope');
    expect(ApiError.notFound('gone').message).toBe('gone');
  });

  it('captures a stack trace', () => {
    const err = ApiError.internal();
    expect(err.stack).toBeTruthy();
  });
});
