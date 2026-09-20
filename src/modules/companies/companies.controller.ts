import { Request, Response } from 'express';
import { asyncHandler } from '../../utils/asyncHandler';
import { ApiError } from '../../utils/ApiError';
import * as repo from './companies.repository';

export const listCompaniesHandler = asyncHandler(async (_req: Request, res: Response) => {
  const rows = await repo.listCompaniesWithTiers();
  res.json({ companies: rows });
});

export const getTierHandler = asyncHandler(async (req: Request, res: Response) => {
  const tier = await repo.getTierById(req.params.tierId);
  if (!tier) throw ApiError.notFound('Company tier not found');
  res.json({ tier });
});
