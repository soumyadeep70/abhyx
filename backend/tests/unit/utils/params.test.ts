import { describe, it, expect } from 'vitest';
import type { Request } from 'express';
import { getParam } from '../../../src/utils/params';
import { ApiError } from '../../../src/utils/ApiError';

const reqWith = (params: Record<string, unknown>) => ({ params }) as unknown as Request;

describe('getParam', () => {
  it('returns a string route param as-is', () => {
    expect(getParam(reqWith({ userId: 'abc' }), 'userId')).toBe('abc');
  });

  it('throws a 400 ApiError when the param is missing', () => {
    expect.assertions(2);
    try {
      getParam(reqWith({}), 'userId');
    } catch (err) {
      expect(err).toBeInstanceOf(ApiError);
      expect((err as ApiError).statusCode).toBe(400);
    }
  });

  it('throws a 400 when Express 5 hands back an array (wildcard segment)', () => {
    expect(() => getParam(reqWith({ userId: ['a', 'b'] }), 'userId')).toThrowError(/userId/);
  });

  it('throws on an empty string', () => {
    expect(() => getParam(reqWith({ userId: '' }), 'userId')).toThrowError(ApiError);
  });
});
