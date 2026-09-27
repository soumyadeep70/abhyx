-- 001_extensions_and_enums.sql
-- Extensions + all ENUM types used across the schema, created up front so
-- every later migration can reference them without ordering issues.

CREATE EXTENSION IF NOT EXISTS pgcrypto;   -- gen_random_uuid()
CREATE EXTENSION IF NOT EXISTS citext;     -- case-insensitive email

-- Identity
CREATE TYPE user_role AS ENUM ('student', 'admin');

-- Content catalog
CREATE TYPE question_type AS ENUM ('aptitude', 'coding');
CREATE TYPE question_difficulty AS ENUM ('easy', 'medium', 'hard');
CREATE TYPE topic_category AS ENUM ('aptitude', 'coding');

-- Practice activity
CREATE TYPE mock_test_status AS ENUM ('in_progress', 'completed', 'abandoned');
CREATE TYPE attempt_type AS ENUM ('aptitude', 'coding', 'mock_test');
CREATE TYPE error_type AS ENUM ('conceptual', 'computational', 'careless', 'time_management', 'unknown');
CREATE TYPE submission_status AS ENUM (
  'pending', 'accepted', 'wrong_answer', 'tle', 'runtime_error', 'compile_error'
);

-- Interview system
CREATE TYPE interview_round_type AS ENUM ('technical', 'hr', 'system_design');
CREATE TYPE interview_session_status AS ENUM ('in_progress', 'completed', 'abandoned');
CREATE TYPE interview_message_role AS ENUM ('interviewer', 'candidate');
CREATE TYPE hiring_recommendation AS ENUM ('hire', 'borderline', 'no_hire');

-- Profile & readiness
CREATE TYPE resume_status AS ENUM ('processing', 'analyzed', 'failed');
CREATE TYPE roadmap_status AS ENUM ('active', 'completed', 'abandoned');
CREATE TYPE roadmap_phase_status AS ENUM ('pending', 'active', 'completed');
CREATE TYPE skill_status AS ENUM ('strong', 'weak', 'improving');
CREATE TYPE readiness_trigger_reason AS ENUM (
  'assessment_batch', 'interview_completed', 'resume_uploaded', 'nightly_job', 'manual'
);

-- Generic trigger to keep updated_at fresh (used by many tables)
CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
