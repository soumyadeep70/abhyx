import { query, withTransaction } from '../../db/pool';

export async function listQuestions(filters: {
  type?: 'aptitude' | 'coding';
  topicId?: string;
  difficulty?: 'easy' | 'medium' | 'hard';
  companyId?: string;
  page: number;
  pageSize: number;
}) {
  const conditions: string[] = ['q.is_active'];
  const params: any[] = [];

  if (filters.type) { params.push(filters.type); conditions.push(`q.type = $${params.length}`); }
  if (filters.topicId) { params.push(filters.topicId); conditions.push(`q.topic_id = $${params.length}`); }
  if (filters.difficulty) { params.push(filters.difficulty); conditions.push(`q.difficulty = $${params.length}`); }

  let companyJoin = '';
  if (filters.companyId) {
    params.push(filters.companyId);
    companyJoin = `JOIN question_companies qc ON qc.question_id = q.id AND qc.company_id = $${params.length}`;
  }

  const offset = (filters.page - 1) * filters.pageSize;
  params.push(filters.pageSize, offset);

  const { rows } = await query(
    `SELECT q.id, q.type, q.topic_id, t.name AS topic_name, q.difficulty, q.title, q.created_at
     FROM questions q
     JOIN topics t ON t.id = q.topic_id
     ${companyJoin}
     WHERE ${conditions.join(' AND ')}
     ORDER BY q.created_at DESC
     LIMIT $${params.length - 1} OFFSET $${params.length}`,
    params
  );
  return rows;
}

export async function getQuestionWithDetails(questionId: string, includeAnswer: boolean) {
  const { rows } = await query(
    `SELECT q.*, t.name AS topic_name FROM questions q JOIN topics t ON t.id = q.topic_id WHERE q.id = $1`,
    [questionId]
  );
  const question = rows[0];
  if (!question) return null;

  if (question.type === 'aptitude') {
    const { rows: details } = await query(
      `SELECT options, correct_answer FROM aptitude_question_details WHERE question_id = $1`,
      [questionId]
    );
    return {
      ...question,
      options: details[0]?.options ?? [],
      correct_answer: includeAnswer ? details[0]?.correct_answer : undefined,
    };
  }

  const { rows: details } = await query(
    `SELECT function_signature, starter_code, test_cases, constraints_text, time_limit_ms, memory_limit_kb, judge0_language_ids
     FROM coding_problem_details WHERE question_id = $1`,
    [questionId]
  );
  const d = details[0] ?? {};
  return {
    ...question,
    function_signature: d.function_signature,
    starter_code: d.starter_code,
    constraints_text: d.constraints_text,
    time_limit_ms: d.time_limit_ms,
    memory_limit_kb: d.memory_limit_kb,
    judge0_language_ids: d.judge0_language_ids,
    // sample test cases only unless caller explicitly wants the judge set (submission path fetches separately)
    sample_test_cases: Array.isArray(d.test_cases) ? d.test_cases.slice(0, 1) : [],
  };
}

export async function getFullTestCases(questionId: string): Promise<{ input: string; expected: string }[]> {
  const { rows } = await query(`SELECT test_cases FROM coding_problem_details WHERE question_id = $1`, [questionId]);
  return rows[0]?.test_cases ?? [];
}

export async function createAptitudeQuestion(input: any) {
  return withTransaction(async (client) => {
    const { rows } = await client.query(
      `INSERT INTO questions (type, topic_id, difficulty, title, prompt) VALUES ('aptitude', $1,$2,$3,$4) RETURNING id`,
      [input.topic_id, input.difficulty, input.title, input.prompt]
    );
    const questionId = rows[0].id;
    await client.query(
      `INSERT INTO aptitude_question_details (question_id, options, correct_answer) VALUES ($1,$2::jsonb,$3::jsonb)`,
      [questionId, JSON.stringify(input.options), JSON.stringify(input.correct_answer)]
    );
    await linkTagsAndCompanies(client, questionId, input.tag_ids, input.company_ids);
    return questionId;
  });
}

export async function createCodingQuestion(input: any) {
  return withTransaction(async (client) => {
    const { rows } = await client.query(
      `INSERT INTO questions (type, topic_id, difficulty, title, prompt) VALUES ('coding', $1,$2,$3,$4) RETURNING id`,
      [input.topic_id, input.difficulty, input.title, input.prompt]
    );
    const questionId = rows[0].id;
    await client.query(
      `INSERT INTO coding_problem_details
        (question_id, function_signature, starter_code, test_cases, constraints_text, time_limit_ms, memory_limit_kb, judge0_language_ids)
       VALUES ($1,$2,$3::jsonb,$4::jsonb,$5,$6,$7,$8)`,
      [
        questionId,
        input.function_signature ?? null,
        JSON.stringify(input.starter_code ?? {}),
        JSON.stringify(input.test_cases),
        input.constraints_text ?? null,
        input.time_limit_ms,
        input.memory_limit_kb,
        input.judge0_language_ids,
      ]
    );
    await linkTagsAndCompanies(client, questionId, input.tag_ids, input.company_ids);
    return questionId;
  });
}

async function linkTagsAndCompanies(client: any, questionId: string, tagIds: string[] = [], companyIds: string[] = []) {
  for (const tagId of tagIds) {
    await client.query(`INSERT INTO question_tags (question_id, tag_id) VALUES ($1,$2) ON CONFLICT DO NOTHING`, [questionId, tagId]);
  }
  for (const companyId of companyIds) {
    await client.query(`INSERT INTO question_companies (question_id, company_id) VALUES ($1,$2) ON CONFLICT DO NOTHING`, [questionId, companyId]);
  }
}

export async function deactivateQuestion(questionId: string) {
  await query(`UPDATE questions SET is_active = FALSE WHERE id = $1`, [questionId]);
}

export async function listTopics() {
  const { rows } = await query(`SELECT id, name, category, parent_topic_id FROM topics ORDER BY category, name`);
  return rows;
}
