import { Router } from 'express';
import { requireAuth, requireSelfOrAdmin } from '../../middlewares/auth';
import { validate } from '../../middlewares/validate';
import { submitCodeSchema, submissionIdParamSchema, userIdParamSchema, questionIdParamSchema } from './coding.schema';
import * as ctrl from './coding.controller';

const router = Router();

router.get('/problem/:questionId', requireAuth, validate({ params: questionIdParamSchema }), ctrl.getProblemHandler);
router.post('/submit', requireAuth, validate({ body: submitCodeSchema }), ctrl.submitCodeHandler);
router.get('/submissions/:submissionId', requireAuth, validate({ params: submissionIdParamSchema }), ctrl.getSubmissionHandler);
router.get(
  '/submissions/user/:userId',
  requireAuth,
  validate({ params: userIdParamSchema }),
  requireSelfOrAdmin(),
  ctrl.listSubmissionsHandler
);

export default router;
