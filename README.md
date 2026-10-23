# AI Placement Platform — full local stack

One command brings up the database, the backend (with migrations + the 372-question bank), Judge0 code
execution, an AI service, your frontend, and a live log viewer.

```
 Browser ──► frontend  :3000 (nginx, static build of ./frontend)
    │
    └──────► backend   :8080 (Express API) ──► postgres      (app data)
                                           ├─► ai-service     (mock  OR  your FastAPI)   header: X-Internal-Api-Key
                                           └─► judge0-server ◄── judge0-workers ── judge0-db / judge0-redis
 migrate (one-shot, before backend): migrations + idempotent seed      dozzle :9999 → live logs of everything
```

The **browser** talks to the backend directly (so `FRONTEND_API_URL` and `CORS_ORIGINS` must use host-reachable
`localhost` URLs); the **containers** talk to each other by service name (`postgres`, `ai-service`, `judge0-server`).

## 1. Layout

```
placement-platform/
├── docker-compose.yml        the stack
├── .env                      generated config + secrets for compose (you are not meant to hand-write it)
├── .env.example              annotated template
├── backend.local.env         same config for running the backend on your host (npm run dev)
├── ai-service.env            env for YOUR real AI service (only with the real-ai profile)
├── Makefile                  shortcuts (make up / logs / check ...)
├── scripts/init-env.sh       generates all secrets      scripts/check.sh   end-to-end health check
├── backend/                  the backend (this is the updated one with the per-topic seeds)
├── frontend/                 ← PUT YOUR FRONTEND HERE (needs package.json with a `build` script)
├── ai-service/               ← put your real AI service here (optional)
└── infra/                    judge0 config, frontend Dockerfile, AI mock
```

## 2. Prerequisites

* Docker Engine 24+ with **Compose v2.24+** (`docker compose version`).
* ~6 GB free RAM, ~8 GB disk (Judge0's image is large).
* Judge0's sandbox needs a Docker host with **cgroup v1** and `privileged` containers — read [Judge0](#7-judge0-read-this-once).

## 3. Launch

```bash
cp -r <your-frontend> ./frontend          # once (skip if frontend/package.json already exists)
./scripts/init-env.sh                     # once: writes .env + infra/judge0/judge0.conf with random secrets (idempotent)
docker compose up -d --build              # first run: ~5-10 min (builds + pulls Judge0)
./scripts/check.sh                        # when it settles: end-to-end verification
```
(`make up` and `make check` do the same.) A ready-made `.env` is included, so you can skip `init-env.sh`
the first time — but regenerate secrets before sharing this folder anywhere.

| What | URL |
|---|---|
| Frontend | http://localhost:3000 |
| Backend API / health | http://localhost:8080/api/v1 · http://localhost:8080/health |
| **Live logs of every service** | http://localhost:9999 (Dozzle) |
| Postgres (host-only) | `localhost:5432` — user/db in `.env` |
| Judge0 (host-only) | http://localhost:2358/about |
| AI mock (host-only) | http://localhost:9000/health |

Create your first admin (public registration only makes students):
```bash
make admin email=you@example.com pass='Str0ng!Passw0rd' name='Your Name'
```

## 4. Monitoring: logs and health of every service

**Everything in one browser tab:** http://localhost:9999 → pick any/all containers, search, filter by level.

**Terminal:**
```bash
docker compose ps -a                              # state + health of every service (migrate should be "Exited (0)")
docker compose logs -f --tail=100 -t              # ALL services, interleaved, timestamped
docker compose logs -f backend                    # one service (backend | postgres | migrate | frontend | ai-service-mock |
docker compose logs -f judge0-server judge0-workers   #   ai-service | judge0-server | judge0-workers | judge0-db | judge0-redis)
docker compose logs --since 10m backend           # recent window
docker compose logs migrate                       # what the migrations/seed did on startup
make errors                                       # error/fatal/exception lines from the last hour, all services
docker stats                                      # live CPU/memory per container
./scripts/check.sh                                # PASS/FAIL for containers, DB rows, auth, CORS, AI, every Judge0 language, frontend
```
Logs are rotated (20 MB × 5 per container), so they never fill the disk. The backend logs JSON (pino): pipe it
through `| jq -r '"\(.time) \(.level) \(.msg)"'` if you want it readable.

**What to look for**

| Service | Healthy log looks like | Red flags |
|---|---|---|
| migrate | `Applied migration` / `Seeding complete`, then exits 0 | `Migration command failed`, `seed: unknown company` |
| backend | JSON lines per request; `/health` is not logged | `AI service call failed`, `Judge0 submission failed`, `ECONNREFUSED`, `password authentication failed` |
| judge0-workers | lines showing jobs being picked up and finished | `isolate`/`cgroup` errors → see Judge0 section |
| ai-service(-mock) | one line per call: `{"msg":"ok","path":"/resume/analyze"}` | `rejected: bad or missing X-Internal-Api-Key` |
| frontend | nginx access lines | 404s on `/assets/...` (wrong build output) |

## 5. How everything is wired (.env → backend)

| `.env` variable | Becomes in the backend | Why |
|---|---|---|
| `POSTGRES_USER/PASSWORD/DB` | `DATABASE_URL=postgres://…@postgres:5432/…` | backend + migrate reach the DB by service name |
| `BETTER_AUTH_SECRET` | `BETTER_AUTH_SECRET` | signs sessions; must stay stable or users are logged out |
| `PUBLIC_API_ORIGIN` | `BETTER_AUTH_URL` | the URL the **browser** uses for the API |
| `CORS_ORIGINS` | `CORS_ORIGINS` (CORS **and** better-auth trusted origins) | must contain the exact frontend origin, e.g. `http://localhost:3000` |
| `AI_SERVICE_API_KEY` | `AI_SERVICE_API_KEY` (sent as `X-Internal-Api-Key`) | shared secret backend ⇄ AI service |
| *(fixed)* | `AI_SERVICE_BASE_URL=http://ai-service:9000` | mock and real service both answer to the alias `ai-service` |
| `JUDGE0_BASE_URL` (default `http://judge0-server:2358`) | `JUDGE0_BASE_URL` | key/host left empty → no RapidAPI headers sent |
| `FRONTEND_API_URL` | build arg → `VITE_API_URL` / `VITE_API_BASE_URL` / `REACT_APP_API_URL` / `NEXT_PUBLIC_API_URL` | **baked in at build time** — rebuild the frontend after changing it |
| `COMPOSE_PROFILES` | — | picks `frontend`, `mock-ai` **or** `real-ai`, `monitor` |

Running the backend on your host instead (`npm run dev`)? `backend.local.env` has the same values with `localhost` URLs:
```bash
docker compose up -d postgres judge0-server judge0-workers judge0-db judge0-redis ai-service-mock
cd backend && cp ../backend.local.env .env && npm install && npm run migrate && npm run seed && npm run dev
```

## 6. Frontend assumptions (I could not see your frontend code)

The bundled `infra/frontend/Dockerfile` builds a **static SPA** (Vite, CRA, …): it detects npm/yarn/pnpm from your lockfile,
runs `npm run build`, takes `dist/`, `build/` or `out/`, and serves it with nginx (SPA fallback included).

* API URL variable not one of the four names? Edit `frontend.build.args` in `docker-compose.yml` and the `ARG/ENV` block in the Dockerfile.
* Frontend on another port/host? Put that exact origin in `CORS_ORIGINS` (login will fail with a CORS error otherwise).
* Next.js with server rendering? Replace the Dockerfile via `FRONTEND_DOCKERFILE=...` with a `next build` + `next start` image and map port 3000.
* Prefer hot reload? Drop the `frontend` profile and run `npm run dev` locally (Vite on :5173 is already in `CORS_ORIGINS`).
* Auth shape: `GET /api/v1/auth/me` returns `{ "user": { "id", "email", "full_name", "role", "college", "graduation_year" } }`;
  register/login return `{ user, token }` and every authenticated call sends `Authorization: Bearer <token>`.

## 7. Judge0 (read this once)

Judge0 sandboxes untrusted code with `isolate`, which needs `privileged: true` and, for the 1.13.x image used here, **cgroup v1**.

* **Run `./scripts/check.sh` first.** Section 5 submits a real program in Python, JS, Java, C++ and SQLite with the same limits the seeded
  questions use. All five `PASS` ⇒ you are done.
* Failures mentioning `cgroup` / `isolate` / "Internal Error" ⇒ your Docker host uses cgroup v2 (Ubuntu 22.04+, recent Docker Desktop/WSL2).
  Fixes: boot the kernel with `systemd.unified_cgroup_hierarchy=0` (Linux VM/server), **or** use hosted Judge0 — set in `.env`:
  `JUDGE0_BASE_URL=https://judge0-ce.p.rapidapi.com`, `JUDGE0_API_KEY=<key>`, `JUDGE0_API_HOST=judge0-ce.p.rapidapi.com`, then `docker compose up -d backend`.
  (You can then stop the four `judge0-*` services.)
* Apple Silicon: the image is amd64-only and runs under emulation (slow, may not work) — prefer hosted Judge0 there.
* Only Java failing? Seeds allow 128 MB per run; raise `memory_limit` (and `MAX_MEMORY_LIMIT` in `infra/judge0/judge0.conf`) if the JVM is killed.
* Judge0 is bound to `127.0.0.1` on purpose: it runs arbitrary code and has no auth here. Never publish port 2358.

## 8. AI service: mock vs real

Default is the **mock** (`COMPOSE_PROFILES=…,mock-ai`): deterministic, implements all six endpoints the backend calls and checks the
`X-Internal-Api-Key` header — enough to exercise resume analysis, interview scoring, roadmaps, weak-topic analysis, readiness and company intel end-to-end.
To use your FastAPI service: put it in `ai-service/` (needs a `Dockerfile`, listening on 9000 — or set `AI_SERVICE_PORT`), put provider keys in
`ai-service.env`, and change `mock-ai` → `real-ai` in `COMPOSE_PROFILES`. Then `docker compose up -d --build`. Run exactly one of the two.

## 9. Everyday operations

| Task | Command |
|---|---|
| Start / stop (data kept) | `docker compose up -d` / `docker compose down` |
| Restart one service | `docker compose restart backend` |
| Rebuild after code changes | `docker compose up -d --build backend` (or `frontend`) |
| Re-run migrations + seed | `make migrate` (also automatic on every `up`; seeds update questions in place, never duplicate) |
| SQL shell | `make psql` |
| Backup | `make backup` → `backup-<timestamp>.sql` |
| Wipe everything (DBs, uploads) | `make clean` |
| Changed `.env` | `docker compose up -d` (recreates only affected services) |

## 10. Troubleshooting

| Symptom | Cause / fix |
|---|---|
| `required variable POSTGRES_USER is missing` | no `.env` → `./scripts/init-env.sh` |
| backend restarts / `password authentication failed` | `.env` password changed after the DB volume was created → restore the old `.env` or `make clean` |
| Frontend shows CORS error on login | its origin is not in `CORS_ORIGINS` → fix `.env`, `docker compose up -d backend` |
| Frontend calls `localhost:5173`/wrong API | API URL is baked at build time → fix `FRONTEND_API_URL`, `docker compose up -d --build frontend` |
| `frontend` build: "no dist/, build/ or out/" | your build outputs elsewhere → adapt `infra/frontend/Dockerfile` |
| `port is already allocated` | change the port in `.env` (e.g. `POSTGRES_PORT=5433`) |
| Code submissions return 502 / `Judge0 submission failed` | `check.sh` section 5; see [Judge0](#7-judge0-read-this-once) |
| AI features return 502 | `check.sh` section 4: `401` = key mismatch between backend and AI service, `ERR` = service not running (profile?) |
| `migrate` shows `Exited (1)` | `docker compose logs migrate`; backend will not start until it succeeds |

## 11. Before this leaves your laptop

Rotate every secret (`./scripts/init-env.sh --force` on a fresh volume), serve over HTTPS and set `PUBLIC_API_ORIGIN`/`CORS_ORIGINS` to the real https origins,
drop the `monitor` profile (Dozzle reads the Docker socket), keep Postgres and Judge0 off public interfaces, and put a reverse proxy in front.

## What was verified when this was assembled

Verified in a sandbox **without Docker**: `docker compose config` validates for every profile combination; the compiled backend, run in production mode with
exactly the environment the container receives, starts, registers/authenticates users over plain HTTP, serves the 16 topics and enforces CORS; the compiled
migrate+seed job (what the `migrate` service runs) applies all migrations and 372 questions on an empty database and is a no-op on re-run; the AI mock passes all
six calls through the backend's real client and rejects a wrong key; `check.sh` passes the backend section and correctly fails when Judge0 is absent.
**Not verifiable there:** image builds, the Judge0 containers (hardware/cgroup dependent), your frontend build and your real AI service. First `docker compose up` on your machine is the real test — `./scripts/check.sh` tells you exactly which piece, if any, needs attention.
