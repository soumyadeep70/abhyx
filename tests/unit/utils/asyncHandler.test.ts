import { describe, it, expect, vi } from 'vitest';
import { asyncHandler } from '../../../src/utils/asyncHandler';

function mockReqRes() {
  return {
    req: {} as any,
    res: {} as any,
    next: vi.fn(),
  };
}

describe('asyncHandler', () => {
  it('calls through to the wrapped handler with (req, res, next)', async () => {
    const { req, res, next } = mockReqRes();
    const handler = vi.fn().mockResolvedValue(undefined);
    const wrapped = asyncHandler(handler);

    await wrapped(req, res, next);

    expect(handler).toHaveBeenCalledWith(req, res, next);
    expect(next).not.toHaveBeenCalled();
  });

  it('forwards a rejected promise to next() instead of throwing', async () => {
    const { req, res, next } = mockReqRes();
    const boom = new Error('boom');
    const handler = vi.fn().mockRejectedValue(boom);
    const wrapped = asyncHandler(handler);

    await wrapped(req, res, next);
    // asyncHandler's .catch(next) is fire-and-forget; give the microtask a tick.
    await new Promise((r) => setImmediate(r));

    expect(next).toHaveBeenCalledWith(boom);
  });

  it('never lets a rejection escape as an unhandled rejection', async () => {
    const { req, res, next } = mockReqRes();
    const wrapped = asyncHandler(async () => {
      throw new Error('sync-looking throw inside async fn');
    });

    await expect(wrapped(req, res, next)).resolves.toBeUndefined();
  });
});
