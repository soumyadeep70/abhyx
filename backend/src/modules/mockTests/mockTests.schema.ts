import { z } from 'zod';

export const createMockTestSchema = z.object({
  company_tier_id: z.string().uuid(),
  aptitude_question_count: z.number().int().min(0).max(30).optional().default(10),
  coding_question_count: z.number().int().min(0).max(10).optional().default(2),
});

export const mockTestIdParamSchema = z.object({ mockTestId: z.string().uuid() });
export const userIdParamSchema = z.object({ userId: z.string().uuid() });
