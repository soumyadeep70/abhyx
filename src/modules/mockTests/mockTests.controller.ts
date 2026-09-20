import { Request, Response } from 'express';
import { asyncHandler } from '../../utils/asyncHandler';
import * as service from './mockTests.service';

export const startHandler = asyncHandler(async (req: Request, res: Response) => {
  const userId = req.user!.sub;
  const result = await service.startMockTest({
    userId,
    tierId: req.body.company_tier_id,
    aptitudeCount: req.body.aptitude_question_count,
    codingCount: req.body.coding_question_count,
  });
  res.status(201).json(result);
});

export const getHandler = asyncHandler(async (req: Request, res: Response) => {
  const test = await service.getMockTestDetail(req.params.mockTestId);
  res.json({ mock_test: test });
});

export const completeHandler = asyncHandler(async (req: Request, res: Response) => {
  const result = await service.finishMockTest(req.params.mockTestId, req.user!.sub);
  res.json(result);
});

export const abandonHandler = asyncHandler(async (req: Request, res: Response) => {
  const result = await service.abandonMockTest(req.params.mockTestId);
  res.json(result);
});

export const listHandler = asyncHandler(async (req: Request, res: Response) => {
  const tests = await service.listMockTests(req.params.userId);
  res.json({ mock_tests: tests });
});
