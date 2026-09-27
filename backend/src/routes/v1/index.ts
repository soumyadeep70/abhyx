import { Router } from 'express';
import authRoutes from '../../modules/auth/auth.routes';
import userRoutes from '../../modules/users/users.routes';
import companyRoutes from '../../modules/companies/companies.routes';
import questionRoutes from '../../modules/questions/questions.routes';
import assessmentRoutes from '../../modules/assessment/assessment.routes';
import codingRoutes from '../../modules/coding/coding.routes';
import mockTestRoutes from '../../modules/mockTests/mockTests.routes';
import interviewRoutes from '../../modules/interview/interview.routes';
import resumeRoutes from '../../modules/resume/resume.routes';
import roadmapRoutes from '../../modules/roadmap/roadmap.routes';
import readinessRoutes from '../../modules/readiness/readiness.routes';
import analyticsRoutes from '../../modules/analytics/analytics.routes';
import leaderboardRoutes from '../../modules/leaderboard/leaderboard.routes';
import gamificationRoutes from '../../modules/gamification/gamification.routes';

const router = Router();

router.use('/auth', authRoutes);
router.use('/users', userRoutes);
router.use('/users', gamificationRoutes); // GET /users/:userId/badges
router.use('/companies', companyRoutes);
router.use('/questions', questionRoutes);
router.use('/assessment', assessmentRoutes);
router.use('/coding', codingRoutes);
router.use('/mock-tests', mockTestRoutes);
router.use('/interview', interviewRoutes);
router.use('/resume', resumeRoutes);
router.use('/roadmap', roadmapRoutes);
router.use('/readiness', readinessRoutes);
router.use('/analytics', analyticsRoutes);
router.use('/leaderboard', leaderboardRoutes);

export default router;
