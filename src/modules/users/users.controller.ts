import { Request, Response } from 'express';
import { asyncHandler } from '../../utils/asyncHandler';
import { ApiError } from '../../utils/ApiError';
import * as repo from './users.repository';

export const getProfileHandler = asyncHandler(async (req: Request, res: Response) => {
  const profile = await repo.getProfile(req.params.userId);
  if (!profile) throw ApiError.notFound('User not found');
  const [targetCompanies, streak] = await Promise.all([
    repo.getTargetCompanies(req.params.userId),
    repo.getStreak(req.params.userId),
  ]);
  res.json({ profile, target_companies: targetCompanies, streak });
});

export const getTargetCompaniesHandler = asyncHandler(async (req: Request, res: Response) => {
  const rows = await repo.getTargetCompanies(req.params.userId);
  res.json({ target_companies: rows });
});

export const updateTargetCompaniesHandler = asyncHandler(async (req: Request, res: Response) => {
  await repo.replaceTargetCompanies(req.params.userId, req.body.target_company_tier_ids);
  const rows = await repo.getTargetCompanies(req.params.userId);
  res.json({ target_companies: rows });
});

export const getActivityHandler = asyncHandler(async (req: Request, res: Response) => {
  const [streak, heatmap] = await Promise.all([
    repo.getStreak(req.params.userId),
    repo.getActivityHeatmap(req.params.userId),
  ]);
  res.json({ streak, activity_dates: heatmap });
});
