import { Router } from 'express';
import { requireAuth, requireSelfOrAdmin } from '../../middlewares/auth';
import { validate } from '../../middlewares/validate';
import { userIdParamSchema } from './analytics.schema';
import * as ctrl from './analytics.controller';

const router = Router();
router.get('/:userId/dashboard', requireAuth, validate({ params: userIdParamSchema }), requireSelfOrAdmin(), ctrl.dashboardHandler);
export default router;
