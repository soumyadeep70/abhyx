import { ApiError } from '../../utils/ApiError';
import { logger } from '../../utils/logger';
import { checkMockTestBadges } from '../gamification/badges.service';
import { maybeRecomputeReadiness } from '../readiness/readiness.service';
import * as repo from './mockTests.repository';

export async function startMockTest(params: {
  userId: string;
  tierId: string;
  aptitudeCount: number;
  codingCount: number;
}) {
  const created = await repo.createMockTest(params);
  if (created.question_count === 0) throw ApiError.internal('No active questions available to build a mock test');
  const questions = await repo.getMockTestQuestions(created.id);
  return { ...created, questions };
}

export async function getMockTestDetail(mockTestId: string) {
  const test = await repo.getMockTest(mockTestId);
  if (!test) throw ApiError.notFound('Mock test not found');
  const questions = await repo.getMockTestQuestions(mockTestId);
  return { ...test, questions };
}

export async function finishMockTest(mockTestId: string, userId: string) {
  const test = await repo.getMockTest(mockTestId);
  if (!test) throw ApiError.notFound('Mock test not found');
  if (test.status !== 'in_progress') throw ApiError.conflict('Mock test is not in progress');

  const score = await repo.computeScore(mockTestId);
  await repo.completeMockTest(mockTestId, score);

  checkMockTestBadges(userId).catch((err) => logger.warn({ err }, 'mock test badge check failed'));
  maybeRecomputeReadiness(userId, 'assessment_batch').catch((err) =>
    logger.warn({ err }, 'readiness recompute after mock test failed')
  );

  return { id: mockTestId, status: 'completed', total_score: score };
}

export async function abandonMockTest(mockTestId: string) {
  const test = await repo.getMockTest(mockTestId);
  if (!test) throw ApiError.notFound('Mock test not found');
  await repo.abandonMockTest(mockTestId);
  return { id: mockTestId, status: 'abandoned' };
}

export async function listMockTests(userId: string) {
  return repo.listMockTestsForUser(userId);
}
