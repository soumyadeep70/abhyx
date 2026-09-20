import { Router } from 'express';
import { requireAuth, requireSelfOrAdmin } from '../../middlewares/auth';
import { validate } from '../../middlewares/validate';
import { createMockTestSchema, mockTestIdParamSchema, userIdParamSchema } from './mockTests.schema';
import * as ctrl from './mockTests.controller';

const router = Router();

router.post('/', requireAuth, validate({ body: createMockTestSchema }), ctrl.startHandler);
router.get('/:mockTestId', requireAuth, validate({ params: mockTestIdParamSchema }), ctrl.getHandler);
router.post('/:mockTestId/complete', requireAuth, validate({ params: mockTestIdParamSchema }), ctrl.completeHandler);
router.post('/:mockTestId/abandon', requireAuth, validate({ params: mockTestIdParamSchema }), ctrl.abandonHandler);
router.get(
  '/user/:userId',
  requireAuth,
  validate({ params: userIdParamSchema }),
  requireSelfOrAdmin(),
  ctrl.listHandler
);

export default router;
