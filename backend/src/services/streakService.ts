import { PoolClient } from 'pg';

/**
 * Records today's activity for a user and updates their streak counters.
 * Called from any module that represents "the student did something today"
 * (assessment submit, code submission, interview message, mock test start).
 *
 * Uses the natural (user_id, activity_date) PK with ON CONFLICT DO NOTHING
 * as the dedupe key (per schema note), so calling this multiple times in one
 * day is a no-op for the log but still safe to call unconditionally.
 *
 * Must be called with a client already inside the caller's transaction so
 * the activity log + streak update are atomic with the action that
 * triggered them.
 */
export async function recordActivity(client: PoolClient, userId: string): Promise<void> {
  const { rowCount } = await client.query(
    `INSERT INTO student_activity_log (user_id, activity_date) VALUES ($1, CURRENT_DATE)
     ON CONFLICT (user_id, activity_date) DO NOTHING`,
    [userId]
  );
  if (rowCount === 0) return; // already recorded today, streak already accounted for

  const { rows } = await client.query(
    `SELECT current_streak, longest_streak, last_active_date FROM student_streaks WHERE user_id = $1 FOR UPDATE`,
    [userId]
  );
  const streak = rows[0] ?? { current_streak: 0, longest_streak: 0, last_active_date: null };

  let newCurrent: number;
  if (!streak.last_active_date) {
    newCurrent = 1;
  } else {
    const last = new Date(streak.last_active_date);
    const diffDays = Math.round((Date.now() - last.getTime()) / 86_400_000);
    newCurrent = diffDays === 1 ? streak.current_streak + 1 : 1; // gap > 1 day resets; diffDays===0 can't happen (log dedupe above)
  }
  const newLongest = Math.max(newCurrent, streak.longest_streak ?? 0);

  await client.query(
    `INSERT INTO student_streaks (user_id, current_streak, longest_streak, last_active_date)
     VALUES ($1, $2, $3, CURRENT_DATE)
     ON CONFLICT (user_id) DO UPDATE
       SET current_streak = $2, longest_streak = $3, last_active_date = CURRENT_DATE`,
    [userId, newCurrent, newLongest]
  );
}
