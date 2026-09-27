-- 006_preferences_gamification.sql
-- 05 · Preferences & Gamification

CREATE TABLE user_target_companies (
  user_id           UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  company_tier_id   UUID NOT NULL REFERENCES company_tiers(id) ON DELETE CASCADE,
  priority          SMALLINT,
  added_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (user_id, company_tier_id)
);
CREATE INDEX idx_user_target_companies_user_priority ON user_target_companies(user_id, priority);

CREATE TABLE badges (
  id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  code         TEXT NOT NULL UNIQUE,
  name         TEXT NOT NULL,
  description  TEXT,
  icon_url     TEXT,
  is_active    BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE user_badges (
  user_id     UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  badge_id    UUID NOT NULL REFERENCES badges(id) ON DELETE RESTRICT,
  earned_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (user_id, badge_id)
);
CREATE INDEX idx_user_badges_user ON user_badges(user_id);
