import { describe, it, expect } from 'vitest';

/**
 * Every other test in this suite mocks the database boundary (see
 * tests/unit and tests/integration) so the suite runs anywhere with just
 * `npm test` -- no Postgres required. This file is the deliberate
 * exception: a real, unmocked round trip against Postgres, migrated with
 * the project's own migration runner, to catch anything a mock can't
 * (actual SQL syntax errors, constraint definitions, the better-auth
 * schema in migration 009 actually matching what better-auth expects).
 *
 * Gated behind RUN_DB_INTEGRATION so `npm test` (the fast, DB-free path CI
 * runs on every push) never depends on a live database:
 *
 *   docker compose up -d postgres
 *   DATABASE_URL=postgres://placement_user:placement_pass@localhost:5432/placement_platform \
 *     npm run test:integration
 *
 * See TESTING.md for the full walkthrough.
 */
const shouldRun = process.env.RUN_DB_INTEGRATION === 'true';

describe.skipIf(!shouldRun)('database (real Postgres)', () => {
  it('is reachable and has the users/session/account tables from migrations 002 + 009', async () => {
    // Imported lazily, inside the test, so a plain `npm test` run never
    // even constructs a real Pool against a DB that may not exist.
    const { pool } = await import('../../src/db/pool');

    const { rows } = await pool.query<{ table_name: string }>(
      `SELECT table_name FROM information_schema.tables
       WHERE table_schema = 'public' AND table_name IN ('users', 'session', 'account', 'verification')`
    );
    const tableNames = rows.map((r) => r.table_name).sort();
    expect(tableNames).toEqual(['account', 'session', 'users', 'verification']);

    await pool.end();
  });

  it('enforces the unique email constraint on users', async () => {
    const { pool } = await import('../../src/db/pool');
    const email = `dup-${Date.now()}@test.local`;

    await pool.query(
      `INSERT INTO users (email, full_name, role) VALUES ($1, 'First', 'student')`,
      [email]
    );

    await expect(
      pool.query(`INSERT INTO users (email, full_name, role) VALUES ($1, 'Second', 'student')`, [email])
    ).rejects.toMatchObject({ code: '23505' });

    await pool.query(`DELETE FROM users WHERE email = $1`, [email]);
    await pool.end();
  });
});
