import { z } from 'zod';

export const startSessionSchema = z.object({
  round_type: z.enum(['technical', 'hr', 'system_design']),
  company_tier_id: z.string().uuid().optional(),
});

export const respondSchema = z.object({
  message: z.string().min(1),
});

export const sessionIdParamSchema = z.object({ sessionId: z.string().uuid() });
