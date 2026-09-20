import axios, { AxiosInstance } from 'axios';
import { env } from '../config/env';
import { logger } from '../utils/logger';
import { ApiError } from '../utils/ApiError';

/**
 * Single client for the separate FastAPI AI microservice described in the
 * HLD (Section 09, "FastAPI AI Service Internal APIs"). Per the HLD's
 * "Non-Negotiable Engineering Rules": the frontend never calls AI APIs
 * directly, and Express is the only orchestrator — this module is that
 * single choke point, so callers never see fetch/axios directly.
 *
 * The AI service is expected to return Pydantic-validated JSON on success;
 * any transport failure or non-2xx here is surfaced as a 502 so the caller
 * (a route handler) can decide whether to degrade gracefully (e.g. serve a
 * stale cache entry) or fail the request.
 */

const client: AxiosInstance = axios.create({
  baseURL: env.AI_SERVICE_BASE_URL,
  timeout: env.AI_SERVICE_TIMEOUT_MS,
  headers: {
    'Content-Type': 'application/json',
    ...(env.AI_SERVICE_API_KEY ? { 'X-Internal-Api-Key': env.AI_SERVICE_API_KEY } : {}),
  },
});

async function post<TResponse>(path: string, body: unknown): Promise<TResponse> {
  try {
    const { data } = await client.post<TResponse>(path, body);
    return data;
  } catch (err: any) {
    logger.error({ err: err?.message, path }, 'AI service call failed');
    throw ApiError.badGateway(`AI service call to ${path} failed`, {
      upstreamStatus: err?.response?.status,
      upstreamBody: err?.response?.data,
    });
  }
}

export interface ResumeAnalysisResult {
  ats_score: number;
  skills_present: string[];
  skills_missing: string[];
  keyword_gaps: string[];
  summary: string;
}
export function analyzeResume(payload: {
  resume_text: string;
  target_company?: string;
}): Promise<ResumeAnalysisResult> {
  return post('/resume/analyze', payload);
}

export interface InterviewScoreResult {
  technical_accuracy: number;
  communication_clarity: number;
  problem_solving_approach: number;
  depth_of_knowledge: number;
  hr_readiness: number | null;
  feedback: string;
  follow_up_question?: string;
}
export function scoreInterviewAnswer(payload: {
  round_type: string;
  company?: string;
  question: string;
  answer: string;
  conversation_history: { role: string; message: string }[];
}): Promise<InterviewScoreResult> {
  return post('/interview/score', payload);
}

export interface RoadmapGenerationResult {
  phases: {
    phase_number: number;
    title: string;
    topics: string[];
    estimated_days: number;
    resources: string[];
  }[];
}
export function generateRoadmap(payload: {
  weak_topics: string[];
  target_company: string;
  weeks_available: number;
  resume_gaps?: string[];
}): Promise<RoadmapGenerationResult> {
  return post('/roadmap/generate', payload);
}

export interface WeakTopicAnalysisResult {
  strong: string[];
  weak: string[];
  improving: string[];
  error_breakdown: Record<string, number>;
}
export function analyzeWeakTopics(payload: {
  topic_performance: { topic: string; accuracy: number; attempts: number; trend?: number[] }[];
}): Promise<WeakTopicAnalysisResult> {
  return post('/analytics/weak-topics', payload);
}

export interface ReadinessInsightResult {
  headline: string;
  strengths: string[];
  risks: string[];
  next_actions: string[];
}
export function getReadinessInsights(payload: {
  company: string;
  tier: string;
  score: number;
  probability: number;
  breakdown: Record<string, number | null>;
}): Promise<ReadinessInsightResult> {
  return post('/readiness/insights', payload);
}

export interface CompanyIntelligenceResult {
  recent_patterns: string[];
  commonly_asked_topics: string[];
  interview_tips: string[];
  sources: string[];
}
export function getCompanyIntelligence(payload: {
  company: string;
  tier: string;
}): Promise<CompanyIntelligenceResult> {
  return post('/company/intelligence', payload);
}
