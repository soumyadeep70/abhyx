import { Request, Response } from 'express';
import { asyncHandler } from '../../utils/asyncHandler';
import { ApiError } from '../../utils/ApiError';
import * as service from './resume.service';

export const uploadHandler = asyncHandler(async (req: Request, res: Response) => {
  if (!req.file) throw ApiError.badRequest('No file uploaded (expected multipart field "resume")');
  const result = await service.uploadAndAnalyzeResume({
    userId: req.user!.sub,
    fileBuffer: req.file.buffer,
    originalName: req.file.originalname,
    targetCompanyTierId: req.body.target_company_tier_id,
  });
  res.status(201).json(result);
});

export const listHandler = asyncHandler(async (req: Request, res: Response) => {
  const resumes = await service.listResumeHistory(req.params.userId);
  res.json({ resumes });
});
