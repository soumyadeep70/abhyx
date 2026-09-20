#!/usr/bin/env node
'use strict';

/**
 * Mock AI microservice.
 *
 * Implements every endpoint `src/services/aiServiceClient.ts` calls, with
 * the exact response shapes those TypeScript interfaces expect, so the
 * whole backend can be run and tested end-to-end without the real FastAPI
 * AI service. Deliberately zero npm dependencies (just Node's built-in
 * `http`) so it needs nothing beyond `node` to run -- no `npm install`,
 * no network access, no version drift from the backend's own deps.
 *
 * Endpoints (all POST, JSON in, JSON out):
 *   /resume/analyze
 *   /interview/score
 *   /roadmap/generate
 *   /analytics/weak-topics
 *   /readiness/insights
 *   /company/intelligence
 * Plus: GET /health
 *
 * Responses are deterministic functions of the request body wherever that's
 * meaningful (e.g. `ats_score` reacts to resume length/keywords, weak-topic
 * analysis echoes back the topics it was given as "weak" below a threshold)
 * so tests asserting on specific fields aren't testing randomness.
 *
 * Configurable via env vars, useful for exercising the backend's failure
 * paths (aiServiceClient wraps any non-2xx / timeout as ApiError.badGateway):
 *   PORT                    default 9000
 *   MOCK_AI_API_KEY         if set, requests must send X-Internal-Api-Key
 *                           matching it, or get a 401
 *   MOCK_AI_LATENCY_MS      artificial delay before responding (default 0)
 *   MOCK_AI_FAILURE_RATE    0..1, chance of a random request getting a 500
 *                           (default 0)
 */

const http = require('http');

function readJsonBody(req) {
  return new Promise((resolve, reject) => {
    let raw = '';
    req.on('data', (chunk) => {
      raw += chunk;
      if (raw.length > 5 * 1024 * 1024) {
        reject(Object.assign(new Error('Payload too large'), { statusCode: 413 }));
        req.destroy();
      }
    });
    req.on('end', () => {
      if (!raw) return resolve({});
      try {
        resolve(JSON.parse(raw));
      } catch (err) {
        reject(Object.assign(new Error('Invalid JSON body'), { statusCode: 400 }));
      }
    });
    req.on('error', reject);
  });
}

function sendJson(res, statusCode, payload) {
  const body = JSON.stringify(payload);
  res.writeHead(statusCode, {
    'Content-Type': 'application/json',
    'Content-Length': Buffer.byteLength(body),
  });
  res.end(body);
}

function clamp(n, min, max) {
  return Math.max(min, Math.min(max, n));
}

// ---- Handlers, one per aiServiceClient.ts method -------------------------

function handleResumeAnalyze(body) {
  const text = String(body.resume_text || '');
  const words = text.toLowerCase().split(/\W+/).filter(Boolean);
  const wordSet = new Set(words);

  // A small, illustrative skills taxonomy -- enough to make ats_score and
  // skills_present/missing react visibly to different resumes in tests.
  const knownSkills = [
    'javascript', 'typescript', 'python', 'java', 'react', 'node',
    'express', 'sql', 'postgresql', 'docker', 'kubernetes', 'aws',
    'git', 'rest', 'graphql', 'testing', 'ci', 'cd',
  ];
  const present = knownSkills.filter((s) => wordSet.has(s));
  const missing = knownSkills.filter((s) => !wordSet.has(s)).slice(0, 6);

  const lengthScore = clamp(Math.round((text.length / 2000) * 40), 0, 40);
  const skillScore = clamp(Math.round((present.length / knownSkills.length) * 60), 0, 60);
  const atsScore = clamp(lengthScore + skillScore, 5, 98);

  return {
    ats_score: atsScore,
    skills_present: present,
    skills_missing: missing,
    keyword_gaps: missing.slice(0, 3),
    summary:
      text.length < 50
        ? 'Resume text is very short; the mock analyzer could not extract much signal.'
        : `Mock analysis found ${present.length} recognized skill keyword(s) and estimates an ATS score of ${atsScore}.`,
  };
}

function handleInterviewScore(body) {
  const answerLength = String(body.answer || '').length;
  const base = clamp(40 + Math.round(answerLength / 10), 20, 95);
  const jitter = (seed) => clamp(base + (hashCode(String(body.question || '') + seed) % 15) - 7, 10, 100);

  const isHr = body.round_type === 'hr';
  return {
    technical_accuracy: jitter('tech'),
    communication_clarity: jitter('comm'),
    problem_solving_approach: jitter('prob'),
    depth_of_knowledge: jitter('depth'),
    hr_readiness: isHr ? jitter('hr') : null,
    feedback:
      answerLength < 20
        ? 'Answer was quite brief. Mock feedback: elaborate with a concrete example next time.'
        : 'Mock feedback: solid structure. Consider quantifying impact where possible.',
    follow_up_question: 'Mock follow-up: can you walk through a specific example of that?',
  };
}

function handleRoadmapGenerate(body) {
  const weakTopics = Array.isArray(body.weak_topics) ? body.weak_topics : [];
  const weeks = Number(body.weeks_available) > 0 ? Number(body.weeks_available) : 4;
  const topicsPerPhase = Math.max(1, Math.ceil((weakTopics.length || 1) / weeks));

  const phases = [];
  for (let i = 0; i < weeks; i++) {
    const slice = weakTopics.slice(i * topicsPerPhase, (i + 1) * topicsPerPhase);
    phases.push({
      phase_number: i + 1,
      title: slice.length ? `Focus: ${slice.join(', ')}` : `General practice, week ${i + 1}`,
      topics: slice.length ? slice : ['Mixed review'],
      estimated_days: 7,
      resources: [`Mock resource list for ${slice[0] || 'general review'}`],
    });
  }
  return { phases };
}

function handleWeakTopics(body) {
  const performance = Array.isArray(body.topic_performance) ? body.topic_performance : [];
  const strong = [];
  const weak = [];
  const improving = [];
  const errorBreakdown = { conceptual: 0, computational: 0, careless: 0, time_management: 0 };

  for (const p of performance) {
    const accuracy = Number(p.accuracy) || 0;
    if (accuracy >= 0.75) strong.push(p.topic);
    else if (accuracy < 0.5) {
      weak.push(p.topic);
      errorBreakdown.conceptual += 1;
    } else improving.push(p.topic);
  }

  return { strong, weak, improving, error_breakdown: errorBreakdown };
}

function handleReadinessInsights(body) {
  const score = Number(body.score) || 0;
  return {
    headline:
      score >= 80
        ? `Strong readiness for ${body.company || 'this company'} (${body.tier || 'tier'}).`
        : score >= 50
        ? `On track for ${body.company || 'this company'}, with room to grow.`
        : `Early stage for ${body.company || 'this company'} -- focus time on the basics.`,
    strengths: Object.entries(body.breakdown || {})
      .filter(([, v]) => Number(v) >= 70)
      .map(([k]) => k),
    risks: Object.entries(body.breakdown || {})
      .filter(([, v]) => Number(v) < 50)
      .map(([k]) => k),
    next_actions: ['Keep a daily practice streak', 'Target the weakest sub-score first'],
  };
}

function handleCompanyIntelligence(body) {
  const company = body.company || 'this company';
  return {
    recent_patterns: [`Mock pattern: ${company} has recently emphasized data structures rounds.`],
    commonly_asked_topics: ['Arrays', 'Dynamic Programming', 'System Design Basics'],
    interview_tips: [`Research ${company}'s recent product launches before the interview.`],
    sources: ['mock-ai-service (offline, deterministic placeholder data)'],
  };
}

function hashCode(str) {
  let hash = 0;
  for (let i = 0; i < str.length; i++) {
    hash = (hash << 5) - hash + str.charCodeAt(i);
    hash |= 0;
  }
  return Math.abs(hash);
}

const ROUTES = {
  'POST /resume/analyze': handleResumeAnalyze,
  'POST /interview/score': handleInterviewScore,
  'POST /roadmap/generate': handleRoadmapGenerate,
  'POST /analytics/weak-topics': handleWeakTopics,
  'POST /readiness/insights': handleReadinessInsights,
  'POST /company/intelligence': handleCompanyIntelligence,
};

/**
 * Builds an http.Server. Options (all optional, and all overridable per
 * instance -- this is what lets tests spin up several differently-configured
 * mock servers in one process rather than being stuck with whatever was in
 * `process.env` at require() time):
 *   apiKey        string | undefined  -- require X-Internal-Api-Key if set
 *   latencyMs     number              -- artificial delay before responding
 *   failureRate   number 0..1         -- chance of a random 500
 */
function createServer(options = {}) {
  const apiKey = options.apiKey ?? process.env.MOCK_AI_API_KEY ?? '';
  const latencyMs = options.latencyMs ?? Number(process.env.MOCK_AI_LATENCY_MS || 0);
  const failureRate = options.failureRate ?? Number(process.env.MOCK_AI_FAILURE_RATE || 0);

  return http.createServer(async (req, res) => {
    try {
      const url = new URL(req.url, `http://${req.headers.host}`);

      if (req.method === 'GET' && url.pathname === '/health') {
        return sendJson(res, 200, { status: 'ok', service: 'mock-ai-service' });
      }

      if (apiKey && req.headers['x-internal-api-key'] !== apiKey) {
        return sendJson(res, 401, { error: 'Invalid or missing X-Internal-Api-Key' });
      }

      if (failureRate > 0 && Math.random() < failureRate) {
        return sendJson(res, 500, { error: 'Mock AI service: simulated failure (MOCK_AI_FAILURE_RATE)' });
      }

      const routeKey = `${req.method} ${url.pathname}`;
      const handler = ROUTES[routeKey];
      if (!handler) {
        return sendJson(res, 404, { error: `No mock handler for ${routeKey}` });
      }

      const body = await readJsonBody(req);

      if (latencyMs > 0) await new Promise((r) => setTimeout(r, latencyMs));

      const result = handler(body);
      return sendJson(res, 200, result);
    } catch (err) {
      const statusCode = err && err.statusCode ? err.statusCode : 500;
      return sendJson(res, statusCode, { error: err.message || 'Internal mock server error' });
    }
  });
}

if (require.main === module) {
  const PORT = Number(process.env.PORT || 9000);
  createServer().listen(PORT, () => {
    // eslint-disable-next-line no-console
    console.log(`mock-ai-service listening on http://localhost:${PORT}`);
  });
}

module.exports = { createServer, handlers: { ...ROUTES, hashCode } };
