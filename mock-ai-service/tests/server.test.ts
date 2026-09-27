import { describe, it, expect, beforeAll, afterAll } from 'vitest';
import type { AddressInfo } from 'net';
import { createServer } from '../../mock-ai-service/server.js';

function listen(server: ReturnType<typeof createServer>): Promise<string> {
  return new Promise((resolve) => {
    server.listen(0, () => {
      const { port } = server.address() as AddressInfo;
      resolve(`http://127.0.0.1:${port}`);
    });
  });
}

function close(server: ReturnType<typeof createServer>): Promise<void> {
  return new Promise((resolve) => server.close(() => resolve()));
}

describe('mock-ai-service', () => {
  let baseUrl: string;
  let server: ReturnType<typeof createServer>;

  beforeAll(async () => {
    server = createServer({});
    baseUrl = await listen(server);
  });

  afterAll(() => close(server));

  it('GET /health returns ok', async () => {
    const res = await fetch(`${baseUrl}/health`);
    expect(res.status).toBe(200);
    expect((await res.json()).status).toBe('ok');
  });

  it('POST /resume/analyze returns the ResumeAnalysisResult shape and reacts to skill keywords', async () => {
    const res = await fetch(`${baseUrl}/resume/analyze`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ resume_text: 'Experienced in javascript, react, node, docker, git and sql.' }),
    });
    const body = await res.json();
    expect(res.status).toBe(200);
    expect(body).toEqual(
      expect.objectContaining({
        ats_score: expect.any(Number),
        skills_present: expect.arrayContaining(['javascript', 'react', 'node']),
        skills_missing: expect.any(Array),
        keyword_gaps: expect.any(Array),
        summary: expect.any(String),
      })
    );
  });

  it('/resume/analyze scores a keyword-rich resume higher than an empty one', async () => {
    const rich = await fetch(`${baseUrl}/resume/analyze`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        resume_text: ('javascript typescript react node express sql postgresql docker kubernetes aws git rest graphql testing ci cd ' + 'padding '.repeat(200)),
      }),
    });
    const empty = await fetch(`${baseUrl}/resume/analyze`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ resume_text: '' }),
    });
    const richBody = await rich.json();
    const emptyBody = await empty.json();
    expect(richBody.ats_score).toBeGreaterThan(emptyBody.ats_score);
  });

  it('POST /interview/score returns the InterviewScoreResult shape', async () => {
    const res = await fetch(`${baseUrl}/interview/score`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ question: 'Explain closures', answer: 'A closure is a function bundled with its lexical scope.', round_type: 'technical' }),
    });
    const body = await res.json();
    expect(body.hr_readiness).toBeNull();
    expect(body).toEqual(
      expect.objectContaining({
        technical_accuracy: expect.any(Number),
        communication_clarity: expect.any(Number),
        problem_solving_approach: expect.any(Number),
        depth_of_knowledge: expect.any(Number),
        feedback: expect.any(String),
        follow_up_question: expect.any(String),
      })
    );
  });

  it('POST /interview/score sets hr_readiness for an hr round', async () => {
    const res = await fetch(`${baseUrl}/interview/score`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ question: 'Tell me about yourself', answer: 'I am ...', round_type: 'hr' }),
    });
    const body = await res.json();
    expect(typeof body.hr_readiness).toBe('number');
  });

  it('POST /roadmap/generate splits weak topics across the requested number of weeks', async () => {
    const res = await fetch(`${baseUrl}/roadmap/generate`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ weak_topics: ['DP', 'Graphs', 'Trees', 'Greedy'], weeks_available: 2 }),
    });
    const body = await res.json();
    expect(body.phases).toHaveLength(2);
    expect(body.phases[0]).toEqual(
      expect.objectContaining({ phase_number: 1, topics: expect.any(Array), estimated_days: 7 })
    );
  });

  it('POST /analytics/weak-topics buckets by accuracy thresholds', async () => {
    const res = await fetch(`${baseUrl}/analytics/weak-topics`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        topic_performance: [
          { topic: 'Arrays', accuracy: 0.9 },
          { topic: 'Graphs', accuracy: 0.3 },
          { topic: 'Strings', accuracy: 0.6 },
        ],
      }),
    });
    const body = await res.json();
    expect(body.strong).toEqual(['Arrays']);
    expect(body.weak).toEqual(['Graphs']);
    expect(body.improving).toEqual(['Strings']);
  });

  it('POST /readiness/insights names strengths/risks from the breakdown', async () => {
    const res = await fetch(`${baseUrl}/readiness/insights`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        company: 'TCS',
        tier: 'Ninja',
        score: 75,
        probability: 0.6,
        breakdown: { aptitude: 80, coding: 40 },
      }),
    });
    const body = await res.json();
    expect(body.strengths).toContain('aptitude');
    expect(body.risks).toContain('coding');
    expect(body.headline).toMatch(/TCS/);
  });

  it('POST /company/intelligence returns the CompanyIntelligenceResult shape', async () => {
    const res = await fetch(`${baseUrl}/company/intelligence`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ company: 'Infosys' }),
    });
    const body = await res.json();
    expect(body.recent_patterns[0]).toMatch(/Infosys/);
    expect(body.commonly_asked_topics.length).toBeGreaterThan(0);
    expect(body.sources.length).toBeGreaterThan(0);
  });

  it('returns 404 for an unknown route', async () => {
    const res = await fetch(`${baseUrl}/not/a/real/route`, { method: 'POST', body: '{}' });
    expect(res.status).toBe(404);
  });

  it('returns 400 for invalid JSON', async () => {
    const res = await fetch(`${baseUrl}/resume/analyze`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: '{not valid json',
    });
    expect(res.status).toBe(400);
  });
});

describe('mock-ai-service auth/latency/failure simulation', () => {
  it('401s when MOCK_AI_API_KEY is configured and the header is missing/wrong', async () => {
    const server = createServer({ apiKey: 'secret-key' });
    const baseUrl = await listen(server);
    try {
      const noKey = await fetch(`${baseUrl}/resume/analyze`, { method: 'POST', body: '{}' });
      expect(noKey.status).toBe(401);

      const wrongKey = await fetch(`${baseUrl}/resume/analyze`, {
        method: 'POST',
        headers: { 'X-Internal-Api-Key': 'wrong' },
        body: '{}',
      });
      expect(wrongKey.status).toBe(401);

      const rightKey = await fetch(`${baseUrl}/resume/analyze`, {
        method: 'POST',
        headers: { 'X-Internal-Api-Key': 'secret-key', 'Content-Type': 'application/json' },
        body: '{}',
      });
      expect(rightKey.status).toBe(200);
    } finally {
      await close(server);
    }
  });

  it('respects an artificial latency (used to exercise AI_SERVICE_TIMEOUT_MS handling in the real client)', async () => {
    const server = createServer({ latencyMs: 50 });
    const baseUrl = await listen(server);
    try {
      const start = Date.now();
      await fetch(`${baseUrl}/resume/analyze`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: '{}',
      });
      expect(Date.now() - start).toBeGreaterThanOrEqual(45);
    } finally {
      await close(server);
    }
  });

  it('always fails with failureRate=1 (used to exercise ApiError.badGateway handling)', async () => {
    const server = createServer({ failureRate: 1 });
    const baseUrl = await listen(server);
    try {
      const res = await fetch(`${baseUrl}/resume/analyze`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: '{}',
      });
      expect(res.status).toBe(500);
    } finally {
      await close(server);
    }
  });
});
