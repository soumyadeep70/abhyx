import { Request, Response } from 'express';
import { asyncHandler } from '../../utils/asyncHandler';
import { getParam } from '../../utils/params';
import { ApiError } from '../../utils/ApiError';
import * as repo from './questions.repository';

export const listQuestionsHandler = asyncHandler(async (req: Request, res: Response) => {
  const q = req.query as any;
  const rows = await repo.listQuestions({
    type: q.type,
    topicId: q.topic_id,
    difficulty: q.difficulty,
    companyId: q.company_id,
    page: q.page,
    pageSize: q.page_size,
  });
  res.json({ questions: rows, page: q.page, page_size: q.page_size });
});

export const getQuestionHandler = asyncHandler(async (req: Request, res: Response) => {
  const isAdmin = req.user?.role === 'admin';
  const question = await repo.getQuestionWithDetails(getParam(req, 'questionId'), isAdmin);
  if (!question) throw ApiError.notFound('Question not found');
  res.json({ question });
});

export const createQuestionHandler = asyncHandler(async (req: Request, res: Response) => {
  const body = req.body;
  const id = body.type === 'aptitude' ? await repo.createAptitudeQuestion(body) : await repo.createCodingQuestion(body);
  res.status(201).json({ id });
});

export const deactivateQuestionHandler = asyncHandler(async (req: Request, res: Response) => {
  await repo.deactivateQuestion(getParam(req, 'questionId'));
  res.status(204).send();
});

export const listTopicsHandler = asyncHandler(async (_req: Request, res: Response) => {
  const topics = await repo.listTopics();
  res.json({ topics });
});
