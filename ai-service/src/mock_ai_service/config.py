"""Runtime configuration (environment variables, overridable per app)."""

from __future__ import annotations

import math
import os
from dataclasses import dataclass


def _env_float(name: str) -> float:
    raw = os.environ.get(name, "")
    try:
        value = float(raw) if raw else 0.0
    except ValueError:
        return 0.0
    return value if math.isfinite(value) else 0.0


@dataclass(frozen=True, slots=True)
class Settings:
    """Behaviour switches for the mock service.

    api_key       if non-empty, requests must send a matching
                  ``X-Internal-Api-Key`` header (``MOCK_AI_API_KEY``)
    latency_ms    artificial delay before responding (``MOCK_AI_LATENCY_MS``)
    failure_rate  0..1 chance of a random 500 (``MOCK_AI_FAILURE_RATE``)
    """

    api_key: str = ""
    latency_ms: float = 0.0
    failure_rate: float = 0.0

    @classmethod
    def resolve(
        cls,
        *,
        api_key: str | None = None,
        latency_ms: float | None = None,
        failure_rate: float | None = None,
    ) -> Settings:
        """Explicit values win (even ``""`` / ``0``); ``None`` falls back to the
        environment -- mirroring the original's ``options.x ?? process.env.X``."""
        return cls(
            api_key=api_key if api_key is not None else os.environ.get("MOCK_AI_API_KEY", ""),
            latency_ms=latency_ms if latency_ms is not None else _env_float("MOCK_AI_LATENCY_MS"),
            failure_rate=(
                failure_rate if failure_rate is not None else _env_float("MOCK_AI_FAILURE_RATE")
            ),
        )
