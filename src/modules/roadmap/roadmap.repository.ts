import { PoolClient } from 'pg';
import { query, withTransaction } from '../../db/pool';

export async function findTopicIdsByNames(names: string[]): Promise<Map<string, string>> {
  if (!names.length) return new Map();
  const { rows } = await query(`SELECT id, name FROM topics WHERE name ILIKE ANY($1::text[])`, [names]);
  const map = new Map<string, string>();
  for (const row of rows as any[]) map.set(row.name.toLowerCase(), row.id);
  return map;
}

export async function abandonActiveRoadmap(client: PoolClient, userId: string) {
  await client.query(`UPDATE roadmaps SET status = 'abandoned' WHERE user_id = $1 AND status = 'active'`, [userId]);
}

export async function createRoadmap(params: {
  userId: string;
  tierId: string;
  targetDate?: string;
  phases: { phase_number: number; title: string; topicIds: string[] }[];
}) {
  return withTransaction(async (client: PoolClient) => {
    await abandonActiveRoadmap(client, params.userId);

    const { rows } = await client.query(
      `INSERT INTO roadmaps (user_id, target_company_id, target_date, status) VALUES ($1,$2,$3,'active') RETURNING id, generated_at`,
      [params.userId, params.tierId, params.targetDate ?? null]
    );
    const roadmapId = rows[0].id;

    for (const phase of params.phases) {
      const { rows: phaseRows } = await client.query(
        `INSERT INTO roadmap_phases (roadmap_id, phase_number, title, status)
         VALUES ($1,$2,$3, $4) RETURNING id`,
        [roadmapId, phase.phase_number, phase.title, phase.phase_number === 1 ? 'active' : 'pending']
      );
      const phaseId = phaseRows[0].id;
      for (const topicId of phase.topicIds) {
        await client.query(
          `INSERT INTO roadmap_phase_topics (roadmap_phase_id, topic_id) VALUES ($1,$2) ON CONFLICT DO NOTHING`,
          [phaseId, topicId]
        );
      }
    }

    return { id: roadmapId, generated_at: rows[0].generated_at };
  });
}

export async function getActiveRoadmap(userId: string) {
  const { rows } = await query(
    `SELECT r.*, ct.tier_name, c.name AS company_name
     FROM roadmaps r
     LEFT JOIN company_tiers ct ON ct.id = r.target_company_id
     LEFT JOIN companies c ON c.id = ct.company_id
     WHERE r.user_id = $1 AND r.status = 'active'`,
    [userId]
  );
  return rows[0] ?? null;
}

export async function getPhasesForRoadmap(roadmapId: string) {
  const { rows } = await query(
    `SELECT rp.id, rp.phase_number, rp.title, rp.status,
            COALESCE(ARRAY_AGG(t.name) FILTER (WHERE t.name IS NOT NULL), '{}') AS topics
     FROM roadmap_phases rp
     LEFT JOIN roadmap_phase_topics rpt ON rpt.roadmap_phase_id = rp.id
     LEFT JOIN topics t ON t.id = rpt.topic_id
     WHERE rp.roadmap_id = $1
     GROUP BY rp.id
     ORDER BY rp.phase_number`,
    [roadmapId]
  );
  return rows;
}

export async function getPhaseById(phaseId: string) {
  const { rows } = await query(`SELECT * FROM roadmap_phases WHERE id = $1`, [phaseId]);
  return rows[0] ?? null;
}

export async function markPhaseCompleted(phaseId: string) {
  await query(`UPDATE roadmap_phases SET status = 'completed' WHERE id = $1`, [phaseId]);
}

export async function activateNextPendingPhase(roadmapId: string) {
  await query(
    `UPDATE roadmap_phases SET status = 'active'
     WHERE id = (
       SELECT id FROM roadmap_phases
       WHERE roadmap_id = $1 AND status = 'pending'
       ORDER BY phase_number LIMIT 1
     )`,
    [roadmapId]
  );
}

export async function countIncompletePhases(roadmapId: string): Promise<number> {
  const { rows } = await query<{ count: string }>(
    `SELECT COUNT(*) AS count FROM roadmap_phases WHERE roadmap_id = $1 AND status <> 'completed'`,
    [roadmapId]
  );
  return Number(rows[0].count);
}

export async function markRoadmapCompleted(roadmapId: string) {
  await query(`UPDATE roadmaps SET status = 'completed' WHERE id = $1`, [roadmapId]);
}
