# Ascent — AI Placement Platform Frontend

A React + TypeScript + Vite frontend covering every module of the backend:
auth & onboarding, dashboard analytics, adaptive aptitude practice, a Judge0-backed
coding arena, mock tests, an AI mock interview, resume intelligence, a generated
roadmap, per-company readiness scoring, companies directory, leaderboard,
gamification badges, profile management, and an admin question bank.

## Quick start

```bash
npm install
cp .env.example .env      # point VITE_API_BASE_URL at your running backend
npm run dev                # http://localhost:5173
```

The backend's `.env.example` already whitelists `http://localhost:5173` in
`CORS_ORIGINS`, so the two projects work together out of the box in dev.

```bash
npm run build               # tsc -b && vite build -> dist/
npm run preview             # serve the production build locally
```

## Architecture

- **`src/lib/apiClient.ts`** — a single Axios instance. A request interceptor
  attaches `Authorization: Bearer <token>` from `localStorage`; a response
  interceptor normalizes every backend error into `ApiClientError` (the
  backend's error envelope is always `{ error: { message } }`).
- **`src/lib/api/*.ts`** — one thin module per backend route module
  (`auth`, `users`, `companies`, `questions`, `assessment`, `coding`,
  `mockTests`, `interview`, `resume`, `roadmap`, `readiness`, `analytics`,
  `leaderboard`), each typed against the backend's actual response shape
  (verified against the controllers/services/repositories, not just the
  schema files — several response shapes differ from what the request
  schemas would suggest; see "Backend quirks" below).
- **`src/lib/auth-context.tsx`** — session state. On load it calls
  `GET /auth/me` if a token is present; login/register/logout all go through
  better-auth's bearer-token flow (no cookies involved).
- **React Query** for all server state (caching, invalidation, mutations).
  **React Router** for navigation, with a `ProtectedRoute` (redirects to
  `/login`) and `AdminRoute` (redirects non-admins away from
  `/admin/questions`).
- **Monaco Editor** (`@monaco-editor/react`) is lazy-loaded only when a
  coding problem is opened, and by default fetches its worker/assets from a
  CDN at runtime (not bundled). For a fully offline deployment, install the
  `monaco-editor` package directly and configure `loader.config(...)` per
  `@monaco-editor/react`'s docs.

## Design

Palette and type system live in `tailwind.config.js` (`ink` for
text/surfaces, `paper` for the background, `signal` gold as the primary
accent, `momentum` teal for positive states, `alert` red for weak states),
paired with Sora (display) and Inter (body) via `@fontsource`. Deliberately
plain, hairline-bordered cards rather than heavy shadows — this is a dense,
data-first tool, not a marketing page.

## Backend quirks this frontend works around

These aren't bugs in the frontend — they're real backend behaviors that
would silently break naive client code, so they're documented here:

1. **`GET /assessment/next` throws a 404** (via `ApiError.notFound`) when no
   adaptive question is available, rather than returning `{ question: null }`.
   `assessmentApi.next()` catches that specific 404 and resolves to `null`.
2. **Aptitude answers are keyed by letter**, e.g. `{ "choice": "B" }` — this
   convention only exists as a code comment in
   `assessment.service.ts` (`submitAptitudeAnswer`), not in any schema.
   Both the practice flow and the admin question-creation form use this
   same `{ choice: "A" | "B" | ... }` shape consistently. **If your actual
   seed data uses a different key/format for `correct_answer`, scoring will
   be silently wrong** — worth a quick check against real seed rows before
   relying on this in production.
3. **Topic analytics accuracy is a 0–1 fraction**, not a percentage, and
   there's no per-topic "correct count" field — only `attempts`, `accuracy`,
   and a derived `label` (`strong` / `weak` / `improving` /
   `insufficient_data`). The same shape is reused verbatim inside the
   dashboard's `topic_heatmap`.
4. **`coding_progress` in the dashboard is one row per `(week, difficulty)`**,
   not a single summary row — the dashboard page pivots it into a
   per-week/per-difficulty line chart client-side. `solved` arrives as a
   Postgres bigint, i.e. a numeric *string*, and is coerced with `Number()`.
5. **The interview module has no endpoint to re-fetch an in-progress
   conversation.** `GET /interview/session/:id/scorecard` auto-*completes*
   the session as a side effect, so it can't be polled for history. The
   session page therefore keeps the transcript in React state, mirrored to
   `sessionStorage` (survives an accidental reload in the same tab, but not
   a lost/cleared browser session — there's no backend source of truth for
   an in-progress transcript).
6. **`question` field names**: the questions table's body column is
   `prompt` (not `description`/`body`), and the coding-question constraints
   column is `constraints_text` (not `constraints`). `starter_code` and
   `sample_test_cases`/`function_signature` are optional/nullable.
7. **Mock test question rows** (`GET /mock-tests/:id`) don't carry a row id
   or `section` — they're `{ order_index, question_id, type, title,
   difficulty, topic_name }`, joined fresh from `questions`/`topics` each
   time.
8. **`multipart/form-data` uploads must not set an explicit `Content-Type`
   header** — `resumeApi.upload()` deliberately lets Axios/the browser
   generate the multipart boundary itself; hand-setting the header (a very
   common mistake) strips the boundary and multer rejects the request.

## Known gaps / next steps

- No automated tests yet (the backend has a full Vitest suite; this project
  doesn't). Given the size of the surface area, Playwright e2e tests against
  a seeded backend would give the most coverage per hour of effort.
- No offline/PWA support.
- The admin question form doesn't support attaching `tag_ids`/`company_ids`/
  custom `judge0_language_ids` — all three default to `[]` per the backend
  schema, which is fine for getting a question live, but an admin can't yet
  tag a question to a specific company from this UI.
