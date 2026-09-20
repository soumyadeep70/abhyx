import { Router } from 'express';
import { requireAuth } from '../../middlewares/auth';
import * as ctrl from './companies.controller';

const router = Router();
router.get('/', requireAuth, ctrl.listCompaniesHandler);
router.get('/tiers/:tierId', requireAuth, ctrl.getTierHandler);

export default router;
