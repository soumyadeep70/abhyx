/**
 * Minimal, dependency-free SQL migration runner.
 *
 * Why not an ORM/migration framework: the schema in this project is defined
 * precisely (composite PKs, cross-table CHECK-equivalent triggers, partial
 * unique indexes, ENUMs) down to exact invariants from the source schema
 * doc. Hand-written, numbered .sql files give full, auditable control over
 * DDL; this runner just tracks which files have been applied, in a
 * transaction each, in filename order.
 *
 * Usage:
 *   npm run migrate           -> applies all pending migrations
 *   npm run migrate:status    -> lists applied / pending migrations
 *   npm run seed              -> applies db/seeds/*.sql (idempotent content, not schema)
 */
import fs from 'fs';
import path from 'path';
import { pool, withTransaction } from './pool';
import { logger } from '../utils/logger';

const MIGRATIONS_DIR = path.join(__dirname, 'migrations');
const SEEDS_DIR = path.join(__dirname, 'seeds');

async function ensureMigrationsTable() {
  await pool.query(`
    CREATE TABLE IF NOT EXISTS schema_migrations (
      filename    TEXT PRIMARY KEY,
      applied_at  TIMESTAMPTZ NOT NULL DEFAULT now()
    );
  `);
}

function listSqlFiles(dir: string): string[] {
  if (!fs.existsSync(dir)) return [];
  return fs
    .readdirSync(dir)
    .filter((f) => f.endsWith('.sql'))
    .sort();
}

async function up() {
  await ensureMigrationsTable();
  const files = listSqlFiles(MIGRATIONS_DIR);
  const { rows } = await pool.query<{ filename: string }>('SELECT filename FROM schema_migrations');
  const applied = new Set(rows.map((r) => r.filename));

  for (const file of files) {
    if (applied.has(file)) continue;
    const sql = fs.readFileSync(path.join(MIGRATIONS_DIR, file), 'utf8');
    logger.info({ file }, 'Applying migration');
    await withTransaction(async (client) => {
      await client.query(sql);
      await client.query('INSERT INTO schema_migrations (filename) VALUES ($1)', [file]);
    });
    logger.info({ file }, 'Applied migration');
  }
  logger.info('All migrations applied');
}

async function status() {
  await ensureMigrationsTable();
  const files = listSqlFiles(MIGRATIONS_DIR);
  const { rows } = await pool.query<{ filename: string }>('SELECT filename FROM schema_migrations');
  const applied = new Set(rows.map((r) => r.filename));
  for (const file of files) {
    console.log(`${applied.has(file) ? '[x]' : '[ ]'} ${file}`);
  }
}

async function seed() {
  const files = listSqlFiles(SEEDS_DIR);
  for (const file of files) {
    const sql = fs.readFileSync(path.join(SEEDS_DIR, file), 'utf8');
    logger.info({ file }, 'Running seed file');
    await pool.query(sql);
  }
  logger.info('Seeding complete');
}

async function main() {
  const cmd = process.argv[2] ?? 'up';
  try {
    if (cmd === 'up') await up();
    else if (cmd === 'status') await status();
    else if (cmd === 'seed') await seed();
    else {
      console.error(`Unknown command: ${cmd}. Use up | status | seed`);
      process.exit(1);
    }
  } catch (err) {
    logger.error({ err }, 'Migration command failed');
    process.exitCode = 1;
  } finally {
    await pool.end();
  }
}

main();
