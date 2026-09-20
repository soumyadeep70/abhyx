import { describe, it, expect } from 'vitest';
import express from 'express';
import request from 'supertest';
import { z } from 'zod';
import { notFoundHandler, errorHandler } from '../../src/middlewares/errorHandler';
import { ApiError } from '../../src/utils/ApiError';

// A small standalone app, independent of the real route tree, so these
// assertions are only about errorHandler's own mapping logic.
function buildTestApp() {
  const app = express();
  app.use(express.json());

  app.get('/boom/api-error', () => {
    throw ApiError.forbidden('nope');
  });
  app.get('/boom/zod', () => {
    z.object({ email: z.string().email() }).parse({ email: 'not-an-email' });
  });
  app.get('/boom/unique-violation', () => {
    const err: any = new Error('duplicate key value violates unique constraint');
    err.code = '23505';
    err.detail = 'Key (email)=(a@x.com) already exists.';
    throw err;
  });
  app.get('/boom/fk-violation', () => {
    const err: any = new Error('violates foreign key constraint');
    err.code = '23503';
    throw err;
  });
  app.get('/boom/check-violation', () => {
    const err: any = new Error('violates check constraint');
    err.code = '23514';
    throw err;
  });
  app.get('/boom/invalid-text-representation', () => {
    const err: any = new Error('invalid input syntax for type uuid: "abc"');
    err.code = '22P02';
    throw err;
  });
  app.get('/boom/unknown', () => {
    throw new Error('something unexpected');
  });

  app.use(notFoundHandler);
  app.use(errorHandler);
  return app;
}

const app = buildTestApp();

describe('errorHandler', () => {
  it('maps ApiError to its own status code and message', async () => {
    const res = await request(app).get('/boom/api-error');
    expect(res.status).toBe(403);
    expect(res.body).toEqual({ error: { message: 'nope', details: undefined } });
  });

  it('maps a ZodError to 400 with flattened validation details', async () => {
    const res = await request(app).get('/boom/zod');
    expect(res.status).toBe(400);
    expect(res.body.error.message).toBe('Validation failed');
    expect(res.body.error.details).toHaveProperty('fieldErrors');
  });

  it('maps a Postgres unique-violation (23505) to 409', async () => {
    const res = await request(app).get('/boom/unique-violation');
    expect(res.status).toBe(409);
    expect(res.body.error.message).toBe('Duplicate resource');
  });

  it('maps a Postgres foreign-key violation (23503) to 409', async () => {
    const res = await request(app).get('/boom/fk-violation');
    expect(res.status).toBe(409);
    expect(res.body.error.message).toMatch(/does not exist/);
  });

  it('maps a Postgres check-constraint violation (23514) to 400', async () => {
    const res = await request(app).get('/boom/check-violation');
    expect(res.status).toBe(400);
  });

  it('falls back to a generic 500 for anything unrecognized, without leaking internals', async () => {
    const res = await request(app).get('/boom/unknown');
    expect(res.status).toBe(500);
    expect(res.body).toEqual({ error: { message: 'Internal server error' } });
    expect(res.text).not.toMatch(/something unexpected/);
  });

  it('returns a 404 envelope for unmatched routes', async () => {
    const res = await request(app).get('/does-not-exist');
    expect(res.status).toBe(404);
    expect(res.body.error.message).toContain('GET /does-not-exist');
  });

  it('maps Postgres 22P02 (malformed uuid etc.) to 400 without leaking the driver message', async () => {
    const res = await request(app).get('/boom/invalid-text-representation');
    expect(res.status).toBe(400);
    expect(res.body.error.message).toBe('Malformed identifier or value');
    expect(JSON.stringify(res.body)).not.toContain('invalid input syntax');
  });
});
