# Changes & Assumptions

This is the single source of truth for "what did you change from the spec,
and why" and "what did you assume when the spec didn't say." Everything here
is also commented in-line at the exact file/line it applies to (search for
`TRADEOFF`, `ASSUMPTION`, `NOTE ON`, `CONTRADICTION`) — this file just
collects them in one place for review. §7–§9 cover the later better-auth
migration, test suite, and TypeScript 7/Express 5/dependency-majors pass,
all of which post-date the original schema/route sections below.

---

## 1. Schema changes (relative to the 31-table PDF reference)

The PDF schema was treated as authoritative over the HLD's older Prisma
sketch (Section 08), since the PDF is explicitly the "full schema reference
— nothing omitted" revision and the HLD itself predates it (it still
describes `student_profiles` and `company_readiness_scores`, which the PDF
correctly replaces with normalized `readiness_scores` /
`readiness_score_history` / `student_skill_map` etc.). All 31 tables from
the PDF are implemented exactly as specified — every ENUM, every composite
PK, every CASCADE/RESTRICT/SET NULL choice, every named CHECK.

Four things were added **on top of** those 31 tables. None of them change
or remove anything from the reference schema; each closes a gap between
"what the PRD requires the product to do" and "what table currently holds
that data."

| Addition | Type | Why |
|---|---|---|
| `refresh_tokens` | table | HLD explicitly calls for "JWT-based authentication with refresh token support." A refresh token has to be revocable (logout, suspected theft) before its natural expiry, which a bare JWT can't do — only server-side state can. Stored as a SHA-256 hash, never the raw token, and rotated on every use (old token marked `revoked_at` + `replaced_by` pointing at the new one) so a leaked-and-replayed old token is detectable. |
| `ai_cache` | table | The HLD's "AI Cost Control Strategy" table specifies per-call-type cache durations (readiness insights 1h, weak-topic detection 24h, roadmap generation 24h, company intelligence 24h) but the 31-table schema has nowhere to persist them. Rather than five near-identical cache tables, one generic `(cache_key, cache_type, payload, expires_at)` table backs all five call types. |
| `mv_leaderboard` | materialized view (not a table) | Module 10's leaderboard is entirely derived from `readiness_scores` + `student_streaks` — it has no independent data of its own, so it must never become a second source of truth that can drift. A materialized view, refreshed every 15 minutes by cron, gives fast reads without that risk. `REFRESH ... CONCURRENTLY` is used so reads are never blocked during a refresh. |
| seed data (migration 008 + `db/seeds/001_sample_questions.sql`) | data, not schema | Companies/tiers/topics/badges the app can't function without, plus ~10 sample questions so the platform is exercisable without a content team. Question-bank seeding is deliberately kept separate from schema migrations (`npm run seed`, not `npm run migrate`) since it's content, not structure. |

### Open question flagged, not silently resolved

HLD Section 04's weight table (e.g. TCS Ninja: Aptitude 40 / Coding 25 /
Resume 10 / Interview 25 = 100) has **no consistency column** and already
sums to 100 without one. But `company_tiers` in the PDF schema requires
**five** weights (including `consistency_weight`) summing to 100, and HLD's
own Module 7/8 text treats consistency as a real scored dimension. These two
parts of the source material contradict each other. The seed data resolves
it by folding a flat 5-point consistency weight into every tier and
reducing that tier's interview weight by 5 points — a defensible default,
but **a product decision, not a fact derivable from either document**. Flag
this for the team; the fix is a one-line UPDATE to `company_tiers` once
someone decides the real numbers.

### A cross-table invariant the DDL alone can't express

Postgres CHECK constraints can't reference another table, but the schema
implies `questions.type` must always match `topics.category` (an aptitude
question shouldn't hang off a coding topic). Migration 002 enforces this
with a `BEFORE INSERT OR UPDATE` trigger (`enforce_question_type_matches_topic`)
instead of leaving it as an application-layer-only rule that a raw SQL
`INSERT` could silently violate.

---

## 2. API route naming: PDF vs HLD

The HLD's Section 09 REST table and the PDF schema were written at
different times and don't always agree on where a feature lives. Where they
conflicted, this backend follows the HLD's route names (since that's the
contract a frontend would already be coded against) but the PDF's schema
(since it's the more complete, more recent data model). Notable spots:

- `GET /coding/problem/:id` (HLD naming) is served from the same
  `questions` table/repository as `GET /questions/:id` — there's no
  separate "problems" table, just a `type='coding'` question with its 1:1
  `coding_problem_details` row.
- `/interview/session/start`, `/interview/session/:id/respond`,
  `/interview/session/:id/scorecard` match the HLD's literal paths.
- `/roadmap/:userId/active` and `PATCH /roadmap/:userId/phase/:id` match the
  HLD's literal paths, layered on the PDF's `roadmaps`/`roadmap_phases`/
  `roadmap_phase_topics` tables.
- Endpoints the HLD's table doesn't mention at all (target-company
  onboarding, badges, mock-test lifecycle, coding submission history, resume
  version history, per-tier readiness history/insights) were added following
  the same `/resource/:userId/sub-resource` convention as the endpoints the
  HLD does list.

---

## 3. Business-logic judgment calls (the AI service contract didn't specify these)

The FastAPI AI service's contract (HLD Section 09, second table) is six
endpoints, each doing one clearly-scoped thing. Several real product
behaviors sit in the gaps between those six calls. Rather than inventing
extra AI endpoints that aren't in the spec, this backend fills those gaps
deterministically, and every instance is commented `TRADEOFF` at the
call site:

- **Aptitude answer correctness** is a JSON-shape comparison against the
  stored answer key, not an AI call — a single-correct-answer MCQ doesn't
  need an LLM to grade it, and doing so would add latency/cost for free.
- **Per-attempt `error_type`** (conceptual/computational/careless) is filled
  immediately by a cheap local heuristic (hints used → conceptual; answered
  in under 5 seconds → careless; else unknown) so the column is never left
  null while waiting for the batched AI call. The *authoritative* signal —
  what actually updates `student_skill_map` (strong/weak/improving) — only
  ever comes from `POST /analytics/weak-topics`, fired every 5th attempt and
  cached 24h, exactly as the HLD's cost-control table specifies.
- **Interview opening question**: the AI service scores a
  question-and-answer pair; it doesn't generate the very first question of
  a session (there's no answer yet to score). The opener is a fixed,
  sensible prompt per round type; every question after that is the
  `follow_up_question` the AI returns alongside its scoring of the previous
  answer, so the conversation is adaptive from turn 2 onward.
- **Interview session scorecard** (`interview_scorecards`) is synthesized
  deterministically from the five numeric dimensions of every
  `interview_answer_scores` row in the session (averaged, thresholded into
  `hire`/`borderline`/`no_hire` at 80/60), not by a seventh AI call. Reason:
  `interview_answer_scores` has no column for the AI's per-turn free-text
  `feedback` — the schema only persists the five numbers — so there is
  nothing to re-summarize into `strengths`/`weaknesses`/`improvement_plan`.
  Those three arrays are instead derived from which dimensions scored ≥7.5
  or <5 across the session. If per-turn feedback text needs to survive for
  a future "regenerate scorecard narrative" feature, that's a schema
  addition (a `feedback TEXT` column on `interview_answer_scores`), not a
  backend bug.
- **Readiness → probability formula.** Neither document specifies how a
  0–100 readiness score becomes a placement probability (only example
  outputs like "TCS Ninja: 88%" are given). This backend uses a linear ramp
  (0% at ≤40 points, 100% at ≥100 points) as an explicit, swappable
  placeholder — flagged in the code as the first thing to replace with a
  calibrated model once real outcome data exists.

---

## 4. Infrastructure tradeoffs (student-project / single-instance scale)

These are conscious scope cuts appropriate for what's being built, not
things that were missed:

- **No job queue.** Resume analysis, roadmap generation, and Judge0 polling
  all run in-request or as a `.catch()`-guarded fire-and-forget promise on
  the same process, not on a queue (BullMQ/SQS/etc). Fine at this scale;
  the first thing to change if traffic grows enough that a slow AI call
  starts holding an HTTP connection open too long.
- **Judge0 execution is per-test-case, sequential**, not Judge0's batch
  submission API. Simpler error handling, short-circuits on compile error,
  but is slower for problems with many test cases. Flagged in
  `judge0Client.ts`/`coding.service.ts`.
- **Local disk file storage** for resume PDFs (`services/fileStorage.ts`),
  not S3/GCS/Cloudinary. The `resumes.file_url` column only ever stores
  what this module returns, so swapping in a real object store later is a
  one-file change with no schema or caller impact — but as shipped, uploads
  don't survive a redeploy or scale past one instance.
- **Nightly readiness recompute runs sequentially**, one user at a time, in
  a single process (`services/cron/nightlyReadinessJob.ts`). Bounded and
  predictable at small scale; the first thing to parallelize/queue if the
  user base grows.
- **No test suite was included in the original revision.** Superseded —
  see §8 below and [TESTING.md](TESTING.md).
- **Rate limiting is in-process** (`express-rate-limit`, in-memory store),
  not Redis-backed — fine for a single instance, resets on restart, and
  won't coordinate correctly across multiple instances behind a load
  balancer.

---

## 5. Invariants this backend enforces (carried over from the schema, or added)

- A user can have at most one `is_current = true` resume (partial unique
  index + trigger that unsets any previous current resume on insert/update).
- A user can have at most one `status = 'active'` roadmap (partial unique
  index); generating a new roadmap always abandons the previous active one
  first, in the same transaction.
- `assessment_attempts.topic_id` / `.difficulty` are always filled by a
  `BEFORE INSERT` trigger from the parent question — callers never set them
  directly, so they can't drift from the question they denormalize.
- `code_submissions.status` and `assessment_attempts.is_correct` are always
  written in the same transaction as the Judge0-derived result, so a
  submission can never exist with a status that doesn't match whether it
  was actually accepted.
- Refresh tokens are single-use: `POST /auth/refresh` always issues a new
  token and revokes the one it was given, in the same transaction, so a
  captured-and-replayed refresh token is immediately detectable (the
  legitimate holder's next refresh will fail against an already-revoked
  token).
- `student_activity_log`'s natural `(user_id, activity_date)` primary key
  with `ON CONFLICT DO NOTHING` means recording activity is idempotent —
  calling it ten times in one day only logs once and only updates the
  streak counters once.

---

## 6. What to check before calling this "done"

1. Decide the real consistency-weight numbers for `company_tiers` (Section 1).
2. Replace the linear score→probability ramp with a calibrated model once
   there's real outcome data (Section 3).
3. Point `AI_SERVICE_BASE_URL` at an actual running FastAPI service — this
   backend assumes its exact 6-endpoint contract as documented in HLD
   Section 09 and implemented in `services/aiServiceClient.ts`; any
   response-shape drift there will surface as a 502 from whichever route
   triggered it.
4. Decide on a real object store before any multi-instance deployment
   (Section 4).
5. Add the three tests called out in the README before doing any
   significant refactor of the adaptive picker, readiness engine, or coding
   submission aggregation.

---

## 7. Auth migration: hand-rolled JWT → better-auth

The original `refresh_tokens` table + `utils/jwt.ts` design described in
Section 1 above has been replaced with [better-auth](https://www.better-auth.com/).
Full rationale and wiring details are in
**[docs/ARCHITECTURE.md §5](docs/ARCHITECTURE.md#5-auth-better-auth-replacing-the-old-hand-rolled-jwt)**
— summary of what changed:

- `refresh_tokens` table dropped; `session`, `account`, `verification`
  tables added (migration `009_better_auth.sql`), all mapped onto the
  existing `users` table for the user model itself (no parallel user
  table).
- `users.password_hash` dropped — passwords now live in `account.password`
  (better-auth's `credential` provider), hashed with the same bcrypt
  utilities (`utils/password.ts`) as before, at the same `BCRYPT_SALT_ROUNDS`.
- Access+refresh token pair replaced with one sliding-expiry session token
  (`SESSION_EXPIRES_IN_DAYS` / `SESSION_UPDATE_AGE_HOURS`).
- `role` is declared `input: false` on the better-auth user model, so it's
  structurally impossible for a client to self-elevate via the public
  registration endpoint — admins are provisioned via `npm run create-admin`
  (`src/db/createAdmin.ts`).
- Every module outside `auth`/`middlewares/auth.ts` was untouched: `req.user`
  keeps the exact same `{ sub, role, email }` shape it always had.

**Caveat, stated plainly:** this migration was written in a sandboxed
environment with no network access, so `npm install` (to actually pull in
the `better-auth` package) and a real test run could not be performed as
part of writing it. See **[TESTING.md §5](TESTING.md#5-a-note-on-how-this-suite-was-written)**
for the two specific assumptions about better-auth's API surface worth
double-checking first against your installed version, before treating this
as production-verified.

---

## 8. Test suite added

A test suite now exists (`npm test`) — see **[TESTING.md](TESTING.md)** for
full coverage details, conventions, and the same no-network caveat as
above (nothing in the suite has actually been executed; it's written
against the documented behavior of Vitest/Supertest/better-auth and should
be run for real as the first next step, not assumed passing).

---

## 9. TypeScript 7, Express 5, and a pass over every dependency's major version

Researched (web search, since this postdates training knowledge) and
applied in one pass. Same caveat as §7/§8 applies with equal force: **none
of this was compiled or run.** Every change below is the kind of thing
`npx tsc --noEmit` and `npm test` will confirm or refute in about thirty
seconds once you can actually install — do that before trusting this
section further than "a careful reading of the docs."

### TypeScript 5.6 → 7.0

TypeScript 7 (GA July 2026) is a from-scratch port of the compiler to Go
("Project Corsa") — same CLI (`tsc`), same `typescript` npm package, same
type-checking semantics, but a hard line on anything TypeScript 6.0 had
already deprecated. Changes made to `tsconfig.json`:

- **`"types": ["node"]` added explicitly.** TS 6+ defaults this to `[]`
  instead of auto-including every `@types/*` package — without it, Node
  globals (`process`, `Buffer`, `__dirname`, ...) stop resolving and
  virtually nothing compiles.
- **`moduleResolution: "node"` → `"nodenext"`** (paired with `module:
  "nodenext"`). Classic/`node10` resolution is removed outright in 7.0.
  Since `package.json` has no `"type": "module"`, this package still
  compiles as CommonJS, and nodenext resolution for a CommonJS-context file
  behaves like the old `node` mode — **no import statements needed
  extensions added.** This is the single riskiest line in this whole
  section to get wrong silently; `npx tsc --noEmit` is the check.
- **Unused `baseUrl`/`paths` (`@/*`) removed** — grepped the whole `src/`
  tree first; the alias was never actually imported anywhere.
- `rootDir`/`outDir`/`strict` were already explicit in this project, so
  those particular TS 6.0 "surprising default" changes don't apply here.

### Express 4.19 → 5.2

Grepped the whole route tree first for every pattern Express 5's
path-to-regexp v8 upgrade actually breaks (wildcard routes, regex routes,
`app.del()`, pluralized `accepts*`) — this app uses none of them except
one, both instances of which are fixed:

- **`app.all('/api/auth/*', ...)` → `'/api/auth/*splat'`** in `app.ts`.
  Bare `*` wildcards are rejected in Express 5 (`TypeError: Missing
  parameter name`); wildcards now need a name, same as `:params`.
- **`req.query` reassignment in `middlewares/validate.ts`.** Express 5 made
  `req.query` a getter-only accessor (no setter) for security reasons —
  `req.query = parsed` now throws. Fixed with the officially documented
  workaround, `Object.defineProperty(req, 'query', { value: parsed,
  writable: true, ... })`. This was the only place in the codebase
  reassigning `req.query`.
- **`asyncHandler` was deliberately left in place**, even though Express 5
  now forwards a rejected promise from an async route handler to `next()`
  automatically, making it technically redundant. Removing it from every
  controller across a dozen modules for no behavioral change wasn't worth
  the diff size or the risk of missing one. `middlewares/auth.ts`'s
  `requireAuth` already catches internally rather than relying on this
  either way, so nothing in the auth path depends on Express 5's new
  behavior specifically.
- `express.urlencoded({ extended: true })` is already explicit in `app.ts`,
  so Express 5's default flip to `extended: false` doesn't affect this app.
- `@types/express` bumped to `^5.0.0` to match.

### better-auth 1.2 → 1.7

Two real bugs in the original integration, not just a version bump —
found via better-auth's own GitHub issues while verifying the design:

- **`advanced.database.generateId: false` doesn't reliably work** as of
  better-auth 1.2.6+ (see [better-auth#2275](https://github.com/better-auth/better-auth/issues/2275)):
  it still generates its own 32-character id internally and tries to
  insert it, which throws `invalid input syntax for type uuid` against a
  UUID column. Fixed to `generateId: "uuid"` (supported since better-auth
  1.4, calls `crypto.randomUUID()` itself for every model) in
  `src/lib/auth.ts`. The `DEFAULT gen_random_uuid()` on each id column in
  migration `009_better_auth.sql` is now a defensive fallback, not the
  actual mechanism.
- **`additionalFields` need `returned: true`** or better-auth stores the
  column but silently omits it from the user object in every sign-up/
  sign-in/getSession response. Since `middlewares/auth.ts` reads `role`
  and `isActive` straight off that object, this would have meant every
  session resolved to a role-less user — added `returned: true` to all
  four custom fields (`role`, `college`, `graduationYear`, `isActive`).
- The `auth.api.signInEmail`/`signUpEmail` → `{ token, user }` shape that
  `auth.service.ts` relies on is confirmed current (better-auth's own
  GitHub discussions show this exact destructuring pattern), so that
  earlier flagged assumption now has real evidence behind it — still worth
  a first-run check, per TESTING.md §5.

### zod 3.23 → 4.4

Grepped every `*.schema.ts` for zod v4's known breaking patterns (custom
`{ message: ... }` error options, discriminated-union internals). Found
none in actual use — the one `message:` match in `interview.schema.ts` is
an unrelated field named `message`, not a zod option. No schema files
needed code changes; only the version bump. better-auth itself has been
zod-4-based since its 1.3.x line, so this also removes a latent v3/v4
mismatch between this app's zod and better-auth's internal one.

### Vitest 2.1 → 4.1

Version bump only (`vitest` + `@vitest/coverage-v8`, kept in lockstep).
`vitest.config.ts`'s options (`environment`, `setupFiles`, `include`,
`testTimeout`/`hookTimeout`, `coverage.{provider,reporter,include,
exclude}`) are all still-current API as far as could be confirmed without
running it — the removed-in-4.0 item found during research was the
`basic` *test* reporter, which this config never used (it configures
*coverage* reporters, a separate option).

### Left alone, on purpose

- **`multer` stays on `1.4.5-lts.1`**, not the `2.x` rewrite. That specific
  tag is multer's own maintained-patched LTS line; jumping to a major
  rewrite of a file-upload middleware, unable to test the actual multipart
  upload path (`resume` module), was judged higher-risk than lower-value
  here.
- **Every other dependency** (`axios`, `bcryptjs`, `pg`, `pino`,
  `node-cron`, `helmet`, `cors`, `compression`, `express-rate-limit`,
  `pino-http`, `tsx`, `supertest`, etc.) got a minor/patch bump within its
  existing major version, not a researched major jump — no evidence
  surfaced of a breaking major release for any of them that this app's
  usage would hit. `npm outdated` after install is the authoritative
  source on all of these, not this file.

