import { query } from '../../db/pool';
import { logger } from '../../utils/logger';

/**
 * Badge-award checks. Kept intentionally simple (a handful of SQL checks
 * against thresholds mentioned in HLD Module 10) rather than a generic rule
 * engine, since the badge catalog is small and curated (see seed data).
 * Called fire-and-forget after the events that can plausibly earn a badge;
 * failures here must never fail the parent request, so callers should not
 * await this on the critical path of a user-facing response when latency
 * matters (it's cheap, but this is the explicit contract).
 */
async function awardIfMissing(userId: string, badgeCode: string): Promise<boolean> {
  const { rows } = await query<{ id: string }>(`SELECT id FROM badges WHERE code = $1 AND is_active`, [badgeCode]);
  const badge = rows[0];
  if (!badge) return false;
  const { rowCount } = await query(
    `INSERT INTO user_badges (user_id, badge_id) VALUES ($1, $2) ON CONFLICT DO NOTHING`,
    [userId, badge.id]
  );
  return (rowCount ?? 0) > 0;
}

export async function checkStreakBadges(userId: string): Promise<void> {
  try {
    const { rows } = await query<{ current_streak: number }>(
      `SELECT current_streak FROM student_streaks WHERE user_id = $1`,
      [userId]
    );
    const streak = rows[0]?.current_streak ?? 0;
    if (streak >= 10) await awardIfMissing(userId, 'ten_day_streak');
    if (streak >= 30) await awardIfMissing(userId, 'thirty_day_streak');
  } catch (err) {
    logger.warn({ err, userId }, 'Streak badge check failed (non-fatal)');
  }
}

export async function checkCodingBadges(userId: string): Promise<void> {
  try {
    const { rows } = await query<{ solved: string }>(
      `SELECT COUNT(DISTINCT question_id) AS solved FROM code_submissions
       WHERE user_id = $1 AND status = 'accepted'`,
      [userId]
    );
    if (Number(rows[0]?.solved ?? 0) >= 50) await awardIfMissing(userId, 'dsa_master');
  } catch (err) {
    logger.warn({ err, userId }, 'Coding badge check failed (non-fatal)');
  }
}

export async function checkAptitudeBadges(userId: string): Promise<void> {
  try {
    const { rows } = await query<{ sessions: string }>(
      `SELECT COUNT(*) AS sessions FROM (
         SELECT date_trunc('hour', created_at) AS bucket, AVG(is_correct::int) AS acc
         FROM assessment_attempts
         WHERE user_id = $1 AND attempt_type = 'aptitude'
         GROUP BY bucket HAVING AVG(is_correct::int) >= 0.9
       ) t`,
      [userId]
    );
    if (Number(rows[0]?.sessions ?? 0) >= 5) await awardIfMissing(userId, 'aptitude_ace');
  } catch (err) {
    logger.warn({ err, userId }, 'Aptitude badge check failed (non-fatal)');
  }
}

export async function checkInterviewBadges(userId: string, overallScore: number): Promise<void> {
  try {
    if (overallScore >= 80) await awardIfMissing(userId, 'interview_ready');
  } catch (err) {
    logger.warn({ err, userId }, 'Interview badge check failed (non-fatal)');
  }
}

export async function checkResumeBadges(userId: string, atsScore: number): Promise<void> {
  try {
    if (atsScore >= 85) await awardIfMissing(userId, 'resume_polished');
  } catch (err) {
    logger.warn({ err, userId }, 'Resume badge check failed (non-fatal)');
  }
}

export async function checkMockTestBadges(userId: string): Promise<void> {
  try {
    await awardIfMissing(userId, 'first_mock_test');
  } catch (err) {
    logger.warn({ err, userId }, 'Mock test badge check failed (non-fatal)');
  }
}

export async function listBadgesForUser(userId: string) {
  const { rows } = await query(
    `SELECT b.code, b.name, b.description, b.icon_url, ub.earned_at
     FROM badges b
     LEFT JOIN user_badges ub ON ub.badge_id = b.id AND ub.user_id = $1
     WHERE b.is_active
     ORDER BY (ub.earned_at IS NULL), ub.earned_at DESC`,
    [userId]
  );
  return rows;
}
