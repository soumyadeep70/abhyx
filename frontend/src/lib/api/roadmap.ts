import { apiClient } from '../apiClient';
import type { Roadmap } from '../types';

export interface GenerateRoadmapInput {
  company_tier_id: string;
  weeks_available?: number;
  target_date?: string;
}

export const roadmapApi = {
  generate: (input: GenerateRoadmapInput) => apiClient.post<{ roadmap: Roadmap }>('/roadmap/generate', input).then((r) => r.data.roadmap),
  getActive: (userId: string) => apiClient.get<{ roadmap: Roadmap }>(`/roadmap/${userId}/active`).then((r) => r.data.roadmap),
  completePhase: (userId: string, phaseId: string) =>
    apiClient.patch<{ roadmap: Roadmap }>(`/roadmap/${userId}/phase/${phaseId}`).then((r) => r.data.roadmap),
};
