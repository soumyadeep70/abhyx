-- 001_sample_questions.sql
-- Small starter question bank so the platform is exercisable end to end
-- without a content team. Real content ingestion is out of scope here.

DO $$
DECLARE
  v_quant UUID; v_logical UUID; v_verbal UUID; v_arrays UUID; v_strings UUID; v_dp UUID;
  v_q UUID;
  v_tcs UUID; v_amazon UUID;
BEGIN
  SELECT id INTO v_quant   FROM topics WHERE name = 'Quantitative Aptitude' AND category = 'aptitude';
  SELECT id INTO v_logical FROM topics WHERE name = 'Logical Reasoning' AND category = 'aptitude';
  SELECT id INTO v_verbal  FROM topics WHERE name = 'Verbal Ability' AND category = 'aptitude';
  SELECT id INTO v_arrays  FROM topics WHERE name = 'Arrays' AND category = 'coding';
  SELECT id INTO v_strings FROM topics WHERE name = 'Strings' AND category = 'coding';
  SELECT id INTO v_dp      FROM topics WHERE name = 'Dynamic Programming' AND category = 'coding';
  SELECT id INTO v_tcs     FROM companies WHERE name = 'TCS';
  SELECT id INTO v_amazon  FROM companies WHERE name = 'Amazon';

  -- Aptitude: quantitative
  INSERT INTO questions (type, topic_id, difficulty, title, prompt)
  VALUES ('aptitude', v_quant, 'easy', 'Simple Interest Basics',
          'A sum of money doubles itself in 8 years at simple interest. In how many years will it triple?')
  RETURNING id INTO v_q;
  INSERT INTO aptitude_question_details (question_id, options, correct_answer)
  VALUES (v_q, '["12 years","16 years","20 years","24 years"]'::jsonb, '{"choice":"16 years"}'::jsonb);
  INSERT INTO question_companies (question_id, company_id) VALUES (v_q, v_tcs);

  INSERT INTO questions (type, topic_id, difficulty, title, prompt)
  VALUES ('aptitude', v_quant, 'medium', 'Train Speed Problem',
          'Two trains 120m and 180m long run at 54 km/hr and 36 km/hr in opposite directions. In how many seconds will they cross each other?')
  RETURNING id INTO v_q;
  INSERT INTO aptitude_question_details (question_id, options, correct_answer)
  VALUES (v_q, '["10s","12s","14s","16s"]'::jsonb, '{"choice":"12s"}'::jsonb);

  -- Aptitude: logical reasoning
  INSERT INTO questions (type, topic_id, difficulty, title, prompt)
  VALUES ('aptitude', v_logical, 'easy', 'Blood Relations',
          'Pointing to a man, a woman said, "His mother is the only daughter of my mother." How is the woman related to the man?')
  RETURNING id INTO v_q;
  INSERT INTO aptitude_question_details (question_id, options, correct_answer)
  VALUES (v_q, '["Mother","Sister","Aunt","Grandmother"]'::jsonb, '{"choice":"Mother"}'::jsonb);

  -- Aptitude: verbal
  INSERT INTO questions (type, topic_id, difficulty, title, prompt)
  VALUES ('aptitude', v_verbal, 'easy', 'Synonym',
          'Choose the word most similar in meaning to "Meticulous".')
  RETURNING id INTO v_q;
  INSERT INTO aptitude_question_details (question_id, options, correct_answer)
  VALUES (v_q, '["Careless","Careful","Casual","Quick"]'::jsonb, '{"choice":"Careful"}'::jsonb);

  -- Coding: arrays
  INSERT INTO questions (type, topic_id, difficulty, title, prompt)
  VALUES ('coding', v_arrays, 'easy', 'Two Sum',
          'Given an array of integers nums and an integer target, return indices of the two numbers that add up to target.')
  RETURNING id INTO v_q;
  INSERT INTO coding_problem_details (question_id, function_signature, starter_code, test_cases, constraints_text, time_limit_ms, memory_limit_kb, judge0_language_ids)
  VALUES (
    v_q,
    'def two_sum(nums: List[int], target: int) -> List[int]',
    '{"python":"def two_sum(nums, target):\n    pass","javascript":"function twoSum(nums, target) {\n}"}'::jsonb,
    '[{"input":"[2,7,11,15]\n9","expected":"[0,1]"},{"input":"[3,2,4]\n6","expected":"[1,2]"}]'::jsonb,
    '2 <= nums.length <= 10^4',
    2000, 131072, ARRAY[71,63]
  );
  INSERT INTO question_companies (question_id, company_id) VALUES (v_q, v_amazon);

  INSERT INTO questions (type, topic_id, difficulty, title, prompt)
  VALUES ('coding', v_strings, 'medium', 'Longest Substring Without Repeating Characters',
          'Given a string s, find the length of the longest substring without repeating characters.')
  RETURNING id INTO v_q;
  INSERT INTO coding_problem_details (question_id, function_signature, starter_code, test_cases, constraints_text, time_limit_ms, memory_limit_kb, judge0_language_ids)
  VALUES (
    v_q,
    'def length_of_longest_substring(s: str) -> int',
    '{"python":"def length_of_longest_substring(s):\n    pass"}'::jsonb,
    '[{"input":"abcabcbb","expected":"3"},{"input":"bbbbb","expected":"1"}]'::jsonb,
    '0 <= s.length <= 5 * 10^4',
    2000, 131072, ARRAY[71]
  );
  INSERT INTO question_companies (question_id, company_id) VALUES (v_q, v_amazon);

  INSERT INTO questions (type, topic_id, difficulty, title, prompt)
  VALUES ('coding', v_dp, 'hard', 'Longest Increasing Subsequence',
          'Given an integer array nums, return the length of the longest strictly increasing subsequence.')
  RETURNING id INTO v_q;
  INSERT INTO coding_problem_details (question_id, function_signature, starter_code, test_cases, constraints_text, time_limit_ms, memory_limit_kb, judge0_language_ids)
  VALUES (
    v_q,
    'def length_of_lis(nums: List[int]) -> int',
    '{"python":"def length_of_lis(nums):\n    pass"}'::jsonb,
    '[{"input":"[10,9,2,5,3,7,101,18]","expected":"4"}]'::jsonb,
    '1 <= nums.length <= 2500',
    3000, 131072, ARRAY[71]
  );
END $$;
