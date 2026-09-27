import { query, withTransaction } from '../../db/pool';

export async function getProfile(userId: string) {
  const { rows } = await query(
    `SELECT id, email, full_name, role, college, graduation_year, created_at FROM users WHERE id = $1`,
    [userId]
  );
  return rows[0] ?? null;
}

export async function getTargetCompanies(userId: string) {
  const { rows } = await query(
    `SELECT utc.company_tier_id, utc.priority, utc.added_at, ct.tier_name, c.name AS company_name
     FROM user_target_companies utc
     JOIN company_tiers ct ON ct.id = utc.company_tier_id
     JOIN companies c ON c.id = ct.company_id
     WHERE utc.user_id = $1
     ORDER BY utc.priority NULLS LAST, utc.added_at`,
    [userId]
  );
  return rows;
}

/** Replaces the full target-company set for a user (used by the onboarding "edit targets" screen). */
export async function replaceTargetCompanies(userId: string, tierIds: string[]) {
  await withTransaction(async (client) => {
    await client.query(`DELETE FROM user_target_companies WHERE user_id = $1`, [userId]);
    for (let i = 0; i < tierIds.length; i++) {
      await client.query(
        `INSERT INTO user_target_companies (user_id, company_tier_id, priority) VALUES ($1, $2, $3)`,
        [userId, tierIds[i], i + 1]
      );
      await client.query(
        `INSERT INTO readiness_scores (user_id, company_tier_id, score, probability)
         VALUES ($1, $2, 0, 0) ON CONFLICT (user_id, company_tier_id) DO NOTHING`,
        [userId, tierIds[i]]
      );
    }
  });
}

export async function getStreak(userId: string) {
  const { rows } = await query(
    `SELECT current_streak, longest_streak, last_active_date FROM student_streaks WHERE user_id = $1`,
    [userId]
  );
  return rows[0] ?? { current_streak: 0, longest_streak: 0, last_active_date: null };
}

export async function getActivityHeatmap(userId: string, sinceDays = 365) {
  const { rows } = await query(
    `SELECT activity_date FROM student_activity_log
     WHERE user_id = $1 AND activity_date >= (CURRENT_DATE - $2::int)
     ORDER BY activity_date`,
    [userId, sinceDays]
  );
  return rows.map((r: any) => r.activity_date);
}
