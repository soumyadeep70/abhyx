# AI Placement Platform — Backend

Production backend for the AI-Powered Placement Intelligence Platform.
Node.js + Express + TypeScript, PostgreSQL via raw SQL (`pg`), **better-auth**
for authentication, Judge0 for sandboxed code execution, and a thin client
to a separate FastAPI AI microservice for every LLM-backed feature.

**Start here:**
- **[docs/ARCHITECTURE.md](docs/ARCHITECTURE.md)** — full project structure,
  what every module does, the auth model, how to run/dev it. Read this first.
- **[CHANGES_AND_ASSUMPTIONS.md](CHANGES_AND_ASSUMPTIONS.md)** — what was
  changed from the reference schema and every non-obvious judgment call.
- **[TESTING.md](TESTING.md)** — what's covered and how to run/extend it.

## Stack

- **Runtime**: Node.js 20, TypeScript 7 (strict mode, native Go compiler)
- **Web**: Express 5, zod for request validation, helmet/cors/compression
- **Data**: PostgreSQL 16, raw SQL migrations (no ORM), `pg` connection pool
- **Auth**: [better-auth](https://www.better-auth.com/) — email/password,
  sliding-expiry bearer-token sessions, DB-backed via the same `pg` pool.
  See [docs/ARCHITECTURE.md §5](docs/ARCHITECTURE.md#5-auth-better-auth-replacing-the-old-hand-rolled-jwt).
- **Code execution**: Judge0 CE (RapidAPI or self-hosted)
- **AI**: separate FastAPI microservice, called only from
  `src/services/aiServiceClient.ts` — a zero-dependency mock of it ships in
  `mock-ai-service/` for local dev and tests
- **Jobs**: `node-cron` for nightly readiness recompute + leaderboard refresh
- **Tests**: Vitest + Supertest — see [TESTING.md](TESTING.md)

## Quick start

### With Docker (fastest — backend + Postgres + mock AI service)

```bash
cp .env.example .env          # edit BETTER_AUTH_SECRET at minimum
docker compose up --build
docker compose exec backend npm run migrate
docker compose exec backend npm run seed
```

API at `http://localhost:8080/api/v1`, health check at `/health`.

### Without Docker

```bash
npm install
cp .env.example .env          # point DATABASE_URL at your own Postgres
npm run migrate               # applies src/db/migrations/*.sql in order
npm run seed                  # companies/tiers/topics/badges + sample questions
npm run mock-ai               # in a second terminal — stands in for the AI service
npm run dev                   # tsx watch mode
```

`npm run migrate:status` shows applied migrations.
`npm run create-admin -- <email> <password> [name]` provisions an admin
account (public registration only ever creates students).

Full details, including every required env var, module-by-module
descriptions, and the reasoning behind the auth setup: **[docs/ARCHITECTURE.md](docs/ARCHITECTURE.md)**.

## Testing

```bash
npm test                  # unit + mocked-integration suite, no DB/network needed
npm run test:coverage
npm run test:integration  # opt-in, needs a real Postgres — see TESTING.md
```

See **[TESTING.md](TESTING.md)** for what's covered, the testing
conventions used, and — importantly — a note on what in this revision
could not be executed/verified in the environment it was written in.

## API surface (selected)

All routes are namespaced under `API_BASE_PATH` (default `/api/v1`) and
(except `/auth/*` and `GET /health`) require `Authorization: Bearer <session_token>`.

| Method | Path | Notes |
|---|---|---|
| POST | `/auth/register` | creates user (via better-auth) + streak row + onboarding target companies |
| POST | `/auth/login` / `/auth/refresh` / `/auth/logout` | sessions have a sliding expiry — see docs/ARCHITECTURE.md §5 |
| GET/PUT | `/users/:userId/target-companies` | onboarding target-company picks |
| GET | `/questions`, `/questions/:id` | catalog browsing; `POST/DELETE` admin-only |
| POST | `/assessment/submit` | aptitude MCQ submit; triggers streak, badges, batched AI weak-topic analysis |
| GET | `/assessment/next` | adaptive question picker (weak topics first, then push difficulty on strong topics) |
| POST | `/coding/submit` | runs every test case through Judge0, stores aggregated result |
| GET | `/coding/problem/:id` | problem + starter code + sample test cases (not the judge set) |
| POST | `/mock-tests` / `/mock-tests/:id/complete` | full-length sectional mock tests |
| POST | `/interview/session/start` / `/respond` / `GET .../scorecard` | AI-scored mock interview |
| POST | `/resume/upload` (multipart, field `resume`) | PDF → text → AI ATS analysis → auto roadmap |
| POST | `/roadmap/generate`, `GET /roadmap/:userId/active`, `PATCH /roadmap/:userId/phase/:id` | |
| GET | `/readiness/:userId`, `POST /readiness/:userId/recompute` | deterministic weighted score + AI insights |
| GET | `/analytics/:userId/dashboard` | one round trip for the whole Module 8 dashboard |
| GET | `/leaderboard?scope=overall\|college\|streak` | reads the `mv_leaderboard` materialized view |
| GET | `/users/:userId/badges` | gamification |

## Design choices worth knowing before you extend this

See **[docs/ARCHITECTURE.md §9](docs/ARCHITECTURE.md#9-design-choices-worth-knowing-before-you-extend-this)**
for the full list (no ORM, AI-call isolation, fire-and-forget side effects,
`TRADEOFF`/`ASSUMPTION` comments throughout the codebase).
