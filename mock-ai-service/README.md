# mock-ai-service

A drop-in stand-in for the real FastAPI AI microservice described in the
backend's HLD, used for local development and the backend's test suite.

It implements every endpoint `src/services/aiServiceClient.ts` calls, with
the same response shapes, using **zero npm dependencies** (just Node's
built-in `http` module) -- run it with nothing but `node`:

```bash
node mock-ai-service/server.js
# or, from backend/:
npm run mock-ai
```

Then point the backend at it (already the default in `.env.example`):

```
AI_SERVICE_BASE_URL=http://localhost:9000
```

## Endpoints

| Method | Path                       | Mirrors                              |
|--------|----------------------------|---------------------------------------|
| POST   | `/resume/analyze`          | `aiClient.analyzeResume`             |
| POST   | `/interview/score`         | `aiClient.scoreInterviewAnswer`      |
| POST   | `/roadmap/generate`        | `aiClient.generateRoadmap`           |
| POST   | `/analytics/weak-topics`   | `aiClient.analyzeWeakTopics`         |
| POST   | `/readiness/insights`      | `aiClient.getReadinessInsights`      |
| POST   | `/company/intelligence`    | `aiClient.getCompanyIntelligence`    |
| GET    | `/health`                  | liveness check                       |

Responses are deterministic functions of the request body wherever that's
meaningful (e.g. a resume's `ats_score` reacts to its length and which
known skill keywords appear in it), so tests asserting on response fields
aren't asserting on randomness.

## Simulating failure modes

`aiServiceClient.ts` wraps any non-2xx response or timeout from the AI
service as `ApiError.badGateway`. To exercise that path in tests without
touching backend code, start the mock with:

```bash
MOCK_AI_FAILURE_RATE=1 node mock-ai-service/server.js   # every call 500s
MOCK_AI_LATENCY_MS=25000 node mock-ai-service/server.js # trips AI_SERVICE_TIMEOUT_MS
MOCK_AI_API_KEY=secret node mock-ai-service/server.js   # 401s unless the
                                                          # backend sends a
                                                          # matching
                                                          # X-Internal-Api-Key
```

## Docker

```bash
docker build -t mock-ai-service ./mock-ai-service
docker run -p 9000:9000 mock-ai-service
```

Also wired into the repo's root `docker-compose.yml` as the `mock-ai-service`
service, which `backend` depends on there.
