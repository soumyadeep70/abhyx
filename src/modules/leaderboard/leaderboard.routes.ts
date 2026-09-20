import { Router } from 'express';
import { requireAuth, requireRole } from '../../middlewares/auth';
import { validate } from '../../middlewares/validate';
import { leaderboardQuerySchema } from './leaderboard.schema';
import * as ctrl from './leaderboard.controller';

const router = Router();
router.get('/', requireAuth, validate({ query: leaderboardQuerySchema }), ctrl.getHandler);
router.post('/refresh', requireAuth, requireRole('admin'), ctrl.refreshHandler);
export default router;
