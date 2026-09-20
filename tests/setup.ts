/**
 * Runs once before every test file (see vitest.config.ts `setupFiles`).
 * `src/config/env.ts` validates and freezes `process.env` at import time
 * (and `process.exit(1)`s if required vars are missing), so these have to
 * be set before anything under `src/` gets imported anywhere.
 */
process.env.NODE_ENV = process.env.NODE_ENV || 'test';
process.env.DATABASE_URL = process.env.DATABASE_URL || 'postgres://test:test@localhost:5432/placement_platform_test';
process.env.BETTER_AUTH_SECRET = process.env.BETTER_AUTH_SECRET || 'a'.repeat(32);
process.env.BETTER_AUTH_URL = process.env.BETTER_AUTH_URL || 'http://localhost:8080';
// Real bcrypt cost, kept low so unit tests hashing/verifying passwords stay fast.
process.env.BCRYPT_SALT_ROUNDS = process.env.BCRYPT_SALT_ROUNDS || '4';
process.env.AI_SERVICE_BASE_URL = process.env.AI_SERVICE_BASE_URL || 'http://localhost:9000';
process.env.CORS_ORIGINS = process.env.CORS_ORIGINS || 'http://localhost:5173';
process.env.ENABLE_CRON = 'false';
// Keep Judge0 polling fast in tests (default prod values would make a
// timeout test take 15+ seconds).
process.env.JUDGE0_POLL_INTERVAL_MS = process.env.JUDGE0_POLL_INTERVAL_MS || '1';
process.env.JUDGE0_POLL_MAX_ATTEMPTS = process.env.JUDGE0_POLL_MAX_ATTEMPTS || '3';

import { vi } from 'vitest';

/**
 * Global mock for better-auth's Node adapter helpers. Every test that needs
 * real session behavior mocks `src/lib/auth`'s `auth.api.*` directly (see
 * tests/unit/middlewares/auth.test.ts, auth.service.test.ts) -- these two
 * helpers are just plumbing around that, and mocking them here means a test
 * file that also mocks `src/lib/auth` (giving it only a partial `{ api }`
 * shape) never has to worry about `toNodeHandler`/`fromNodeHeaders` making
 * assumptions about the rest of the real `auth` object's shape.
 *
 * This does NOT mock the `better-auth` package itself, so `src/lib/auth.ts`
 * still exercises the real `betterAuth({...})` config wherever it's
 * imported un-mocked (e.g. tests/integration/health.test.ts) -- that's a
 * useful smoke test that the config object itself is well-formed.
 */
vi.mock('better-auth/node', () => ({
  fromNodeHeaders: (headers: Record<string, unknown>) => headers,
  toNodeHandler: () => (_req: unknown, res: any) => {
    res.statusCode = 501;
    res.setHeader('Content-Type', 'application/json');
    res.end(JSON.stringify({ error: { message: 'better-auth direct handler is not exercised in tests' } }));
  },
}));
