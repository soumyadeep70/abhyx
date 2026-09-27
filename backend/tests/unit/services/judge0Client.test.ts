import { describe, it, expect, vi, beforeEach } from 'vitest';

const postMock = vi.fn();
const getMock = vi.fn();
vi.mock('axios', () => ({
  default: {
    create: () => ({ post: (...args: any[]) => postMock(...args), get: (...args: any[]) => getMock(...args) }),
  },
}));

import {
  mapJudge0Status,
  isTerminal,
  createSubmission,
  getSubmissionResult,
  pollUntilDone,
  JUDGE0_LANGUAGE_IDS,
} from '../../../src/services/judge0Client';
import { ApiError } from '../../../src/utils/ApiError';

describe('mapJudge0Status', () => {
  it.each([
    [3, 'accepted'],
    [4, 'wrong_answer'],
    [5, 'tle'],
    [6, 'compile_error'],
    [7, 'runtime_error'],
    [9, 'runtime_error'],
    [12, 'runtime_error'],
  ] as const)('status id %i -> %s', (id, expected) => {
    expect(mapJudge0Status(id)).toBe(expected);
  });

  it('treats in-queue/processing (1, 2) and anything unrecognized as pending', () => {
    expect(mapJudge0Status(1)).toBe('pending');
    expect(mapJudge0Status(2)).toBe('pending');
    expect(mapJudge0Status(999)).toBe('pending');
  });
});

describe('isTerminal', () => {
  it('is false while in queue or processing', () => {
    expect(isTerminal(1)).toBe(false);
    expect(isTerminal(2)).toBe(false);
  });

  it('is true for accepted through compile/runtime error codes', () => {
    for (const id of [3, 4, 5, 6, 7, 12]) {
      expect(isTerminal(id)).toBe(true);
    }
  });
});

describe('createSubmission', () => {
  beforeEach(() => {
    postMock.mockReset();
  });

  it('returns the Judge0 token on success', async () => {
    postMock.mockResolvedValue({ data: { token: 'abc-123' } });
    const result = await createSubmission({ languageId: 71, sourceCode: 'print(1)', stdin: '' });
    expect(result).toEqual({ token: 'abc-123' });
  });

  it('wraps a Judge0 failure as a 502 ApiError.badGateway rather than leaking the axios error', async () => {
    postMock.mockRejectedValue({ message: 'network error', response: { data: { error: 'rate limited' } } });
    await expect(createSubmission({ languageId: 71, sourceCode: 'x', stdin: '' })).rejects.toMatchObject({
      statusCode: 502,
    });
  });
});

describe('getSubmissionResult', () => {
  beforeEach(() => {
    getMock.mockReset();
  });

  it('normalizes the Judge0 payload into the internal Judge0Result shape', async () => {
    getMock.mockResolvedValue({
      data: { status: { id: 3 }, stdout: 'ok', stderr: null, compile_output: null, time: '0.05', memory: 3200 },
    });
    const result = await getSubmissionResult('tok-1');
    expect(result).toEqual({
      statusId: 3,
      status: 'accepted',
      stdout: 'ok',
      stderr: null,
      compileOutput: null,
      time: '0.05',
      memory: 3200,
    });
  });
});

describe('pollUntilDone', () => {
  beforeEach(() => {
    getMock.mockReset();
  });

  it('returns as soon as Judge0 reports a terminal status, without over-polling', async () => {
    getMock
      .mockResolvedValueOnce({ data: { status: { id: 1 } } }) // in queue
      .mockResolvedValueOnce({ data: { status: { id: 2 } } }) // processing
      .mockResolvedValueOnce({ data: { status: { id: 3 }, time: '0.01', memory: 1000 } }); // accepted

    const result = await pollUntilDone('tok-1');

    expect(result.status).toBe('accepted');
    expect(getMock).toHaveBeenCalledTimes(3);
  });

  it('times out with a 502 ApiError after JUDGE0_POLL_MAX_ATTEMPTS non-terminal polls', async () => {
    getMock.mockResolvedValue({ data: { status: { id: 2 } } }); // always "processing"

    await expect(pollUntilDone('tok-stuck')).rejects.toMatchObject({ statusCode: 502 });
  });
});

describe('JUDGE0_LANGUAGE_IDS', () => {
  it('covers every language coding.service accepts', () => {
    expect(JUDGE0_LANGUAGE_IDS).toMatchObject({ python: 71, javascript: 63, java: 62, cpp: 54 });
  });
});
