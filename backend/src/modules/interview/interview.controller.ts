import { Request, Response } from 'express';
import { asyncHandler } from '../../utils/asyncHandler';
import { getParam } from '../../utils/params';
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
    sessionId: getParam(req, 'sessionId'),
    userId: req.user!.sub,
    message: req.body.message,
  });
  res.status(201).json(result);
});

export const scorecardHandler = asyncHandler(async (req: Request, res: Response) => {
  const scorecard = await service.getScorecardOrCompute(getParam(req, 'sessionId'), req.user!.sub);
  res.json({ scorecard });
});

export const completeHandler = asyncHandler(async (req: Request, res: Response) => {
  const scorecard = await service.completeSession(getParam(req, 'sessionId'), req.user!.sub);
  res.json({ scorecard });
});

export const listHandler = asyncHandler(async (req: Request, res: Response) => {
  const sessions = await service.listSessions(getParam(req, 'userId'));
  res.json({ sessions });
});
