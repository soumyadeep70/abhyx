/**
 * Creates (or promotes) an admin account.
 *
 * Public registration (`POST /api/v1/auth/register`) always creates a
 * 'student' -- `role` is explicitly `input: false` in src/lib/auth.ts so a
 * client can never set it. This script is the deliberate side door:
 *
 *   npm run create-admin -- admin@example.com "S0me!StrongPass" "Admin User"
 *
 * Safe to re-run: if the email already exists, it just flips that user's
 * role to 'admin' instead of erroring.
 */
import { auth } from '../lib/auth';
import { pool } from './pool';
import { logger } from '../utils/logger';

async function main() {
  const [email, password, name = 'Admin'] = process.argv.slice(2);
  if (!email || !password) {
    // eslint-disable-next-line no-console
    console.error('Usage: npm run create-admin -- <email> <password> [full name]');
    process.exit(1);
  }

  const { rows: existing } = await pool.query<{ id: string }>(`SELECT id FROM users WHERE email = $1`, [email]);

  let userId: string;
  if (existing[0]) {
    userId = existing[0].id;
    logger.info({ email }, 'User already exists, promoting to admin');
  } else {
    const result = await auth.api.signUpEmail({
      body: { email, password, name },
    });
    userId = (result.user as any).id;
    logger.info({ email }, 'Created new user');
  }

  await pool.query(`UPDATE users SET role = 'admin' WHERE id = $1`, [userId]);
  logger.info({ email, userId }, 'Account is now an admin');
  await pool.end();
}

main().catch((err) => {
  logger.error({ err }, 'create-admin failed');
  process.exit(1);
});
