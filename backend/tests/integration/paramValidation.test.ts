import { describe, it, expect, vi, beforeEach } from 'vitest';
import request from 'supertest';

const getSessionMock = vi.fn();
vi.mock('../../src/lib/auth', () => ({
  auth: { api: { getSession: (...args: any[]) => getSessionMock(...args) } },
}));

import { createApp } from '../../src/app';

const app = createApp();

/**
 * Regression guard: every route that takes an id param must reject a
 * malformed id with a 400 *before* it reaches Postgres. Previously
 * GET /companies/tiers/:tierId and GET /users/:userId/badges skipped
 * validate(), so a bad id surfaced as a 500 from a `22P02` driver error.
 */
describe('malformed id params are rejected with 400 (not 500)', () => {
  const headers = { Authorization: 'Bearer t' };

  beforeEach(() => {
    getSessionMock.mockReset();
    getSessionMock.mockResolvedValue({
      session: { id: 'sess' },
      user: { id: 'admin-1', email: 'a@x.com', name: 'Admin', role: 'admin', isActive: true },
    });
  });

  it('GET /companies/tiers/:tierId', async () => {
    const res = await request(app).get('/api/v1/companies/tiers/not-a-uuid').set(headers);
    expect(res.status).toBe(400);
  });

  it('GET /users/:userId/badges', async () => {
    const res = await request(app).get('/api/v1/users/not-a-uuid/badges').set(headers);
    expect(res.status).toBe(400);
  });

  it('still 401s an unauthenticated caller before validating anything', async () => {
    getSessionMock.mockResolvedValue(null);
    const res = await request(app).get('/api/v1/companies/tiers/not-a-uuid');
    expect(res.status).toBe(401);
  });
});
