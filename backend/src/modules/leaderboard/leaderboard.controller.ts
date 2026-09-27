import { Request, Response } from 'express';
import { asyncHandler } from '../../utils/asyncHandler';
import * as service from './leaderboard.service';

export const getHandler = asyncHandler(async (req: Request, res: Response) => {
  const q = req.query as any;
  const rows = await service.getLeaderboard({ scope: q.scope, college: q.college, limit: q.limit });
  res.json({ leaderboard: rows });
});

export const refreshHandler = asyncHandler(async (_req: Request, res: Response) => {
  await service.refreshNow();
  res.status(204).send();
});
