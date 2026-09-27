-- 003_practice_activity.sql
-- 02 · Practice Activity

CREATE TABLE mock_tests (
  id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id             UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  target_company_id   UUID REFERENCES company_tiers(id) ON DELETE SET NULL,
  status              mock_test_status NOT NULL DEFAULT 'in_progress',
  total_score         NUMERIC(5,2),
  started_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
  completed_at        TIMESTAMPTZ
);
CREATE INDEX idx_mock_tests_user_started ON mock_tests(user_id, started_at DESC);

CREATE TABLE mock_test_questions (
  mock_test_id  UUID NOT NULL REFERENCES mock_tests(id) ON DELETE CASCADE,
  question_id   UUID NOT NULL REFERENCES questions(id) ON DELETE CASCADE,
  order_index   SMALLINT NOT NULL,
  PRIMARY KEY (mock_test_id, question_id)
);
CREATE INDEX idx_mock_test_questions_order ON mock_test_questions(mock_test_id, order_index);

CREATE TABLE assessment_attempts (
  id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id                 UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  question_id             UUID NOT NULL REFERENCES questions(id) ON DELETE RESTRICT,
  mock_test_id            UUID REFERENCES mock_tests(id) ON DELETE CASCADE,
  attempt_type            attempt_type NOT NULL,
  topic_id                UUID NOT NULL,          -- denormalized copy, auto-filled by trigger
  difficulty              question_difficulty NOT NULL, -- denormalized copy, auto-filled by trigger
  answer                  JSONB,
  time_taken_seconds      INTEGER,
  is_correct              BOOLEAN,
  hints_used              SMALLINT NOT NULL DEFAULT 0,
  error_type              error_type,
  ai_explanation          TEXT,
  created_at              TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_assessment_attempts_user_created ON assessment_attempts(user_id, created_at DESC);
CREATE INDEX idx_assessment_attempts_user_topic ON assessment_attempts(user_id, topic_id);
CREATE INDEX idx_assessment_attempts_question ON assessment_attempts(question_id);
CREATE INDEX idx_assessment_attempts_mock_test ON assessment_attempts(mock_test_id) WHERE mock_test_id IS NOT NULL;

-- BEFORE INSERT trigger: denormalize topic_id / difficulty from the parent question
CREATE OR REPLACE FUNCTION fill_assessment_attempt_denorm()
RETURNS TRIGGER AS $$
DECLARE
  q_topic_id UUID;
  q_difficulty question_difficulty;
BEGIN
  SELECT topic_id, difficulty INTO q_topic_id, q_difficulty
  FROM questions WHERE id = NEW.question_id;

  IF q_topic_id IS NULL THEN
    RAISE EXCEPTION 'question_id % not found', NEW.question_id;
  END IF;

  NEW.topic_id := q_topic_id;
  NEW.difficulty := q_difficulty;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_assessment_attempts_denorm
  BEFORE INSERT ON assessment_attempts
  FOR EACH ROW EXECUTE FUNCTION fill_assessment_attempt_denorm();

CREATE TABLE assessment_recommended_topics (
  assessment_attempt_id  UUID NOT NULL REFERENCES assessment_attempts(id) ON DELETE CASCADE,
  topic_id                UUID NOT NULL REFERENCES topics(id) ON DELETE CASCADE,
  PRIMARY KEY (assessment_attempt_id, topic_id)
);

CREATE TABLE code_submissions (
  id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  assessment_attempt_id   UUID REFERENCES assessment_attempts(id) ON DELETE SET NULL,
  user_id                 UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  question_id             UUID NOT NULL REFERENCES questions(id) ON DELETE RESTRICT,
  language                TEXT NOT NULL,
  source_code             TEXT NOT NULL,
  judge0_token            TEXT,
  status                  submission_status NOT NULL DEFAULT 'pending',
  runtime_ms              INTEGER,
  memory_kb               INTEGER,
  test_cases_passed       SMALLINT,
  test_cases_total        SMALLINT,
  submitted_at            TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_code_submissions_user_submitted ON code_submissions(user_id, submitted_at DESC);
CREATE INDEX idx_code_submissions_question ON code_submissions(question_id);
