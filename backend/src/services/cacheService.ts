import { query } from '../db/pool';

/**
 * Thin wrapper over the `ai_cache` table (see migration 007). Centralizes
 * cache-key construction so each module doesn't invent its own convention.
 */
export type CacheType =
  | 'readiness_insight'
  | 'weak_topic'
  | 'resume_analysis'
  | 'roadmap'
  | 'company_intel';

export function buildCacheKey(type: CacheType, ...parts: string[]): string {
  return [type, ...parts].join(':');
}

export async function getCache<T = unknown>(cacheKey: string): Promise<T | null> {
  const { rows } = await query<{ payload: T }>(
    `SELECT payload FROM ai_cache WHERE cache_key = $1 AND expires_at > now()`,
    [cacheKey]
  );
  return rows[0]?.payload ?? null;
}

export async function setCache(
  cacheKey: string,
  cacheType: CacheType,
  payload: unknown,
  ttlMs: number,
  userId?: string
): Promise<void> {
  await query(
    `INSERT INTO ai_cache (cache_key, cache_type, user_id, payload, expires_at)
     VALUES ($1, $2, $3, $4::jsonb, now() + ($5 || ' milliseconds')::interval)
     ON CONFLICT (cache_key) DO UPDATE
       SET payload = EXCLUDED.payload, expires_at = EXCLUDED.expires_at, created_at = now()`,
    [cacheKey, cacheType, userId ?? null, JSON.stringify(payload), ttlMs]
  );
}

export async function invalidateCache(cacheKey: string): Promise<void> {
  await query(`DELETE FROM ai_cache WHERE cache_key = $1`, [cacheKey]);
}
