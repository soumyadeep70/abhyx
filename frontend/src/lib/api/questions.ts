import { apiClient } from '../apiClient';
import type { AptitudeQuestionDetail, CodingQuestionDetail, QuestionListItem, Topic } from '../types';

export interface ListQuestionsParams {
  type?: 'aptitude' | 'coding';
  topic_id?: string;
  difficulty?: 'easy' | 'medium' | 'hard';
  company_id?: string;
  page?: number;
  page_size?: number;
}

export const questionsApi = {
  listTopics: () => apiClient.get<{ topics: Topic[] }>('/questions/topics').then((r) => r.data.topics),
  list: (params: ListQuestionsParams) =>
    apiClient.get<{ questions: QuestionListItem[]; page: number; page_size: number }>('/questions', { params }).then((r) => r.data),
  get: (questionId: string) =>
    apiClient
      .get<{ question: AptitudeQuestionDetail | CodingQuestionDetail }>(`/questions/${questionId}`)
      .then((r) => r.data.question),
  create: (body: Record<string, unknown>) => apiClient.post<{ id: string }>('/questions', body).then((r) => r.data.id),
  deactivate: (questionId: string) => apiClient.delete(`/questions/${questionId}`).then(() => undefined),
};
