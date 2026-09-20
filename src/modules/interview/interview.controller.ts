import { Request, Response } from 'express';
import { asyncHandler } from '../../utils/asyncHandler';
import * as service from './interview.service';

export const startHandler = asyncHandler(async (req: Request, res: Response) => {
  const result = await service.startSession({
    userId: req.user!.sub,
    roundType: req.body.round_type,
    tierId: req.body.company_tier_id,
  });
  res.status(201).json(result);
});

export const respondHandler = asyncHandler(async (req: Request, res: Response) => {
  const result = await service.respond({
    sessionId: req.params.sessionId,
    userId: req.user!.sub,
    message: req.body.message,
  });
  res.status(201).json(result);
});

export const scorecardHandler = asyncHandler(async (req: Request, res: Response) => {
  const scorecard = await service.getScorecardOrCompute(req.params.sessionId, req.user!.sub);
  res.json({ scorecard });
});

export const completeHandler = asyncHandler(async (req: Request, res: Response) => {
  const scorecard = await service.completeSession(req.params.sessionId, req.user!.sub);
  res.json({ scorecard });
});

export const listHandler = asyncHandler(async (req: Request, res: Response) => {
  const sessions = await service.listSessions(req.params.userId);
  res.json({ sessions });
});
