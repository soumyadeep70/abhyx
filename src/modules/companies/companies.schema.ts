import { z } from 'zod';

export const tierIdParamSchema = z.object({ tierId: z.string().uuid() });
