import { apiClient } from '../apiClient';
import type { ResumeAnalysis, ResumeHistoryItem } from '../types';

export const resumeApi = {
  upload: (file: File, targetCompanyTierId?: string) => {
    const form = new FormData();
    form.append('resume', file);
    if (targetCompanyTierId) form.append('target_company_tier_id', targetCompanyTierId);
    // Deliberately no explicit Content-Type: the browser/axios must generate the
    // multipart boundary itself. Setting 'multipart/form-data' by hand here would
    // strip that boundary and the backend's multer parser would reject every upload.
    return apiClient.post<ResumeAnalysis>('/resume/upload', form).then((r) => r.data);
  },
  listForUser: (userId: string) =>
    apiClient.get<{ resumes: ResumeHistoryItem[] }>(`/resume/user/${userId}`).then((r) => r.data.resumes),
};
