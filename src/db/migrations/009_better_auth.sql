-- 009_better_auth.sql
-- Replaces the hand-rolled JWT + refresh_tokens auth (migration 007,
-- ADDITION 1) with better-auth. See CHANGES_AND_ASSUMPTIONS.md for the
-- rationale.
--
-- `users` keeps its identity (id, email, full_name, role, college,
-- graduation_year, is_active) and stays the model better-auth's `user`
-- table maps onto (see src/lib/auth.ts `user.modelName: "users"`). It picks
-- up two columns better-auth's core schema always expects, and loses
-- `password_hash`, which now lives in `account.password` instead (better-
-- auth stores email/password credentials as a provider account, not on the
-- user row -- this is also what makes adding OAuth providers later a
-- config change instead of a schema change).

ALTER TABLE users
  ADD COLUMN email_verified BOOLEAN NOT NULL DEFAULT false,
  ADD COLUMN image TEXT;

ALTER TABLE users
  DROP COLUMN password_hash;

-- better-auth core tables. Ids are UUIDs, matching every other table in
-- this schema. better-auth generates them itself (advanced.database.
-- generateId: "uuid" in src/lib/auth.ts calls crypto.randomUUID() per
-- insert) rather than relying on the column default below to fire --
-- that default is a defensive fallback for any row inserted outside
-- better-auth's own code path, not the primary mechanism.

CREATE TABLE session (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  token       TEXT NOT NULL UNIQUE,
  expires_at  TIMESTAMPTZ NOT NULL,
  ip_address  TEXT,
  user_agent  TEXT,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_session_user_id ON session(user_id);
CREATE INDEX idx_session_expires_at ON session(expires_at);
CREATE TRIGGER trg_session_updated_at BEFORE UPDATE ON session
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- One row per login method per user. For this app that's always exactly one
-- ('credential' / email+password) today, but the shape is what lets a
-- future "Sign in with Google" become additive rather than a rewrite.
CREATE TABLE account (
  id                        UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id                   UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  account_id                TEXT NOT NULL,
  provider_id               TEXT NOT NULL,
  password                  TEXT,
  access_token              TEXT,
  refresh_token             TEXT,
  id_token                  TEXT,
  access_token_expires_at   TIMESTAMPTZ,
  refresh_token_expires_at  TIMESTAMPTZ,
  scope                     TEXT,
  created_at                TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at                TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (provider_id, account_id)
);
CREATE INDEX idx_account_user_id ON account(user_id);
CREATE TRIGGER trg_account_updated_at BEFORE UPDATE ON account
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- Short-lived tokens for email verification / password reset flows.
CREATE TABLE verification (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  identifier  TEXT NOT NULL,
  value       TEXT NOT NULL,
  expires_at  TIMESTAMPTZ NOT NULL,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_verification_identifier ON verification(identifier);

DROP TABLE refresh_tokens;
