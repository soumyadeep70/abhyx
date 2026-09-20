-- 005_profile_readiness.sql
-- 04 · Profile & Readiness

CREATE TABLE resumes (
  id                 UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id            UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  file_url           TEXT NOT NULL,
  status             resume_status NOT NULL DEFAULT 'processing',
  ats_score          NUMERIC(5,2),
  extracted_skills   TEXT[] NOT NULL DEFAULT '{}',
  keyword_gaps       TEXT[] NOT NULL DEFAULT '{}',
  ai_summary         TEXT,
  is_current         BOOLEAN NOT NULL DEFAULT FALSE,
  uploaded_at        TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_resumes_user_uploaded ON resumes(user_id, uploaded_at DESC);
-- invariant: only one resume per user may be flagged current
CREATE UNIQUE INDEX uq_resumes_one_current_per_user ON resumes(user_id) WHERE is_current;

CREATE OR REPLACE FUNCTION unset_other_current_resumes()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.is_current THEN
    UPDATE resumes SET is_current = FALSE
    WHERE user_id = NEW.user_id AND id <> NEW.id AND is_current;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_resumes_single_current
  BEFORE INSERT OR UPDATE OF is_current ON resumes
  FOR EACH ROW WHEN (NEW.is_current) EXECUTE FUNCTION unset_other_current_resumes();

CREATE TABLE roadmaps (
  id                 UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id            UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  target_company_id  UUID REFERENCES company_tiers(id) ON DELETE SET NULL,
  target_date        DATE,
  status             roadmap_status NOT NULL DEFAULT 'active',
  generated_at       TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_roadmaps_user ON roadmaps(user_id, generated_at DESC);
-- invariant: only one active roadmap per user
CREATE UNIQUE INDEX uq_roadmaps_one_active_per_user ON roadmaps(user_id) WHERE status = 'active';

CREATE TABLE roadmap_phases (
  id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  roadmap_id     UUID NOT NULL REFERENCES roadmaps(id) ON DELETE CASCADE,
  phase_number   SMALLINT NOT NULL,
  title          TEXT NOT NULL,
  status         roadmap_phase_status NOT NULL DEFAULT 'pending',
  UNIQUE (roadmap_id, phase_number)
);
CREATE INDEX idx_roadmap_phases_roadmap ON roadmap_phases(roadmap_id, phase_number);

CREATE TABLE roadmap_phase_topics (
  roadmap_phase_id  UUID NOT NULL REFERENCES roadmap_phases(id) ON DELETE CASCADE,
  topic_id          UUID NOT NULL REFERENCES topics(id) ON DELETE CASCADE,
  PRIMARY KEY (roadmap_phase_id, topic_id)
);

CREATE TABLE student_skill_map (
  user_id         UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  topic_id        UUID NOT NULL REFERENCES topics(id) ON DELETE CASCADE,
  status          skill_status NOT NULL,
  last_analyzed   TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (user_id, topic_id)
);
CREATE INDEX idx_student_skill_map_status ON student_skill_map(user_id, status);

CREATE TABLE student_streaks (
  user_id           UUID PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
  current_streak    INTEGER NOT NULL DEFAULT 0,
  longest_streak    INTEGER NOT NULL DEFAULT 0,
  last_active_date  DATE
);

CREATE TABLE student_activity_log (
  user_id        UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  activity_date  DATE NOT NULL,
  PRIMARY KEY (user_id, activity_date)
);
CREATE INDEX idx_student_activity_log_date ON student_activity_log(activity_date);

CREATE TABLE readiness_scores (
  user_id             UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  company_tier_id     UUID NOT NULL REFERENCES company_tiers(id) ON DELETE CASCADE,
  score               NUMERIC(5,2) NOT NULL CHECK (score BETWEEN 0 AND 100),
  probability          NUMERIC(4,3) NOT NULL CHECK (probability BETWEEN 0 AND 1),
  aptitude_score       NUMERIC(5,2),
  coding_score         NUMERIC(5,2),
  resume_score         NUMERIC(5,2),
  interview_score      NUMERIC(5,2),
  consistency_score    NUMERIC(5,2),
  last_computed        TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (user_id, company_tier_id)
);
CREATE INDEX idx_readiness_scores_company_tier ON readiness_scores(company_tier_id);

CREATE TABLE readiness_score_history (
  id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id           UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  company_tier_id   UUID NOT NULL REFERENCES company_tiers(id) ON DELETE CASCADE,
  score             NUMERIC(5,2) NOT NULL,
  probability       NUMERIC(4,3) NOT NULL,
  trigger_reason    readiness_trigger_reason NOT NULL,
  computed_at       TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_readiness_score_history_user_company_time
  ON readiness_score_history(user_id, company_tier_id, computed_at DESC);
