import { describe, it, expect, vi, beforeEach } from 'vitest';

const getSessionMock = vi.fn();

vi.mock('../../../src/lib/auth', () => ({
  auth: { api: { getSession: (...args: any[]) => getSessionMock(...args) } },
}));

// requireAuth/requireRole/requireSelfOrAdmin are imported AFTER the mock above
// is registered, so they pick up the mocked `auth` instance.
import { requireAuth, requireRole, requireSelfOrAdmin } from '../../../src/middlewares/auth';
import { ApiError } from '../../../src/utils/ApiError';

function mockReqResNext(headers: Record<string, string> = {}) {
  return {
    req: { headers, params: {} as Record<string, string> } as any,
    res: {} as any,
    next: vi.fn(),
  };
}

const STUDENT_SESSION = {
  session: { id: 'sess-1' },
  user: { id: 'user-1', email: 's@example.com', name: 'Stu Dent', role: 'student', isActive: true },
};
const ADMIN_SESSION = {
  session: { id: 'sess-2' },
  user: { id: 'admin-1', email: 'a@example.com', name: 'Admin User', role: 'admin', isActive: true },
};

describe('requireAuth', () => {
  beforeEach(() => {
    getSessionMock.mockReset();
  });

  it('populates req.user from a valid session, keeping the sub/role/email shape', async () => {
    getSessionMock.mockResolvedValue(STUDENT_SESSION);
    const { req, res, next } = mockReqResNext({ authorization: 'Bearer valid-token' });

    await requireAuth(req, res, next);

    expect(req.user).toEqual({
      sub: 'user-1',
      role: 'student',
      email: 's@example.com',
      fullName: 'Stu Dent',
    });
    expect(req.sessionId).toBe('sess-1');
    expect(next).toHaveBeenCalledWith(); // called with no error
  });

  it('rejects with 401 when there is no session', async () => {
    getSessionMock.mockResolvedValue(null);
    const { req, res, next } = mockReqResNext();

    await requireAuth(req, res, next);

    expect(req.user).toBeUndefined();
    expect(next).toHaveBeenCalledTimes(1);
    const err = next.mock.calls[0][0] as ApiError;
    expect(err).toBeInstanceOf(ApiError);
    expect(err.statusCode).toBe(401);
  });

  it('rejects with 401 when the session lookup throws', async () => {
    getSessionMock.mockRejectedValue(new Error('network blip'));
    const { req, res, next } = mockReqResNext();

    await requireAuth(req, res, next);

    const err = next.mock.calls[0][0] as ApiError;
    expect(err.statusCode).toBe(401);
  });

  it('rejects a session for a deactivated account', async () => {
    getSessionMock.mockResolvedValue({
      session: { id: 'sess-3' },
      user: { id: 'user-2', email: 'x@example.com', name: 'X', role: 'student', isActive: false },
    });
    const { req, res, next } = mockReqResNext();

    await requireAuth(req, res, next);

    const err = next.mock.calls[0][0] as ApiError;
    expect(err.statusCode).toBe(401);
    expect(err.message).toMatch(/no longer active/i);
  });

  it('defaults role to student if the session user has none set', async () => {
    getSessionMock.mockResolvedValue({
      session: { id: 'sess-4' },
      user: { id: 'user-3', email: 'y@example.com', name: 'Y' },
    });
    const { req, res, next } = mockReqResNext();

    await requireAuth(req, res, next);

    expect(req.user?.role).toBe('student');
  });
});

describe('requireRole', () => {
  it('allows a user whose role is in the allow-list', () => {
    const { req, res, next } = mockReqResNext();
    req.user = { sub: 'u1', role: 'admin', email: 'a@x.com', fullName: 'A' };

    requireRole('admin', 'student')(req, res, next);

    expect(next).toHaveBeenCalledWith();
  });

  it('forbids a user whose role is not in the allow-list', () => {
    const { req, res, next } = mockReqResNext();
    req.user = { sub: 'u1', role: 'student', email: 's@x.com', fullName: 'S' };

    requireRole('admin')(req, res, next);

    const err = next.mock.calls[0][0] as ApiError;
    expect(err.statusCode).toBe(403);
  });

  it('401s if requireAuth never ran (no req.user)', () => {
    const { req, res, next } = mockReqResNext();

    requireRole('admin')(req, res, next);

    const err = next.mock.calls[0][0] as ApiError;
    expect(err.statusCode).toBe(401);
  });
});

describe('requireSelfOrAdmin', () => {
  it('allows a student acting on their own resource', () => {
    const { req, res, next } = mockReqResNext();
    req.user = { sub: 'user-1', role: 'student', email: 's@x.com', fullName: 'S' };
    req.params.userId = 'user-1';

    requireSelfOrAdmin()(req, res, next);

    expect(next).toHaveBeenCalledWith();
  });

  it('forbids a student acting on a different user\'s resource', () => {
    const { req, res, next } = mockReqResNext();
    req.user = { sub: 'user-1', role: 'student', email: 's@x.com', fullName: 'S' };
    req.params.userId = 'user-2';

    requireSelfOrAdmin()(req, res, next);

    const err = next.mock.calls[0][0] as ApiError;
    expect(err.statusCode).toBe(403);
  });

  it('allows an admin acting on any resource', () => {
    const { req, res, next } = mockReqResNext();
    req.user = { sub: 'admin-1', role: 'admin', email: 'a@x.com', fullName: 'A' };
    req.params.userId = 'someone-else';

    requireSelfOrAdmin()(req, res, next);

    expect(next).toHaveBeenCalledWith();
  });

  it('honors a custom param name', () => {
    const { req, res, next } = mockReqResNext();
    req.user = { sub: 'user-1', role: 'student', email: 's@x.com', fullName: 'S' };
    req.params.ownerId = 'user-1';

    requireSelfOrAdmin('ownerId')(req, res, next);

    expect(next).toHaveBeenCalledWith();
  });
});
