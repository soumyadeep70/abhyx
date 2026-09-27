import { Request, Response } from 'express';
import { asyncHandler } from '../../utils/asyncHandler';
import { getParam } from '../../utils/params';
import * as service from './assessment.service';

export const submitHandler = asyncHandler(async (req: Request, res: Response) => {
  const userId = req.user!.sub;
  const result = await service.submitAptitudeAnswer({
    userId,
    questionId: req.body.question_id,
    answer: req.body.answer,
    timeTakenSeconds: req.body.time_taken_seconds,
    hintsUsed: req.body.hints_used,
    mockTestId: req.body.mock_test_id,
  });
  res.status(201).json(result);
});

export const nextQuestionHandler = asyncHandler(async (req: Request, res: Response) => {
  const userId = req.user!.sub;
  const q = req.query as any;
  const question = await service.getNextAdaptiveQuestion({
    userId,
    category: q.category,
    companyId: q.company_tier_id,
  });
  res.json({ question });
});

export const analyticsHandler = asyncHandler(async (req: Request, res: Response) => {
  const analytics = await service.getTopicAnalytics(getParam(req, 'userId'));
  res.json({ topics: analytics });
});
