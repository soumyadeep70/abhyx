/**
 * The shape every route/controller reads off `req.user`. Field names
 * (`sub`, `role`, `email`) are kept identical to the old JWT payload on
 * purpose: every module that does `req.user!.sub` or `req.user?.role`
 * (resume, assessment, coding, interview, mockTests, roadmap, questions,
 * ...) needed zero changes when auth moved from hand-signed JWTs to
 * better-auth sessions -- only `middlewares/auth.ts` had to change how this
 * object gets populated.
 */
export interface AuthenticatedUser {
  sub: string;
  role: 'student' | 'admin';
  email: string;
  fullName: string;
}

declare global {
  namespace Express {
    interface Request {
      user?: AuthenticatedUser;
      /** Raw better-auth session id, set alongside `user` by requireAuth. Handy for logging/audit. */
      sessionId?: string;
    }
  }
}

export {};
