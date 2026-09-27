import { query } from '../../db/pool';

/** Coding progress by difficulty over time (weekly buckets), for a line chart. */
export async function getCodingProgressByDifficulty(userId: string) {
  const { rows } = await query(
    `SELECT date_trunc('week', cs.submitted_at) AS week,
            q.difficulty,
            COUNT(*) FILTER (WHERE cs.status = 'accepted') AS solved
     FROM code_submissions cs
     JOIN questions q ON q.id = cs.question_id
     WHERE cs.user_id = $1
     GROUP BY week, q.difficulty
     ORDER BY week`,
    [userId]
  );
  return rows;
}

export async function getLatestInterviewScorecardByRoundType(userId: string) {
  const { rows } = await query(
    `SELECT DISTINCT ON (s.round_type)
            s.round_type, sc.technical_accuracy, sc.communication_clarity,
            sc.problem_solving_approach, sc.depth_of_knowledge, sc.hr_readiness,
            sc.overall_score, sc.created_at
     FROM interview_scorecards sc
     JOIN interview_sessions s ON s.id = sc.session_id
     WHERE s.user_id = $1
     ORDER BY s.round_type, sc.created_at DESC`,
    [userId]
  );
  return rows;
}
