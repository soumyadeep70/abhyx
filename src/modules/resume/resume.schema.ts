import { z } from 'zod';

export const uploadResumeBodySchema = z.object({
  target_company_tier_id: z.string().uuid().optional(),
});

export const userIdParamSchema = z.object({ userId: z.string().uuid() });
