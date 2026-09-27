import { z } from 'zod';

export const userIdParamSchema = z.object({ userId: z.string().uuid() });
export const tierIdParamSchema = z.object({ userId: z.string().uuid(), tierId: z.string().uuid() });
