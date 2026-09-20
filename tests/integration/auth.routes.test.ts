import { describe, it, expect, vi, beforeEach } from 'vitest';
import request from 'supertest';

const signUpEmailMock = vi.fn();
const signInEmailMock = vi.fn();
const signOutMock = vi.fn();
const getSessionMock = vi.fn();

vi.mock('../../src/lib/auth', () => ({
  auth: {
    api: {
      signUpEmail: (...args: any[]) => signUpEmailMock(...args),
      signInEmail: (...args: any[]) => signInEmailMock(...args),
      signOut: (...args: any[]) => signOutMock(...args),
      getSession: (...args: any[]) => getSessionMock(...args),
    },
  },
}));

const attachOnboardingMock = vi.fn();
vi.mock('../../src/modules/auth/auth.repository', () => ({
  attachOnboarding: (...args: any[]) => attachOnboardingMock(...args),
}));

import { createApp } from '../../src/app';

const app = createApp();

describe('POST /api/v1/auth/register', () => {
  beforeEach(() => {
    signUpEmailMock.mockReset();
    attachOnboardingMock.mockReset();
  });

  it('400s on an invalid body before ever touching better-auth', async () => {
    const res = await request(app).post('/api/v1/auth/register').send({ email: 'not-an-email' });
    expect(res.status).toBe(400);
    expect(signUpEmailMock).not.toHaveBeenCalled();
  });

  it('201s with the created user and a session token on a valid registration', async () => {
    signUpEmailMock.mockResolvedValue({
      user: { id: 'u1', email: 'new@student.com', name: 'New Student', role: 'student' },
      token: 'session-token-xyz',
    });
    attachOnboardingMock.mockResolvedValue(undefined);

    const res = await request(app).post('/api/v1/auth/register').send({
      email: 'new@student.com',
      password: 'password123',
      full_name: 'New Student',
    });

    expect(res.status).toBe(201);
    expect(res.body.token).toBe('session-token-xyz');
    expect(res.body.user.email).toBe('new@student.com');
    expect(res.body.user.role).toBe('student'); // never client-settable, see auth.schema.ts
  });

  it('409s when better-auth reports the email is already taken', async () => {
    signUpEmailMock.mockRejectedValue({ status: 'UNPROCESSABLE_ENTITY', body: { message: 'User already exists' } });

    const res = await request(app)
      .post('/api/v1/auth/register')
      .send({ email: 'dupe@student.com', password: 'password123', full_name: 'Dupe' });

    expect(res.status).toBe(409);
  });
});

describe('POST /api/v1/auth/login', () => {
  beforeEach(() => {
    signInEmailMock.mockReset();
  });

  it('200s with the user and token on valid credentials', async () => {
    signInEmailMock.mockResolvedValue({
      user: { id: 'u1', email: 'student@x.com', name: 'S', role: 'student' },
      token: 'session-token-abc',
    });

    const res = await request(app).post('/api/v1/auth/login').send({ email: 'student@x.com', password: 'password123' });

    expect(res.status).toBe(200);
    expect(res.body.token).toBe('session-token-abc');
  });

  it('401s on invalid credentials', async () => {
    signInEmailMock.mockRejectedValue({ status: 'UNAUTHORIZED', body: { message: 'Invalid email or password' } });
    const res = await request(app).post('/api/v1/auth/login').send({ email: 'student@x.com', password: 'wrong' });
    expect(res.status).toBe(401);
  });

  it('400s when the body is missing required fields', async () => {
    const res = await request(app).post('/api/v1/auth/login').send({ email: 'student@x.com' });
    expect(res.status).toBe(400);
  });
});

describe('GET /api/v1/auth/me', () => {
  beforeEach(() => {
    getSessionMock.mockReset();
  });

  it('401s with no Authorization header', async () => {
    const res = await request(app).get('/api/v1/auth/me');
    expect(res.status).toBe(401);
  });

  it("200s with the session user's info given a valid bearer token", async () => {
    getSessionMock.mockResolvedValue({
      session: { id: 'sess-1' },
      user: { id: 'u1', email: 'me@x.com', name: 'Me', role: 'student', isActive: true },
    });

    const res = await request(app).get('/api/v1/auth/me').set('Authorization', 'Bearer valid-token');

    expect(res.status).toBe(200);
    expect(res.body.user).toEqual({ sub: 'u1', role: 'student', email: 'me@x.com', fullName: 'Me' });
  });
});

describe('POST /api/v1/auth/logout', () => {
  it('204s regardless of whether a session was present', async () => {
    signOutMock.mockResolvedValue(undefined);
    const res = await request(app).post('/api/v1/auth/logout').set('Authorization', 'Bearer whatever');
    expect(res.status).toBe(204);
  });
});
