import { describe, it, expect, vi, beforeEach } from 'vitest';

const repoMock = {
  getTierWeights: vi.fn(),
  getAptitudeSubScore: vi.fn(),
  getCodingSubScore: vi.fn(),
  getResumeSubScore: vi.fn(),
  getInterviewSubScore: vi.fn(),
  getConsistencySubScore: vi.fn(),
  getPreviousScore: vi.fn(),
  upsertReadinessScore: vi.fn(),
  insertHistory: vi.fn(),
  getTargetTiersForUser: vi.fn(),
  getFullProfile: vi.fn(),
  getScoreHistory: vi.fn(),
  getAllUserIdsWithTargets: vi.fn(),
};
vi.mock('../../../../src/modules/readiness/readiness.repository', () => repoMock);

const getReadinessInsightsMock = vi.fn();
vi.mock('../../../../src/services/aiServiceClient', () => ({
  getReadinessInsights: (...args: any[]) => getReadinessInsightsMock(...args),
}));

const getCacheMock = vi.fn();
const setCacheMock = vi.fn();
vi.mock('../../../../src/services/cacheService', () => ({
  buildCacheKey: (...parts: string[]) => parts.join(':'),
  getCache: (...args: any[]) => getCacheMock(...args),
  setCache: (...args: any[]) => setCacheMock(...args),
}));

import * as readinessService from '../../../../src/modules/readiness/readiness.service';

const WEIGHTS = {
  id: 'tier-1',
  company_id: 'co-1',
  company_name: 'TCS',
  tier_name: 'TCS Ninja',
  aptitude_weight: 40,
  coding_weight: 25,
  resume_weight: 10,
  interview_weight: 20,
  consistency_weight: 5,
};

function flushMicrotasks() {
  return new Promise((r) => setImmediate(r));
}

describe('readiness.service.recomputeForTier', () => {
  beforeEach(() => {
    Object.values(repoMock).forEach((fn) => fn.mockReset());
    getReadinessInsightsMock.mockReset();
    getCacheMock.mockReset();
    setCacheMock.mockReset();

    repoMock.getTierWeights.mockResolvedValue(WEIGHTS);
    repoMock.getAptitudeSubScore.mockResolvedValue(80);
    repoMock.getCodingSubScore.mockResolvedValue(60);
    repoMock.getResumeSubScore.mockResolvedValue(90);
    repoMock.getInterviewSubScore.mockResolvedValue(70);
    repoMock.getConsistencySubScore.mockResolvedValue(50);
    repoMock.upsertReadinessScore.mockResolvedValue(undefined);
    repoMock.insertHistory.mockResolvedValue(undefined);
    getReadinessInsightsMock.mockResolvedValue({
      headline: 'ok',
      strengths: [],
      risks: [],
      next_actions: [],
    });
  });

  it('computes the weighted score exactly per the documented formula', async () => {
    // (80*40 + 60*25 + 90*10 + 70*20 + 50*5) / 100 = 72.5
    repoMock.getPreviousScore.mockResolvedValue(72.5); // no "significant change" noise for this assertion
    const result = await readinessService.recomputeForTier('user-1', 'tier-1', 'manual');

    expect(result.score).toBe(72.5);
    expect(repoMock.upsertReadinessScore).toHaveBeenCalledWith(
      expect.objectContaining({ userId: 'user-1', tierId: 'tier-1', score: 72.5 })
    );
  });

  it('maps score to probability via the documented linear ramp (40 -> 0, 100 -> 1)', async () => {
    repoMock.getPreviousScore.mockResolvedValue(null);
    // Force a known, clean score by using equal weights that sum with clean sub-scores.
    repoMock.getAptitudeSubScore.mockResolvedValue(70);
    repoMock.getCodingSubScore.mockResolvedValue(70);
    repoMock.getResumeSubScore.mockResolvedValue(70);
    repoMock.getInterviewSubScore.mockResolvedValue(70);
    repoMock.getConsistencySubScore.mockResolvedValue(70);

    const result = await readinessService.recomputeForTier('user-1', 'tier-1', 'manual');

    expect(result.score).toBe(70);
    // (70 - 40) / (100 - 40) = 0.5
    expect(result.probability).toBe(0.5);
  });

  it('clamps probability to 0 at or below the 40-point floor', async () => {
    repoMock.getPreviousScore.mockResolvedValue(null);
    repoMock.getAptitudeSubScore.mockResolvedValue(0);
    repoMock.getCodingSubScore.mockResolvedValue(0);
    repoMock.getResumeSubScore.mockResolvedValue(0);
    repoMock.getInterviewSubScore.mockResolvedValue(0);
    repoMock.getConsistencySubScore.mockResolvedValue(0);

    const result = await readinessService.recomputeForTier('user-1', 'tier-1', 'manual');

    expect(result.score).toBe(0);
    expect(result.probability).toBe(0);
  });

  it('clamps probability to 1 at or above the 100-point ceiling', async () => {
    repoMock.getPreviousScore.mockResolvedValue(null);
    repoMock.getAptitudeSubScore.mockResolvedValue(100);
    repoMock.getCodingSubScore.mockResolvedValue(100);
    repoMock.getResumeSubScore.mockResolvedValue(100);
    repoMock.getInterviewSubScore.mockResolvedValue(100);
    repoMock.getConsistencySubScore.mockResolvedValue(100);

    const result = await readinessService.recomputeForTier('user-1', 'tier-1', 'manual');

    expect(result.score).toBe(100);
    expect(result.probability).toBe(1);
  });

  it('throws a 404 ApiError when the tier does not exist', async () => {
    repoMock.getTierWeights.mockResolvedValue(null);
    await expect(readinessService.recomputeForTier('user-1', 'missing-tier', 'manual')).rejects.toMatchObject({
      statusCode: 404,
    });
  });

  describe('AI enrichment cost-control gate (fires only on a >5 point change)', () => {
    it('triggers AI enrichment when there was no previous score', async () => {
      repoMock.getPreviousScore.mockResolvedValue(null);
      const result = await readinessService.recomputeForTier('user-1', 'tier-1', 'manual');
      await flushMicrotasks();

      expect(result.changedSignificantly).toBe(true);
      expect(getReadinessInsightsMock).toHaveBeenCalledTimes(1);
      expect(getReadinessInsightsMock).toHaveBeenCalledWith(
        expect.objectContaining({ company: 'TCS', tier: 'TCS Ninja', score: 72.5 })
      );
    });

    it('triggers AI enrichment when the score moved by more than 5 points', async () => {
      repoMock.getPreviousScore.mockResolvedValue(72.5 - 5.01);
      const result = await readinessService.recomputeForTier('user-1', 'tier-1', 'manual');
      await flushMicrotasks();

      expect(result.changedSignificantly).toBe(true);
      expect(getReadinessInsightsMock).toHaveBeenCalledTimes(1);
    });

    it('does NOT trigger AI enrichment when the score moved by exactly 5 points or less', async () => {
      repoMock.getPreviousScore.mockResolvedValue(72.5 - 5);
      const result = await readinessService.recomputeForTier('user-1', 'tier-1', 'manual');
      await flushMicrotasks();

      expect(result.changedSignificantly).toBe(false);
      expect(getReadinessInsightsMock).not.toHaveBeenCalled();
    });

    it('never lets an AI enrichment failure reject recomputeForTier (fire-and-forget)', async () => {
      repoMock.getPreviousScore.mockResolvedValue(null);
      getReadinessInsightsMock.mockRejectedValue(new Error('AI service down'));

      await expect(readinessService.recomputeForTier('user-1', 'tier-1', 'manual')).resolves.toMatchObject({
        score: 72.5,
      });
      await flushMicrotasks();
    });
  });
});

describe('readiness.service.maybeRecomputeReadiness', () => {
  beforeEach(() => {
    Object.values(repoMock).forEach((fn) => fn.mockReset());
    repoMock.getTierWeights.mockResolvedValue(WEIGHTS);
    repoMock.getAptitudeSubScore.mockResolvedValue(50);
    repoMock.getCodingSubScore.mockResolvedValue(50);
    repoMock.getResumeSubScore.mockResolvedValue(50);
    repoMock.getInterviewSubScore.mockResolvedValue(50);
    repoMock.getConsistencySubScore.mockResolvedValue(50);
    repoMock.getPreviousScore.mockResolvedValue(50);
    repoMock.upsertReadinessScore.mockResolvedValue(undefined);
    repoMock.insertHistory.mockResolvedValue(undefined);
  });

  it('recomputes every tier the user has targeted', async () => {
    repoMock.getTargetTiersForUser.mockResolvedValue([
      { ...WEIGHTS, id: 'tier-1' },
      { ...WEIGHTS, id: 'tier-2' },
    ]);

    await readinessService.maybeRecomputeReadiness('user-1', 'assessment_batch');

    expect(repoMock.upsertReadinessScore).toHaveBeenCalledTimes(2);
    expect(repoMock.upsertReadinessScore.mock.calls.map((c) => c[0].tierId).sort()).toEqual(['tier-1', 'tier-2']);
  });

  it('is a no-op when the user has no target companies', async () => {
    repoMock.getTargetTiersForUser.mockResolvedValue([]);

    await readinessService.maybeRecomputeReadiness('user-1', 'manual');

    expect(repoMock.upsertReadinessScore).not.toHaveBeenCalled();
  });
});

describe('readiness.service.getInsights', () => {
  it('returns whatever is cached (or null) without recomputing', async () => {
    getCacheMock.mockResolvedValue({ headline: 'cached insight' });
    const result = await readinessService.getInsights('user-1', 'tier-1');
    expect(result).toEqual({ headline: 'cached insight' });

    getCacheMock.mockResolvedValue(null);
    expect(await readinessService.getInsights('user-1', 'tier-1')).toBeNull();
  });
});
