import { Request, Response } from 'express';
import { asyncHandler } from '../../utils/asyncHandler';
import * as service from './analytics.service';

export const dashboardHandler = asyncHandler(async (req: Request, res: Response) => {
  const dashboard = await service.getDashboard(req.params.userId);
  res.json(dashboard);
});
