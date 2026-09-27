import { describe, it, expect, vi, beforeEach } from 'vitest';
import request from 'supertest';

const getSessionMock = vi.fn();
vi.mock('../../src/lib/auth', () => ({
  auth: { api: { getSession: (...args: any[]) => getSessionMock(...args) } },
}));

const uploadMock = vi.hoisted(() => vi.fn());
vi.mock('../../src/modules/resume/resume.service', () => ({
  uploadAndAnalyzeResume: uploadMock,
  listResumeHistory: vi.fn(),
}));

import { createApp } from '../../src/app';
import { env } from '../../src/config/env';

const app = createApp();
const headers = { Authorization: 'Bearer t' };
const pdf = Buffer.from('%PDF-1.4\n1 0 obj\n<<>>\nendobj\n%%EOF');

describe('POST /api/v1/resume/upload (multer)', () => {
  beforeEach(() => {
    getSessionMock.mockReset();
    getSessionMock.mockResolvedValue({
      session: { id: 's' },
      user: { id: 'u-1', email: 's@x.com', name: 'S', role: 'student', isActive: true },
    });
    uploadMock.mockReset();
    uploadMock.mockResolvedValue({ resume_id: 'r1' });
  });

  it('accepts a PDF and hands the in-memory buffer + original name to the service', async () => {
    const res = await request(app)
      .post('/api/v1/resume/upload')
      .set(headers)
      .attach('resume', pdf, { filename: 'cv.pdf', contentType: 'application/pdf' });

    expect(res.status).toBe(201);
    expect(uploadMock).toHaveBeenCalledTimes(1);
    const arg = uploadMock.mock.calls[0][0];
    expect(arg.userId).toBe('u-1');
    expect(arg.originalName).toBe('cv.pdf');
    expect(Buffer.isBuffer(arg.fileBuffer)).toBe(true);
    expect(arg.fileBuffer.equals(pdf)).toBe(true);
  });

  it('400s when the multipart "resume" field is missing', async () => {
    const res = await request(app).post('/api/v1/resume/upload').set(headers).field('note', 'no file here');
    expect(res.status).toBe(400);
    expect(uploadMock).not.toHaveBeenCalled();
  });

  it('415s a non-PDF upload (not a 500)', async () => {
    const res = await request(app)
      .post('/api/v1/resume/upload')
      .set(headers)
      .attach('resume', Buffer.from('hello'), { filename: 'notes.txt', contentType: 'text/plain' });

    expect(res.status).toBe(415);
    expect(uploadMock).not.toHaveBeenCalled();
  });

  it('413s a file over MAX_RESUME_UPLOAD_MB (not a 500)', async () => {
    const tooBig = Buffer.alloc(env.MAX_RESUME_UPLOAD_MB * 1024 * 1024 + 1024, 0x20);
    const res = await request(app)
      .post('/api/v1/resume/upload')
      .set(headers)
      .attach('resume', tooBig, { filename: 'huge.pdf', contentType: 'application/pdf' });

    expect(res.status).toBe(413);
    expect(uploadMock).not.toHaveBeenCalled();
  });
});
