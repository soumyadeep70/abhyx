import { z } from 'zod';

export const leaderboardQuerySchema = z.object({
  scope: z.enum(['overall', 'college', 'streak']).default('overall'),
  college: z.string().optional(),
  limit: z.coerce.number().int().min(1).max(100).default(50),
});
