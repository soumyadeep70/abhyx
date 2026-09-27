import { Router } from 'express';
import { validate } from '../../middlewares/validate';
import { requireAuth } from '../../middlewares/auth';
import { authRateLimiter } from '../../middlewares/rateLimiter';
import { registerSchema, loginSchema } from './auth.schema';
import * as ctrl from './auth.controller';

const router = Router();

router.post('/register', authRateLimiter, validate({ body: registerSchema }), ctrl.registerHandler);
router.post('/login', authRateLimiter, validate({ body: loginSchema }), ctrl.loginHandler);
router.post('/refresh', authRateLimiter, ctrl.refreshHandler);
router.post('/logout', ctrl.logoutHandler);
router.get('/me', requireAuth, ctrl.meHandler);

export default router;
