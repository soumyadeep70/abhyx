import { Request, Response } from 'express';
import { asyncHandler } from '../../utils/asyncHandler';
import * as service from './readiness.service';

export const getProfileHandler = asyncHandler(async (req: Request, res: Response) => {
  const profile = await service.getFullReadinessProfile(req.params.userId);
  res.json({ readiness: profile });
});

export const recomputeHandler = asyncHandler(async (req: Request, res: Response) => {
  await service.maybeRecomputeReadiness(req.params.userId, 'manual');
  const profile = await service.getFullReadinessProfile(req.params.userId);
  res.json({ readiness: profile });
});

export const getHistoryHandler = asyncHandler(async (req: Request, res: Response) => {
  const history = await service.getHistory(req.params.userId, req.params.tierId);
  res.json({ history });
});

export const getInsightsHandler = asyncHandler(async (req: Request, res: Response) => {
  const insights = await service.getInsights(req.params.userId, req.params.tierId);
  res.json({ insights }); // null when nothing cached yet (no significant score change has occurred)
});
