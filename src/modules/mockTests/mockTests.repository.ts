import { PoolClient } from 'pg';
import { query, withTransaction } from '../../db/pool';

export async function createMockTest(params: {
  userId: string;
  tierId: string;
  aptitudeCount: number;
  codingCount: number;
}) {
  return withTransaction(async (client: PoolClient) => {
    const { rows } = await client.query(
      `INSERT INTO mock_tests (user_id, target_company_id, status) VALUES ($1,$2,'in_progress') RETURNING id, started_at`,
      [params.userId, params.tierId]
    );
    const mockTestId = rows[0].id;

    const pickQuestions = async (type: 'aptitude' | 'coding', count: number) => {
      if (count === 0) return [];
      const { rows: qs } = await client.query(
        `SELECT id FROM questions WHERE type = $1 AND is_active ORDER BY random() LIMIT $2`,
        [type, count]
      );
      return qs.map((r: any) => r.id);
    };

    const aptitudeIds = await pickQuestions('aptitude', params.aptitudeCount);
    const codingIds = await pickQuestions('coding', params.codingCount);
    const allIds = [...aptitudeIds, ...codingIds];

    for (let i = 0; i < allIds.length; i++) {
      await client.query(
        `INSERT INTO mock_test_questions (mock_test_id, question_id, order_index) VALUES ($1,$2,$3)`,
        [mockTestId, allIds[i], i + 1]
      );
    }

    return { id: mockTestId, started_at: rows[0].started_at, question_count: allIds.length };
  });
}

export async function getMockTest(mockTestId: string) {
  const { rows } = await query(
    `SELECT mt.*, ct.tier_name, c.name AS company_name
     FROM mock_tests mt
     LEFT JOIN company_tiers ct ON ct.id = mt.target_company_id
     LEFT JOIN companies c ON c.id = ct.company_id
     WHERE mt.id = $1`,
    [mockTestId]
  );
  return rows[0] ?? null;
}

export async function getMockTestQuestions(mockTestId: string) {
  const { rows } = await query(
    `SELECT mtq.order_index, q.id AS question_id, q.type, q.title, q.difficulty, t.name AS topic_name
     FROM mock_test_questions mtq
     JOIN questions q ON q.id = mtq.question_id
     JOIN topics t ON t.id = q.topic_id
     WHERE mtq.mock_test_id = $1
     ORDER BY mtq.order_index`,
    [mockTestId]
  );
  return rows;
}

export async function computeScore(mockTestId: string): Promise<number> {
  const { rows } = await query<{ score: string | null }>(
    `SELECT AVG(is_correct::int) * 100 AS score FROM assessment_attempts WHERE mock_test_id = $1`,
    [mockTestId]
  );
  return rows[0]?.score ? Number(rows[0].score) : 0;
}

export async function completeMockTest(mockTestId: string, totalScore: number) {
  await query(
    `UPDATE mock_tests SET status = 'completed', total_score = $2, completed_at = now() WHERE id = $1`,
    [mockTestId, totalScore]
  );
}

export async function abandonMockTest(mockTestId: string) {
  await query(`UPDATE mock_tests SET status = 'abandoned', completed_at = now() WHERE id = $1`, [mockTestId]);
}

export async function listMockTestsForUser(userId: string) {
  const { rows } = await query(
    `SELECT mt.id, mt.status, mt.total_score, mt.started_at, mt.completed_at, ct.tier_name, c.name AS company_name
     FROM mock_tests mt
     LEFT JOIN company_tiers ct ON ct.id = mt.target_company_id
     LEFT JOIN companies c ON c.id = ct.company_id
     WHERE mt.user_id = $1
     ORDER BY mt.started_at DESC`,
    [userId]
  );
  return rows;
}
