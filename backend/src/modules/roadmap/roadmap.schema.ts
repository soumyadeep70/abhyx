import { z } from 'zod';

export const generateRoadmapSchema = z.object({
  company_tier_id: z.string().uuid(),
  weeks_available: z.number().int().min(1).max(52).optional().default(8),
  target_date: z.string().optional(),
});

export const userIdParamSchema = z.object({ userId: z.string().uuid() });
export const phaseParamSchema = z.object({ userId: z.string().uuid(), id: z.string().uuid() });
