import { ApiError } from '../../utils/ApiError';
import * as repo from './roadmap.repository';
import * as aiClient from '../../services/aiServiceClient';
import { buildCacheKey, getCache, setCache } from '../../services/cacheService';
import { env } from '../../config/env';
import { getTierWeights } from '../readiness/readiness.repository';
import { getWeakTopicIds } from '../assessment/assessment.repository';
import { query } from '../../db/pool';

async function getWeakTopicNames(userId: string): Promise<string[]> {
  const [weakAptitude, weakCoding] = await Promise.all([
    getWeakTopicIds(userId, 'aptitude'),
    getWeakTopicIds(userId, 'coding'),
  ]);
  const ids = [...weakAptitude, ...weakCoding];
  if (!ids.length) return [];
  const { rows } = await query(`SELECT name FROM topics WHERE id = ANY($1::uuid[])`, [ids]);
  return rows.map((r: any) => r.name);
}

/**
 * Generates (or regenerates) the student's active roadmap. Called both from
 * an explicit POST /roadmap/generate and automatically after every resume
 * analysis per HLD Module 4. A new roadmap always supersedes and abandons
 * any existing active one — the schema's partial unique index only allows
 * one active roadmap per user, so "generate" is inherently a replace, not
 * an append.
 */
export async function generateRoadmapForUser(
  userId: string,
  tierId: string,
  resumeGaps: string[] = [],
  weeksAvailable = 8,
  targetDate?: string
) {
  const tier = await getTierWeights(tierId);
  if (!tier) throw ApiError.notFound('Company tier not found');

  const weakTopics = await getWeakTopicNames(userId);

  const cacheKey = buildCacheKey('roadmap', userId, tierId);
  let aiResult = await getCache<Awaited<ReturnType<typeof aiClient.generateRoadmap>>>(cacheKey);
  if (!aiResult) {
    aiResult = await aiClient.generateRoadmap({
      weak_topics: weakTopics,
      target_company: tier.company_name,
      weeks_available: weeksAvailable,
      resume_gaps: resumeGaps,
    });
    await setCache(cacheKey, 'roadmap', aiResult, env.ROADMAP_CACHE_TTL_HOURS * 3600_000, userId);
  }

  const allTopicNames = aiResult.phases.flatMap((p) => p.topics);
  const topicIdByName = await repo.findTopicIdsByNames(allTopicNames);

  const phases = aiResult.phases.map((p) => ({
    phase_number: p.phase_number,
    title: p.title,
    topicIds: p.topics
      .map((name) => topicIdByName.get(name.toLowerCase()))
      .filter((id): id is string => Boolean(id)),
  }));

  const created = await repo.createRoadmap({ userId, tierId, targetDate, phases });
  return getRoadmapDetail(created.id, userId);
}

async function getRoadmapDetail(_roadmapId: string, userId: string) {
  return getActiveRoadmap(userId);
}

export async function getActiveRoadmap(userId: string) {
  const roadmap = await repo.getActiveRoadmap(userId);
  if (!roadmap) return null;
  const phases = await repo.getPhasesForRoadmap(roadmap.id);
  return { ...roadmap, phases };
}

export async function completePhase(userId: string, phaseId: string) {
  const phase = await repo.getPhaseById(phaseId);
  if (!phase) throw ApiError.notFound('Roadmap phase not found');

  const roadmap = await repo.getActiveRoadmap(userId);
  if (!roadmap || roadmap.id !== phase.roadmap_id) {
    throw ApiError.forbidden('This phase does not belong to your active roadmap');
  }

  await repo.markPhaseCompleted(phaseId);
  await repo.activateNextPendingPhase(phase.roadmap_id);

  const remaining = await repo.countIncompletePhases(phase.roadmap_id);
  if (remaining === 0) {
    await repo.markRoadmapCompleted(phase.roadmap_id);
  }

  return getActiveRoadmap(userId);
}
