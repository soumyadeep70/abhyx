import { apiClient } from '../apiClient';
import type { InterviewRespondResult, InterviewScorecard, InterviewSessionSummary, InterviewStartResult } from '../types';

export const interviewApi = {
  start: (input: { round_type: 'technical' | 'hr' | 'system_design'; company_tier_id?: string }) =>
    apiClient.post<InterviewStartResult>('/interview/session/start', input).then((r) => r.data),
  respond: (sessionId: string, message: string) =>
    apiClient.post<InterviewRespondResult>(`/interview/session/${sessionId}/respond`, { message }).then((r) => r.data),
  getScorecard: (sessionId: string) =>
    apiClient.get<{ scorecard: InterviewScorecard }>(`/interview/session/${sessionId}/scorecard`).then((r) => r.data.scorecard),
  complete: (sessionId: string) =>
    apiClient.post<{ scorecard: InterviewScorecard }>(`/interview/session/${sessionId}/complete`).then((r) => r.data.scorecard),
  listForUser: (userId: string) =>
    apiClient.get<{ sessions: InterviewSessionSummary[] }>(`/interview/sessions/user/${userId}`).then((r) => r.data.sessions),
};
