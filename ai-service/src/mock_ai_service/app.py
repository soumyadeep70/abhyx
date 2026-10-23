"""FastAPI application factory.

Request pipeline (identical order to the Node original):

1. ``GET /health``                      -> always 200 (no auth, no failures)
2. ``X-Internal-Api-Key`` check         -> 401 when an API key is configured
3. random failure injection             -> 500 with probability ``failure_rate``
4. routing                              -> 404 for any unknown method/path
5. body read (<= 5 MiB) and JSON parse  -> 413 / 400
6. artificial latency
7. handler                              -> 200
"""

from __future__ import annotations

import asyncio
import hmac
import json
import logging
import random
from collections.abc import Awaitable, Callable
from typing import Annotated, Any

from fastapi import Depends, FastAPI, Request, Response
from fastapi.responses import JSONResponse
from starlette.exceptions import HTTPException as StarletteHTTPException

from . import handlers
from .config import Settings
from .schemas import (
    CompanyIntelligenceResult,
    HealthResponse,
    InterviewScoreResult,
    ReadinessInsightsResult,
    ResumeAnalysisResult,
    RoadmapResult,
    WeakTopicsResult,
)

logger = logging.getLogger("mock_ai_service")

SERVICE_NAME = "mock-ai-service"
API_KEY_HEADER = "x-internal-api-key"
MAX_BODY_BYTES = 5 * 1024 * 1024


class MockHTTPError(Exception):
    """An error that is rendered as ``{"error": message}`` with ``status_code``."""

    def __init__(self, status_code: int, message: str) -> None:
        super().__init__(message)
        self.status_code = status_code
        self.message = message


def _error(status_code: int, message: str) -> JSONResponse:
    return JSONResponse({"error": message}, status_code=status_code)


def _reject_constant(name: str) -> Any:
    # Python accepts NaN / Infinity; JSON.parse (and the original) does not.
    raise ValueError(f"Invalid JSON constant: {name}")


def _parse_float(text: str) -> int | float:
    # JS has one number type: ``2.0`` parses to ``2`` and is echoed back as ``2``.
    value = float(text)
    return int(value) if value.is_integer() and abs(value) < 1e21 else value


def _pathname(request: Request) -> str:
    raw = request.scope.get("raw_path")
    return raw.decode("latin-1") if isinstance(raw, bytes) else request.url.path


async def parsed_body(request: Request) -> dict[str, Any]:
    """Read and parse the JSON body, then apply the configured latency.

    Like the original, the body is parsed regardless of ``Content-Type`` and
    an empty body is ``{}``. Valid JSON that is not an object is treated as
    ``{}`` too (handlers only ever look fields up by name).
    """
    chunks: list[bytes] = []
    size = 0
    async for chunk in request.stream():
        size += len(chunk)
        if size > MAX_BODY_BYTES:
            raise MockHTTPError(413, "Payload too large")
        chunks.append(chunk)

    raw = b"".join(chunks).decode("utf-8", errors="replace")
    body: dict[str, Any] = {}
    if raw:
        try:
            parsed = json.loads(raw, parse_constant=_reject_constant, parse_float=_parse_float)
        except (ValueError, RecursionError):
            raise MockHTTPError(400, "Invalid JSON body") from None
        if isinstance(parsed, dict):
            body = parsed

    settings: Settings = request.app.state.settings
    if settings.latency_ms > 0:
        await asyncio.sleep(settings.latency_ms / 1000)
    return body


Body = Annotated[dict[str, Any], Depends(parsed_body)]


def create_app(
    *,
    api_key: str | None = None,
    latency_ms: float | None = None,
    failure_rate: float | None = None,
) -> FastAPI:
    """Build an independent app instance.

    Arguments left as ``None`` fall back to the ``MOCK_AI_*`` environment
    variables, so tests can run several differently configured instances in
    one process.
    """
    settings = Settings.resolve(api_key=api_key, latency_ms=latency_ms, failure_rate=failure_rate)

    app = FastAPI(
        title=SERVICE_NAME,
        description="Deterministic mock of the FastAPI AI microservice.",
        # Parity with the original: no extra endpoints, no trailing-slash redirects.
        docs_url=None,
        redoc_url=None,
        openapi_url=None,
        redirect_slashes=False,
    )
    app.state.settings = settings

    # ---- cross-cutting behaviour ------------------------------------------

    @app.middleware("http")
    async def gate(
        request: Request, call_next: Callable[[Request], Awaitable[Response]]
    ) -> Response:
        if request.method == "GET" and request.url.path == "/health":
            return await call_next(request)

        if settings.api_key:
            # Header values are decoded as latin-1 by the ASGI server; re-encoding
            # recovers the raw bytes the client sent, compared in constant time.
            supplied = request.headers.get(API_KEY_HEADER, "").encode("latin-1")
            if not hmac.compare_digest(supplied, settings.api_key.encode()):
                return _error(401, "Invalid or missing X-Internal-Api-Key")

        if settings.failure_rate > 0 and random.random() < settings.failure_rate:  # noqa: S311 - chaos, not crypto
            return _error(500, "Mock AI service: simulated failure (MOCK_AI_FAILURE_RATE)")

        return await call_next(request)

    @app.exception_handler(MockHTTPError)
    async def mock_http_error(_: Request, exc: MockHTTPError) -> JSONResponse:
        return _error(exc.status_code, exc.message)

    @app.exception_handler(StarletteHTTPException)
    async def http_error(request: Request, exc: StarletteHTTPException) -> JSONResponse:
        if exc.status_code in (404, 405):  # the original has a single "not found"
            return _error(404, f"No mock handler for {request.method} {_pathname(request)}")
        return _error(exc.status_code, str(exc.detail))

    @app.exception_handler(Exception)
    async def unexpected_error(_: Request, exc: Exception) -> JSONResponse:
        logger.exception("Unhandled error", exc_info=exc)
        return _error(500, "Internal mock server error")

    # ---- endpoints --------------------------------------------------------

    @app.get("/health", response_model=HealthResponse)
    async def health() -> HealthResponse:
        return HealthResponse(status="ok", service=SERVICE_NAME)

    @app.post("/resume/analyze", response_model=ResumeAnalysisResult)
    async def resume_analyze(body: Body) -> ResumeAnalysisResult:
        return handlers.analyze_resume(body)

    @app.post("/interview/score", response_model=InterviewScoreResult)
    async def interview_score(body: Body) -> InterviewScoreResult:
        return handlers.score_interview_answer(body)

    @app.post("/roadmap/generate", response_model=RoadmapResult)
    async def roadmap_generate(body: Body) -> RoadmapResult:
        return handlers.generate_roadmap(body)

    @app.post("/analytics/weak-topics", response_model=WeakTopicsResult)
    async def weak_topics(body: Body) -> WeakTopicsResult:
        return handlers.analyze_weak_topics(body)

    @app.post("/readiness/insights", response_model=ReadinessInsightsResult)
    async def readiness_insights(body: Body) -> ReadinessInsightsResult:
        return handlers.get_readiness_insights(body)

    @app.post("/company/intelligence", response_model=CompanyIntelligenceResult)
    async def company_intelligence(body: Body) -> CompanyIntelligenceResult:
        return handlers.get_company_intelligence(body)

    return app
