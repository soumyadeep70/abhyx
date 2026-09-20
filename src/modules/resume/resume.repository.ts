import { query } from '../../db/pool';

export async function insertProcessingResume(userId: string, fileUrl: string): Promise<string> {
  const { rows } = await query(
    `INSERT INTO resumes (user_id, file_url, status) VALUES ($1,$2,'processing') RETURNING id`,
    [userId, fileUrl]
  );
  return rows[0].id;
}

export async function markAnalyzed(params: {
  resumeId: string;
  atsScore: number;
  extractedSkills: string[];
  keywordGaps: string[];
  aiSummary: string;
}) {
  await query(
    `UPDATE resumes SET status = 'analyzed', ats_score = $2, extracted_skills = $3, keyword_gaps = $4, ai_summary = $5, is_current = TRUE
     WHERE id = $1`,
    [params.resumeId, params.atsScore, params.extractedSkills, params.keywordGaps, params.aiSummary]
  );
}

export async function markFailed(resumeId: string) {
  await query(`UPDATE resumes SET status = 'failed' WHERE id = $1`, [resumeId]);
}

export async function listForUser(userId: string) {
  const { rows } = await query(
    `SELECT id, status, ats_score, extracted_skills, keyword_gaps, ai_summary, is_current, uploaded_at
     FROM resumes WHERE user_id = $1 ORDER BY uploaded_at DESC`,
    [userId]
  );
  return rows;
}

export async function getCurrent(userId: string) {
  const { rows } = await query(`SELECT * FROM resumes WHERE user_id = $1 AND is_current LIMIT 1`, [userId]);
  return rows[0] ?? null;
}
