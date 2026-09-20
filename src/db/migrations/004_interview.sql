-- 004_interview.sql
-- 03 · Interview System

CREATE TABLE interview_sessions (
  id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id             UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  target_company_id   UUID REFERENCES company_tiers(id) ON DELETE SET NULL,
  round_type          interview_round_type NOT NULL,
  status              interview_session_status NOT NULL DEFAULT 'in_progress',
  duration_seconds    INTEGER,
  started_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
  completed_at        TIMESTAMPTZ
);
CREATE INDEX idx_interview_sessions_user_started ON interview_sessions(user_id, started_at DESC);

CREATE TABLE interview_messages (
  id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  session_id        UUID NOT NULL REFERENCES interview_sessions(id) ON DELETE CASCADE,
  role              interview_message_role NOT NULL,
  message           TEXT NOT NULL,
  sequence_number   SMALLINT NOT NULL,
  created_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (session_id, sequence_number)
);
CREATE INDEX idx_interview_messages_session ON interview_messages(session_id, sequence_number);

CREATE TABLE interview_answer_scores (
  id                          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  session_id                  UUID NOT NULL REFERENCES interview_sessions(id) ON DELETE CASCADE,
  candidate_message_id        UUID NOT NULL UNIQUE REFERENCES interview_messages(id) ON DELETE CASCADE,
  technical_accuracy          NUMERIC(4,2) NOT NULL CHECK (technical_accuracy BETWEEN 0 AND 10),
  communication_clarity       NUMERIC(4,2) NOT NULL CHECK (communication_clarity BETWEEN 0 AND 10),
  problem_solving_approach    NUMERIC(4,2) NOT NULL CHECK (problem_solving_approach BETWEEN 0 AND 10),
  depth_of_knowledge          NUMERIC(4,2) NOT NULL CHECK (depth_of_knowledge BETWEEN 0 AND 10),
  hr_readiness                NUMERIC(4,2) CHECK (hr_readiness BETWEEN 0 AND 10),
  created_at                  TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_interview_answer_scores_session ON interview_answer_scores(session_id);

CREATE TABLE interview_scorecards (
  session_id              UUID PRIMARY KEY REFERENCES interview_sessions(id) ON DELETE CASCADE,
  technical_accuracy      NUMERIC(4,2),
  communication_clarity   NUMERIC(4,2),
  problem_solving_approach NUMERIC(4,2),
  depth_of_knowledge      NUMERIC(4,2),
  hr_readiness            NUMERIC(4,2),
  overall_score           NUMERIC(5,2) CHECK (overall_score BETWEEN 0 AND 100),
  strengths                TEXT[] NOT NULL DEFAULT '{}',
  weaknesses               TEXT[] NOT NULL DEFAULT '{}',
  improvement_plan         TEXT[] NOT NULL DEFAULT '{}',
  hiring_recommendation    hiring_recommendation,
  created_at               TIMESTAMPTZ NOT NULL DEFAULT now()
);
