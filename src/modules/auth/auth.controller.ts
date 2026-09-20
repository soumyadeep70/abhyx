import { Request, Response } from 'express';
import { asyncHandler } from '../../utils/asyncHandler';
import * as authService from './auth.service';

export const registerHandler = asyncHandler(async (req: Request, res: Response) => {
  const result = await authService.register(req.body, req.headers);
  res.status(201).json(result);
});

export const loginHandler = asyncHandler(async (req: Request, res: Response) => {
  const result = await authService.login(req.body, req.headers);
  res.status(200).json(result);
});

// No body needed: the session to refresh/check is whatever bearer token is
// on the request. See auth.service.ts for why this is now a sliding-expiry
// check rather than a token-rotation step.
export const refreshHandler = asyncHandler(async (req: Request, res: Response) => {
  const result = await authService.refresh(req.headers);
  res.status(200).json(result);
});

export const logoutHandler = asyncHandler(async (req: Request, res: Response) => {
  await authService.logout(req.headers);
  res.status(204).send();
});

export const meHandler = asyncHandler(async (req: Request, res: Response) => {
  res.status(200).json({ user: req.user });
});
