# Architecture & Project Guide

This is the one document to read to understand what every part of this
backend does and how to run it. For *why* things are shaped the way they
are (spec deviations, judgment calls, tradeoffs) see
**[CHANGES_AND_ASSUMPTIONS.md](../CHANGES_AND_ASSUMPTIONS.md)** — this file
is the map, that one is the rationale. For the test suite specifically, see
**[TESTING.md](../TESTING.md)**.

---

## 1. What this service is

The backend for an AI-powered placement-prep platform: students practice
aptitude MCQs and coding problems, take mock interviews scored by an AI
service, upload resumes for ATS analysis, get a generated study roadmap,
and track a per-company "readiness score." Everything funnels into a
single Express API; a separate FastAPI microservice (not in this repo)
handles every LLM-backed call.

```
                        ┌────────────────────┐
   Browser / mobile ───▶│   Express API       │◀── this repo
                        │  (this backend)      │
                        └──────┬───────┬───────┘
                               │       │
                   ┌───────────┘       └───────────┐
                   ▼                                ▼
          ┌─────────────────┐              ┌──────────────────┐
          │   PostgreSQL      │              │  AI microservice   │
          │ (users, questions, │              │ (FastAPI, separate │
          │  submissions, ...) │              │  repo — see        │
          └─────────────────┘              │  mock-ai-service/   │
                   ▲                        │  for local dev)     │
                   │                        └──────────────────┘
                   │
          ┌─────────────────┐
          │   Judge0 CE        │   sandboxed code execution
          │ (RapidAPI or self-  │
          │  hosted)            │
          └─────────────────┘
```

## 2. Tech stack

| Concern | Choice |
|---|---|
| Runtime | Node.js 20, TypeScript 7 (strict, native Go compiler) |
| Web framework | Express 5 |
| Request validation | zod (`*.schema.ts` per module) |
| Database | PostgreSQL 16, raw SQL migrations, `pg` — no ORM |
| **Auth** | **better-auth** (email/password, bearer-token sessions) — see §5 |
| Code execution | Judge0 CE, polled (no webhooks) |
| AI | Separate FastAPI service, called only from `services/aiServiceClient.ts` |
| Jobs | `node-cron` (nightly readiness recompute, leaderboard refresh) |
| Tests | Vitest + Supertest — see [TESTING.md](../TESTING.md) |

## 3. Directory structure

```
backend/
  src/
    config/
      env.ts                zod-validated environment config — the single
                             place every env var is read; everything else
                             imports `env` from here, never `process.env`
    lib/
      auth.ts                the better-auth instance (§5)
    db/
      pool.ts                 pg Pool + query() + withTransaction() helpers
      migrate.ts               migration runner CLI (up | status | seed)
      createAdmin.ts           CLI: provision an admin account (§5.4)
      migrations/*.sql        numbered, hand-written schema migrations,
                               001 → 009, applied in order and tracked in
                               a `schema_migrations` table
      seeds/*.sql              reference + sample content data
    middlewares/
      auth.ts                  requireAuth / requireRole / requireSelfOrAdmin
      validate.ts              wraps a zod schema as Express middleware
      errorHandler.ts          maps every error type to a JSON envelope
      rateLimiter.ts           global + auth-specific rate limits
    services/                 cross-module infrastructure, not tied to one
                               module's data:
      aiServiceClient.ts        the ONLY file that knows the AI
                                 microservice's HTTP contract
      judge0Client.ts           Judge0 submission + polling + status mapping
      cacheService.ts           generic (cache_key, cache_type, payload,
                                 expires_at) cache backing all 5 AI-call
                                 caches (see CHANGES_AND_ASSUMPTIONS §1)
      streakService.ts          daily-activity + streak bookkeeping
      fileStorage.ts            local-disk resume PDF storage
      cron/                     scheduled jobs (nightly readiness, mv
                                 leaderboard refresh)
    modules/<name>/            one folder per resource, see §4
      <name>.schema.ts           zod request validation
      <name>.repository.ts       all SQL for this module (only repositories
                                  import `query`/`withTransaction`)
      <name>.service.ts          business logic, orchestration, side
                                  effects (fire-and-forget hooks, AI calls)
      <name>.controller.ts       thin HTTP layer: parse req, call service,
                                  shape response — no logic here
      <name>.routes.ts            Express router: middleware chain per route
    routes/v1/index.ts          mounts every module router under /api/v1
    types/express.d.ts          augments Express's Request with `.user`
    utils/                     ApiError, asyncHandler, logger, password
    app.ts                      Express app assembly (all middleware,
                                 routes, error handling — no `listen()`)
    index.ts                    process entrypoint: DB reachability check,
                                 `app.listen()`, starts cron, graceful
                                 shutdown on SIGTERM/SIGINT
  mock-ai-service/             zero-dependency stand-in for the FastAPI AI
                               service, for local dev/tests (§7)
  tests/                       the test suite (§ see TESTING.md)
  docs/ARCHITECTURE.md         this file
  CHANGES_AND_ASSUMPTIONS.md   spec deviations and judgment calls
  TESTING.md                   how to run/extend the test suite
  docker-compose.yml           backend + postgres + mock-ai-service
```

Every module under `src/modules/` follows the same four/five-file shape so
the codebase is navigable without a map: **routes → controllers → services
→ repositories**, with repositories as the only place raw SQL is written.
`auth` is the one exception worth knowing about — see §5.2.

## 4. What each module does

| Module | Owns | Notable behavior |
|---|---|---|
| `auth` | Registration, login, session refresh/logout, `/me` | Thin wrapper around better-auth (§5) plus the onboarding transaction (streak row + target companies) that runs right after a new account is created |
| `users` | Profile, target-company picks, activity heatmap | `requireSelfOrAdmin` gates every route — a student can only ever read/edit their own resources |
| `companies` | Company + company-tier catalog | Read-mostly; tiers carry the 5 readiness weights (aptitude/coding/resume/interview/consistency) |
| `questions` | Aptitude + coding question catalog | One `questions` table with a 1:1 detail table per type (`aptitude_question_details` / `coding_problem_details`); admin-only writes |
| `assessment` | Aptitude MCQ submission, adaptive question picker, per-topic analytics | The picker (weak topics → strong topics → generic fallback, company-biased) and the every-5th-attempt batched AI weak-topic trigger both live here — see `assessment.repository.ts`'s `pickAdaptiveQuestion` and `assessment.service.ts`'s `triggerWeakTopicAnalysisIfDue` |
| `coding` | Code submission, Judge0 orchestration | Runs every test case sequentially through Judge0, short-circuits on compile error, picks one overall status by severity (`STATUS_SEVERITY` in `coding.service.ts`) |
| `mockTests` | Full sectional mock tests | Composes aptitude + coding questions into a timed test, scores on completion |
| `interview` | AI-scored mock interview sessions | Fixed opener per round type; every question after that is the AI's `follow_up_question` from scoring the previous answer (see CHANGES_AND_ASSUMPTIONS §3) |
| `resume` | PDF upload → text extraction → AI ATS analysis | `pdf-parse` for extraction, `fileStorage.ts` for local-disk storage, triggers roadmap regeneration |
| `roadmap` | AI-generated study roadmap, phase tracking | A user has at most one `active` roadmap (partial unique index); generating a new one abandons the old in the same transaction |
| `readiness` | Deterministic weighted score + AI insights, per company tier | `readiness.service.ts`'s `recomputeForTier` is the core formula — see §4.1 |
| `analytics` | Aggregated per-user dashboard | Mostly reads that stitch together other modules' repositories |
| `leaderboard` | Overall / college / streak leaderboards | Reads `mv_leaderboard`, a materialized view refreshed every 15 min by cron — never a second source of truth (CHANGES_AND_ASSUMPTIONS §1) |
| `gamification` | Badges | Checked (fire-and-forget) after aptitude submissions, coding submissions, and mock test completion |

### 4.1 The readiness formula, concretely

`readiness.service.ts`:

```
score = (aptitude*Wa + coding*Wc + resume*Wr + interview*Wi + consistency*Ws) / 100
probability = clamp((score - 40) / (100 - 40), 0, 1)   // linear ramp, see CHANGES_AND_ASSUMPTIONS §3
```

Sub-scores (`readiness.repository.ts`) are each computed from a different
table (aptitude = accuracy over last 30 attempts, coding = difficulty-
weighted solve rate, resume = latest ATS score, interview = average of last
5 scorecards, consistency = current streak / 30 days). Recompute is
triggered after any relevant event (`maybeRecomputeReadiness`, called from
`assessment`, `coding`, `interview`, `resume`) and nightly for every user
with a target company (`services/cron`). AI enrichment
(`getReadinessInsights`) only fires when the score moved by more than 5
points since last time — see the "AI Cost Control Strategy" note in
`readiness.service.ts` and the corresponding test in
`tests/unit/modules/readiness/readiness.service.test.ts`.

## 5. Auth: better-auth (replacing the old hand-rolled JWT)

An earlier version of this backend hand-signed JWT access tokens and
managed a `refresh_tokens` table by hand (rotation, revocation, hashing).
That's gone. Auth is now **better-auth**, a single library owning the
whole email/password + session lifecycle.

### 5.1 Why, concretely

- One less hand-rolled security-critical subsystem (token signing,
  rotation, hashing, expiry math) to get right and keep right.
- Sessions are opaque, DB-backed bearer tokens with **sliding expiry**:
  `SESSION_EXPIRES_IN_DAYS` (default 30) is the hard TTL,
  `SESSION_UPDATE_AGE_HOURS` (default 24) is how often an active session's
  expiry gets pushed forward. This directly replaces the old
  access(15m)+refresh(30d) pair with one token that's just as revocable
  (delete the row / `auth.api.signOut`) and never needs a client-side
  rotation dance.
- Room to add OAuth providers later as a config change (`socialProviders:
  {...}` in `src/lib/auth.ts`), not a schema rewrite — see §5.2.

### 5.2 How it's wired in

- **`src/lib/auth.ts`** — the single `betterAuth({...})` instance. It talks
  to Postgres through the *same* `pg.Pool` as everything else
  (`database: pool`); better-auth auto-detects the dialect from the Pool
  instance. `advanced.database.generateId: false` tells it to rely on
  Postgres's `gen_random_uuid()` defaults instead of its own nanoid-style
  ids, so ids stay consistent with the rest of the schema.
- **`users` table reuse.** better-auth's `user` model is mapped onto the
  *existing* `users` table (`user.modelName: 'users'`) rather than creating
  a parallel one — `name` maps to `full_name`, and `role` / `college` /
  `graduation_year` / `is_active` are declared as `additionalFields` with
  `fieldName` pointing at the existing snake_case columns. `role` is
  `input: false`, meaning a client can never set it via the public sign-up
  request — see §5.4 for how admins actually get created.
- **New tables** (migration `009_better_auth.sql`): `session`, `account`,
  `verification` — better-auth's own core schema, created directly (no
  `ALTER`/`DROP` — this schema has never shipped, so there was nothing to
  migrate away from). Passwords live in `account.password` (provider
  `credential`); `users` never has a `password_hash` column — see
  `002_foundation.sql`.
- **`middlewares/auth.ts`** — `requireAuth` calls
  `auth.api.getSession({ headers: fromNodeHeaders(req.headers) })` and, on
  success, populates `req.user = { sub, role, email, fullName }`. Every
  other module in the codebase reads `req.user.sub` / `req.user.role`
  exactly as before — **only this one file changed** when auth moved from
  JWTs to better-auth sessions; no controller/service elsewhere needed
  touching. `requireRole` and `requireSelfOrAdmin` are unchanged.
- **`bearer` plugin.** SPA/mobile clients authenticate with
  `Authorization: Bearer <token>` (no cookie dance required), which is what
  `middlewares/auth.ts` and every route already expected.
- **`app.ts` mounts `/api/auth/*`** (`toNodeHandler(auth)`) as a courtesy
  direct-access path to better-auth's full HTTP surface. In normal use,
  clients talk to `/api/v1/auth/*` instead (§5.3), which is this backend's
  own thin wrapper — kept so the onboarding transaction stays atomic with
  registration and the response shape stays stable for existing clients.

### 5.3 `/api/v1/auth/*` — this backend's own auth routes

| Route | What it does |
|---|---|
| `POST /auth/register` | Calls `auth.api.signUpEmail` (creates the `users` + `account` row), then runs `attachOnboarding` (streak row + target companies + zeroed readiness rows) in its own transaction. Returns `{ user, token }`. |
| `POST /auth/login` | `auth.api.signInEmail`. Returns `{ user, token }`. |
| `POST /auth/refresh` | No token rotation anymore (sessions slide automatically — see §5.1); this just calls `getSession` and reports the current token/expiry, kept for API back-compat with clients that poll it. |
| `POST /auth/logout` | `auth.api.signOut`. Idempotent — logging out twice is not an error. |
| `GET /auth/me` | Returns `req.user` as populated by `requireAuth`. |

### 5.4 Provisioning an admin

Public registration always creates a `student` (role is `input: false` —
see §5.2). To create or promote an admin:

```bash
npm run create-admin -- admin@example.com "S0me!StrongPass" "Admin User"
```

Safe to re-run: if the email already exists it just flips that user's role
to `admin`.

## 6. How to run this

### 6.1 With Docker (fastest — backend + Postgres + mock AI service)

```bash
cp .env.example .env          # edit BETTER_AUTH_SECRET at minimum
docker compose up --build
docker compose exec backend npm run migrate
docker compose exec backend npm run seed
```

API at `http://localhost:8080/api/v1`, health check at `/health`. The mock
AI service (§7) is already running at `http://mock-ai-service:9000` inside
the compose network, and `AI_SERVICE_BASE_URL` defaults to it.

### 6.2 Without Docker

```bash
npm install
cp .env.example .env          # point DATABASE_URL at your own Postgres
npm run migrate               # applies src/db/migrations/*.sql in order
npm run seed                  # companies/tiers/topics/badges + sample questions
npm run mock-ai               # in a second terminal — see §7
npm run dev                   # tsx watch mode
```

`npm run migrate:status` shows which migrations have been applied.
`npm run create-admin -- <email> <password> [name]` provisions an admin (§5.4).

### 6.3 Required environment variables

At minimum, set real values for:

- `DATABASE_URL`
- `BETTER_AUTH_SECRET` (32+ random chars — `openssl rand -base64 32`)
- `BETTER_AUTH_URL` (must match the URL clients actually reach this API on)
- `AI_SERVICE_BASE_URL` (the real FastAPI service, or `mock-ai-service`
  locally — see §7)
- `JUDGE0_API_KEY` / `JUDGE0_API_HOST` (RapidAPI's Judge0 CE; leave blank
  for a self-hosted instance)

Everything else has a sane default — see `.env.example`.

### 6.4 Building & running in production

```bash
npm run build     # tsc -> dist/
npm start         # node dist/index.js
```

(`docker-compose.yml`'s `backend` service does exactly this via the
multi-stage `Dockerfile`.)

## 7. mock-ai-service

A zero-dependency (`node` built-ins only) stand-in for the real FastAPI AI
microservice, implementing all six endpoints `aiServiceClient.ts` calls
with deterministic, request-shaped responses. See
**[mock-ai-service/README.md](../mock-ai-service/README.md)** for the full
endpoint table and how to simulate latency/failures/auth for testing the
backend's degrade paths.

```bash
npm run mock-ai                              # http://localhost:9000
AI_SERVICE_BASE_URL=http://localhost:9000     # point the backend at it
```

## 8. Testing

See **[TESTING.md](../TESTING.md)**. Short version: `npm test` runs the
full unit + mocked-integration suite with no external dependencies
(Postgres, Judge0, or the AI service all mocked at their client boundary).
`npm run test:integration` additionally runs a small real-Postgres suite
against a database you provide.

## 9. Design choices worth knowing before you extend this

- **No ORM.** The schema has enough cross-cutting invariants (composite
  PKs, partial unique indexes, a cross-table CHECK enforced via trigger)
  that hand-written SQL in the migrations was more legible and auditable
  than an ORM's DSL. `db/migrate.ts` is a small, dependency-free migration
  runner tracking applied files in a `schema_migrations` table.
- **AI calls are isolated to one client.** `services/aiServiceClient.ts` is
  the only file that knows the AI microservice's HTTP contract. Every call
  is wrapped so a timeout or non-2xx becomes `ApiError.badGateway`, which
  the caller can choose to degrade around (serve stale cache) rather than
  crash the request.
- **Fire-and-forget side effects are explicit.** Badge checks, readiness
  recomputes, and cache warms after a submission never block the response
  — they're `.catch()`-guarded promises, logged on failure, documented
  inline everywhere they're used, and covered by tests asserting they
  don't reject the caller (see TESTING.md).
- **Every module reads `req.user` the same way regardless of what backs
  it.** This is what let auth move from JWTs to better-auth touching only
  `middlewares/auth.ts` — keep that contract (`sub`/`role`/`email`) stable
  if `AuthenticatedUser` in `types/express.d.ts` ever changes again.
- **Search for `TRADEOFF` / `ASSUMPTION` comments** before assuming a gap
  in this codebase is an oversight — see CHANGES_AND_ASSUMPTIONS.md for the
  consolidated list.
