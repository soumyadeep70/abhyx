import 'dotenv/config';
import { z } from 'zod';

const boolFromString = z
  .string()
  .optional()
  .transform((v) => v === 'true' || v === '1');

const EnvSchema = z.object({
  NODE_ENV: z.enum(['development', 'test', 'production']).default('development'),
  PORT: z.coerce.number().default(8080),
  API_BASE_PATH: z.string().default('/api/v1'),
  CORS_ORIGINS: z.string().default('*'),

  DATABASE_URL: z.string().min(1, 'DATABASE_URL is required'),
  DATABASE_SSL: boolFromString,
  DB_POOL_MAX: z.coerce.number().default(10),

  // ---- Auth (better-auth) ----
  // BETTER_AUTH_SECRET signs/encrypts better-auth's session cookies and CSRF
  // tokens. BETTER_AUTH_URL is the base URL better-auth issues links/cookies
  // against (must match how the API is actually reached by clients).
  BETTER_AUTH_SECRET: z.string().min(32, 'BETTER_AUTH_SECRET must be at least 32 chars'),
  BETTER_AUTH_URL: z.string().default('http://localhost:8080'),
  // Sessions are opaque bearer tokens stored in the `session` table (see
  // migration 009). SESSION_EXPIRES_IN_DAYS is the hard TTL; a session is
  // silently extended by SESSION_UPDATE_AGE_HOURS on use, so an active user
  // never gets logged out mid-flow while an idle one still expires.
  SESSION_EXPIRES_IN_DAYS: z.coerce.number().default(30),
  SESSION_UPDATE_AGE_HOURS: z.coerce.number().default(24),
  BCRYPT_SALT_ROUNDS: z.coerce.number().default(11),

  AI_SERVICE_BASE_URL: z.string().default('http://localhost:9000'),
  AI_SERVICE_TIMEOUT_MS: z.coerce.number().default(20000),
  AI_SERVICE_API_KEY: z.string().default(''),

  JUDGE0_BASE_URL: z.string().default('https://judge0-ce.p.rapidapi.com'),
  JUDGE0_API_KEY: z.string().default(''),
  JUDGE0_API_HOST: z.string().default(''),
  JUDGE0_POLL_INTERVAL_MS: z.coerce.number().default(1000),
  JUDGE0_POLL_MAX_ATTEMPTS: z.coerce.number().default(15),

  READINESS_CACHE_TTL_MINUTES: z.coerce.number().default(60),
  WEAK_TOPIC_CACHE_TTL_HOURS: z.coerce.number().default(24),
  ROADMAP_CACHE_TTL_HOURS: z.coerce.number().default(24),
  COMPANY_INTEL_CACHE_TTL_HOURS: z.coerce.number().default(24),
  NIGHTLY_JOB_CRON: z.string().default('0 2 * * *'),
  ENABLE_CRON: boolFromString,

  MAX_RESUME_UPLOAD_MB: z.coerce.number().default(5),
});

const parsed = EnvSchema.safeParse(process.env);
if (!parsed.success) {
  // eslint-disable-next-line no-console
  console.error('Invalid environment configuration:', parsed.error.flatten().fieldErrors);
  process.exit(1);
}

export const env = parsed.data;
export const corsOrigins = env.CORS_ORIGINS.split(',').map((s) => s.trim());
