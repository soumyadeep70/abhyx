import { query } from '../../db/pool';

export interface CompanyTierWeights {
  id: string;
  company_id: string;
  company_name: string;
  tier_name: string;
  aptitude_weight: number;
  coding_weight: number;
  resume_weight: number;
  interview_weight: number;
  consistency_weight: number;
}

export async function getTargetTiersForUser(userId: string): Promise<CompanyTierWeights[]> {
  const { rows } = await query(
    `SELECT ct.id, ct.company_id, c.name AS company_name, ct.tier_name,
            ct.aptitude_weight, ct.coding_weight, ct.resume_weight, ct.interview_weight, ct.consistency_weight
     FROM user_target_companies utc
     JOIN company_tiers ct ON ct.id = utc.company_tier_id
     JOIN companies c ON c.id = ct.company_id
     WHERE utc.user_id = $1`,
    [userId]
  );
  return rows;
}

export async function getTierWeights(tierId: string): Promise<CompanyTierWeights | null> {
  const { rows } = await query(
    `SELECT ct.id, ct.company_id, c.name AS company_name, ct.tier_name,
            ct.aptitude_weight, ct.coding_weight, ct.resume_weight, ct.interview_weight, ct.consistency_weight
     FROM company_tiers ct JOIN companies c ON c.id = ct.company_id
     WHERE ct.id = $1`,
    [tierId]
  );
  return rows[0] ?? null;
}

/** Aptitude sub-score: accuracy over the last 30 aptitude attempts, 0-100. */
export async function getAptitudeSubScore(userId: string): Promise<number> {
  const { rows } = await query<{ score: string | null }>(
    `SELECT AVG(is_correct::int) * 100 AS score FROM (
       SELECT is_correct FROM assessment_attempts
       WHERE user_id = $1 AND attempt_type IN ('aptitude','mock_test')
       ORDER BY created_at DESC LIMIT 30
     ) recent`,
    [userId]
  );
  return rows[0]?.score ? Number(rows[0].score) : 0;
}

/**
 * Coding sub-score: difficulty-weighted solve rate over distinct attempted
 * problems (easy=1, medium=2, hard=3 points; score = points solved / points
 * attempted * 100). Weighting difficulty avoids a student who only solves
 * easy problems scoring the same as one clearing hard ones.
 */
export async function getCodingSubScore(userId: string): Promise<number> {
  const { rows } = await query<{ score: string | null }>(
    `WITH per_question AS (
       SELECT q.id, q.difficulty,
              BOOL_OR(cs.status = 'accepted') AS solved
       FROM code_submissions cs
       JOIN questions q ON q.id = cs.question_id
       WHERE cs.user_id = $1
       GROUP BY q.id, q.difficulty
     ),
     weighted AS (
       SELECT
         CASE difficulty WHEN 'easy' THEN 1 WHEN 'medium' THEN 2 ELSE 3 END AS weight,
         solved
       FROM per_question
     )
     SELECT CASE WHEN SUM(weight) = 0 THEN NULL
            ELSE (SUM(weight) FILTER (WHERE solved))::float / SUM(weight) * 100 END AS score
     FROM weighted`,
    [userId]
  );
  return rows[0]?.score ? Number(rows[0].score) : 0;
}

/** Resume sub-score: latest (is_current) resume's ATS score, 0 if none uploaded. */
export async function getResumeSubScore(userId: string): Promise<number> {
  const { rows } = await query<{ ats_score: string | null }>(
    `SELECT ats_score FROM resumes WHERE user_id = $1 AND is_current LIMIT 1`,
    [userId]
  );
  return rows[0]?.ats_score ? Number(rows[0].ats_score) : 0;
}

/** Interview sub-score: average overall_score across the user's last 5 completed scorecards. */
export async function getInterviewSubScore(userId: string): Promise<number> {
  const { rows } = await query<{ score: string | null }>(
    `SELECT AVG(sc.overall_score) AS score FROM (
       SELECT isc.overall_score FROM interview_scorecards isc
       JOIN interview_sessions s ON s.id = isc.session_id
       WHERE s.user_id = $1
       ORDER BY isc.created_at DESC LIMIT 5
     ) sc`,
    [userId]
  );
  return rows[0]?.score ? Number(rows[0].score) : 0;
}

/** Consistency sub-score: current streak normalized against a 30-day cap. */
export async function getConsistencySubScore(userId: string): Promise<number> {
  const { rows } = await query<{ current_streak: number }>(
    `SELECT current_streak FROM student_streaks WHERE user_id = $1`,
    [userId]
  );
  const streak = rows[0]?.current_streak ?? 0;
  return Math.min(streak / 30, 1) * 100;
}

export async function getPreviousScore(userId: string, tierId: string): Promise<number | null> {
  const { rows } = await query<{ score: string }>(
    `SELECT score FROM readiness_scores WHERE user_id = $1 AND company_tier_id = $2`,
    [userId, tierId]
  );
  return rows[0]?.score ? Number(rows[0].score) : null;
}

export async function upsertReadinessScore(params: {
  userId: string;
  tierId: string;
  score: number;
  probability: number;
  aptitude: number;
  coding: number;
  resume: number;
  interview: number;
  consistency: number;
}) {
  await query(
    `INSERT INTO readiness_scores
       (user_id, company_tier_id, score, probability, aptitude_score, coding_score, resume_score, interview_score, consistency_score, last_computed)
     VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9, now())
     ON CONFLICT (user_id, company_tier_id) DO UPDATE SET
       score = $3, probability = $4, aptitude_score = $5, coding_score = $6,
       resume_score = $7, interview_score = $8, consistency_score = $9, last_computed = now()`,
    [
      params.userId,
      params.tierId,
      params.score,
      params.probability,
      params.aptitude,
      params.coding,
      params.resume,
      params.interview,
      params.consistency,
    ]
  );
}

export async function insertHistory(params: {
  userId: string;
  tierId: string;
  score: number;
  probability: number;
  reason: string;
}) {
  await query(
    `INSERT INTO readiness_score_history (user_id, company_tier_id, score, probability, trigger_reason)
     VALUES ($1,$2,$3,$4,$5)`,
    [params.userId, params.tierId, params.score, params.probability, params.reason]
  );
}

export async function getFullProfile(userId: string) {
  const { rows } = await query(
    `SELECT rs.company_tier_id, c.name AS company_name, ct.tier_name,
            rs.score, rs.probability, rs.aptitude_score, rs.coding_score,
            rs.resume_score, rs.interview_score, rs.consistency_score, rs.last_computed
     FROM readiness_scores rs
     JOIN company_tiers ct ON ct.id = rs.company_tier_id
     JOIN companies c ON c.id = ct.company_id
     WHERE rs.user_id = $1
     ORDER BY rs.score DESC`,
    [userId]
  );
  return rows;
}

export async function getScoreHistory(userId: string, tierId: string, limit = 30) {
  const { rows } = await query(
    `SELECT score, probability, trigger_reason, computed_at
     FROM readiness_score_history
     WHERE user_id = $1 AND company_tier_id = $2
     ORDER BY computed_at DESC LIMIT $3`,
    [userId, tierId, limit]
  );
  return rows;
}

export async function getAllUserIdsWithTargets(): Promise<string[]> {
  const { rows } = await query<{ user_id: string }>(`SELECT DISTINCT user_id FROM user_target_companies`);
  return rows.map((r) => r.user_id);
}
