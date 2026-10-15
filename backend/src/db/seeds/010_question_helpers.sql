-- 010_question_helpers.sql
-- Session-local helper functions used by the per-topic question seed files
-- (100_*.sql … 310_*.sql). They live in pg_temp, so nothing is added to the
-- schema and they disappear with the connection.
--
-- `npm run seed` runs every seed file on ONE connection inside ONE
-- transaction (see seed() in src/db/migrate.ts) so these helpers are visible
-- to the files that follow, and a failure in any file rolls the whole seed
-- back instead of leaving a half-populated question bank.
--
-- Both helpers are UPSERTS keyed on (topic, title, type):
--   * first run  -> inserts the question + its detail row + company/tag links
--   * later runs -> updates prompt / difficulty / details / links in place
-- so `npm run seed` is safe to run repeatedly and content fixes shipped in a
-- seed file reach existing databases. `is_active` is never touched on update,
-- so a question an admin deactivated stays deactivated.
--
-- NOTE: because re-seeding overwrites content, edit seeded questions in these
-- files rather than through the admin API if you want the edit to survive.

CREATE OR REPLACE FUNCTION pg_temp.seed_link_companies(p_question_id UUID, p_companies TEXT[])
RETURNS VOID AS $$
DECLARE
  v_name TEXT;
  v_company_id UUID;
BEGIN
  DELETE FROM question_companies WHERE question_id = p_question_id;
  FOREACH v_name IN ARRAY COALESCE(p_companies, '{}') LOOP
    SELECT id INTO v_company_id FROM companies WHERE name = v_name;
    IF v_company_id IS NULL THEN
      RAISE EXCEPTION 'seed: unknown company "%" (is 000_reference_data.sql applied?)', v_name;
    END IF;
    INSERT INTO question_companies (question_id, company_id) VALUES (p_question_id, v_company_id)
      ON CONFLICT DO NOTHING;
  END LOOP;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION pg_temp.seed_link_tags(p_question_id UUID, p_tags TEXT[])
RETURNS VOID AS $$
DECLARE
  v_name TEXT;
  v_tag_id UUID;
BEGIN
  DELETE FROM question_tags WHERE question_id = p_question_id;
  FOREACH v_name IN ARRAY COALESCE(p_tags, '{}') LOOP
    INSERT INTO tags (name) VALUES (v_name) ON CONFLICT (name) DO NOTHING;
    SELECT id INTO v_tag_id FROM tags WHERE name = v_name;
    INSERT INTO question_tags (question_id, tag_id) VALUES (p_question_id, v_tag_id)
      ON CONFLICT DO NOTHING;
  END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Multiple-choice question. The answer key is stored as {"choice": "<option text>"},
-- the exact shape assessment.service compares submitted answers against.
CREATE OR REPLACE FUNCTION pg_temp.seed_aptitude(
  p_topic       TEXT,
  p_difficulty  question_difficulty,
  p_title       TEXT,
  p_prompt      TEXT,
  p_options     JSONB,
  p_answer      TEXT,
  p_companies   TEXT[] DEFAULT '{}',
  p_tags        TEXT[] DEFAULT '{}'
) RETURNS VOID AS $$
DECLARE
  v_topic_id UUID;
  v_id UUID;
BEGIN
  SELECT id INTO v_topic_id FROM topics WHERE name = p_topic AND category = 'aptitude';
  IF v_topic_id IS NULL THEN
    RAISE EXCEPTION 'seed: aptitude topic "%" not found (is 000_reference_data.sql applied?)', p_topic;
  END IF;
  IF jsonb_array_length(p_options) < 2 OR NOT (p_options ? p_answer) THEN
    RAISE EXCEPTION 'seed: answer "%" is not one of the options for "%"', p_answer, p_title;
  END IF;

  SELECT id INTO v_id FROM questions WHERE topic_id = v_topic_id AND title = p_title AND type = 'aptitude'
    ORDER BY created_at, id LIMIT 1;
  IF v_id IS NULL THEN
    INSERT INTO questions (type, topic_id, difficulty, title, prompt, created_at)
    VALUES ('aptitude', v_topic_id, p_difficulty, p_title, p_prompt, clock_timestamp())
    RETURNING id INTO v_id;
  ELSE
    UPDATE questions SET difficulty = p_difficulty, prompt = p_prompt WHERE id = v_id;
  END IF;

  INSERT INTO aptitude_question_details (question_id, options, correct_answer)
  VALUES (v_id, p_options, jsonb_build_object('choice', p_answer))
  ON CONFLICT (question_id) DO UPDATE SET options = EXCLUDED.options, correct_answer = EXCLUDED.correct_answer;

  -- Rows with the same topic + title that aren't the canonical one can only come from the
  -- pre-upsert seed (which inserted a fresh copy on every run). Hide them rather than delete:
  -- attempts reference questions with ON DELETE RESTRICT.
  UPDATE questions SET is_active = FALSE
   WHERE topic_id = v_topic_id AND title = p_title AND id <> v_id AND is_active;

  PERFORM pg_temp.seed_link_companies(v_id, p_companies);
  PERFORM pg_temp.seed_link_tags(v_id, p_tags);
END;
$$ LANGUAGE plpgsql;

-- Judge0-graded coding question. test_cases is [{"input": <stdin>, "expected": <stdout>}, ...];
-- the first case is the one the API shows as the sample, the rest stay hidden.
CREATE OR REPLACE FUNCTION pg_temp.seed_coding(
  p_topic        TEXT,
  p_difficulty   question_difficulty,
  p_title        TEXT,
  p_prompt       TEXT,
  p_signature    TEXT,
  p_starter      JSONB,
  p_tests        JSONB,
  p_constraints  TEXT,
  p_time_ms      INTEGER,
  p_memory_kb    INTEGER,
  p_langs        INTEGER[],
  p_companies    TEXT[] DEFAULT '{}',
  p_tags         TEXT[] DEFAULT '{}'
) RETURNS VOID AS $$
DECLARE
  v_topic_id UUID;
  v_id UUID;
BEGIN
  SELECT id INTO v_topic_id FROM topics WHERE name = p_topic AND category = 'coding';
  IF v_topic_id IS NULL THEN
    RAISE EXCEPTION 'seed: coding topic "%" not found (is 000_reference_data.sql applied?)', p_topic;
  END IF;
  IF jsonb_array_length(p_tests) < 1 THEN
    RAISE EXCEPTION 'seed: "%" has no test cases', p_title;
  END IF;

  SELECT id INTO v_id FROM questions WHERE topic_id = v_topic_id AND title = p_title AND type = 'coding'
    ORDER BY created_at, id LIMIT 1;
  IF v_id IS NULL THEN
    INSERT INTO questions (type, topic_id, difficulty, title, prompt, created_at)
    VALUES ('coding', v_topic_id, p_difficulty, p_title, p_prompt, clock_timestamp())
    RETURNING id INTO v_id;
  ELSE
    UPDATE questions SET difficulty = p_difficulty, prompt = p_prompt WHERE id = v_id;
  END IF;

  INSERT INTO coding_problem_details
    (question_id, function_signature, starter_code, test_cases, constraints_text, time_limit_ms, memory_limit_kb, judge0_language_ids)
  VALUES (v_id, p_signature, p_starter, p_tests, p_constraints, p_time_ms, p_memory_kb, p_langs)
  ON CONFLICT (question_id) DO UPDATE SET
    function_signature = EXCLUDED.function_signature,
    starter_code = EXCLUDED.starter_code,
    test_cases = EXCLUDED.test_cases,
    constraints_text = EXCLUDED.constraints_text,
    time_limit_ms = EXCLUDED.time_limit_ms,
    memory_limit_kb = EXCLUDED.memory_limit_kb,
    judge0_language_ids = EXCLUDED.judge0_language_ids;

  -- Rows with the same topic + title that aren't the canonical one can only come from the
  -- pre-upsert seed (which inserted a fresh copy on every run). Hide them rather than delete:
  -- attempts reference questions with ON DELETE RESTRICT.
  UPDATE questions SET is_active = FALSE
   WHERE topic_id = v_topic_id AND title = p_title AND id <> v_id AND is_active;

  PERFORM pg_temp.seed_link_companies(v_id, p_companies);
  PERFORM pg_temp.seed_link_tags(v_id, p_tags);
END;
$$ LANGUAGE plpgsql;
