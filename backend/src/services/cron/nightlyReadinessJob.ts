import cron from 'node-cron';
import { env } from '../../config/env';
import { logger } from '../../utils/logger';
import { getAllUserIdsForNightlyJob, maybeRecomputeReadiness } from '../../modules/readiness/readiness.service';

/**
 * Nightly batch recompute for every student with at least one target
 * company, per HLD's readiness_score_history.trigger_reason = 'nightly_job'.
 * Runs sequentially (not in parallel) to keep DB and AI-service load bounded
 * on a free-tier deployment; acceptable at student-project scale, called out
 * in CHANGES_AND_ASSUMPTIONS.md as the first thing to parallelize/queue if
 * the user base grows.
 */
export async function runNightlyReadinessJob(): Promise<void> {
  const userIds = await getAllUserIdsForNightlyJob();
  logger.info({ count: userIds.length }, 'Starting nightly readiness recompute');
  for (const userId of userIds) {
    try {
      await maybeRecomputeReadiness(userId, 'nightly_job');
    } catch (err) {
      logger.error({ err, userId }, 'Nightly readiness recompute failed for user');
    }
  }
  logger.info('Nightly readiness recompute complete');
}

export function scheduleNightlyReadinessJob(): void {
  if (!env.ENABLE_CRON) {
    logger.info('Cron disabled via ENABLE_CRON=false');
    return;
  }
  cron.schedule(env.NIGHTLY_JOB_CRON, () => {
    runNightlyReadinessJob().catch((err) => logger.error({ err }, 'Nightly readiness job crashed'));
  });
  logger.info({ schedule: env.NIGHTLY_JOB_CRON }, 'Nightly readiness job scheduled');
}
