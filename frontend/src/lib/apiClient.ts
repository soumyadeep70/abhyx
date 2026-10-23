import axios, { AxiosError } from "axios";

const baseURL = import.meta.env.VITE_API_URL;

if (!baseURL) {
  throw new Error("VITE_API_URL is not defined. Check your .env file.");
}

export const apiClient = axios.create({ baseURL });

const TOKEN_KEY = "ascent.token";

export function getToken(): string | null {
  return localStorage.getItem(TOKEN_KEY);
}

export function setToken(token: string | null): void {
  if (token) localStorage.setItem(TOKEN_KEY, token);
  else localStorage.removeItem(TOKEN_KEY);
}

apiClient.interceptors.request.use((config) => {
  const token = getToken();
  if (token) {
    config.headers = config.headers ?? {};
    config.headers.Authorization = `Bearer ${token}`;
  }
  return config;
});

/** The backend's error envelope is always `{ error: { message } }` (see errorHandler.ts). */
export class ApiClientError extends Error {
  status?: number;
  constructor(message: string, status?: number) {
    super(message);
    this.name = "ApiClientError";
    this.status = status;
  }
}

apiClient.interceptors.response.use(
  (res) => res,
  (error: AxiosError<{ error?: { message?: string } }>) => {
    const message =
      error.response?.data?.error?.message ?? error.message ?? "Request failed";
    return Promise.reject(new ApiClientError(message, error.response?.status));
  },
);

export function isUnauthorized(err: unknown): boolean {
  return err instanceof ApiClientError && err.status === 401;
}
