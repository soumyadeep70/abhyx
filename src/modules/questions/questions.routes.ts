import { Router } from 'express';
import { requireAuth, requireRole } from '../../middlewares/auth';
import { validate } from '../../middlewares/validate';
import {
  listQuestionsQuerySchema,
  questionIdParamSchema,
  createQuestionSchema,
} from './questions.schema';
import * as ctrl from './questions.controller';

const router = Router();

router.get('/topics', requireAuth, ctrl.listTopicsHandler);
router.get('/', requireAuth, validate({ query: listQuestionsQuerySchema }), ctrl.listQuestionsHandler);
router.get('/:questionId', requireAuth, validate({ params: questionIdParamSchema }), ctrl.getQuestionHandler);

// Admin content management (Module 3/2's "problem bank management")
router.post('/', requireAuth, requireRole('admin'), validate({ body: createQuestionSchema }), ctrl.createQuestionHandler);
router.delete('/:questionId', requireAuth, requireRole('admin'), validate({ params: questionIdParamSchema }), ctrl.deactivateQuestionHandler);

export default router;
