import { describe, it, expect, vi, beforeEach } from 'vitest';

// vi.mock() factories are hoisted above module-level consts; vi.hoisted() keeps
// this object initialised in time for the factory below (avoids a TDZ ReferenceError).
const repoMock = vi.hoisted(() => ({
  getAptitudeAnswerKey: vi.fn(),
  insertAssessmentAttempt: vi.fn(),
  countAttemptsSince: vi.fn(),
  getTopicPerformance: vi.fn(),
  upsertSkillMap: vi.fn(),
  pickAdaptiveQuestion: vi.fn(),
}));
vi.mock('../../../../src/modules/assessment/assessment.repository', () => repoMock);

const withTransactionMock = vi.fn(async (fn: any) => fn({} as any));
vi.mock('../../../../src/db/pool', () => ({
  withTransaction: (...args: any[]) => withTransactionMock(...(args as [any])),
  query: vi.fn(),
}));

const recordActivityMock = vi.fn();
vi.mock('../../../../src/services/streakService', () => ({
  recordActivity: (...args: any[]) => recordActivityMock(...args),
}));

const checkAptitudeBadgesMock = vi.fn().mockResolvedValue(undefined);
vi.mock('../../../../src/modules/gamification/badges.service', () => ({
  checkAptitudeBadges: (...args: any[]) => checkAptitudeBadgesMock(...args),
}));

const analyzeWeakTopicsMock = vi.fn();
vi.mock('../../../../src/services/aiServiceClient', () => ({
  analyzeWeakTopics: (...args: any[]) => analyzeWeakTopicsMock(...args),
}));

const getCacheMock = vi.fn();
const setCacheMock = vi.fn();
vi.mock('../../../../src/services/cacheService', () => ({
  buildCacheKey: (...parts: string[]) => parts.join(':'),
  getCache: (...args: any[]) => getCacheMock(...args),
  setCache: (...args: any[]) => setCacheMock(...args),
}));

const getQuestionWithDetailsMock = vi.fn();
vi.mock('../../../../src/modules/questions/questions.repository', () => ({
  getQuestionWithDetails: (...args: any[]) => getQuestionWithDetailsMock(...args),
}));

const maybeRecomputeReadinessMock = vi.fn().mockResolvedValue(undefined);
vi.mock('../../../../src/modules/readiness/readiness.service', () => ({
  maybeRecomputeReadiness: (...args: any[]) => maybeRecomputeReadinessMock(...args),
}));

import * as assessmentService from '../../../../src/modules/assessment/assessment.service';
import { ApiError } from '../../../../src/utils/ApiError';

function flush() {
  return new Promise((r) => setImmediate(r));
}

describe('assessment.service.submitAptitudeAnswer', () => {
  beforeEach(() => {
    Object.values(repoMock).forEach((fn) => fn.mockReset());
    withTransactionMock.mockClear(); // keep the passthrough impl, drop call history from earlier tests
    recordActivityMock.mockReset();
    checkAptitudeBadgesMock.mockReset().mockResolvedValue(undefined);
    analyzeWeakTopicsMock.mockReset();
    getCacheMock.mockReset();
    setCacheMock.mockReset();
    maybeRecomputeReadinessMock.mockReset().mockResolvedValue(undefined);

    repoMock.insertAssessmentAttempt.mockResolvedValue({ id: 'attempt-1', topic_id: 'topic-1', difficulty: 'easy' });
    repoMock.countAttemptsSince.mockResolvedValue(1); // not a multiple of 5 by default
  });

  it('marks the attempt correct when the submitted answer matches the key exactly', async () => {
    repoMock.getAptitudeAnswerKey.mockResolvedValue({ choice: 'B' });

    const result = await assessmentService.submitAptitudeAnswer({
      userId: 'u1',
      questionId: 'q1',
      answer: { choice: 'B' },
      hintsUsed: 0,
    });

    expect(result.is_correct).toBe(true);
    expect(repoMock.insertAssessmentAttempt).toHaveBeenCalledWith(
      expect.anything(),
      expect.objectContaining({ isCorrect: true, errorType: undefined })
    );
  });

  it('marks the attempt incorrect on any mismatch, including partial/extra keys', async () => {
    repoMock.getAptitudeAnswerKey.mockResolvedValue({ choice: 'B' });

    const result = await assessmentService.submitAptitudeAnswer({
      userId: 'u1',
      questionId: 'q1',
      answer: { choice: 'C' },
      hintsUsed: 0,
    });

    expect(result.is_correct).toBe(false);
  });

  it('404s when the question does not exist', async () => {
    repoMock.getAptitudeAnswerKey.mockResolvedValue(null);

    await expect(
      assessmentService.submitAptitudeAnswer({ userId: 'u1', questionId: 'missing', answer: {}, hintsUsed: 0 })
    ).rejects.toMatchObject({ statusCode: 404 });
  });

  describe('heuristic error_type on an incorrect answer', () => {
    beforeEach(() => {
      repoMock.getAptitudeAnswerKey.mockResolvedValue({ choice: 'B' });
    });

    it('is "conceptual" whenever a hint was used, regardless of time taken', async () => {
      await assessmentService.submitAptitudeAnswer({
        userId: 'u1',
        questionId: 'q1',
        answer: { choice: 'C' },
        hintsUsed: 1,
        timeTakenSeconds: 60,
      });
      expect(repoMock.insertAssessmentAttempt).toHaveBeenCalledWith(
        expect.anything(),
        expect.objectContaining({ errorType: 'conceptual' })
      );
    });

    it('is "careless" for a fast (<5s), hint-free wrong answer', async () => {
      await assessmentService.submitAptitudeAnswer({
        userId: 'u1',
        questionId: 'q1',
        answer: { choice: 'C' },
        hintsUsed: 0,
        timeTakenSeconds: 3,
      });
      expect(repoMock.insertAssessmentAttempt).toHaveBeenCalledWith(
        expect.anything(),
        expect.objectContaining({ errorType: 'careless' })
      );
    });

    it('is "unknown" for a slower, hint-free wrong answer', async () => {
      await assessmentService.submitAptitudeAnswer({
        userId: 'u1',
        questionId: 'q1',
        answer: { choice: 'C' },
        hintsUsed: 0,
        timeTakenSeconds: 45,
      });
      expect(repoMock.insertAssessmentAttempt).toHaveBeenCalledWith(
        expect.anything(),
        expect.objectContaining({ errorType: 'unknown' })
      );
    });

    it('leaves error_type undefined on a correct answer even if a hint was used', async () => {
      await assessmentService.submitAptitudeAnswer({
        userId: 'u1',
        questionId: 'q1',
        answer: { choice: 'B' },
        hintsUsed: 1,
      });
      expect(repoMock.insertAssessmentAttempt).toHaveBeenCalledWith(
        expect.anything(),
        expect.objectContaining({ errorType: undefined, isCorrect: true })
      );
    });
  });

  it('records streak activity inside the same transaction as the attempt insert', async () => {
    repoMock.getAptitudeAnswerKey.mockResolvedValue({ choice: 'B' });
    await assessmentService.submitAptitudeAnswer({ userId: 'u1', questionId: 'q1', answer: { choice: 'B' }, hintsUsed: 0 });
    expect(withTransactionMock).toHaveBeenCalledTimes(1);
    expect(recordActivityMock).toHaveBeenCalledWith(expect.anything(), 'u1');
  });

  it('fires badge check and readiness recompute without blocking the response', async () => {
    repoMock.getAptitudeAnswerKey.mockResolvedValue({ choice: 'B' });
    await assessmentService.submitAptitudeAnswer({ userId: 'u1', questionId: 'q1', answer: { choice: 'B' }, hintsUsed: 0 });
    await flush();
    expect(checkAptitudeBadgesMock).toHaveBeenCalledWith('u1');
    expect(maybeRecomputeReadinessMock).toHaveBeenCalledWith('u1', 'assessment_batch');
  });

  describe('the every-5th-attempt weak-topic AI trigger', () => {
    beforeEach(() => {
      repoMock.getAptitudeAnswerKey.mockResolvedValue({ choice: 'B' });
    });

    it('does NOT call the AI service when the attempt count is not a multiple of 5', async () => {
      repoMock.countAttemptsSince.mockResolvedValue(7);
      await assessmentService.submitAptitudeAnswer({ userId: 'u1', questionId: 'q1', answer: {}, hintsUsed: 0 });
      await flush();
      expect(analyzeWeakTopicsMock).not.toHaveBeenCalled();
    });

    it('does NOT call the AI service on attempt 0 (guards the % 5 === 0 edge case)', async () => {
      repoMock.countAttemptsSince.mockResolvedValue(0);
      await assessmentService.submitAptitudeAnswer({ userId: 'u1', questionId: 'q1', answer: {}, hintsUsed: 0 });
      await flush();
      expect(analyzeWeakTopicsMock).not.toHaveBeenCalled();
    });

    it('calls the AI service on the 5th, 10th, ... attempt when nothing is cached', async () => {
      repoMock.countAttemptsSince.mockResolvedValue(10);
      getCacheMock.mockResolvedValue(null);
      repoMock.getTopicPerformance.mockResolvedValue([
        { topic_id: 't1', topic_name: 'Arrays', category: 'aptitude', attempts: 8, accuracy: 0.9 },
        { topic_id: 't2', topic_name: 'Graphs', category: 'aptitude', attempts: 2, accuracy: 0.1 }, // <5 attempts, excluded
      ]);
      analyzeWeakTopicsMock.mockResolvedValue({ strong: ['Arrays'], weak: [], improving: [] });

      await assessmentService.submitAptitudeAnswer({ userId: 'u1', questionId: 'q1', answer: {}, hintsUsed: 0 });
      await flush();

      expect(analyzeWeakTopicsMock).toHaveBeenCalledWith({
        topic_performance: [{ topic: 'Arrays', accuracy: 0.9, attempts: 8 }],
      });
      expect(repoMock.upsertSkillMap).toHaveBeenCalledWith('u1', 't1', 'strong');
      expect(setCacheMock).toHaveBeenCalled();
    });

    it('skips the AI call when a batch already ran within the cache TTL', async () => {
      repoMock.countAttemptsSince.mockResolvedValue(15);
      getCacheMock.mockResolvedValue({ strong: [], weak: [], improving: [] }); // still fresh
      await assessmentService.submitAptitudeAnswer({ userId: 'u1', questionId: 'q1', answer: {}, hintsUsed: 0 });
      await flush();
      expect(analyzeWeakTopicsMock).not.toHaveBeenCalled();
    });

    it('skips the AI call when no topic has enough attempts yet (nothing meaningful to send)', async () => {
      repoMock.countAttemptsSince.mockResolvedValue(5);
      getCacheMock.mockResolvedValue(null);
      repoMock.getTopicPerformance.mockResolvedValue([
        { topic_id: 't1', topic_name: 'Arrays', category: 'aptitude', attempts: 2, accuracy: 0.9 },
      ]);
      await assessmentService.submitAptitudeAnswer({ userId: 'u1', questionId: 'q1', answer: {}, hintsUsed: 0 });
      await flush();
      expect(analyzeWeakTopicsMock).not.toHaveBeenCalled();
    });

    it('never lets a failed AI/weak-topic batch reject the attempt submission', async () => {
      repoMock.countAttemptsSince.mockResolvedValue(5);
      getCacheMock.mockRejectedValue(new Error('cache down'));
      await expect(
        assessmentService.submitAptitudeAnswer({ userId: 'u1', questionId: 'q1', answer: {}, hintsUsed: 0 })
      ).resolves.toMatchObject({ attempt_id: 'attempt-1' });
      await flush();
    });
  });
});

describe('assessment.service.getNextAdaptiveQuestion', () => {
  beforeEach(() => {
    repoMock.pickAdaptiveQuestion.mockReset();
    getQuestionWithDetailsMock.mockReset();
  });

  it('returns full question details for whatever the picker selected', async () => {
    repoMock.pickAdaptiveQuestion.mockResolvedValue({ id: 'q1' });
    getQuestionWithDetailsMock.mockResolvedValue({ id: 'q1', title: 'Two Sum' });

    const result = await assessmentService.getNextAdaptiveQuestion({ userId: 'u1', category: 'coding' });

    expect(repoMock.pickAdaptiveQuestion).toHaveBeenCalledWith({ userId: 'u1', category: 'coding' });
    expect(getQuestionWithDetailsMock).toHaveBeenCalledWith('q1', false);
    expect(result).toEqual({ id: 'q1', title: 'Two Sum' });
  });

  it('404s when the picker has nothing left to serve', async () => {
    repoMock.pickAdaptiveQuestion.mockResolvedValue(null);
    await expect(assessmentService.getNextAdaptiveQuestion({ userId: 'u1', category: 'aptitude' })).rejects.toMatchObject({
      statusCode: 404,
    });
  });
});
