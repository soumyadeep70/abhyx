import express, { Express } from 'express';
import helmet from 'helmet';
import cors from 'cors';
import compression from 'compression';
import pinoHttp from 'pino-http';
import path from 'path';
import { toNodeHandler } from 'better-auth/node';
import { auth } from './lib/auth';
import { env, corsOrigins } from './config/env';
import { logger } from './utils/logger';
import { globalRateLimiter, authRateLimiter } from './middlewares/rateLimiter';
import { notFoundHandler, errorHandler } from './middlewares/errorHandler';
import v1Router from './routes/v1';

export function createApp(): Express {
  const app = express();

  app.set('trust proxy', 1);
  app.use(helmet());
  app.use(
    cors({
      origin: corsOrigins.includes('*') ? true : corsOrigins,
      credentials: true,
    })
  );
  app.use(compression());

  // better-auth's handler parses the request body itself and must see the
  // raw (unparsed) request, so it's mounted BEFORE express.json(). This app
  // primarily talks to better-auth programmatically via `auth.api.*` from
  // the /api/v1/auth/* routes below (so onboarding stays transactional and
  // the response shape stays stable) -- this mount exists so the rest of
  // better-auth's surface (e.g. its own CSRF/session-cookie machinery, and
  // any auth endpoint this backend doesn't explicitly wrap) is still
  // reachable directly at /api/auth/* if a client needs it.
  app.use('/api/auth', authRateLimiter);
  app.all('/api/auth/*splat', toNodeHandler(auth));

  app.use(express.json({ limit: '2mb' }));
  app.use(express.urlencoded({ extended: true }));
  app.use(pinoHttp({ logger, autoLogging: { ignore: (req) => req.url === '/health' } }));
  app.use(globalRateLimiter);

  // Locally stored resume PDFs (see services/fileStorage.ts) served statically for admin/debug access.
  app.use('/uploads', express.static(path.join(process.cwd(), 'uploads')));

  app.get('/health', (_req, res) => res.json({ status: 'ok', env: env.NODE_ENV, timestamp: new Date().toISOString() }));

  app.use(env.API_BASE_PATH, v1Router);

  app.use(notFoundHandler);
  app.use(errorHandler);

  return app;
}
