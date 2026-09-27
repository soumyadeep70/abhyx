import { z } from 'zod';

export const updateTargetCompaniesSchema = z.object({
  target_company_tier_ids: z.array(z.string().uuid()).min(1).max(10),
});

export const userIdParamSchema = z.object({ userId: z.string().uuid() });
