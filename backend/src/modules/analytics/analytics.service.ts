import * as repo from './analytics.repository';
import { getFullReadinessProfile } from '../readiness/readiness.service';
import { getTopicAnalytics } from '../assessment/assessment.service';
import { getActivityHeatmap, getStreak } from '../users/users.repository';

/**
 * Single aggregation point for Module 8's dashboard: readiness breakdown,
 * topic accuracy heatmap, coding progress by difficulty, interview radar,
 * and the streak calendar. Each piece is also independently available from
 * its own module's endpoints; this endpoint exists purely so the frontend
 * dashboard can render with one round trip instead of five.
 */
export async function getDashboard(userId: string) {
  const [readiness, topics, codingProgress, interviewRadar, streak, activityDates] = await Promise.all([
    getFullReadinessProfile(userId),
    getTopicAnalytics(userId),
    repo.getCodingProgressByDifficulty(userId),
    repo.getLatestInterviewScorecardByRoundType(userId),
    getStreak(userId),
    getActivityHeatmap(userId),
  ]);

  return {
    readiness,
    topic_heatmap: topics,
    coding_progress: codingProgress,
    interview_radar: interviewRadar,
    streak,
    activity_dates: activityDates,
  };
}
