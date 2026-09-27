import { PoolClient } from 'pg';
import { query, withTransaction } from '../../db/pool';

export async function createSession(params: {
  userId: string;
  roundType: 'technical' | 'hr' | 'system_design';
  tierId?: string;
}) {
  const { rows } = await query(
    `INSERT INTO interview_sessions (user_id, target_company_id, round_type, status)
     VALUES ($1,$2,$3,'in_progress') RETURNING id, started_at`,
    [params.userId, params.tierId ?? null, params.roundType]
  );
  return rows[0];
}

export async function getSession(sessionId: string) {
  const { rows } = await query(
    `SELECT s.*, ct.tier_name, c.name AS company_name
     FROM interview_sessions s
     LEFT JOIN company_tiers ct ON ct.id = s.target_company_id
     LEFT JOIN companies c ON c.id = ct.company_id
     WHERE s.id = $1`,
    [sessionId]
  );
  return rows[0] ?? null;
}

export async function getNextSequenceNumber(sessionId: string): Promise<number> {
  const { rows } = await query<{ max: number | null }>(
    `SELECT MAX(sequence_number) AS max FROM interview_messages WHERE session_id = $1`,
    [sessionId]
  );
  return (rows[0]?.max ?? 0) + 1;
}

export async function getLastInterviewerMessage(sessionId: string) {
  const { rows } = await query(
    `SELECT id, message FROM interview_messages
     WHERE session_id = $1 AND role = 'interviewer'
     ORDER BY sequence_number DESC LIMIT 1`,
    [sessionId]
  );
  return rows[0] ?? null;
}

export async function getConversationHistory(sessionId: string) {
  const { rows } = await query(
    `SELECT role, message FROM interview_messages WHERE session_id = $1 ORDER BY sequence_number`,
    [sessionId]
  );
  return rows;
}

export async function insertMessage(
  client: PoolClient,
  params: { sessionId: string; role: 'interviewer' | 'candidate'; message: string; sequenceNumber: number }
) {
  const { rows } = await client.query(
    `INSERT INTO interview_messages (session_id, role, message, sequence_number) VALUES ($1,$2,$3,$4) RETURNING id`,
    [params.sessionId, params.role, params.message, params.sequenceNumber]
  );
  return rows[0].id;
}

export async function insertAnswerScore(
  client: PoolClient,
  params: {
    sessionId: string;
    candidateMessageId: string;
    technicalAccuracy: number;
    communicationClarity: number;
    problemSolvingApproach: number;
    depthOfKnowledge: number;
    hrReadiness: number | null;
  }
) {
  await client.query(
    `INSERT INTO interview_answer_scores
       (session_id, candidate_message_id, technical_accuracy, communication_clarity, problem_solving_approach, depth_of_knowledge, hr_readiness)
     VALUES ($1,$2,$3,$4,$5,$6,$7)`,
    [
      params.sessionId,
      params.candidateMessageId,
      params.technicalAccuracy,
      params.communicationClarity,
      params.problemSolvingApproach,
      params.depthOfKnowledge,
      params.hrReadiness,
    ]
  );
}

export async function getAnswerScoresForSession(sessionId: string) {
  const { rows } = await query(
    `SELECT technical_accuracy, communication_clarity, problem_solving_approach, depth_of_knowledge, hr_readiness
     FROM interview_answer_scores WHERE session_id = $1`,
    [sessionId]
  );
  return rows;
}

export async function markSessionCompleted(sessionId: string, durationSeconds: number) {
  await query(
    `UPDATE interview_sessions SET status = 'completed', completed_at = now(), duration_seconds = $2 WHERE id = $1`,
    [sessionId, durationSeconds]
  );
}

export async function getScorecard(sessionId: string) {
  const { rows } = await query(`SELECT * FROM interview_scorecards WHERE session_id = $1`, [sessionId]);
  return rows[0] ?? null;
}

export async function insertScorecard(params: {
  sessionId: string;
  dims: {
    technical_accuracy: number;
    communication_clarity: number;
    problem_solving_approach: number;
    depth_of_knowledge: number;
    hr_readiness: number | null;
  };
  overallScore: number;
  strengths: string[];
  weaknesses: string[];
  improvementPlan: string[];
  hiringRecommendation: 'hire' | 'borderline' | 'no_hire';
}) {
  await query(
    `INSERT INTO interview_scorecards
       (session_id, technical_accuracy, communication_clarity, problem_solving_approach, depth_of_knowledge, hr_readiness,
        overall_score, strengths, weaknesses, improvement_plan, hiring_recommendation)
     VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11)
     ON CONFLICT (session_id) DO NOTHING`,
    [
      params.sessionId,
      params.dims.technical_accuracy,
      params.dims.communication_clarity,
      params.dims.problem_solving_approach,
      params.dims.depth_of_knowledge,
      params.dims.hr_readiness,
      params.overallScore,
      params.strengths,
      params.weaknesses,
      params.improvementPlan,
      params.hiringRecommendation,
    ]
  );
}

export async function listSessionsForUser(userId: string) {
  const { rows } = await query(
    `SELECT s.id, s.round_type, s.status, s.started_at, s.completed_at, s.duration_seconds,
            ct.tier_name, c.name AS company_name, sc.overall_score, sc.hiring_recommendation
     FROM interview_sessions s
     LEFT JOIN company_tiers ct ON ct.id = s.target_company_id
     LEFT JOIN companies c ON c.id = ct.company_id
     LEFT JOIN interview_scorecards sc ON sc.session_id = s.id
     WHERE s.user_id = $1
     ORDER BY s.started_at DESC`,
    [userId]
  );
  return rows;
}
