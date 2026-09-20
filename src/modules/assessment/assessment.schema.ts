import { z } from 'zod';

export const submitAssessmentSchema = z.object({
  question_id: z.string().uuid(),
  answer: z.record(z.string(), z.unknown()),
  time_taken_seconds: z.number().int().positive().optional(),
  hints_used: z.number().int().min(0).optional().default(0),
  mock_test_id: z.string().uuid().optional(),
});

export const nextQuestionQuerySchema = z.object({
  category: z.enum(['aptitude', 'coding']).default('aptitude'),
  company_tier_id: z.string().uuid().optional(),
});

export const userIdParamSchema = z.object({ userId: z.string().uuid() });
