import { z } from 'zod';

export const listQuestionsQuerySchema = z.object({
  type: z.enum(['aptitude', 'coding']).optional(),
  topic_id: z.string().uuid().optional(),
  difficulty: z.enum(['easy', 'medium', 'hard']).optional(),
  company_id: z.string().uuid().optional(),
  page: z.coerce.number().int().min(1).default(1),
  page_size: z.coerce.number().int().min(1).max(100).default(20),
});

export const questionIdParamSchema = z.object({ questionId: z.string().uuid() });

export const createAptitudeQuestionSchema = z.object({
  type: z.literal('aptitude'),
  topic_id: z.string().uuid(),
  difficulty: z.enum(['easy', 'medium', 'hard']),
  title: z.string().min(1),
  prompt: z.string().min(1),
  options: z.array(z.string()).min(2),
  correct_answer: z.record(z.string(), z.unknown()),
  tag_ids: z.array(z.string().uuid()).optional().default([]),
  company_ids: z.array(z.string().uuid()).optional().default([]),
});

export const createCodingQuestionSchema = z.object({
  type: z.literal('coding'),
  topic_id: z.string().uuid(),
  difficulty: z.enum(['easy', 'medium', 'hard']),
  title: z.string().min(1),
  prompt: z.string().min(1),
  function_signature: z.string().optional(),
  starter_code: z.record(z.string(), z.string()).optional().default({}),
  test_cases: z.array(z.object({ input: z.string(), expected: z.string() })).min(1),
  constraints_text: z.string().optional(),
  time_limit_ms: z.number().int().positive().optional().default(2000),
  memory_limit_kb: z.number().int().positive().optional().default(131072),
  judge0_language_ids: z.array(z.number().int()).optional().default([]),
  tag_ids: z.array(z.string().uuid()).optional().default([]),
  company_ids: z.array(z.string().uuid()).optional().default([]),
});

export const createQuestionSchema = z.discriminatedUnion('type', [
  createAptitudeQuestionSchema,
  createCodingQuestionSchema,
]);
