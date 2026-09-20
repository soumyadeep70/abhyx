import { Router } from 'express';
import { asyncHandler } from '../../utils/asyncHandler';
import { requireAuth, requireSelfOrAdmin } from '../../middlewares/auth';
import { listBadgesForUser } from './badges.service';

const router = Router();

router.get(
  '/:userId/badges',
  requireAuth,
  requireSelfOrAdmin(),
  asyncHandler(async (req, res) => {
    const badges = await listBadgesForUser(req.params.userId);
    res.json({ badges });
  })
);

export default router;
