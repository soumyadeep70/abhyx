import { Request, Response } from 'express';
import { asyncHandler } from '../../utils/asyncHandler';
import { getParam } from '../../utils/params';
import * as service from './readiness.service';

export const getProfileHandler = asyncHandler(async (req: Request, res: Response) => {
  const profile = await service.getFullReadinessProfile(getParam(req, 'userId'));
  res.json({ readiness: profile });
});

export const recomputeHandler = asyncHandler(async (req: Request, res: Response) => {
  const userId = getParam(req, 'userId');
  await service.maybeRecomputeReadiness(userId, 'manual');
  const profile = await service.getFullReadinessProfile(userId);
  res.json({ readiness: profile });
});

export const getHistoryHandler = asyncHandler(async (req: Request, res: Response) => {
  const history = await service.getHistory(getParam(req, 'userId'), getParam(req, 'tierId'));
  res.json({ history });
});

export const getInsightsHandler = asyncHandler(async (req: Request, res: Response) => {
  const insights = await service.getInsights(getParam(req, 'userId'), getParam(req, 'tierId'));
  res.json({ insights }); // null when nothing cached yet (no significant score change has occurred)
});
