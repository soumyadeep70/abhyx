import { PoolClient } from 'pg';
import { withTransaction } from '../../db/pool';

/**
 * Everything the HLD's onboarding flow needs *beyond* the user row itself:
 * a student_streaks row and the chosen target companies with a zeroed
 * readiness_scores row per target, so /readiness/:userId returns something
 * sane before the student has attempted anything.
 *
 * User creation itself is now better-auth's job (auth.api.signUpEmail, see
 * auth.service.ts) -- this function is called *after* that succeeds, with
 * the new user's id, inside its own transaction. It's intentionally
 * separate from better-auth's internal user/account inserts, which run in
 * their own transaction we don't control; see CHANGES_AND_ASSUMPTIONS.md
 * for the tradeoff (a user can in theory exist without onboarding rows if
 * this step fails -- registerHandler treats that as a 500 and logs loudly,
 * since it should only ever happen on a DB outage between the two calls).
 */
export async function attachOnboarding(params: {
  userId: string;
  targetCompanyTierIds: string[];
}): Promise<void> {
  await withTransaction(async (client: PoolClient) => {
    await client.query(
      `INSERT INTO student_streaks (user_id, current_streak, longest_streak)
       VALUES ($1, 0, 0)
       ON CONFLICT (user_id) DO NOTHING`,
      [params.userId]
    );

    for (let i = 0; i < params.targetCompanyTierIds.length; i++) {
      const tierId = params.targetCompanyTierIds[i];
      await client.query(
        `INSERT INTO user_target_companies (user_id, company_tier_id, priority)
         VALUES ($1, $2, $3)
         ON CONFLICT (user_id, company_tier_id) DO NOTHING`,
        [params.userId, tierId, i + 1]
      );
      await client.query(
        `INSERT INTO readiness_scores (user_id, company_tier_id, score, probability)
         VALUES ($1, $2, 0, 0)
         ON CONFLICT (user_id, company_tier_id) DO NOTHING`,
        [params.userId, tierId]
      );
    }
  });
}
