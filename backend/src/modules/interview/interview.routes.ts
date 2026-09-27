import { Router } from 'express';
import { requireAuth, requireSelfOrAdmin } from '../../middlewares/auth';
import { validate } from '../../middlewares/validate';
import { startSessionSchema, respondSchema, sessionIdParamSchema } from './interview.schema';
import { userIdParamSchema } from '../users/users.schema';
import * as ctrl from './interview.controller';

const router = Router();

router.post('/session/start', requireAuth, validate({ body: startSessionSchema }), ctrl.startHandler);
router.post(
  '/session/:sessionId/respond',
  requireAuth,
  validate({ params: sessionIdParamSchema, body: respondSchema }),
  ctrl.respondHandler
);
router.get('/session/:sessionId/scorecard', requireAuth, validate({ params: sessionIdParamSchema }), ctrl.scorecardHandler);
router.post('/session/:sessionId/complete', requireAuth, validate({ params: sessionIdParamSchema }), ctrl.completeHandler);
router.get(
  '/sessions/user/:userId',
  requireAuth,
  validate({ params: userIdParamSchema }),
  requireSelfOrAdmin(),
  ctrl.listHandler
);

export default router;
