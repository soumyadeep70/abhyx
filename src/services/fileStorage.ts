import fs from 'fs';
import path from 'path';
import { randomUUID } from 'crypto';

/**
 * Minimal local-disk file storage behind the same interface a real object
 * store (S3, Cloudinary, GCS) would expose: save bytes, get back a
 * dereferenceable URL/path. `resumes.file_url` only ever stores what this
 * returns, never the binary — swapping this module for an S3 client later
 * requires no schema or caller change.
 *
 * TRADEOFF: local disk is not durable across container restarts/redeploys.
 * Fine for a student project / single-instance deployment; flagged in
 * CHANGES_AND_ASSUMPTIONS.md as the first thing to swap for a real bucket
 * before any multi-instance or persistent production deployment.
 */
const UPLOAD_ROOT = path.join(process.cwd(), 'uploads', 'resumes');

export function saveResumeFile(buffer: Buffer, originalName: string): string {
  fs.mkdirSync(UPLOAD_ROOT, { recursive: true });
  const safeName = `${randomUUID()}-${originalName.replace(/[^a-zA-Z0-9._-]/g, '_')}`;
  const fullPath = path.join(UPLOAD_ROOT, safeName);
  fs.writeFileSync(fullPath, buffer);
  return `/uploads/resumes/${safeName}`;
}

export function readResumeFile(fileUrl: string): Buffer {
  const fileName = path.basename(fileUrl);
  return fs.readFileSync(path.join(UPLOAD_ROOT, fileName));
}
