import pdfParse from 'pdf-parse';
import { ApiError } from '../../utils/ApiError';
import { logger } from '../../utils/logger';
import { saveResumeFile } from '../../services/fileStorage';
import * as aiClient from '../../services/aiServiceClient';
import * as repo from './resume.repository';
import { checkResumeBadges } from '../gamification/badges.service';
import { maybeRecomputeReadiness } from '../readiness/readiness.service';
import { getTierWeights } from '../readiness/readiness.repository';
import { generateRoadmapForUser } from '../roadmap/roadmap.service';

export async function uploadAndAnalyzeResume(params: {
  userId: string;
  fileBuffer: Buffer;
  originalName: string;
  targetCompanyTierId?: string;
}) {
  if (params.fileBuffer.length === 0) throw ApiError.badRequest('Uploaded file is empty');

  const fileUrl = saveResumeFile(params.fileBuffer, params.originalName);
  const resumeId = await repo.insertProcessingResume(params.userId, fileUrl);

  let extractedText: string;
  try {
    const parsed = await pdfParse(params.fileBuffer);
    extractedText = parsed.text?.trim() ?? '';
    if (!extractedText) throw new Error('No extractable text found in PDF');
  } catch (err) {
    logger.warn({ err, resumeId }, 'Resume text extraction failed');
    await repo.markFailed(resumeId);
    throw ApiError.badRequest('Could not extract text from this PDF. Please upload a text-based (not scanned/image) PDF.');
  }

  let targetCompanyName: string | undefined;
  if (params.targetCompanyTierId) {
    const tier = await getTierWeights(params.targetCompanyTierId);
    targetCompanyName = tier?.company_name;
  }

  try {
    const analysis = await aiClient.analyzeResume({ resume_text: extractedText, target_company: targetCompanyName });
    await repo.markAnalyzed({
      resumeId,
      atsScore: analysis.ats_score,
      extractedSkills: analysis.skills_present,
      keywordGaps: [...analysis.skills_missing, ...analysis.keyword_gaps],
      aiSummary: analysis.summary,
    });

    checkResumeBadges(params.userId, analysis.ats_score).catch((err) => logger.warn({ err }, 'resume badge check failed'));
    maybeRecomputeReadiness(params.userId, 'resume_uploaded').catch((err) =>
      logger.warn({ err }, 'readiness recompute after resume failed')
    );

    // "Automatic roadmap generation triggered after every resume analysis" (HLD Module 4).
    // Non-blocking: a slow/failed AI roadmap call must not fail the resume upload response.
    if (params.targetCompanyTierId) {
      generateRoadmapForUser(params.userId, params.targetCompanyTierId, analysis.keyword_gaps).catch((err) =>
        logger.warn({ err }, 'automatic roadmap generation after resume upload failed')
      );
    }

    return {
      resume_id: resumeId,
      status: 'analyzed',
      ats_score: analysis.ats_score,
      skills_present: analysis.skills_present,
      skills_missing: analysis.skills_missing,
      keyword_gaps: analysis.keyword_gaps,
      summary: analysis.summary,
    };
  } catch (err) {
    logger.error({ err, resumeId }, 'Resume AI analysis failed');
    await repo.markFailed(resumeId);
    throw ApiError.badGateway('Resume analysis service is currently unavailable. Please try again shortly.');
  }
}

export async function listResumeHistory(userId: string) {
  return repo.listForUser(userId);
}
