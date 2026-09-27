import { describe, it, expect, vi, beforeEach } from 'vitest';

const queryMock = vi.fn();
vi.mock('../../../../src/db/pool', () => ({
  query: (...args: any[]) => queryMock(...args),
  withTransaction: vi.fn(),
}));

import { pickAdaptiveQuestion } from '../../../../src/modules/assessment/assessment.repository';

const WEAK_Q = { id: 'q-weak', topic_id: 't-weak', difficulty: 'easy', title: 'Weak topic Q' };
const STRONG_Q = { id: 'q-strong', topic_id: 't-strong', difficulty: 'hard', title: 'Strong topic Q' };
const FALLBACK_Q = { id: 'q-fallback', topic_id: 't-any', difficulty: 'medium', title: 'Fallback Q' };

function rows(r: any[]) {
  return { rows: r };
}

describe('pickAdaptiveQuestion', () => {
  beforeEach(() => {
    queryMock.mockReset();
  });

  it('step 1: returns a weak-topic, company-preferred question first when one exists', async () => {
    queryMock
      .mockResolvedValueOnce(rows([{ topic_id: 't-weak' }])) // getWeakTopicIds
      .mockResolvedValueOnce(rows([])) // getStrongTopicIds
      .mockResolvedValueOnce(rows([WEAK_Q])); // attempt(weak, [easy,medium], preferCompany=true)

    const result = await pickAdaptiveQuestion({ userId: 'u1', category: 'aptitude', companyId: 'co-1' });

    expect(result).toEqual(WEAK_Q);
    expect(queryMock).toHaveBeenCalledTimes(3);
    // the 3rd call is the company-preferred attempt: it should join question_companies
    expect(queryMock.mock.calls[2][0]).toMatch(/JOIN question_companies/);
  });

  it('step 1b: falls back to weak-topic WITHOUT company preference when the company-biased query finds nothing', async () => {
    queryMock
      .mockResolvedValueOnce(rows([{ topic_id: 't-weak' }])) // weak
      .mockResolvedValueOnce(rows([])) // strong
      .mockResolvedValueOnce(rows([])) // attempt weak + company -> nothing
      .mockResolvedValueOnce(rows([WEAK_Q])); // attempt weak, no company -> hit

    const result = await pickAdaptiveQuestion({ userId: 'u1', category: 'aptitude', companyId: 'co-1' });

    expect(result).toEqual(WEAK_Q);
    expect(queryMock).toHaveBeenCalledTimes(4);
    expect(queryMock.mock.calls[2][0]).toMatch(/JOIN question_companies/);
    expect(queryMock.mock.calls[3][0]).not.toMatch(/JOIN question_companies/);
  });

  it('step 2: falls through to a strong-topic (harder) question when weak topics yield nothing', async () => {
    queryMock
      .mockResolvedValueOnce(rows([{ topic_id: 't-weak' }])) // weak topics exist
      .mockResolvedValueOnce(rows([{ topic_id: 't-strong' }])) // strong topics exist
      .mockResolvedValueOnce(rows([])) // weak + company -> nothing
      .mockResolvedValueOnce(rows([])) // weak, no company -> nothing
      .mockResolvedValueOnce(rows([STRONG_Q])); // strong + company -> hit

    const result = await pickAdaptiveQuestion({ userId: 'u1', category: 'aptitude', companyId: 'co-1' });

    expect(result).toEqual(STRONG_Q);
    expect(queryMock).toHaveBeenCalledTimes(5);
    // the strong-topic attempt should request harder difficulties
    expect(queryMock.mock.calls[4][1]).toEqual(
      expect.arrayContaining([expect.arrayContaining(['hard', 'medium'])])
    );
  });

  it('step 3: falls all the way back to any unattempted question when the student has no weak/strong topics tracked yet', async () => {
    queryMock
      .mockResolvedValueOnce(rows([])) // no weak topics
      .mockResolvedValueOnce(rows([])) // no strong topics
      .mockResolvedValueOnce(rows([FALLBACK_Q])); // generic, company-preferred -> hit

    const result = await pickAdaptiveQuestion({ userId: 'u1', category: 'aptitude', companyId: 'co-1' });

    expect(result).toEqual(FALLBACK_Q);
    expect(queryMock).toHaveBeenCalledTimes(3);
  });

  it('returns null when every fallback is exhausted (no questions left at all)', async () => {
    queryMock
      .mockResolvedValueOnce(rows([])) // weak
      .mockResolvedValueOnce(rows([])) // strong
      .mockResolvedValueOnce(rows([])) // generic + company
      .mockResolvedValueOnce(rows([])); // generic, no company

    const result = await pickAdaptiveQuestion({ userId: 'u1', category: 'aptitude', companyId: 'co-1' });

    expect(result).toBeNull();
    expect(queryMock).toHaveBeenCalledTimes(4);
  });

  it('skips the company-preferred attempt entirely when no companyId is given', async () => {
    queryMock
      .mockResolvedValueOnce(rows([])) // weak
      .mockResolvedValueOnce(rows([])) // strong
      .mockResolvedValueOnce(rows([FALLBACK_Q])); // generic (no company variant, since preferCompany is gated on companyId)

    const result = await pickAdaptiveQuestion({ userId: 'u1', category: 'coding' });

    expect(result).toEqual(FALLBACK_Q);
    // With no companyId, the "preferCompany" attempt short-circuits to the same
    // plain query, so only 3 calls total (weak, strong, one generic attempt).
    expect(queryMock).toHaveBeenCalledTimes(3);
    expect(queryMock.mock.calls[2][0]).not.toMatch(/JOIN question_companies/);
  });

  it('every generated query excludes questions the user already answered correctly', async () => {
    queryMock
      .mockResolvedValueOnce(rows([]))
      .mockResolvedValueOnce(rows([]))
      .mockResolvedValueOnce(rows([FALLBACK_Q]));

    await pickAdaptiveQuestion({ userId: 'u1', category: 'coding' });

    expect(queryMock.mock.calls[2][0]).toMatch(/aa\.is_correct/);
  });
});
