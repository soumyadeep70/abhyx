import { apiClient } from '../apiClient';
import type { LeaderboardRow } from '../types';

export const leaderboardApi = {
  get: (params: { scope: 'overall' | 'college' | 'streak'; college?: string; limit?: number }) =>
    apiClient.get<{ leaderboard: LeaderboardRow[] }>('/leaderboard', { params }).then((r) => r.data.leaderboard),
  refresh: () => apiClient.post('/leaderboard/refresh').then(() => undefined),
};
