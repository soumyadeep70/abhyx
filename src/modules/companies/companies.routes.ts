import { Router } from 'express';
import { requireAuth } from '../../middlewares/auth';
import { validate } from '../../middlewares/validate';
import { tierIdParamSchema } from './companies.schema';
import * as ctrl from './companies.controller';

const router = Router();
router.get('/', requireAuth, ctrl.listCompaniesHandler);
router.get('/tiers/:tierId', requireAuth, validate({ params: tierIdParamSchema }), ctrl.getTierHandler);

export default router;
