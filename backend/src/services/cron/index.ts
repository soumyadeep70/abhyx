import { scheduleNightlyReadinessJob } from './nightlyReadinessJob';
import { scheduleLeaderboardRefresh } from '../../modules/leaderboard/leaderboard.service';

export function startCronJobs(): void {
  scheduleNightlyReadinessJob();
  scheduleLeaderboardRefresh();
}
