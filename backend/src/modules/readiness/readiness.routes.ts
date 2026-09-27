import { Router } from 'express';
import { requireAuth, requireSelfOrAdmin } from '../../middlewares/auth';
import { validate } from '../../middlewares/validate';
import { userIdParamSchema, tierIdParamSchema } from './readiness.schema';
import * as ctrl from './readiness.controller';

const router = Router();

router.get('/:userId', requireAuth, validate({ params: userIdParamSchema }), requireSelfOrAdmin(), ctrl.getProfileHandler);
router.post('/:userId/recompute', requireAuth, validate({ params: userIdParamSchema }), requireSelfOrAdmin(), ctrl.recomputeHandler);
router.get(
  '/:userId/tiers/:tierId/history',
  requireAuth,
  validate({ params: tierIdParamSchema }),
  requireSelfOrAdmin(),
  ctrl.getHistoryHandler
);
router.get(
  '/:userId/tiers/:tierId/insights',
  requireAuth,
  validate({ params: tierIdParamSchema }),
  requireSelfOrAdmin(),
  ctrl.getInsightsHandler
);

export default router;
