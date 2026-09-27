import { withTransaction } from '../../db/pool';
import { ApiError } from '../../utils/ApiError';
import { logger } from '../../utils/logger';
import { recordActivity } from '../../services/streakService';
import { checkAptitudeBadges } from '../gamification/badges.service';
import * as repo from './assessment.repository';
import * as aiClient from '../../services/aiServiceClient';
import { buildCacheKey, getCache, setCache } from '../../services/cacheService';
import { env } from '../../config/env';
import { getQuestionWithDetails } from '../questions/questions.repository';
import { maybeRecomputeReadiness } from '../readiness/readiness.service';

/**
 * Correctness check for aptitude questions is a plain JSON-shape comparison
 * against the stored answer key (e.g. {"choice":"B"}). This is deliberately
 * NOT an AI call: aptitude questions are single-correct-answer MCQs, so an
 * LLM round trip would add latency and cost for a decision a JSON compare
 * already makes deterministically.
 */
function isAnswerCorrect(submitted: unknown, correct: unknown): boolean {
  return JSON.stringify(submitted) === JSON.stringify(correct);
}

/**
 * Cheap local heuristic for error_type when AI enrichment hasn't run yet.
 * TRADEOFF: the HLD says the AI "identifies whether errors are conceptual,
 * computational, or careless" but also caps AI enrichment to batches of 5
 * attempts to control cost. Per-attempt this heuristic fills the column
 * immediately; analyzeAndCacheWeakTopics (fired every 5th attempt) is the
 * authoritative, AI-driven signal that updates student_skill_map — this
 * heuristic is never used for skill-map classification, only as an
 * immediate, non-blocking hint on the attempt row itself.
 */
function heuristicErrorType(timeTakenSeconds: number | undefined, hintsUsed: number): string {
  if (hintsUsed > 0) return 'conceptual';
  if (timeTakenSeconds !== undefined && timeTakenSeconds < 5) return 'careless';
  return 'unknown';
}

export async function submitAptitudeAnswer(params: {
  userId: string;
  questionId: string;
  answer: Record<string, unknown>;
  timeTakenSeconds?: number;
  hintsUsed: number;
  mockTestId?: string;
}) {
  const correctAnswer = await repo.getAptitudeAnswerKey(params.questionId);
  if (correctAnswer === null) throw ApiError.notFound('Aptitude question not found');

  const isCorrect = isAnswerCorrect(params.answer, correctAnswer);
  const errorType = isCorrect ? undefined : heuristicErrorType(params.timeTakenSeconds, params.hintsUsed);

  const attempt = await withTransaction(async (client) => {
    const inserted = await repo.insertAssessmentAttempt(client, {
      userId: params.userId,
      questionId: params.questionId,
      mockTestId: params.mockTestId,
      attemptType: params.mockTestId ? 'mock_test' : 'aptitude',
      answer: params.answer,
      timeTakenSeconds: params.timeTakenSeconds,
      isCorrect: isCorrect,
      hintsUsed: params.hintsUsed,
      errorType,
    });
    await recordActivity(client, params.userId);
    return inserted;
  });

  // Fire-and-forget: badges, batched AI weak-topic analysis, readiness recompute.
  // None of these block the response to the student.
  checkAptitudeBadges(params.userId).catch((err) => logger.warn({ err }, 'badge check failed'));
  triggerWeakTopicAnalysisIfDue(params.userId).catch((err) =>
    logger.warn({ err }, 'weak topic analysis trigger failed')
  );
  maybeRecomputeReadiness(params.userId, 'assessment_batch').catch((err) =>
    logger.warn({ err }, 'readiness recompute trigger failed')
  );

  return { attempt_id: attempt.id, is_correct: isCorrect, topic_id: attempt.topic_id, difficulty: attempt.difficulty };
}

/**
 * AI Cost Control Strategy (HLD Section 05): weak-topic detection runs
 * "every 5 new assessment attempts", cached 24h. This checks the attempt
 * count and only calls the AI service on multiples of 5, then persists the
 * result into student_skill_map so the adaptive picker and analytics read
 * from a cheap local table rather than re-deriving it (or re-calling AI) on
 * every read.
 */
async function triggerWeakTopicAnalysisIfDue(userId: string): Promise<void> {
  const total = await repo.countAttemptsSince(userId);
  if (total === 0 || total % 5 !== 0) return;

  const cacheKey = buildCacheKey('weak_topic', userId);
  const cached = await getCache(cacheKey);
  if (cached) return; // still fresh from a previous batch in the last 24h

  const performance = await repo.getTopicPerformance(userId);
  const aiInput = performance
    .filter((p: any) => Number(p.attempts) >= 5)
    .map((p: any) => ({ topic: p.topic_name, accuracy: p.accuracy, attempts: Number(p.attempts) }));
  if (!aiInput.length) return;

  const result = await aiClient.analyzeWeakTopics({ topic_performance: aiInput });
  await setCache(cacheKey, 'weak_topic', result, env.WEAK_TOPIC_CACHE_TTL_HOURS * 3600_000, userId);

  const byName = new Map(performance.map((p: any) => [p.topic_name, p.topic_id]));
  for (const name of result.strong) {
    const topicId = byName.get(name);
    if (topicId) await repo.upsertSkillMap(userId, topicId, 'strong');
  }
  for (const name of result.weak) {
    const topicId = byName.get(name);
    if (topicId) await repo.upsertSkillMap(userId, topicId, 'weak');
  }
  for (const name of result.improving) {
    const topicId = byName.get(name);
    if (topicId) await repo.upsertSkillMap(userId, topicId, 'improving');
  }
}

export async function getNextAdaptiveQuestion(params: {
  userId: string;
  category: 'aptitude' | 'coding';
  companyId?: string;
}) {
  const picked = await repo.pickAdaptiveQuestion(params);
  if (!picked) throw ApiError.notFound('No more questions available for this category right now');
  return getQuestionWithDetails(picked.id, false);
}

export async function getTopicAnalytics(userId: string) {
  const performance = await repo.getTopicPerformance(userId);
  return performance.map((p: any) => ({
    topic_id: p.topic_id,
    topic_name: p.topic_name,
    category: p.category,
    attempts: Number(p.attempts),
    accuracy: p.accuracy,
    // mirrors the Feature 2 thresholds for a quick client-side label even
    // before the next AI batch has run
    label: Number(p.attempts) < 5 ? 'insufficient_data' : p.accuracy >= 0.75 ? 'strong' : p.accuracy < 0.5 ? 'weak' : 'improving',
  }));
}
