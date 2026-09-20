import { describe, it, expect, vi, beforeEach } from 'vitest';

const repoMock = {
  getCodingQuestionForJudging: vi.fn(),
  insertAssessmentAttemptForCoding: vi.fn(),
  insertCodeSubmission: vi.fn(),
  getSubmissionById: vi.fn(),
  listSubmissionsForUser: vi.fn(),
};
vi.mock('../../../../src/modules/coding/coding.repository', () => repoMock);

const withTransactionMock = vi.fn(async (fn: any) => fn({} as any));
vi.mock('../../../../src/db/pool', () => ({
  withTransaction: (...args: any[]) => withTransactionMock(...(args as [any])),
  query: vi.fn(),
}));

const recordActivityMock = vi.fn();
vi.mock('../../../../src/services/streakService', () => ({
  recordActivity: (...args: any[]) => recordActivityMock(...args),
}));

const checkCodingBadgesMock = vi.fn().mockResolvedValue(undefined);
vi.mock('../../../../src/modules/gamification/badges.service', () => ({
  checkCodingBadges: (...args: any[]) => checkCodingBadgesMock(...args),
}));

const maybeRecomputeReadinessMock = vi.fn().mockResolvedValue(undefined);
vi.mock('../../../../src/modules/readiness/readiness.service', () => ({
  maybeRecomputeReadiness: (...args: any[]) => maybeRecomputeReadinessMock(...args),
}));

const createSubmissionMock = vi.fn();
const pollUntilDoneMock = vi.fn();
vi.mock('../../../../src/services/judge0Client', () => ({
  createSubmission: (...args: any[]) => createSubmissionMock(...args),
  pollUntilDone: (...args: any[]) => pollUntilDoneMock(...args),
  JUDGE0_LANGUAGE_IDS: { python: 71, javascript: 63, java: 62, cpp: 54 },
}));

import * as codingService from '../../../../src/modules/coding/coding.service';

const BASE_QUESTION = {
  id: 'q1',
  test_cases: [{ input: '1', expected: '1' }],
  time_limit_ms: 2000,
  memory_limit_kb: 131072,
  judge0_language_ids: null,
};

function baseParams(overrides: Partial<Parameters<typeof codingService.submitCode>[0]> = {}) {
  return {
    userId: 'u1',
    questionId: 'q1',
    language: 'python' as const,
    sourceCode: 'print(1)',
    hintsUsed: 0,
    ...overrides,
  };
}

/** Queues N createSubmission/pollUntilDone pairs, one per test case, each returning a judge0 status. */
function queueResults(results: Array<{ status: string; time?: string; memory?: number }>) {
  results.forEach((r, i) => {
    createSubmissionMock.mockResolvedValueOnce({ token: `tok-${i}` });
    pollUntilDoneMock.mockResolvedValueOnce(r);
  });
}

describe('coding.service.submitCode', () => {
  beforeEach(() => {
    Object.values(repoMock).forEach((fn) => fn.mockReset());
    createSubmissionMock.mockReset();
    pollUntilDoneMock.mockReset();
    recordActivityMock.mockReset();
    checkCodingBadgesMock.mockReset().mockResolvedValue(undefined);
    maybeRecomputeReadinessMock.mockReset().mockResolvedValue(undefined);

    repoMock.getCodingQuestionForJudging.mockResolvedValue(BASE_QUESTION);
    repoMock.insertAssessmentAttemptForCoding.mockResolvedValue({ id: 'attempt-1' });
    repoMock.insertCodeSubmission.mockResolvedValue('submission-1');
  });

  it('reports accepted only when every test case passes', async () => {
    repoMock.getCodingQuestionForJudging.mockResolvedValue({
      ...BASE_QUESTION,
      test_cases: [{ input: '1', expected: '1' }, { input: '2', expected: '2' }],
    });
    queueResults([{ status: 'accepted' }, { status: 'accepted' }]);

    const result = await codingService.submitCode(baseParams());

    expect(result.status).toBe('accepted');
    expect(result.test_cases_passed).toBe(2);
    expect(result.test_cases_total).toBe(2);
    expect(repoMock.insertAssessmentAttemptForCoding).toHaveBeenCalledWith(
      expect.anything(),
      expect.objectContaining({ isCorrect: true })
    );
  });

  it('reports wrong_answer as the overall status when some but not all cases pass', async () => {
    repoMock.getCodingQuestionForJudging.mockResolvedValue({
      ...BASE_QUESTION,
      test_cases: [{ input: '1', expected: '1' }, { input: '2', expected: '2' }, { input: '3', expected: '3' }],
    });
    queueResults([{ status: 'accepted' }, { status: 'wrong_answer' }, { status: 'accepted' }]);

    const result = await codingService.submitCode(baseParams());

    expect(result.status).toBe('wrong_answer');
    expect(result.test_cases_passed).toBe(2);
    expect(result.test_cases_total).toBe(3);
  });

  it.each([
    [['tle', 'runtime_error'], 'runtime_error'],
    [['runtime_error', 'tle'], 'runtime_error'],
    [['wrong_answer', 'tle'], 'tle'],
    [['tle', 'wrong_answer'], 'tle'],
  ])(
    'picks the most severe status regardless of arrival order: %j -> %s',
    async (statuses, expectedOverall) => {
      repoMock.getCodingQuestionForJudging.mockResolvedValue({
        ...BASE_QUESTION,
        test_cases: statuses.map((_, i) => ({ input: String(i), expected: String(i) })),
      });
      queueResults(statuses.map((status) => ({ status })));

      const result = await codingService.submitCode(baseParams());

      expect(result.status).toBe(expectedOverall);
    }
  );

  it('short-circuits on a compile error: does not run remaining test cases', async () => {
    repoMock.getCodingQuestionForJudging.mockResolvedValue({
      ...BASE_QUESTION,
      test_cases: [{ input: '1', expected: '1' }, { input: '2', expected: '2' }, { input: '3', expected: '3' }],
    });
    queueResults([{ status: 'compile_error' }]); // only one queued -- a 2nd call would throw "no more mock values"

    const result = await codingService.submitCode(baseParams());

    expect(result.status).toBe('compile_error');
    expect(result.test_cases_passed).toBe(0);
    expect(createSubmissionMock).toHaveBeenCalledTimes(1);
    expect(pollUntilDoneMock).toHaveBeenCalledTimes(1);
  });

  it('tracks the maximum runtime and memory across all executed test cases', async () => {
    repoMock.getCodingQuestionForJudging.mockResolvedValue({
      ...BASE_QUESTION,
      test_cases: [{ input: '1', expected: '1' }, { input: '2', expected: '2' }],
    });
    queueResults([
      { status: 'accepted', time: '0.045', memory: 9000 },
      { status: 'accepted', time: '0.120', memory: 7000 },
    ]);

    const result = await codingService.submitCode(baseParams());

    expect(result.runtime_ms).toBe(120);
    expect(result.memory_kb).toBe(9000);
  });

  it('rejects an unsupported language before calling Judge0 at all', async () => {
    await expect(codingService.submitCode(baseParams({ language: 'ruby' as any }))).rejects.toMatchObject({
      statusCode: 400,
    });
    expect(createSubmissionMock).not.toHaveBeenCalled();
  });

  it('rejects a language the question does not accept', async () => {
    repoMock.getCodingQuestionForJudging.mockResolvedValue({ ...BASE_QUESTION, judge0_language_ids: [62] }); // java only
    await expect(codingService.submitCode(baseParams({ language: 'python' }))).rejects.toMatchObject({
      statusCode: 400,
    });
  });

  it('500s if the question has no test cases configured', async () => {
    repoMock.getCodingQuestionForJudging.mockResolvedValue({ ...BASE_QUESTION, test_cases: [] });
    await expect(codingService.submitCode(baseParams())).rejects.toMatchObject({ statusCode: 500 });
  });

  it('404s when the question does not exist', async () => {
    repoMock.getCodingQuestionForJudging.mockResolvedValue(null);
    await expect(codingService.submitCode(baseParams())).rejects.toMatchObject({ statusCode: 404 });
  });

  it('records streak activity and fires badge/readiness hooks without blocking', async () => {
    queueResults([{ status: 'accepted' }]);
    await codingService.submitCode(baseParams());
    await new Promise((r) => setImmediate(r));

    expect(recordActivityMock).toHaveBeenCalledWith(expect.anything(), 'u1');
    expect(checkCodingBadgesMock).toHaveBeenCalledWith('u1');
    expect(maybeRecomputeReadinessMock).toHaveBeenCalledWith('u1', 'assessment_batch');
  });
});

describe('coding.service.getSubmission / listSubmissions', () => {
  beforeEach(() => {
    repoMock.getSubmissionById.mockReset();
    repoMock.listSubmissionsForUser.mockReset();
  });

  it('404s when a submission id does not exist', async () => {
    repoMock.getSubmissionById.mockResolvedValue(null);
    await expect(codingService.getSubmission('missing')).rejects.toMatchObject({ statusCode: 404 });
  });

  it('returns the submission when found', async () => {
    repoMock.getSubmissionById.mockResolvedValue({ id: 's1', status: 'accepted' });
    await expect(codingService.getSubmission('s1')).resolves.toEqual({ id: 's1', status: 'accepted' });
  });

  it('lists all of a user\'s submissions', async () => {
    repoMock.listSubmissionsForUser.mockResolvedValue([{ id: 's1' }, { id: 's2' }]);
    await expect(codingService.listSubmissions('u1')).resolves.toHaveLength(2);
  });
});
