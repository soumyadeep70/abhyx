# Testing

Vitest + Supertest. Three layers, in increasing order of what they touch:

```
tests/
  unit/            pure logic + single-module tests, everything below the
                    module mocked out (repositories, other services)
  integration/      supertest against the real Express app (createApp()),
                    with the database/better-auth boundary mocked
  db-integration/   real Postgres, real migrations — opt-in, see §3
  mock-ai-service/  the mock AI HTTP server tested as its own thing
  setup.ts          env vars + global mocks, loaded before every test file
```

`npm test` runs `unit/`, `integration/`, and `mock-ai-service/` — nothing
in that set touches a network or a real database. `db-integration/` is
skipped unless you opt in (§3).

## 1. Running

```bash
npm test                  # everything except db-integration
npm run test:watch        # watch mode
npm run test:coverage     # with a coverage report (text + html + lcov)
npm run test:integration  # db-integration only, needs a real Postgres (§3)
```

## 2. What's covered, and why these modules specifically

Given the size of this codebase, depth was prioritized on the modules
whose logic is easiest to silently break in a refactor — the ones the
original README flagged before any tests existed — plus the auth rewrite
itself, since that's this change's actual risk surface:

| Area | File(s) | What's asserted |
|---|---|---|
| Adaptive question picker | `tests/unit/modules/assessment/assessment.repository.test.ts` | The exact weak→strong→generic, company-preferred→not fallback order, by asserting call count and query shape at each step |
| Assessment submission | `tests/unit/modules/assessment/assessment.service.test.ts` | Correctness check, the hint/time-based `error_type` heuristic, the every-5th-attempt AI trigger (and that it's skipped on non-multiples, on a still-fresh cache, and when no topic has enough attempts) |
| Readiness engine | `tests/unit/modules/readiness/readiness.service.test.ts` | The weighted-score formula exactly, the score→probability linear ramp and its clamping at both ends, and the >5-point "significant change" gate that controls whether the AI enrichment call fires |
| Coding submission | `tests/unit/modules/coding/coding.service.test.ts` | `STATUS_SEVERITY` aggregation across multiple test-case results (including that arrival order doesn't matter), the compile-error short-circuit, runtime/memory tracking, and every input-validation branch |
| Judge0 client | `tests/unit/services/judge0Client.test.ts` | Status-id mapping, terminal-state detection, the polling loop (returns as soon as terminal, times out after `JUDGE0_POLL_MAX_ATTEMPTS`), error wrapping |
| **Auth (the actual subject of this change)** | `tests/unit/middlewares/auth.test.ts`, `tests/unit/modules/auth/auth.service.test.ts`, `tests/integration/auth.routes.test.ts` | `requireAuth`/`requireRole`/`requireSelfOrAdmin` against a mocked better-auth session; register/login/refresh/logout service logic including the better-auth-error-to-`ApiError` mapping; the full HTTP round trip through `/api/v1/auth/*` |
| Ownership enforcement | `tests/integration/users.routes.test.ts` | `requireSelfOrAdmin` end-to-end: a student can read/edit their own resources, gets 403 on someone else's, an admin gets through either way |
| Error envelope | `tests/integration/errorHandler.test.ts` | Every error class `errorHandler` maps (`ApiError`, `ZodError`, Postgres `23505`/`23503`/`23514`, and the generic 500 fallback) produces the right status + shape, and that an unrecognized error never leaks its message |
| Utilities | `tests/unit/utils/*.test.ts` | `ApiError` factories, `asyncHandler`'s rejection forwarding, real bcrypt round-trips via `utils/password.ts` |
| mock-ai-service | `tests/mock-ai-service/server.test.ts` | Every endpoint's response shape, that scores react to input (a keyword-rich resume scores higher), and the `apiKey`/`latencyMs`/`failureRate` simulation knobs |

**Not individually covered yet** (repositories/services for `companies`,
`questions`, `mockTests`, `interview`, `resume`, `roadmap`, `analytics`,
`leaderboard`, `gamification`): these are mostly straightforward CRUD/SQL
with far less business logic than the modules above, and the
`users.routes.test.ts` + `auth.routes.test.ts` files already establish the
pattern for testing any of them (mock the repository, mock
`src/lib/auth`'s `getSession`, hit the route with supertest). Extending
coverage to a new module is: create `tests/unit/modules/<name>/`, mock
`<name>.repository.ts` the same way `assessment.service.test.ts` does, and
follow the fallback/edge-case list in that module's own code comments.

## 3. The one real-database test file

`tests/db-integration/schema.db.test.ts` is the deliberate exception to
"everything is mocked" — a real round trip against Postgres, migrated with
this project's own migration runner, to catch what a mock can't (actual
SQL syntax, constraint definitions, and specifically whether the
better-auth schema in migration `009_better_auth.sql` matches what the
installed version of better-auth actually expects — see the note in §5
below on why that specific thing couldn't be verified without a live
environment).

It's gated behind `RUN_DB_INTEGRATION=true` so the default `npm test` run
never needs a database:

```bash
docker compose up -d postgres
DATABASE_URL=postgres://placement_user:placement_pass@localhost:5432/placement_platform \
  npm run migrate
DATABASE_URL=postgres://placement_user:placement_pass@localhost:5432/placement_platform \
  npm run test:integration
```

## 4. Conventions used throughout the suite

- **Mock at the repository/client boundary, not deeper.** A `*.service.ts`
  test mocks its `*.repository.ts` (and any other service it calls), not
  `db/pool`. A `*.repository.ts` test (only `assessment.repository.ts`'s
  `pickAdaptiveQuestion` needed this, for the fallback-ordering assertions)
  mocks `db/pool`'s `query` directly.
- **Fire-and-forget assertions always `await flush()`** (a `setImmediate`
  tick) before checking whether a `.catch()`-guarded side effect (badge
  check, readiness recompute, AI enrichment) was called — these are
  intentionally not awaited by the code under test, so the test has to
  yield the event loop once before checking.
- **`better-auth/node`'s `toNodeHandler`/`fromNodeHeaders` are globally
  mocked** in `tests/setup.ts`. This keeps any test that also mocks
  `src/lib/auth` (giving it a partial `{ api }` shape) decoupled from
  assumptions about the rest of the real `auth` object's shape.
  `src/lib/auth.ts` itself is **not** mocked in `tests/integration/health.
  test.ts`, so that file doubles as a smoke test that the real
  `betterAuth({...})` config object is well-formed.
- **`ApiError` assertions use `toMatchObject({ statusCode })`** rather than
  checking `instanceof`, since several tests build the error via a plain
  rejected-promise mock rather than constructing a real `ApiError`.

## 5. A note on how this suite was written

(See also [CHANGES_AND_ASSUMPTIONS.md §9](CHANGES_AND_ASSUMPTIONS.md#9-typescript-7-express-5-and-a-pass-over-every-dependencys-major-version)
for the TypeScript 7 / Express 5 / dependency-majors pass this suite is
also meant to catch regressions in — `npm test` is the check for all of
it, not just the auth rewrite.)

This test suite (and the `better-auth` integration it partly exists to
verify) was written in a sandboxed environment with **no network access**
— `npm install` could not be run, so nothing here has actually been
executed. Everything is written carefully against the documented behavior
of Express, Vitest, Supertest, and better-auth, but you should treat
**running `npm install && npm test` yourself as the real verification
step**, not this document. The two spots most worth double-checking first:

1. **`src/modules/auth/auth.service.ts`** assumes `auth.api.signUpEmail` /
   `signInEmail` return a `token` field directly on the result object
   (documented `bearer`-plugin behavior at the time this was written). If
   your installed version returns the token somewhere else (e.g. only via
   a `set-auth-token` response header when using `asResponse: true`),
   that's a one-function fix in `auth.service.ts` — the tests around it
   (`auth.service.test.ts`, `auth.routes.test.ts`) will fail loudly and
   point straight at it.
2. **`src/db/migrations/009_better_auth.sql`** hand-writes the
   `session`/`account`/`verification` table shapes to match better-auth's
   documented default schema. Run `npx @better-auth/cli generate` against
   your installed version and diff it against this migration before
   relying on it in production — `tests/db-integration/schema.db.test.ts`
   checks the tables exist and get created, not that every column matches
   byte-for-byte.
