import { apiClient } from '../apiClient';
import type { ReadinessHistoryRow, ReadinessInsights, ReadinessScoreRow } from '../types';

export const readinessApi = {
  getProfile: (userId: string) =>
    apiClient.get<{ readiness: ReadinessScoreRow[] }>(`/readiness/${userId}`).then((r) => r.data.readiness),
  recompute: (userId: string) =>
    apiClient.post<{ readiness: ReadinessScoreRow[] }>(`/readiness/${userId}/recompute`).then((r) => r.data.readiness),
  getHistory: (userId: string, tierId: string) =>
    apiClient
      .get<{ history: ReadinessHistoryRow[] }>(`/readiness/${userId}/tiers/${tierId}/history`)
      .then((r) => r.data.history),
  getInsights: (userId: string, tierId: string) =>
    apiClient
      .get<{ insights: ReadinessInsights | null }>(`/readiness/${userId}/tiers/${tierId}/insights`)
      .then((r) => r.data.insights),
};
