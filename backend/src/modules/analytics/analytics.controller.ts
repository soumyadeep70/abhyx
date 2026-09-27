import { Request, Response } from 'express';
import { asyncHandler } from '../../utils/asyncHandler';
import { getParam } from '../../utils/params';
import * as service from './analytics.service';

export const dashboardHandler = asyncHandler(async (req: Request, res: Response) => {
  const dashboard = await service.getDashboard(getParam(req, 'userId'));
  res.json(dashboard);
});
