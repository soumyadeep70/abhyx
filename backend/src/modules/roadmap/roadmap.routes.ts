import { Router } from 'express';
import { requireAuth, requireSelfOrAdmin } from '../../middlewares/auth';
import { validate } from '../../middlewares/validate';
import { generateRoadmapSchema, userIdParamSchema, phaseParamSchema } from './roadmap.schema';
import * as ctrl from './roadmap.controller';

const router = Router();

router.post('/generate', requireAuth, validate({ body: generateRoadmapSchema }), ctrl.generateHandler);
router.get(
  '/:userId/active',
  requireAuth,
  validate({ params: userIdParamSchema }),
  requireSelfOrAdmin(),
  ctrl.getActiveHandler
);
router.patch(
  '/:userId/phase/:id',
  requireAuth,
  validate({ params: phaseParamSchema }),
  requireSelfOrAdmin(),
  ctrl.completePhaseHandler
);

export default router;
