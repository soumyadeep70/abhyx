# mock-ai-service (Python)

```bash
pip install -e ".[dev]"
python -m mock_ai_service            # listens on :9000 (PORT / HOST to override)
# or: uvicorn --factory mock_ai_service:create_app --port 9000
```

Point the backend at it:

```
AI_SERVICE_BASE_URL=http://localhost:9000
```

## Endpoints

| Method | Path                     | Mirrors                           |
| ------ | ------------------------ | --------------------------------- |
| POST   | `/resume/analyze`        | `aiClient.analyzeResume`          |
| POST   | `/interview/score`       | `aiClient.scoreInterviewAnswer`   |
| POST   | `/roadmap/generate`      | `aiClient.generateRoadmap`        |
| POST   | `/analytics/weak-topics` | `aiClient.analyzeWeakTopics`      |
| POST   | `/readiness/insights`    | `aiClient.getReadinessInsights`   |
| POST   | `/company/intelligence`  | `aiClient.getCompanyIntelligence` |
| GET    | `/health`                | liveness check                    |

Responses are deterministic functions of the request body. Request bodies
are intentionally lenient (any JSON, missing fields fall back to defaults,
`Content-Type` is ignored), exactly like the original. Errors are always
`{"error": "<message>"}`: `401` bad key, `404` unknown route **or wrong
method**, `400` invalid JSON, `413` body > 5 MiB, `500` simulated/unexpected.

## Simulating failure modes

| Env var                | Effect                                                             |
| ---------------------- | ------------------------------------------------------------------ |
| `MOCK_AI_FAILURE_RATE` | `0..1` chance of a random 500 (`1` = every call fails)             |
| `MOCK_AI_LATENCY_MS`   | artificial delay before responding (trips `AI_SERVICE_TIMEOUT_MS`) |
| `MOCK_AI_API_KEY`      | require a matching `X-Internal-Api-Key` header, else 401           |

`GET /health` is exempt from all three. Pipeline order: health -> auth ->
failure injection -> routing -> body parsing -> latency -> handler.

## Design

```
src/mock_ai_service/
  app.py        create_app() factory: middleware (auth/failure), error handlers, routes
  handlers.py   pure functions, one per endpoint (no I/O, no framework)
  schemas.py    pydantic response models (the shapes aiServiceClient.ts expects)
  config.py     frozen Settings dataclass; explicit options override env vars
  js_compat.py  JS semantics the original relied on (Number(), String(), Math.round, UTF-16 length, hashCode)
```

`create_app(api_key=..., latency_ms=..., failure_rate=...)` builds an
independent app, so tests can run several differently configured instances in
one process (the equivalent of `createServer({...})`).

## Tests & quality gates

```bash
pytest                    # 400+ tests, enforces >=95% coverage (currently 100% line+branch)
ruff check . && ruff format --check .
mypy src tests            # strict
```

- `test_golden_parity.py` replays **168 requests recorded from the original
  Node server** (including edge cases: unicode/emoji lengths, numeric-string
  coercion, `Object.entries` ordering, malformed JSON, wrong methods...) and
  asserts identical status + JSON.
- `test_handlers.py`: pure unit tests per endpoint (thresholds, bounds, defaults).
- `test_api.py`: every endpoint's contract, the original vitest suite ported 1:1, plus 413/400/404 handling.
- `test_simulation.py`: auth, latency, failure injection, precedence order, env config.
- `test_js_compat.py`: helper semantics, with expected values taken from Node.

## Intentional deviations from the Node original

1. A JSON `null` body, or `null` entries in `topic_performance`, crash the
   Node server with a 500 (`TypeError`); here they are tolerated.
2. `weeks_available` is capped at 104 phases (Node would try to build
   `weeks_available` phases -- `1e9` exhausts memory, `Infinity` never returns).
3. Unexpected errors return a generic `Internal mock server error` and are
   logged, rather than leaking the exception message.
4. The API key is compared in constant time.

## Docker

```bash
docker build -t mock-ai-service .
docker run -p 9000:9000 mock-ai-service
```
