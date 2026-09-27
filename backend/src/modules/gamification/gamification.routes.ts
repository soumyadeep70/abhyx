import { Router } from 'express';
import { asyncHandler } from '../../utils/asyncHandler';
import { getParam } from '../../utils/params';
import { requireAuth, requireSelfOrAdmin } from '../../middlewares/auth';
import { validate } from '../../middlewares/validate';
import { userIdParamSchema } from '../users/users.schema';
import { listBadgesForUser } from './badges.service';

const router = Router();

router.get(
  '/:userId/badges',
  requireAuth,
  validate({ params: userIdParamSchema }),
  requireSelfOrAdmin(),
  asyncHandler(async (req, res) => {
    const badges = await listBadgesForUser(getParam(req, 'userId'));
    res.json({ badges });
  })
);

export default router;
