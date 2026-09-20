import cron from 'node-cron';
import { logger } from '../../utils/logger';
import { env } from '../../config/env';
import * as repo from './leaderboard.repository';

export async function getLeaderboard(params: { scope: 'overall' | 'college' | 'streak'; college?: string; limit: number }) {
  if (params.scope === 'streak') return repo.getStreakLeaderboard(params.limit);
  if (params.scope === 'college') {
    if (!params.college) return [];
    return repo.getCollegeLeaderboard(params.college, params.limit);
  }
  return repo.getOverallLeaderboard(params.limit);
}

export async function refreshNow() {
  await repo.refreshLeaderboard();
}

/**
 * The leaderboard is a materialized view (see migration 007) so it never
 * drifts from readiness_scores/student_streaks, but that means it's only as
 * fresh as the last REFRESH. Every 15 minutes is frequent enough for a
 * leaderboard (nobody needs second-by-second rank updates) and cheap enough
 * not to compete with interactive query load.
 */
export function scheduleLeaderboardRefresh(): void {
  if (!env.ENABLE_CRON) return; // nightlyReadinessJob already logs the "cron disabled" message once
  cron.schedule('*/15 * * * *', () => {
    refreshNow().catch((err) => logger.error({ err }, 'Leaderboard refresh failed'));
  });
  logger.info('Leaderboard refresh scheduled every 15 minutes');
}
