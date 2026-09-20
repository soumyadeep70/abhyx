import { z } from 'zod';

export const submitCodeSchema = z.object({
  question_id: z.string().uuid(),
  language: z.enum(['python', 'javascript', 'java', 'cpp']),
  source_code: z.string().min(1),
  time_taken_seconds: z.number().int().positive().optional(),
  hints_used: z.number().int().min(0).optional().default(0),
  mock_test_id: z.string().uuid().optional(),
});

export const submissionIdParamSchema = z.object({ submissionId: z.string().uuid() });
export const userIdParamSchema = z.object({ userId: z.string().uuid() });
export const questionIdParamSchema = z.object({ questionId: z.string().uuid() });
