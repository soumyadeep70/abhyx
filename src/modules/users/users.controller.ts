import { Request, Response } from 'express';
import { asyncHandler } from '../../utils/asyncHandler';
import { getParam } from '../../utils/params';
import { ApiError } from '../../utils/ApiError';
import * as repo from './users.repository';

export const getProfileHandler = asyncHandler(async (req: Request, res: Response) => {
  const userId = getParam(req, 'userId');
  const profile = await repo.getProfile(userId);
  if (!profile) throw ApiError.notFound('User not found');
  const [targetCompanies, streak] = await Promise.all([
    repo.getTargetCompanies(userId),
    repo.getStreak(userId),
  ]);
  res.json({ profile, target_companies: targetCompanies, streak });
});

export const getTargetCompaniesHandler = asyncHandler(async (req: Request, res: Response) => {
  const rows = await repo.getTargetCompanies(getParam(req, 'userId'));
  res.json({ target_companies: rows });
});

export const updateTargetCompaniesHandler = asyncHandler(async (req: Request, res: Response) => {
  const userId = getParam(req, 'userId');
  await repo.replaceTargetCompanies(userId, req.body.target_company_tier_ids);
  const rows = await repo.getTargetCompanies(userId);
  res.json({ target_companies: rows });
});

export const getActivityHandler = asyncHandler(async (req: Request, res: Response) => {
  const userId = getParam(req, 'userId');
  const [streak, heatmap] = await Promise.all([
    repo.getStreak(userId),
    repo.getActivityHeatmap(userId),
  ]);
  res.json({ streak, activity_dates: heatmap });
});
