import { PoolClient } from 'pg';
import { query, withTransaction } from '../../db/pool';

export async function getCodingQuestionForJudging(questionId: string) {
  const { rows } = await query(
    `SELECT q.id, q.difficulty, q.topic_id, cpd.test_cases, cpd.time_limit_ms, cpd.memory_limit_kb, cpd.judge0_language_ids
     FROM questions q
     JOIN coding_problem_details cpd ON cpd.question_id = q.id
     WHERE q.id = $1 AND q.is_active AND q.type = 'coding'`,
    [questionId]
  );
  return rows[0] ?? null;
}

export async function insertCodeSubmission(
  client: PoolClient,
  params: {
    assessmentAttemptId: string | null;
    userId: string;
    questionId: string;
    language: string;
    sourceCode: string;
    judge0Token: string | null;
    status: string;
    runtimeMs: number | null;
    memoryKb: number | null;
    testCasesPassed: number;
    testCasesTotal: number;
  }
) {
  const { rows } = await client.query(
    `INSERT INTO code_submissions
       (assessment_attempt_id, user_id, question_id, language, source_code, judge0_token, status, runtime_ms, memory_kb, test_cases_passed, test_cases_total)
     VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11)
     RETURNING id`,
    [
      params.assessmentAttemptId,
      params.userId,
      params.questionId,
      params.language,
      params.sourceCode,
      params.judge0Token,
      params.status,
      params.runtimeMs,
      params.memoryKb,
      params.testCasesPassed,
      params.testCasesTotal,
    ]
  );
  return rows[0].id;
}

export async function insertAssessmentAttemptForCoding(
  client: PoolClient,
  params: {
    userId: string;
    questionId: string;
    mockTestId?: string;
    isCorrect: boolean;
    timeTakenSeconds?: number;
    hintsUsed: number;
  }
) {
  const { rows } = await client.query(
    `INSERT INTO assessment_attempts
      (user_id, question_id, mock_test_id, attempt_type, answer, time_taken_seconds, is_correct, hints_used)
     VALUES ($1,$2,$3, $4, '{}'::jsonb, $5,$6,$7)
     RETURNING id, topic_id, difficulty`,
    [
      params.userId,
      params.questionId,
      params.mockTestId ?? null,
      params.mockTestId ? 'mock_test' : 'coding',
      params.timeTakenSeconds ?? null,
      params.isCorrect,
      params.hintsUsed,
    ]
  );
  return rows[0];
}

export async function getSubmissionById(submissionId: string) {
  const { rows } = await query(`SELECT * FROM code_submissions WHERE id = $1`, [submissionId]);
  return rows[0] ?? null;
}

export async function listSubmissionsForUser(userId: string, limit = 20) {
  const { rows } = await query(
    `SELECT cs.id, cs.question_id, q.title, cs.language, cs.status, cs.runtime_ms, cs.memory_kb,
            cs.test_cases_passed, cs.test_cases_total, cs.submitted_at
     FROM code_submissions cs
     JOIN questions q ON q.id = cs.question_id
     WHERE cs.user_id = $1
     ORDER BY cs.submitted_at DESC
     LIMIT $2`,
    [userId, limit]
  );
  return rows;
}
