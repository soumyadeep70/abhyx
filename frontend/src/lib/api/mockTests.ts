import { apiClient } from '../apiClient';
import type { MockTest } from '../types';

export interface CreateMockTestInput {
  company_tier_id: string;
  aptitude_question_count?: number;
  coding_question_count?: number;
}

export const mockTestsApi = {
  start: (input: CreateMockTestInput) => apiClient.post<MockTest>('/mock-tests', input).then((r) => r.data),
  get: (mockTestId: string) => apiClient.get<{ mock_test: MockTest }>(`/mock-tests/${mockTestId}`).then((r) => r.data.mock_test),
  complete: (mockTestId: string) =>
    apiClient
      .post<{ id: string; status: string; total_score: number }>(`/mock-tests/${mockTestId}/complete`)
      .then((r) => r.data),
  abandon: (mockTestId: string) =>
    apiClient.post<{ id: string; status: string }>(`/mock-tests/${mockTestId}/abandon`).then((r) => r.data),
  listForUser: (userId: string) => apiClient.get<{ mock_tests: MockTest[] }>(`/mock-tests/user/${userId}`).then((r) => r.data.mock_tests),
};
