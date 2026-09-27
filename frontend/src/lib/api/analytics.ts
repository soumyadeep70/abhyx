import { apiClient } from '../apiClient';
import type { DashboardData } from '../types';

export const analyticsApi = {
  getDashboard: (userId: string) => apiClient.get<DashboardData>(`/analytics/${userId}/dashboard`).then((r) => r.data),
};
