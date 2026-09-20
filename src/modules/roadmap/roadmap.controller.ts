import { Request, Response } from 'express';
import { asyncHandler } from '../../utils/asyncHandler';
import { ApiError } from '../../utils/ApiError';
import * as service from './roadmap.service';

export const generateHandler = asyncHandler(async (req: Request, res: Response) => {
  const roadmap = await service.generateRoadmapForUser(
    req.user!.sub,
    req.body.company_tier_id,
    [],
    req.body.weeks_available,
    req.body.target_date
  );
  res.status(201).json({ roadmap });
});

export const getActiveHandler = asyncHandler(async (req: Request, res: Response) => {
  const roadmap = await service.getActiveRoadmap(req.params.userId);
  if (!roadmap) throw ApiError.notFound('No active roadmap for this user');
  res.json({ roadmap });
});

export const completePhaseHandler = asyncHandler(async (req: Request, res: Response) => {
  const roadmap = await service.completePhase(req.params.userId, req.params.id);
  res.json({ roadmap });
});
