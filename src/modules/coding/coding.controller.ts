import { Request, Response } from 'express';
import { asyncHandler } from '../../utils/asyncHandler';
import { ApiError } from '../../utils/ApiError';
import { getQuestionWithDetails } from '../questions/questions.repository';
import * as service from './coding.service';

export const getProblemHandler = asyncHandler(async (req: Request, res: Response) => {
  const question = await getQuestionWithDetails(req.params.questionId, false);
  if (!question || question.type !== 'coding') throw ApiError.notFound('Coding problem not found');
  res.json({ question });
});

export const submitCodeHandler = asyncHandler(async (req: Request, res: Response) => {
  const userId = req.user!.sub;
  const result = await service.submitCode({
    userId,
    questionId: req.body.question_id,
    language: req.body.language,
    sourceCode: req.body.source_code,
    timeTakenSeconds: req.body.time_taken_seconds,
    hintsUsed: req.body.hints_used,
    mockTestId: req.body.mock_test_id,
  });
  res.status(201).json(result);
});

export const getSubmissionHandler = asyncHandler(async (req: Request, res: Response) => {
  const submission = await service.getSubmission(req.params.submissionId);
  res.json({ submission });
});

export const listSubmissionsHandler = asyncHandler(async (req: Request, res: Response) => {
  const submissions = await service.listSubmissions(req.params.userId);
  res.json({ submissions });
});
