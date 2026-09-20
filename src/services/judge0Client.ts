import axios from 'axios';
import { env } from '../config/env';
import { logger } from '../utils/logger';
import { ApiError } from '../utils/ApiError';

/**
 * Judge0 CE client. Submissions are created, then polled until Judge0 reports
 * a terminal status (accepted / wrong answer / TLE / runtime / compile
 * error) — no webhooks, to keep this deployable on the free tier described
 * in the HLD without a public callback URL.
 */

const client = axios.create({
  baseURL: env.JUDGE0_BASE_URL,
  headers: {
    'Content-Type': 'application/json',
    ...(env.JUDGE0_API_KEY
      ? { 'X-RapidAPI-Key': env.JUDGE0_API_KEY, 'X-RapidAPI-Host': env.JUDGE0_API_HOST }
      : {}),
  },
  timeout: 15000,
});

// Judge0 status IDs: 1=In Queue, 2=Processing, 3=Accepted, 4=Wrong Answer,
// 5=TLE, 6=Compilation Error, 7-12=various Runtime Errors.
const TERMINAL_STATUS_IDS = new Set([3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]);

export type Judge0SubmissionStatus =
  | 'accepted'
  | 'wrong_answer'
  | 'tle'
  | 'compile_error'
  | 'runtime_error'
  | 'pending';

export function mapJudge0Status(statusId: number): Judge0SubmissionStatus {
  if (statusId === 3) return 'accepted';
  if (statusId === 4) return 'wrong_answer';
  if (statusId === 5) return 'tle';
  if (statusId === 6) return 'compile_error';
  if (statusId >= 7 && statusId <= 12) return 'runtime_error';
  return 'pending';
}

export interface Judge0CreateResult {
  token: string;
}

export async function createSubmission(params: {
  languageId: number;
  sourceCode: string;
  stdin: string;
  expectedOutput?: string;
  timeLimitSeconds?: number;
  memoryLimitKb?: number;
}): Promise<Judge0CreateResult> {
  try {
    const { data } = await client.post('/submissions?base64_encoded=false&wait=false', {
      language_id: params.languageId,
      source_code: params.sourceCode,
      stdin: params.stdin,
      expected_output: params.expectedOutput,
      cpu_time_limit: params.timeLimitSeconds ?? 2,
      memory_limit: params.memoryLimitKb ?? 131072,
    });
    return { token: data.token };
  } catch (err: any) {
    logger.error({ err: err?.message }, 'Judge0 submission creation failed');
    throw ApiError.badGateway('Judge0 submission failed', { upstream: err?.response?.data });
  }
}

export interface Judge0Result {
  statusId: number;
  status: Judge0SubmissionStatus;
  stdout: string | null;
  stderr: string | null;
  compileOutput: string | null;
  time: string | null; // seconds, as string
  memory: number | null; // KB
}

export async function getSubmissionResult(token: string): Promise<Judge0Result> {
  const { data } = await client.get(
    `/submissions/${token}?base64_encoded=false&fields=status,stdout,stderr,compile_output,time,memory`
  );
  return {
    statusId: data.status?.id,
    status: mapJudge0Status(data.status?.id),
    stdout: data.stdout,
    stderr: data.stderr,
    compileOutput: data.compile_output,
    time: data.time,
    memory: data.memory,
  };
}

export function isTerminal(statusId: number): boolean {
  return TERMINAL_STATUS_IDS.has(statusId) && statusId !== 1 && statusId !== 2;
}

/** Poll until Judge0 reaches a terminal state, bounded by env-configured attempts. */
export async function pollUntilDone(token: string): Promise<Judge0Result> {
  for (let attempt = 0; attempt < env.JUDGE0_POLL_MAX_ATTEMPTS; attempt++) {
    const result = await getSubmissionResult(token);
    if (isTerminal(result.statusId)) return result;
    await new Promise((r) => setTimeout(r, env.JUDGE0_POLL_INTERVAL_MS));
  }
  throw ApiError.badGateway('Judge0 submission timed out waiting for a result');
}

// Common Judge0 language IDs used by this platform (CE instance defaults).
export const JUDGE0_LANGUAGE_IDS: Record<string, number> = {
  python: 71,
  javascript: 63,
  java: 62,
  cpp: 54,
};
