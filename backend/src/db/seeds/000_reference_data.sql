-- Core reference data used by the app and the sample question seed.

INSERT INTO companies (name) VALUES
  ('TCS'), ('Infosys'), ('Wipro'), ('Amazon'), ('Accenture')
ON CONFLICT (name) DO NOTHING;

INSERT INTO company_tiers (company_id, tier_name, aptitude_weight, coding_weight, resume_weight, interview_weight, consistency_weight)
SELECT c.id, t.tier_name, t.aptitude_weight, t.coding_weight, t.resume_weight, t.interview_weight, t.consistency_weight
FROM (VALUES
  ('TCS',       'TCS Ninja',   40, 25, 10, 20, 5),
  ('Infosys',   'Infosys SP',  35, 25, 15, 20, 5),
  ('Wipro',     'Wipro Elite', 30, 30, 15, 20, 5),
  ('Amazon',    'Amazon SDE',  15, 45, 15, 20, 5),
  ('Accenture', 'Accenture',   30, 25, 20, 20, 5)
) AS t(company_name, tier_name, aptitude_weight, coding_weight, resume_weight, interview_weight, consistency_weight)
JOIN companies c ON c.name = t.company_name
ON CONFLICT (company_id, tier_name) DO NOTHING;

-- Keep consistency at 5 points and reduce interview weight accordingly so
-- each tier's five weights satisfy the schema's total-weight constraint.

INSERT INTO topics (name, category) VALUES
  ('Quantitative Aptitude', 'aptitude'),
  ('Logical Reasoning', 'aptitude'),
  ('Verbal Ability', 'aptitude'),
  ('Data Interpretation', 'aptitude'),
  ('Arrays', 'coding'),
  ('Strings', 'coding'),
  ('Linked Lists', 'coding'),
  ('Trees', 'coding'),
  ('Graphs', 'coding'),
  ('Dynamic Programming', 'coding'),
  ('Recursion & Backtracking', 'coding'),
  ('Sorting & Searching', 'coding'),
  ('SQL', 'coding'),
  ('Operating Systems', 'coding'),
  ('DBMS', 'coding'),
  ('OOP Concepts', 'coding')
ON CONFLICT (name, category) DO NOTHING;

INSERT INTO badges (code, name, description) VALUES
  ('ten_day_streak',   '10-Day Streak',     'Practiced 10 days in a row'),
  ('thirty_day_streak','30-Day Streak',     'Practiced 30 days in a row'),
  ('dsa_master',       'DSA Master',        'Solved 50+ coding problems across all difficulties'),
  ('aptitude_ace',     'Aptitude Ace',      'Scored 90%+ accuracy in 5+ aptitude sessions'),
  ('interview_ready',  'Interview Ready',   'Achieved an overall interview scorecard of 80+'),
  ('resume_polished',  'Resume Polished',   'Achieved an ATS score of 85+'),
  ('first_mock_test',  'First Mock Test',   'Completed your first full-length mock test')
ON CONFLICT (code) DO NOTHING;