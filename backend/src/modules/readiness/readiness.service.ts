import * as repo from './readiness.repository';
import * as aiClient from '../../services/aiServiceClient';
import { buildCacheKey, getCache, setCache } from '../../services/cacheService';
import { env } from '../../config/env';
import { logger } from '../../utils/logger';
import { ApiError } from '../../utils/ApiError';

const SIGNIFICANT_CHANGE_THRESHOLD = 5; // points, per HLD "AI Cost Control Strategy"

/**
 * Deterministic placement-probability mapping.
 *
 * ASSUMPTION: neither source document specifies the score→probability
 * formula ("Placement Probability Prediction" is described only by example
 * outputs, e.g. "TCS Ninja: 88%"). This engine uses a simple linear ramp —
 * 0% probability at or below 40 readiness points, 100% at or above 100,
 * linear between — as a placeholder that is easy to defend to a mentor/panel
 * and easy to replace with a calibrated model (e.g. logistic regression
 * trained on historical placement outcomes) without touching the rest of
 * the pipeline, since callers only ever see the resulting `probability`
 * field.
 */
function scoreToProbability(score: number): number {
  const floor = 40;
  const ceiling = 100;
  const clamped = Math.max(floor, Math.min(ceiling, score));
  return Number(((clamped - floor) / (ceiling - floor)).toFixed(3));
}

async function computeSubScores(userId: string) {
  const [aptitude, coding, resume, interview, consistency] = await Promise.all([
    repo.getAptitudeSubScore(userId),
    repo.getCodingSubScore(userId),
    repo.getResumeSubScore(userId),
    repo.getInterviewSubScore(userId),
    repo.getConsistencySubScore(userId),
  ]);
  return { aptitude, coding, resume, interview, consistency };
}

interface SubScores {
  aptitude: number;
  coding: number;
  resume: number;
  interview: number;
  consistency: number;
}

function weightedScore(sub: SubScores, weights: repo.CompanyTierWeights): number {
  const total =
    (sub.aptitude * weights.aptitude_weight +
      sub.coding * weights.coding_weight +
      sub.resume * weights.resume_weight +
      sub.interview * weights.interview_weight +
      sub.consistency * weights.consistency_weight) /
    100;
  return Number(total.toFixed(2));
}

export async function recomputeForTier(
  userId: string,
  tierId: string,
  reason: 'assessment_batch' | 'interview_completed' | 'resume_uploaded' | 'nightly_job' | 'manual'
) {
  const weights = await repo.getTierWeights(tierId);
  if (!weights) throw ApiError.notFound('Company tier not found');

  const sub = await computeSubScores(userId);
  const score = weightedScore(sub, weights);
  const probability = scoreToProbability(score);

  const previousScore = await repo.getPreviousScore(userId, tierId);

  await repo.upsertReadinessScore({
    userId,
    tierId,
    score,
    probability,
    aptitude: sub.aptitude,
    coding: sub.coding,
    resume: sub.resume,
    interview: sub.interview,
    consistency: sub.consistency,
  });
  await repo.insertHistory({ userId, tierId, score, probability, reason });

  const changedSignificantly = previousScore === null || Math.abs(score - previousScore) > SIGNIFICANT_CHANGE_THRESHOLD;
  if (changedSignificantly) {
    // Fire-and-forget AI enrichment; never blocks the deterministic score write.
    enrichWithAiInsights(userId, weights, score, probability, sub).catch((err) =>
      logger.warn({ err, userId, tierId }, 'readiness AI enrichment failed (non-fatal)')
    );
  }

  return { tierId, score, probability, sub, changedSignificantly };
}

async function enrichWithAiInsights(
  userId: string,
  weights: repo.CompanyTierWeights,
  score: number,
  probability: number,
  sub: { aptitude: number; coding: number; resume: number; interview: number; consistency: number }
) {
  const cacheKey = buildCacheKey('readiness_insight', userId, weights.id);
  const result = await aiClient.getReadinessInsights({
    company: weights.company_name,
    tier: weights.tier_name,
    score,
    probability,
    breakdown: sub,
  });
  await setCache(cacheKey, 'readiness_insight', result, env.READINESS_CACHE_TTL_MINUTES * 60_000, userId);
}

export async function getInsights(userId: string, tierId: string) {
  const cacheKey = buildCacheKey('readiness_insight', userId, tierId);
  return getCache(cacheKey); // null if not yet computed / expired — caller decides whether to trigger a recompute
}

/** Recomputes every target-company tier a user has selected. Used as the post-event hook. */
export async function maybeRecomputeReadiness(
  userId: string,
  reason: 'assessment_batch' | 'interview_completed' | 'resume_uploaded' | 'nightly_job' | 'manual'
) {
  const tiers = await repo.getTargetTiersForUser(userId);
  for (const tier of tiers) {
    await recomputeForTier(userId, tier.id, reason);
  }
}

export async function getFullReadinessProfile(userId: string) {
  return repo.getFullProfile(userId);
}

export async function getHistory(userId: string, tierId: string) {
  return repo.getScoreHistory(userId, tierId);
}

export async function getAllUserIdsForNightlyJob(): Promise<string[]> {
  return repo.getAllUserIdsWithTargets();
}
