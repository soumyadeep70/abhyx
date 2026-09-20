import { Router } from 'express';
import multer from 'multer';
import { requireAuth, requireSelfOrAdmin } from '../../middlewares/auth';
import { validate } from '../../middlewares/validate';
import { userIdParamSchema } from './resume.schema';
import { env } from '../../config/env';
import { ApiError } from '../../utils/ApiError';
import * as ctrl from './resume.controller';

const upload = multer({
  storage: multer.memoryStorage(),
  limits: { fileSize: env.MAX_RESUME_UPLOAD_MB * 1024 * 1024 },
  fileFilter: (_req, file, cb) => {
    if (file.mimetype !== 'application/pdf') {
      return cb(new ApiError(415, 'Only PDF files are accepted'));
    }
    cb(null, true);
  },
});

const router = Router();

router.post('/upload', requireAuth, upload.single('resume'), ctrl.uploadHandler);
router.get(
  '/user/:userId',
  requireAuth,
  validate({ params: userIdParamSchema }),
  requireSelfOrAdmin(),
  ctrl.listHandler
);

export default router;
