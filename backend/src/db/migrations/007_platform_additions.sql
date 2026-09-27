-- 007_platform_additions.sql
-- Tables added beyond the 31-table reference schema to support features the
-- PRD requires but the schema PDF didn't model. See CHANGES_AND_ASSUMPTIONS.md
-- for the full rationale of each addition.
--
-- Auth session/token storage is intentionally not here: it's better-auth's
-- `session` / `account` / `verification` tables in 009_better_auth.sql, not
-- a hand-rolled refresh-token table. A revocable, rotated refresh token
-- alongside a short-lived signed access token was the original plan (hence
-- this file once had a `refresh_tokens` table), but better-auth's
-- sliding-expiry session already gets the same revocability (delete the row
-- / `auth.api.signOut`) without a client-side rotation dance, so that table
-- was never needed.

-- ADDITION 1: ai_cache
-- The HLD's "AI Cost Control Strategy" table specifies per-call-type cache
-- durations (readiness insights 1h, weak-topic detection 24h, resume
-- analysis until re-upload, roadmap generation 24h, company intelligence
-- 24h). The reference schema has no place to persist these caches, and
-- without persistence every request would re-hit the paid/rate-limited AI
-- service. One generic keyed cache table covers all AI-call types instead
-- of five near-identical tables.
CREATE TABLE ai_cache (
  cache_key    TEXT PRIMARY KEY,
  cache_type   TEXT NOT NULL, -- 'readiness_insight' | 'weak_topic' | 'resume_analysis' | 'roadmap' | 'company_intel'
  user_id      UUID REFERENCES users(id) ON DELETE CASCADE,
  payload      JSONB NOT NULL,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  expires_at   TIMESTAMPTZ NOT NULL
);
CREATE INDEX idx_ai_cache_type_user ON ai_cache(cache_type, user_id);
CREATE INDEX idx_ai_cache_expires ON ai_cache(expires_at);

-- ADDITION 2: leaderboard as a materialized view, not a table.
-- Module 10 needs a college-level ranking by overall readiness and a streak
-- ranking. Both are derived, order-dependent, read-heavy, and must never be
-- a source of truth (they can always be rebuilt from readiness_scores /
-- student_streaks), so a materialized view refreshed on a schedule/trigger
-- is the right tool rather than a persisted ranking table that can drift.
CREATE MATERIALIZED VIEW mv_leaderboard AS
SELECT
  u.id                          AS user_id,
  u.full_name,
  u.college,
  u.graduation_year,
  COALESCE(AVG(rs.score), 0)::NUMERIC(5,2)  AS avg_readiness_score,
  COALESCE(MAX(rs.score), 0)::NUMERIC(5,2)  AS best_readiness_score,
  COALESCE(st.current_streak, 0)            AS current_streak,
  COALESCE(st.longest_streak, 0)            AS longest_streak,
  RANK() OVER (ORDER BY COALESCE(AVG(rs.score), 0) DESC)  AS overall_rank,
  RANK() OVER (
    PARTITION BY u.college
    ORDER BY COALESCE(AVG(rs.score), 0) DESC
  ) AS college_rank
FROM users u
LEFT JOIN readiness_scores rs ON rs.user_id = u.id
LEFT JOIN student_streaks st ON st.user_id = u.id
WHERE u.role = 'student' AND u.is_active
GROUP BY u.id, u.full_name, u.college, u.graduation_year, st.current_streak, st.longest_streak;

CREATE UNIQUE INDEX uq_mv_leaderboard_user ON mv_leaderboard(user_id);
