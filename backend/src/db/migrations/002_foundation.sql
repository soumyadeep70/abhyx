-- 002_foundation.sql
-- 01 · Foundation — Identity, Companies & Content Catalog

-- Credentials are not stored here: better-auth owns email/password auth and
-- keeps the password hash on its own `account` table (provider
-- "credential"), not on the user row. `email_verified` and `image` are the
-- two columns better-auth's core `user` model always expects; see
-- src/lib/auth.ts (`user.modelName: "users"`) for how this table is mapped
-- onto that model, and 009_better_auth.sql for the accompanying
-- session/account/verification tables.
CREATE TABLE users (
  id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email             CITEXT NOT NULL UNIQUE,
  email_verified    BOOLEAN NOT NULL DEFAULT false,
  image             TEXT,
  full_name         TEXT NOT NULL,
  role              user_role NOT NULL DEFAULT 'student',
  college           TEXT,
  graduation_year   SMALLINT,
  is_active         BOOLEAN NOT NULL DEFAULT TRUE,
  created_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at        TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE TRIGGER trg_users_updated_at BEFORE UPDATE ON users
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();

CREATE TABLE companies (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name        TEXT NOT NULL UNIQUE,
  logo_url    TEXT,
  is_active   BOOLEAN NOT NULL DEFAULT TRUE,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE TRIGGER trg_companies_updated_at BEFORE UPDATE ON companies
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();

CREATE TABLE company_tiers (
  id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id          UUID NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
  tier_name           TEXT NOT NULL,
  aptitude_weight     SMALLINT NOT NULL CHECK (aptitude_weight BETWEEN 0 AND 100),
  coding_weight       SMALLINT NOT NULL CHECK (coding_weight BETWEEN 0 AND 100),
  resume_weight       SMALLINT NOT NULL CHECK (resume_weight BETWEEN 0 AND 100),
  interview_weight    SMALLINT NOT NULL CHECK (interview_weight BETWEEN 0 AND 100),
  consistency_weight  SMALLINT NOT NULL CHECK (consistency_weight BETWEEN 0 AND 100),
  is_active           BOOLEAN NOT NULL DEFAULT TRUE,
  created_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (company_id, tier_name),
  CONSTRAINT chk_weights_sum_100 CHECK (
    aptitude_weight + coding_weight + resume_weight + interview_weight + consistency_weight = 100
  )
);
CREATE INDEX idx_company_tiers_company_id ON company_tiers(company_id);

CREATE TABLE topics (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name             TEXT NOT NULL,
  category         topic_category NOT NULL,
  parent_topic_id  UUID REFERENCES topics(id) ON DELETE SET NULL,
  UNIQUE (name, category)
);
CREATE INDEX idx_topics_parent ON topics(parent_topic_id);

CREATE TABLE tags (
  id    UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name  TEXT NOT NULL UNIQUE
);

CREATE TABLE questions (
  id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  type         question_type NOT NULL,
  topic_id     UUID NOT NULL REFERENCES topics(id) ON DELETE RESTRICT,
  difficulty   question_difficulty NOT NULL,
  title        TEXT NOT NULL,
  prompt       TEXT NOT NULL,
  is_active    BOOLEAN NOT NULL DEFAULT TRUE,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  -- invariant: a question's `type` must match the category of its topic
  CONSTRAINT chk_question_type_matches_topic_category_deferred CHECK (TRUE)
);
CREATE TRIGGER trg_questions_updated_at BEFORE UPDATE ON questions
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();
CREATE INDEX idx_questions_topic_id ON questions(topic_id);
CREATE INDEX idx_questions_type_difficulty ON questions(type, difficulty) WHERE is_active;

-- Enforce question.type == topic.category via trigger (cross-table CHECKs aren't supported natively)
CREATE OR REPLACE FUNCTION enforce_question_type_matches_topic()
RETURNS TRIGGER AS $$
DECLARE
  topic_cat topic_category;
BEGIN
  SELECT category INTO topic_cat FROM topics WHERE id = NEW.topic_id;
  IF topic_cat IS DISTINCT FROM NEW.type::text::topic_category THEN
    RAISE EXCEPTION 'question.type (%) must match topics.category (%) for topic_id %',
      NEW.type, topic_cat, NEW.topic_id;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_questions_type_matches_topic
  BEFORE INSERT OR UPDATE OF topic_id, type ON questions
  FOR EACH ROW EXECUTE FUNCTION enforce_question_type_matches_topic();

CREATE TABLE question_tags (
  question_id  UUID NOT NULL REFERENCES questions(id) ON DELETE CASCADE,
  tag_id       UUID NOT NULL REFERENCES tags(id) ON DELETE CASCADE,
  PRIMARY KEY (question_id, tag_id)
);

CREATE TABLE aptitude_question_details (
  question_id     UUID PRIMARY KEY REFERENCES questions(id) ON DELETE CASCADE,
  options         JSONB NOT NULL,
  correct_answer  JSONB NOT NULL
);

CREATE TABLE coding_problem_details (
  question_id          UUID PRIMARY KEY REFERENCES questions(id) ON DELETE CASCADE,
  function_signature   TEXT,
  starter_code         JSONB,
  test_cases           JSONB NOT NULL DEFAULT '[]'::jsonb,
  constraints_text     TEXT,
  time_limit_ms        INTEGER NOT NULL DEFAULT 2000,
  memory_limit_kb      INTEGER NOT NULL DEFAULT 131072,
  judge0_language_ids  INTEGER[] NOT NULL DEFAULT '{}'
);

-- NEW (per revision note in schema PDF): which companies are known to ask a question
CREATE TABLE question_companies (
  question_id  UUID NOT NULL REFERENCES questions(id) ON DELETE CASCADE,
  company_id   UUID NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
  PRIMARY KEY (question_id, company_id)
);
CREATE INDEX idx_question_companies_company ON question_companies(company_id);
