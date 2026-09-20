import { z } from 'zod';

export const registerSchema = z.object({
  email: z.string().email(),
  password: z.string().min(8, 'Password must be at least 8 characters'),
  full_name: z.string().min(1).max(200),
  college: z.string().max(200).optional(),
  graduation_year: z.number().int().min(2000).max(2100).optional(),
  // Onboarding: student picks target companies (company_tiers) right away.
  target_company_tier_ids: z.array(z.string().uuid()).max(10).optional().default([]),
});
export type RegisterInput = z.infer<typeof registerSchema>;

export const loginSchema = z.object({
  email: z.string().email(),
  password: z.string().min(1),
});
export type LoginInput = z.infer<typeof loginSchema>;
