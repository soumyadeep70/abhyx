import { PoolClient } from 'pg';
import { query, withTransaction } from '../../db/pool';

export async function getAptitudeAnswerKey(questionId: string) {
  const { rows } = await query(
    `SELECT correct_answer FROM aptitude_question_details WHERE question_id = $1`,
    [questionId]
  );
  return rows[0]?.correct_answer ?? null;
}

export async function insertAssessmentAttempt(
  client: PoolClient,
  params: {
    userId: string;
    questionId: string;
    mockTestId?: string;
    attemptType: 'aptitude' | 'coding' | 'mock_test';
    answer: unknown;
    timeTakenSeconds?: number;
    isCorrect: boolean;
    hintsUsed: number;
    errorType?: string;
  }
) {
  const { rows } = await client.query(
    `INSERT INTO assessment_attempts
      (user_id, question_id, mock_test_id, attempt_type, answer, time_taken_seconds, is_correct, hints_used, error_type)
     VALUES ($1,$2,$3,$4,$5::jsonb,$6,$7,$8,$9)
     RETURNING id, topic_id, difficulty`,
    [
      params.userId,
      params.questionId,
      params.mockTestId ?? null,
      params.attemptType,
      JSON.stringify(params.answer ?? {}),
      params.timeTakenSeconds ?? null,
      params.isCorrect,
      params.hintsUsed,
      params.errorType ?? null,
    ]
  );
  return rows[0];
}

export async function countAttemptsSince(userId: string, sinceAttemptCount = 5): Promise<number> {
  const { rows } = await query<{ count: string }>(
    `SELECT COUNT(*) AS count FROM assessment_attempts WHERE user_id = $1`,
    [userId]
  );
  return Number(rows[0]?.count ?? 0);
}

export async function getTopicPerformance(userId: string) {
  const { rows } = await query(
    `SELECT t.id AS topic_id, t.name AS topic_name, t.category,
            COUNT(*) AS attempts,
            AVG(aa.is_correct::int)::float AS accuracy
     FROM assessment_attempts aa
     JOIN topics t ON t.id = aa.topic_id
     WHERE aa.user_id = $1
     GROUP BY t.id, t.name, t.category
     ORDER BY t.category, t.name`,
    [userId]
  );
  return rows;
}

export async function upsertSkillMap(userId: string, topicId: string, status: 'strong' | 'weak' | 'improving') {
  await query(
    `INSERT INTO student_skill_map (user_id, topic_id, status, last_analyzed)
     VALUES ($1,$2,$3, now())
     ON CONFLICT (user_id, topic_id) DO UPDATE SET status = $3, last_analyzed = now()`,
    [userId, topicId, status]
  );
}

export async function getWeakTopicIds(userId: string, category: 'aptitude' | 'coding'): Promise<string[]> {
  const { rows } = await query<{ topic_id: string }>(
    `SELECT ssm.topic_id FROM student_skill_map ssm
     JOIN topics t ON t.id = ssm.topic_id
     WHERE ssm.user_id = $1 AND ssm.status = 'weak' AND t.category = $2`,
    [userId, category]
  );
  return rows.map((r) => r.topic_id);
}

export async function getStrongTopicIds(userId: string, category: 'aptitude' | 'coding'): Promise<string[]> {
  const { rows } = await query<{ topic_id: string }>(
    `SELECT ssm.topic_id FROM student_skill_map ssm
     JOIN topics t ON t.id = ssm.topic_id
     WHERE ssm.user_id = $1 AND ssm.status = 'strong' AND t.category = $2`,
    [userId, category]
  );
  return rows.map((r) => r.topic_id);
}

/**
 * Adaptive question picker (Feature 7):
 *  - if the student has weak topics in this category, serve one from there,
 *    preferring easy/medium difficulty and questions not yet answered correctly
 *  - else if they have strong topics, serve a harder question in one of them
 *  - else fall back to any active, unattempted question in the category
 * Company filter (via question_companies) is applied when the student has a
 * target company selected, biasing toward company-relevant questions without
 * making them mandatory (falls back to any question if none match).
 */
export async function pickAdaptiveQuestion(params: {
  userId: string;
  category: 'aptitude' | 'coding';
  companyId?: string;
}) {
  const { userId, category, companyId } = params;

  const weakTopicIds = await getWeakTopicIds(userId, category);
  const strongTopicIds = await getStrongTopicIds(userId, category);

  const attempt = async (topicIds: string[] | null, difficulty: string[] | null, preferCompany: boolean) => {
    const conditions = [`q.type = $1`, `q.is_active`];
    const params2: any[] = [category];

    if (topicIds && topicIds.length) {
      params2.push(topicIds);
      conditions.push(`q.topic_id = ANY($${params2.length}::uuid[])`);
    }
    if (difficulty && difficulty.length) {
      params2.push(difficulty);
      conditions.push(`q.difficulty = ANY($${params2.length}::question_difficulty[])`);
    }
    // exclude questions already answered correctly by this user
    params2.push(userId);
    conditions.push(
      `NOT EXISTS (SELECT 1 FROM assessment_attempts aa WHERE aa.question_id = q.id AND aa.user_id = $${params2.length} AND aa.is_correct)`
    );

    let companyJoin = '';
    if (preferCompany && companyId) {
      params2.push(companyId);
      companyJoin = `JOIN question_companies qc ON qc.question_id = q.id AND qc.company_id = $${params2.length}`;
    }

    const { rows } = await query(
      `SELECT q.id, q.topic_id, q.difficulty, q.title
       FROM questions q
       ${companyJoin}
       WHERE ${conditions.join(' AND ')}
       ORDER BY random()
       LIMIT 1`,
      params2
    );
    return rows[0] ?? null;
  };

  // 1. weak topic, easy/medium, company-preferred
  if (weakTopicIds.length) {
    const q =
      (await attempt(weakTopicIds, ['easy', 'medium'], true)) ?? (await attempt(weakTopicIds, ['easy', 'medium'], false));
    if (q) return q;
  }
  // 2. strong topic, hard, to keep pushing difficulty up
  if (strongTopicIds.length) {
    const q = (await attempt(strongTopicIds, ['hard', 'medium'], true)) ?? (await attempt(strongTopicIds, ['hard', 'medium'], false));
    if (q) return q;
  }
  // 3. fallback: anything unattempted, company-preferred first
  return (await attempt(null, null, true)) ?? (await attempt(null, null, false));
}
