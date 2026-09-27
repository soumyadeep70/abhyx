import { Router } from 'express';
import { requireAuth, requireSelfOrAdmin } from '../../middlewares/auth';
import { validate } from '../../middlewares/validate';
import { updateTargetCompaniesSchema, userIdParamSchema } from './users.schema';
import * as ctrl from './users.controller';

const router = Router();

router.get('/:userId', requireAuth, validate({ params: userIdParamSchema }), requireSelfOrAdmin(), ctrl.getProfileHandler);
router.get('/:userId/target-companies', requireAuth, validate({ params: userIdParamSchema }), requireSelfOrAdmin(), ctrl.getTargetCompaniesHandler);
router.put(
  '/:userId/target-companies',
  requireAuth,
  validate({ params: userIdParamSchema, body: updateTargetCompaniesSchema }),
  requireSelfOrAdmin(),
  ctrl.updateTargetCompaniesHandler
);
router.get('/:userId/activity', requireAuth, validate({ params: userIdParamSchema }), requireSelfOrAdmin(), ctrl.getActivityHandler);

export default router;
