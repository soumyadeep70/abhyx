import { withTransaction } from '../../db/pool';
import { ApiError } from '../../utils/ApiError';
import { logger } from '../../utils/logger';
import { recordActivity } from '../../services/streakService';
import { checkCodingBadges } from '../gamification/badges.service';
import { maybeRecomputeReadiness } from '../readiness/readiness.service';
import * as repo from './coding.repository';
import { createSubmission, pollUntilDone, JUDGE0_LANGUAGE_IDS, Judge0SubmissionStatus } from '../../services/judge0Client';

/**
 * Priority order used to pick a single representative status when a
 * question has multiple test cases and they don't all pass. A compile error
 * on test case 1 means every subsequent case would fail identically, so we
 * short-circuit rather than burning Judge0 quota running the rest.
 */
const STATUS_SEVERITY: Record<Judge0SubmissionStatus, number> = {
  compile_error: 0,
  runtime_error: 1,
  tle: 2,
  wrong_answer: 3,
  accepted: 4,
  pending: 5,
};

export async function submitCode(params: {
  userId: string;
  questionId: string;
  language: 'python' | 'javascript' | 'java' | 'cpp';
  sourceCode: string;
  timeTakenSeconds?: number;
  hintsUsed: number;
  mockTestId?: string;
}) {
  const question = await repo.getCodingQuestionForJudging(params.questionId);
  if (!question) throw ApiError.notFound('Coding question not found');

  const languageId = JUDGE0_LANGUAGE_IDS[params.language];
  if (!languageId) throw ApiError.badRequest(`Unsupported language: ${params.language}`);
  if (question.judge0_language_ids?.length && !question.judge0_language_ids.includes(languageId)) {
    throw ApiError.badRequest(`This question does not accept submissions in ${params.language}`);
  }

  const testCases: { input: string; expected: string }[] = question.test_cases ?? [];
  if (!testCases.length) throw ApiError.internal('Question has no test cases configured');

  let passed = 0;
  let worstStatus: Judge0SubmissionStatus = 'accepted';
  let lastToken: string | null = null;
  let maxRuntimeMs: number | null = null;
  let maxMemoryKb: number | null = null;

  for (const tc of testCases) {
    const { token } = await createSubmission({
      languageId,
      sourceCode: params.sourceCode,
      stdin: tc.input,
      expectedOutput: tc.expected,
      timeLimitSeconds: (question.time_limit_ms ?? 2000) / 1000,
      memoryLimitKb: question.memory_limit_kb ?? 131072,
    });
    lastToken = token;
    const result = await pollUntilDone(token);

    if (result.time) maxRuntimeMs = Math.max(maxRuntimeMs ?? 0, Math.round(parseFloat(result.time) * 1000));
    if (result.memory) maxMemoryKb = Math.max(maxMemoryKb ?? 0, result.memory);

    if (result.status === 'accepted') {
      passed += 1;
    }
    if (STATUS_SEVERITY[result.status] < STATUS_SEVERITY[worstStatus]) {
      worstStatus = result.status;
    }
    // Short-circuit on compile error: every remaining case would fail identically.
    if (result.status === 'compile_error') break;
  }

  const overallStatus = passed === testCases.length ? 'accepted' : worstStatus;
  const isCorrect = overallStatus === 'accepted';

  const { submissionId } = await withTransaction(async (client) => {
    const attempt = await repo.insertAssessmentAttemptForCoding(client, {
      userId: params.userId,
      questionId: params.questionId,
      mockTestId: params.mockTestId,
      isCorrect,
      timeTakenSeconds: params.timeTakenSeconds,
      hintsUsed: params.hintsUsed,
    });

    const submissionId = await repo.insertCodeSubmission(client, {
      assessmentAttemptId: attempt.id,
      userId: params.userId,
      questionId: params.questionId,
      language: params.language,
      sourceCode: params.sourceCode,
      judge0Token: lastToken,
      status: overallStatus,
      runtimeMs: maxRuntimeMs,
      memoryKb: maxMemoryKb,
      testCasesPassed: passed,
      testCasesTotal: testCases.length,
    });

    await recordActivity(client, params.userId);
    return { submissionId, attempt };
  });

  checkCodingBadges(params.userId).catch((err) => logger.warn({ err }, 'coding badge check failed'));
  maybeRecomputeReadiness(params.userId, 'assessment_batch').catch((err) =>
    logger.warn({ err }, 'readiness recompute trigger failed')
  );

  return {
    submission_id: submissionId,
    status: overallStatus,
    test_cases_passed: passed,
    test_cases_total: testCases.length,
    runtime_ms: maxRuntimeMs,
    memory_kb: maxMemoryKb,
  };
}

export async function getSubmission(submissionId: string) {
  const submission = await repo.getSubmissionById(submissionId);
  if (!submission) throw ApiError.notFound('Submission not found');
  return submission;
}

export async function listSubmissions(userId: string) {
  return repo.listSubmissionsForUser(userId);
}
