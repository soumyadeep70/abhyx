import { Router } from 'express';
import { requireAuth, requireSelfOrAdmin } from '../../middlewares/auth';
import { validate } from '../../middlewares/validate';
import { submitAssessmentSchema, nextQuestionQuerySchema, userIdParamSchema } from './assessment.schema';
import * as ctrl from './assessment.controller';

const router = Router();

router.post('/submit', requireAuth, validate({ body: submitAssessmentSchema }), ctrl.submitHandler);
router.get('/next', requireAuth, validate({ query: nextQuestionQuerySchema }), ctrl.nextQuestionHandler);
router.get(
  '/analytics/:userId',
  requireAuth,
  validate({ params: userIdParamSchema }),
  requireSelfOrAdmin(),
  ctrl.analyticsHandler
);

export default router;
