import { query } from '../../db/pool';

export async function listCompaniesWithTiers() {
  const { rows } = await query(`
    SELECT
      c.id AS company_id, c.name AS company_name, c.logo_url,
      ct.id AS tier_id, ct.tier_name,
      ct.aptitude_weight, ct.coding_weight, ct.resume_weight, ct.interview_weight, ct.consistency_weight
    FROM companies c
    JOIN company_tiers ct ON ct.company_id = c.id AND ct.is_active
    WHERE c.is_active
    ORDER BY c.name, ct.tier_name
  `);
  return rows;
}

export async function getTierById(tierId: string) {
  const { rows } = await query(
    `SELECT ct.*, c.name AS company_name FROM company_tiers ct
     JOIN companies c ON c.id = ct.company_id
     WHERE ct.id = $1`,
    [tierId]
  );
  return rows[0] ?? null;
}
