import { describe, it, expect, vi, beforeEach } from 'vitest';
import request from 'supertest';

const getSessionMock = vi.fn();
vi.mock('../../src/lib/auth', () => ({
  auth: { api: { getSession: (...args: any[]) => getSessionMock(...args) } },
}));

// vi.mock() factories are hoisted above module-level consts; vi.hoisted() keeps
// this object initialised in time for the factory below (avoids a TDZ ReferenceError).
const repoMock = vi.hoisted(() => ({
  getProfile: vi.fn(),
  getTargetCompanies: vi.fn(),
  getStreak: vi.fn(),
  replaceTargetCompanies: vi.fn(),
  getActivityHeatmap: vi.fn(),
}));
vi.mock('../../src/modules/users/users.repository', () => repoMock);

import { createApp } from '../../src/app';

const app = createApp();

const STUDENT_1 = { id: 'user-1', email: 's1@x.com', name: 'Student One', role: 'student', isActive: true };
const STUDENT_2 = { id: 'user-2', email: 's2@x.com', name: 'Student Two', role: 'student', isActive: true };
const ADMIN = { id: 'admin-1', email: 'admin@x.com', name: 'Admin', role: 'admin', isActive: true };

function asUser(user: typeof STUDENT_1) {
  getSessionMock.mockResolvedValue({ session: { id: 'sess' }, user });
  return { Authorization: 'Bearer token-for-' + user.id };
}

// NOTE: fixture UUIDs must be RFC 4122-valid (version nibble 1-8, variant nibble 8/9/a/b).
// Zod 4's z.string().uuid() enforces that (Zod 3 did not), and every real id in this
// system is a v4 UUID from gen_random_uuid()/crypto.randomUUID().
describe('GET /api/v1/users/:userId', () => {
  const VALID_UUID = '11111111-1111-4111-8111-111111111111';

  beforeEach(() => {
    getSessionMock.mockReset();
    Object.values(repoMock).forEach((fn) => fn.mockReset());
    repoMock.getProfile.mockResolvedValue({ id: VALID_UUID, email: 's1@x.com', full_name: 'Student One' });
    repoMock.getTargetCompanies.mockResolvedValue([]);
    repoMock.getStreak.mockResolvedValue({ current_streak: 0, longest_streak: 0, last_active_date: null });
  });

  it('401s with no session at all', async () => {
    const res = await request(app).get(`/api/v1/users/${VALID_UUID}`);
    expect(res.status).toBe(401);
  });

  it('400s on a non-uuid userId (validated before auth-ownership check)', async () => {
    const headers = asUser({ ...STUDENT_1, id: VALID_UUID });
    const res = await request(app).get('/api/v1/users/not-a-uuid').set(headers);
    expect(res.status).toBe(400);
  });

  it('200s when a student requests their own profile', async () => {
    const headers = asUser({ ...STUDENT_1, id: VALID_UUID });
    const res = await request(app).get(`/api/v1/users/${VALID_UUID}`).set(headers);
    expect(res.status).toBe(200);
    expect(res.body.profile.id).toBe(VALID_UUID);
  });

  it("403s when a student requests a DIFFERENT student's profile", async () => {
    const headers = asUser(STUDENT_2); // logged in as user-2, but requesting VALID_UUID (user-1)
    const res = await request(app).get(`/api/v1/users/${VALID_UUID}`).set(headers);
    expect(res.status).toBe(403);
  });

  it("200s when an admin requests ANY student's profile", async () => {
    const headers = asUser(ADMIN);
    const res = await request(app).get(`/api/v1/users/${VALID_UUID}`).set(headers);
    expect(res.status).toBe(200);
  });

  it('404s when the profile does not exist', async () => {
    repoMock.getProfile.mockResolvedValue(null);
    const headers = asUser({ ...STUDENT_1, id: VALID_UUID });
    const res = await request(app).get(`/api/v1/users/${VALID_UUID}`).set(headers);
    expect(res.status).toBe(404);
  });
});

describe('PUT /api/v1/users/:userId/target-companies', () => {
  const VALID_UUID = '22222222-2222-4222-8222-222222222222';
  const TIER_ID = '33333333-3333-4333-8333-333333333333';

  beforeEach(() => {
    getSessionMock.mockReset();
    Object.values(repoMock).forEach((fn) => fn.mockReset());
    repoMock.replaceTargetCompanies.mockResolvedValue(undefined);
    repoMock.getTargetCompanies.mockResolvedValue([{ company_tier_id: TIER_ID }]);
  });

  it("403s when a student tries to edit someone else's targets", async () => {
    const headers = asUser(STUDENT_2);
    const res = await request(app)
      .put(`/api/v1/users/${VALID_UUID}/target-companies`)
      .set(headers)
      .send({ target_company_tier_ids: [TIER_ID] });
    expect(res.status).toBe(403);
    expect(repoMock.replaceTargetCompanies).not.toHaveBeenCalled();
  });

  it('200s and replaces targets when a student edits their own', async () => {
    const headers = asUser({ ...STUDENT_1, id: VALID_UUID });
    const res = await request(app)
      .put(`/api/v1/users/${VALID_UUID}/target-companies`)
      .set(headers)
      .send({ target_company_tier_ids: [TIER_ID] });
    expect(res.status).toBe(200);
    expect(repoMock.replaceTargetCompanies).toHaveBeenCalledWith(VALID_UUID, [TIER_ID]);
  });

  it('400s on an empty target list (schema requires at least one)', async () => {
    const headers = asUser({ ...STUDENT_1, id: VALID_UUID });
    const res = await request(app)
      .put(`/api/v1/users/${VALID_UUID}/target-companies`)
      .set(headers)
      .send({ target_company_tier_ids: [] });
    expect(res.status).toBe(400);
  });
});
