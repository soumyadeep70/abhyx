import { apiClient, ApiClientError } from '../apiClient';
import type { NextAssessmentQuestion, TopicAnalyticsRow } from '../types';

export interface SubmitAssessmentInput {
  question_id: string;
  answer: Record<string, unknown>;
  time_taken_seconds?: number;
  hints_used?: number;
  mock_test_id?: string;
}

export const assessmentApi = {
  /** Backend throws 404 (not a null payload) when no adaptive question is available; normalize that to null here. */
  next: (params: { category?: 'aptitude' | 'coding'; company_tier_id?: string }) =>
    apiClient
      .get<{ question: NextAssessmentQuestion }>('/assessment/next', { params })
      .then((r) => r.data.question)
      .catch((err) => {
        if (err instanceof ApiClientError && err.status === 404) return null;
        throw err;
      }),
  submit: (input: SubmitAssessmentInput) =>
    apiClient
      .post<{ attempt_id: string; is_correct: boolean; topic_id: string; difficulty: string }>('/assessment/submit', input)
      .then((r) => r.data),
  analytics: (userId: string) =>
    apiClient.get<{ topics: TopicAnalyticsRow[] }>(`/assessment/analytics/${userId}`).then((r) => r.data.topics),
};
