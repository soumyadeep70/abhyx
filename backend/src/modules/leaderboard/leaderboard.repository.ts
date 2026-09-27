import { query } from '../../db/pool';

export async function refreshLeaderboard() {
  // CONCURRENTLY requires the unique index created in migration 007; avoids
  // locking readers out while the view recomputes.
  await query(`REFRESH MATERIALIZED VIEW CONCURRENTLY mv_leaderboard`);
}

export async function getOverallLeaderboard(limit: number) {
  const { rows } = await query(
    `SELECT user_id, full_name, college, avg_readiness_score, best_readiness_score,
            current_streak, longest_streak, overall_rank
     FROM mv_leaderboard ORDER BY overall_rank LIMIT $1`,
    [limit]
  );
  return rows;
}

export async function getCollegeLeaderboard(college: string, limit: number) {
  const { rows } = await query(
    `SELECT user_id, full_name, college, avg_readiness_score, best_readiness_score,
            current_streak, longest_streak, college_rank
     FROM mv_leaderboard WHERE college = $1 ORDER BY college_rank LIMIT $2`,
    [college, limit]
  );
  return rows;
}

export async function getStreakLeaderboard(limit: number) {
  const { rows } = await query(
    `SELECT user_id, full_name, college, current_streak, longest_streak
     FROM mv_leaderboard ORDER BY current_streak DESC, longest_streak DESC LIMIT $1`,
    [limit]
  );
  return rows;
}
