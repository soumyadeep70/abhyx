from __future__ import annotations

from collections.abc import Callable, Iterator

import pytest
from fastapi.testclient import TestClient

from mock_ai_service import create_app

ClientFactory = Callable[..., TestClient]


@pytest.fixture(autouse=True)
def _clean_env(monkeypatch: pytest.MonkeyPatch) -> None:
    """Make tests independent of the developer's shell environment."""
    for name in ("MOCK_AI_API_KEY", "MOCK_AI_LATENCY_MS", "MOCK_AI_FAILURE_RATE"):
        monkeypatch.delenv(name, raising=False)


@pytest.fixture
def client() -> Iterator[TestClient]:
    with TestClient(create_app()) as test_client:
        yield test_client


@pytest.fixture
def make_client() -> Iterator[ClientFactory]:
    """Build differently configured apps, like ``createServer({...})`` in the original."""
    opened: list[TestClient] = []

    def factory(**options: object) -> TestClient:
        test_client = TestClient(create_app(**options), raise_server_exceptions=False)  # type: ignore[arg-type]
        test_client.__enter__()
        opened.append(test_client)
        return test_client

    yield factory
    for test_client in opened:
        test_client.__exit__(None, None, None)
