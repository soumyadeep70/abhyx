import { withTransaction } from '../../db/pool';
import { ApiError } from '../../utils/ApiError';
import { logger } from '../../utils/logger';
import { recordActivity } from '../../services/streakService';
import { checkInterviewBadges } from '../gamification/badges.service';
import { maybeRecomputeReadiness } from '../readiness/readiness.service';
import * as repo from './interview.repository';
import * as aiClient from '../../services/aiServiceClient';

/**
 * Opening questions. TRADEOFF: the AI service's only interview endpoint is
 * POST /interview/score, which scores a question+answer pair — there is no
 * "generate opening question" endpoint in the HLD's FastAPI API list. Rather
 * than invent an extra AI round trip that isn't specified, the first
 * question per round type is a fixed, sensible opener; every question after
 * that is the `follow_up_question` the AI returns alongside its scoring of
 * the previous answer, so the interview still feels adaptive from turn 2
 * onward.
 */
const OPENING_QUESTIONS: Record<'technical' | 'hr' | 'system_design', string> = {
  technical: 'Let’s start with the basics: can you walk me through how a hash map works internally, and its time complexity for insert and lookup?',
  hr: 'Tell me about yourself and why you’re interested in this role.',
  system_design: 'Let’s design a URL shortener. How would you approach the high-level architecture?',
};

const FALLBACK_FOLLOW_UP = 'Could you elaborate a bit more on that, with a specific example?';

export async function startSession(params: {
  userId: string;
  roundType: 'technical' | 'hr' | 'system_design';
  tierId?: string;
}) {
  const session = await repo.createSession(params);
  const openingQuestion = OPENING_QUESTIONS[params.roundType];

  await withTransaction(async (client) => {
    await repo.insertMessage(client, {
      sessionId: session.id,
      role: 'interviewer',
      message: openingQuestion,
      sequenceNumber: 1,
    });
  });

  return { session_id: session.id, started_at: session.started_at, question: openingQuestion };
}

export async function respond(params: { sessionId: string; userId: string; message: string }) {
  const session = await repo.getSession(params.sessionId);
  if (!session) throw ApiError.notFound('Interview session not found');
  if (session.status !== 'in_progress') throw ApiError.conflict('Interview session is not in progress');

  const lastQuestion = await repo.getLastInterviewerMessage(params.sessionId);
  if (!lastQuestion) throw ApiError.internal('Session has no opening question recorded');

  const history = await repo.getConversationHistory(params.sessionId);

  const aiResult = await aiClient.scoreInterviewAnswer({
    round_type: session.round_type,
    company: session.company_name ?? undefined,
    question: lastQuestion.message,
    answer: params.message,
    conversation_history: history,
  });

  const nextQuestion = aiResult.follow_up_question ?? FALLBACK_FOLLOW_UP;

  const { candidateMessageId, interviewerMessageId } = await withTransaction(async (client) => {
    const nextSeq = await repo.getNextSequenceNumber(params.sessionId);
    const candidateMessageId = await repo.insertMessage(client, {
      sessionId: params.sessionId,
      role: 'candidate',
      message: params.message,
      sequenceNumber: nextSeq,
    });
    await repo.insertAnswerScore(client, {
      sessionId: params.sessionId,
      candidateMessageId,
      technicalAccuracy: aiResult.technical_accuracy,
      communicationClarity: aiResult.communication_clarity,
      problemSolvingApproach: aiResult.problem_solving_approach,
      depthOfKnowledge: aiResult.depth_of_knowledge,
      hrReadiness: session.round_type === 'hr' ? aiResult.hr_readiness ?? null : null,
    });
    const interviewerMessageId = await repo.insertMessage(client, {
      sessionId: params.sessionId,
      role: 'interviewer',
      message: nextQuestion,
      sequenceNumber: nextSeq + 1,
    });
    await recordActivity(client, params.userId);
    return { candidateMessageId, interviewerMessageId };
  });

  return {
    scores: {
      technical_accuracy: aiResult.technical_accuracy,
      communication_clarity: aiResult.communication_clarity,
      problem_solving_approach: aiResult.problem_solving_approach,
      depth_of_knowledge: aiResult.depth_of_knowledge,
      hr_readiness: aiResult.hr_readiness,
    },
    feedback: aiResult.feedback,
    next_question: nextQuestion,
    candidate_message_id: candidateMessageId,
    interviewer_message_id: interviewerMessageId,
  };
}

function avg(nums: number[]): number {
  if (!nums.length) return 0;
  return Number((nums.reduce((a, b) => a + b, 0) / nums.length).toFixed(2));
}

function hiringRecommendationFor(overallScore: number): 'hire' | 'borderline' | 'no_hire' {
  if (overallScore >= 80) return 'hire';
  if (overallScore >= 60) return 'borderline';
  return 'no_hire';
}

/**
 * Deterministic scorecard synthesis. TRADEOFF: interview_answer_scores has
 * no free-text feedback column (only the five numeric dimensions), so
 * strengths/weaknesses/improvement_plan on the final scorecard are derived
 * from which dimensions scored high/low across the session rather than by
 * re-summarizing AI prose — there is nothing to re-summarize once the
 * per-turn `feedback` string returned by the AI service isn't persisted.
 */
async function synthesizeScorecard(sessionId: string, roundType: string) {
  const rows = await repo.getAnswerScoresForSession(sessionId);
  if (!rows.length) {
    return {
      dims: { technical_accuracy: 0, communication_clarity: 0, problem_solving_approach: 0, depth_of_knowledge: 0, hr_readiness: null },
      overallScore: 0,
      strengths: [] as string[],
      weaknesses: ['No answers were recorded in this session.'],
      improvementPlan: ['Complete a full interview session to receive a scorecard.'],
      hiringRecommendation: 'no_hire' as const,
    };
  }

  const dims = {
    technical_accuracy: avg(rows.map((r: any) => Number(r.technical_accuracy))),
    communication_clarity: avg(rows.map((r: any) => Number(r.communication_clarity))),
    problem_solving_approach: avg(rows.map((r: any) => Number(r.problem_solving_approach))),
    depth_of_knowledge: avg(rows.map((r: any) => Number(r.depth_of_knowledge))),
    hr_readiness:
      roundType === 'hr'
        ? avg(rows.filter((r: any) => r.hr_readiness !== null).map((r: any) => Number(r.hr_readiness)))
        : null,
  };

  const dimLabels: Record<string, string> = {
    technical_accuracy: 'Technical accuracy',
    communication_clarity: 'Communication clarity',
    problem_solving_approach: 'Problem-solving approach',
    depth_of_knowledge: 'Depth of knowledge',
    hr_readiness: 'HR readiness',
  };

  const strengths: string[] = [];
  const weaknesses: string[] = [];
  for (const [key, label] of Object.entries(dimLabels)) {
    const value = (dims as any)[key];
    if (value === null) continue;
    if (value >= 7.5) strengths.push(label);
    if (value < 5) weaknesses.push(label);
  }

  const relevantDims = Object.values(dims).filter((v): v is number => v !== null);
  const overallScore = Number((avg(relevantDims) * 10).toFixed(2)); // dims are 0-10 -> overall is 0-100

  const improvementPlan = weaknesses.length
    ? weaknesses.map((w) => `Practice targeted mock questions to improve: ${w.toLowerCase()}.`)
    : ['Keep practicing to maintain consistency across dimensions.'];

  return {
    dims,
    overallScore,
    strengths,
    weaknesses,
    improvementPlan,
    hiringRecommendation: hiringRecommendationFor(overallScore),
  };
}

export async function completeSession(sessionId: string, userId: string) {
  const session = await repo.getSession(sessionId);
  if (!session) throw ApiError.notFound('Interview session not found');

  const existing = await repo.getScorecard(sessionId);
  if (existing) return existing;

  const durationSeconds = Math.max(1, Math.round((Date.now() - new Date(session.started_at).getTime()) / 1000));
  const synthesized = await synthesizeScorecard(sessionId, session.round_type);

  await repo.markSessionCompleted(sessionId, durationSeconds);
  await repo.insertScorecard({
    sessionId,
    dims: synthesized.dims,
    overallScore: synthesized.overallScore,
    strengths: synthesized.strengths,
    weaknesses: synthesized.weaknesses,
    improvementPlan: synthesized.improvementPlan,
    hiringRecommendation: synthesized.hiringRecommendation,
  });

  checkInterviewBadges(userId, synthesized.overallScore).catch((err) =>
    logger.warn({ err }, 'interview badge check failed')
  );
  maybeRecomputeReadiness(userId, 'interview_completed').catch((err) =>
    logger.warn({ err }, 'readiness recompute after interview failed')
  );

  return repo.getScorecard(sessionId);
}

export async function getScorecardOrCompute(sessionId: string, userId: string) {
  const existing = await repo.getScorecard(sessionId);
  if (existing) return existing;
  // Auto-finalize: a student checking the scorecard is implicitly ending the session.
  return completeSession(sessionId, userId);
}

export async function listSessions(userId: string) {
  return repo.listSessionsForUser(userId);
}
