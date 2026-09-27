import { apiClient } from '../apiClient';
import type { CompanyTier } from '../types';

export const companiesApi = {
  list: () => apiClient.get<{ companies: CompanyTier[] }>('/companies').then((r) => r.data.companies),
  getTier: (tierId: string) => apiClient.get<{ tier: CompanyTier }>(`/companies/tiers/${tierId}`).then((r) => r.data.tier),
};
