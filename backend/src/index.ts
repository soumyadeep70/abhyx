import { createApp } from './app';
import { env } from './config/env';
import { logger } from './utils/logger';
import { pool } from './db/pool';
import { startCronJobs } from './services/cron';

async function main() {
  // Fail fast if the DB is unreachable rather than accepting traffic first.
  await pool.query('SELECT 1');
  logger.info('Database connection verified');

  const app = createApp();
  const server = app.listen(env.PORT, () => {
    logger.info({ port: env.PORT, env: env.NODE_ENV }, 'AI Placement Platform backend listening');
  });

  startCronJobs();

  const shutdown = async (signal: string) => {
    logger.info({ signal }, 'Shutting down gracefully');
    server.close(async () => {
      await pool.end();
      process.exit(0);
    });
    // Force-exit if graceful shutdown hangs.
    setTimeout(() => process.exit(1), 10_000).unref();
  };

  process.on('SIGTERM', () => shutdown('SIGTERM'));
  process.on('SIGINT', () => shutdown('SIGINT'));
  process.on('unhandledRejection', (reason) => {
    logger.error({ reason }, 'Unhandled promise rejection');
  });
}

main().catch((err) => {
  logger.error({ err }, 'Fatal error during startup');
  process.exit(1);
});
