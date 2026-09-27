import { apiClient } from '../apiClient';
import type { CodeSubmissionSummary, CodingQuestionDetail, CodingSubmissionResult } from '../types';

export interface SubmitCodeInput {
  question_id: string;
  language: 'python' | 'javascript' | 'java' | 'cpp';
  source_code: string;
  time_taken_seconds?: number;
  hints_used?: number;
  mock_test_id?: string;
}

export const codingApi = {
  getProblem: (questionId: string) =>
    apiClient.get<{ question: CodingQuestionDetail }>(`/coding/problem/${questionId}`).then((r) => r.data.question),
  submit: (input: SubmitCodeInput) => apiClient.post<CodingSubmissionResult>('/coding/submit', input).then((r) => r.data),
  getSubmission: (submissionId: string) =>
    apiClient.get<{ submission: CodeSubmissionSummary }>(`/coding/submissions/${submissionId}`).then((r) => r.data.submission),
  listSubmissions: (userId: string) =>
    apiClient.get<{ submissions: CodeSubmissionSummary[] }>(`/coding/submissions/user/${userId}`).then((r) => r.data.submissions),
};
