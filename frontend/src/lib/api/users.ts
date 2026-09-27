import { apiClient } from '../apiClient';
import type { PublicUser, StreakInfo, TargetCompanyRow } from '../types';

export const usersApi = {
  getProfile: (userId: string) =>
    apiClient
      .get<{ profile: PublicUser; target_companies: TargetCompanyRow[]; streak: StreakInfo }>(`/users/${userId}`)
      .then((r) => r.data),
  getTargetCompanies: (userId: string) =>
    apiClient.get<{ target_companies: TargetCompanyRow[] }>(`/users/${userId}/target-companies`).then((r) => r.data.target_companies),
  updateTargetCompanies: (userId: string, tierIds: string[]) =>
    apiClient
      .put<{ target_companies: TargetCompanyRow[] }>(`/users/${userId}/target-companies`, {
        target_company_tier_ids: tierIds,
      })
      .then((r) => r.data.target_companies),
  getActivity: (userId: string) =>
    apiClient
      .get<{ streak: StreakInfo; activity_dates: string[] }>(`/users/${userId}/activity`)
      .then((r) => r.data),
  getBadges: (userId: string) =>
    apiClient.get<{ badges: import('../types').Badge[] }>(`/users/${userId}/badges`).then((r) => r.data.badges),
};
