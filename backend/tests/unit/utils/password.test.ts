import { describe, it, expect } from 'vitest';
import { hashPassword, verifyPassword } from '../../../src/utils/password';

describe('password utils', () => {
  it('hashes a password to a bcrypt-shaped, non-reversible string', async () => {
    const hash = await hashPassword('correct horse battery staple');
    expect(hash).not.toBe('correct horse battery staple');
    expect(hash).toMatch(/^\$2[aby]\$\d{2}\$/);
  });

  it('verifies the correct password against its own hash', async () => {
    const hash = await hashPassword('s3cure-P@ssword');
    await expect(verifyPassword('s3cure-P@ssword', hash)).resolves.toBe(true);
  });

  it('rejects an incorrect password', async () => {
    const hash = await hashPassword('s3cure-P@ssword');
    await expect(verifyPassword('wrong-password', hash)).resolves.toBe(false);
  });

  it('produces a different hash each time (random salt)', async () => {
    const [a, b] = await Promise.all([hashPassword('same-input'), hashPassword('same-input')]);
    expect(a).not.toBe(b);
    await expect(verifyPassword('same-input', a)).resolves.toBe(true);
    await expect(verifyPassword('same-input', b)).resolves.toBe(true);
  });

  it('is case-sensitive', async () => {
    const hash = await hashPassword('CaseSensitive1');
    await expect(verifyPassword('casesensitive1', hash)).resolves.toBe(false);
  });
});
