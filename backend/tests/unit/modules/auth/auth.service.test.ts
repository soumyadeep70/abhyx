import { describe, it, expect, vi, beforeEach } from 'vitest';

const signUpEmailMock = vi.fn();
const signInEmailMock = vi.fn();
const signOutMock = vi.fn();
const getSessionMock = vi.fn();
const attachOnboardingMock = vi.fn();

vi.mock('../../../../src/lib/auth', () => ({
  auth: {
    api: {
      signUpEmail: (...args: any[]) => signUpEmailMock(...args),
      signInEmail: (...args: any[]) => signInEmailMock(...args),
      signOut: (...args: any[]) => signOutMock(...args),
      getSession: (...args: any[]) => getSessionMock(...args),
    },
  },
}));

vi.mock('../../../../src/modules/auth/auth.repository', () => ({
  attachOnboarding: (...args: any[]) => attachOnboardingMock(...args),
}));

import * as authService from '../../../../src/modules/auth/auth.service';
import { ApiError } from '../../../../src/utils/ApiError';

const HEADERS = { authorization: 'Bearer whatever' };

describe('authService.register', () => {
  beforeEach(() => {
    signUpEmailMock.mockReset();
    attachOnboardingMock.mockReset();
  });

  it('creates the account then runs onboarding, returning the public user + token', async () => {
    signUpEmailMock.mockResolvedValue({
      user: { id: 'u1', email: 'a@x.com', name: 'A B', role: 'student', college: 'MIT', graduationYear: 2026 },
      token: 'session-token-abc',
    });
    attachOnboardingMock.mockResolvedValue(undefined);

    const result = await authService.register(
      {
        email: 'a@x.com',
        password: 'password123',
        full_name: 'A B',
        college: 'MIT',
        graduation_year: 2026,
        target_company_tier_ids: ['tier-1', 'tier-2'],
      },
      HEADERS
    );

    expect(signUpEmailMock).toHaveBeenCalledWith(
      expect.objectContaining({
        body: expect.objectContaining({ email: 'a@x.com', name: 'A B', college: 'MIT', graduationYear: 2026 }),
      })
    );
    expect(attachOnboardingMock).toHaveBeenCalledWith({ userId: 'u1', targetCompanyTierIds: ['tier-1', 'tier-2'] });
    expect(result).toEqual({
      user: { id: 'u1', email: 'a@x.com', full_name: 'A B', role: 'student', college: 'MIT', graduation_year: 2026 },
      token: 'session-token-abc',
    });
  });

  it('maps a duplicate-email failure from better-auth onto a 409/409-like ApiError', async () => {
    signUpEmailMock.mockRejectedValue({ status: 'UNPROCESSABLE_ENTITY', body: { message: 'User already exists' } });

    await expect(
      authService.register(
        { email: 'dupe@x.com', password: 'password123', full_name: 'Dupe', target_company_tier_ids: [] },
        HEADERS
      )
    ).rejects.toMatchObject({ statusCode: 409, message: 'User already exists' });

    expect(attachOnboardingMock).not.toHaveBeenCalled();
  });

  it('throws a 500 (without leaving onboarding silently skipped) if better-auth omits a token', async () => {
    signUpEmailMock.mockResolvedValue({ user: { id: 'u2', email: 'b@x.com', name: 'B' } /* no token */ });

    await expect(
      authService.register(
        { email: 'b@x.com', password: 'password123', full_name: 'B', target_company_tier_ids: [] },
        HEADERS
      )
    ).rejects.toMatchObject({ statusCode: 500 });

    expect(attachOnboardingMock).not.toHaveBeenCalled();
  });

  it('surfaces a 500 if onboarding fails after the account was created', async () => {
    signUpEmailMock.mockResolvedValue({ user: { id: 'u3', email: 'c@x.com', name: 'C' }, token: 'tok' });
    attachOnboardingMock.mockRejectedValue(new Error('db down'));

    await expect(
      authService.register(
        { email: 'c@x.com', password: 'password123', full_name: 'C', target_company_tier_ids: ['t1'] },
        HEADERS
      )
    ).rejects.toMatchObject({ statusCode: 500 });
  });
});

describe('authService.login', () => {
  beforeEach(() => {
    signInEmailMock.mockReset();
  });

  it('returns the public user + token on success', async () => {
    signInEmailMock.mockResolvedValue({
      user: { id: 'u1', email: 'a@x.com', name: 'A', role: 'student' },
      token: 'tok-123',
    });

    const result = await authService.login({ email: 'a@x.com', password: 'password123' }, HEADERS);

    expect(result.token).toBe('tok-123');
    expect(result.user.email).toBe('a@x.com');
  });

  it('maps invalid credentials to a 401', async () => {
    signInEmailMock.mockRejectedValue({ status: 'UNAUTHORIZED', body: { message: 'Invalid email or password' } });

    await expect(authService.login({ email: 'a@x.com', password: 'wrong' }, HEADERS)).rejects.toMatchObject({
      statusCode: 401,
    });
  });
});

describe('authService.refresh', () => {
  beforeEach(() => {
    getSessionMock.mockReset();
  });

  it('returns the current (possibly slid-forward) session state', async () => {
    const expiresAt = new Date('2030-01-01T00:00:00Z');
    getSessionMock.mockResolvedValue({
      user: { id: 'u1', email: 'a@x.com', name: 'A', role: 'student' },
      session: { token: 'still-valid-token', expiresAt },
    });

    const result = await authService.refresh(HEADERS);

    expect(result).toEqual({
      user: { id: 'u1', email: 'a@x.com', full_name: 'A', role: 'student', college: null, graduation_year: null },
      token: 'still-valid-token',
      expires_at: expiresAt,
    });
  });

  it('401s when there is no session to refresh', async () => {
    getSessionMock.mockResolvedValue(null);

    await expect(authService.refresh(HEADERS)).rejects.toMatchObject({ statusCode: 401 });
  });
});

describe('authService.logout', () => {
  it('calls signOut and does not throw', async () => {
    signOutMock.mockResolvedValue(undefined);
    await expect(authService.logout(HEADERS)).resolves.toBeUndefined();
    expect(signOutMock).toHaveBeenCalled();
  });

  it('swallows an error from signOut (logging out twice is not a failure)', async () => {
    signOutMock.mockRejectedValue(new Error('session already gone'));
    await expect(authService.logout(HEADERS)).resolves.toBeUndefined();
  });
});
