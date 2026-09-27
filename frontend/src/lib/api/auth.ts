import { apiClient } from '../apiClient';
import type { AuthResult, PublicUser } from '../types';

export interface RegisterInput {
  email: string;
  password: string;
  full_name: string;
  college?: string;
  graduation_year?: number;
  target_company_tier_ids?: string[];
}

export interface LoginInput {
  email: string;
  password: string;
}

export const authApi = {
  register: (input: RegisterInput) => apiClient.post<AuthResult>('/auth/register', input).then((r) => r.data),
  login: (input: LoginInput) => apiClient.post<AuthResult>('/auth/login', input).then((r) => r.data),
  logout: () => apiClient.post('/auth/logout').then(() => undefined),
  me: () => apiClient.get<{ user: PublicUser }>('/auth/me').then((r) => r.data.user),
};
