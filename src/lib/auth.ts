import { betterAuth } from 'better-auth';
import { bearer } from 'better-auth/plugins';
import { pool } from '../db/pool';
import { env, corsOrigins } from '../config/env';
import { hashPassword, verifyPassword } from '../utils/password';

/**
 * Single better-auth instance for the whole service. This replaces the old
 * hand-rolled `utils/jwt.ts` (manual access-token signing + a DB-backed
 * opaque refresh token that had to be rotated by hand on every /refresh
 * call). better-auth owns the full email/password + session lifecycle:
 *
 *  - Passwords are hashed with our existing bcrypt utilities (kept, so
 *    BCRYPT_SALT_ROUNDS still means something and no hashing algorithm
 *    changes for anyone auditing this) but stored in better-auth's own
 *    `account` table (provider "credential"), not on `users.password_hash`
 *    anymore — see migration 009_better_auth.sql.
 *  - Sessions are opaque, DB-backed bearer tokens (`session` table) with a
 *    sliding expiry: `session.expiresIn` is the hard TTL, `session.updateAge`
 *    is how often an active session's expiry is pushed forward. This is the
 *    direct replacement for the old access+refresh token pair — one token,
 *    transparently renewed, still fully revocable server-side (delete the
 *    row / call `auth.api.signOut`).
 *  - The `bearer` plugin lets API clients (SPA, mobile) send
 *    `Authorization: Bearer <token>` instead of relying on cookies, which
 *    matches how `middlewares/auth.ts` and every existing route already
 *    expect to authenticate.
 *
 * better-auth talks to Postgres through the *same* `pg.Pool` the rest of the
 * app uses (see db/pool.ts) — no second connection pool, no ORM. It detects
 * the Kysely PostgresDialect automatically from the Pool instance.
 */
export const auth = betterAuth({
  database: pool,
  secret: env.BETTER_AUTH_SECRET,
  baseURL: env.BETTER_AUTH_URL,
  basePath: '/api/auth',
  trustedOrigins: corsOrigins.includes('*') ? undefined : corsOrigins,

  // Postgres still gets a UUID default (see migration 009) as a defensive
  // fallback, but better-auth is the one actually generating every id now:
  // "uuid" makes it call crypto.randomUUID() itself for every model
  // (user/session/account/verification) rather than omitting the field and
  // hoping the DB default fires. The seemingly more obvious `generateId:
  // false` ("let the database generate it") is unreliable as of better-auth
  // 1.2.6+ -- it still generates its own 32-char id internally and tries to
  // insert it, which throws `invalid input syntax for type uuid` against a
  // UUID column. `generateId: "uuid"` is the supported, documented way to
  // get real UUIDs (better-auth 1.4+).
  advanced: {
    database: { generateId: 'uuid' },
  },

  user: {
    // Reuse the existing `users` table rather than creating a parallel one.
    modelName: 'users',
    fields: {
      name: 'full_name',
      createdAt: 'created_at',
      updatedAt: 'updated_at',
    },
    additionalFields: {
      // `input: false` on role is load-bearing: it stops a client from
      // passing `role: "admin"` in a sign-up request body. Every
      // self-registered account is a student; admins are provisioned via
      // `npm run create-admin` (src/db/createAdmin.ts).
      // `returned: true` is equally load-bearing on all four fields below:
      // without it, better-auth stores the column but omits it from the
      // user object in sign-up/sign-in/getSession responses -- silently
      // breaking `middlewares/auth.ts`, which reads `role`/`isActive`
      // straight off that object.
      role: {
        type: 'string',
        defaultValue: 'student',
        input: false,
        returned: true,
        fieldName: 'role',
      },
      college: {
        type: 'string',
        required: false,
        returned: true,
        fieldName: 'college',
      },
      graduationYear: {
        type: 'number',
        required: false,
        returned: true,
        fieldName: 'graduation_year',
      },
      isActive: {
        type: 'boolean',
        defaultValue: true,
        returned: true,
        fieldName: 'is_active',
      },
    },
  },

  emailAndPassword: {
    enabled: true,
    autoSignIn: true,
    minPasswordLength: 8,
    password: {
      hash: hashPassword,
      verify: ({ password, hash }) => verifyPassword(password, hash),
    },
  },

  session: {
    expiresIn: env.SESSION_EXPIRES_IN_DAYS * 24 * 60 * 60,
    updateAge: env.SESSION_UPDATE_AGE_HOURS * 60 * 60,
    // Keep the session payload light; role/email/etc. are fetched from
    // `users` on every getSession call rather than cached on the cookie, so
    // an admin demotion or account deactivation takes effect immediately.
    freshAge: 0,
  },

  plugins: [bearer()],
});

export type Auth = typeof auth;
