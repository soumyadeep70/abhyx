"""Auth / latency / failure simulation and configuration."""

from __future__ import annotations

import random
import time

import pytest

from mock_ai_service import Settings, create_app
from mock_ai_service.app import API_KEY_HEADER

from .conftest import ClientFactory

# ---- API key -----------------------------------------------------------------


def test_401_when_api_key_configured_and_header_missing_or_wrong(
    make_client: ClientFactory,
) -> None:
    client = make_client(api_key="secret-key")

    missing = client.post("/resume/analyze", content="{}")
    assert missing.status_code == 401
    assert missing.json() == {"error": "Invalid or missing X-Internal-Api-Key"}

    wrong = client.post("/resume/analyze", headers={"X-Internal-Api-Key": "wrong"}, content="{}")
    assert wrong.status_code == 401

    right = client.post(
        "/resume/analyze",
        headers={"X-Internal-Api-Key": "secret-key", "Content-Type": "application/json"},
        content="{}",
    )
    assert right.status_code == 200


def test_header_name_is_case_insensitive_and_value_is_case_sensitive(
    make_client: ClientFactory,
) -> None:
    client = make_client(api_key="Secret")
    assert (
        client.post("/company/intelligence", headers={API_KEY_HEADER.upper(): "Secret"}).status_code
        == 200
    )
    assert (
        client.post("/company/intelligence", headers={API_KEY_HEADER: "secret"}).status_code == 401
    )


def test_non_ascii_api_keys_work(make_client: ClientFactory) -> None:
    client = make_client(api_key="cl\u00e9-secr\u00e8te")
    name = API_KEY_HEADER.encode()
    ok = client.post("/company/intelligence", headers={name: "cl\u00e9-secr\u00e8te".encode()})
    assert ok.status_code == 200
    assert client.post("/company/intelligence", headers={name: b"cl\xc3\xa9"}).status_code == 401


def test_health_bypasses_auth_and_failure_injection(make_client: ClientFactory) -> None:
    client = make_client(api_key="secret-key", failure_rate=1)
    assert client.get("/health").status_code == 200


def test_auth_is_checked_before_routing(make_client: ClientFactory) -> None:
    client = make_client(api_key="secret-key")
    assert client.post("/not/a/route", content="{}").status_code == 401
    assert client.get("/resume/analyze").status_code == 401  # even wrong method
    assert client.post("/health", content="{}").status_code == 401  # only GET /health is exempt


def test_auth_is_checked_before_failure_injection(make_client: ClientFactory) -> None:
    client = make_client(api_key="k", failure_rate=1)
    assert client.post("/resume/analyze", content="{}").status_code == 401


def test_empty_api_key_disables_auth(make_client: ClientFactory) -> None:
    assert make_client(api_key="").post("/resume/analyze", content="{}").status_code == 200


# ---- failure injection -----------------------------------------------------


def test_always_fails_with_failure_rate_one(make_client: ClientFactory) -> None:
    client = make_client(failure_rate=1)
    for _ in range(20):
        response = client.post("/resume/analyze", content="{}")
        assert response.status_code == 500
        assert response.json() == {
            "error": "Mock AI service: simulated failure (MOCK_AI_FAILURE_RATE)"
        }


def test_failure_injection_hits_unknown_routes_before_404(make_client: ClientFactory) -> None:
    assert make_client(failure_rate=1).post("/nope", content="{}").status_code == 500


def test_never_fails_with_failure_rate_zero(make_client: ClientFactory) -> None:
    client = make_client(failure_rate=0)
    assert all(client.post("/resume/analyze", content="{}").status_code == 200 for _ in range(20))


def test_partial_failure_rate_uses_a_random_draw(
    make_client: ClientFactory, monkeypatch: pytest.MonkeyPatch
) -> None:
    client = make_client(failure_rate=0.5)
    draws = iter([0.49, 0.5, 0.99, 0.0])
    monkeypatch.setattr(random, "random", lambda: next(draws))
    statuses = [client.post("/company/intelligence", content="{}").status_code for _ in range(4)]
    assert statuses == [500, 200, 200, 500]  # fails iff draw < rate


# ---- latency ------------------------------------------------------------------


def test_respects_artificial_latency(make_client: ClientFactory) -> None:
    client = make_client(latency_ms=50)
    start = time.perf_counter()
    response = client.post("/resume/analyze", content="{}")
    elapsed_ms = (time.perf_counter() - start) * 1000
    assert response.status_code == 200
    assert elapsed_ms >= 45


def test_no_latency_by_default(make_client: ClientFactory) -> None:
    client = make_client()
    start = time.perf_counter()
    client.post("/resume/analyze", content="{}")
    assert (time.perf_counter() - start) < 0.5


def test_latency_is_applied_after_body_validation(make_client: ClientFactory) -> None:
    client = make_client(latency_ms=2000)
    start = time.perf_counter()
    assert client.post("/resume/analyze", content="{bad").status_code == 400
    assert client.post("/nope", content="{}").status_code == 404
    assert (time.perf_counter() - start) < 1.0  # errors short-circuit before the delay


def test_health_is_not_delayed(make_client: ClientFactory) -> None:
    client = make_client(latency_ms=2000)
    start = time.perf_counter()
    assert client.get("/health").status_code == 200
    assert (time.perf_counter() - start) < 1.0


# ---- configuration -------------------------------------------------------------


def test_settings_default_to_disabled() -> None:
    assert Settings.resolve() == Settings(api_key="", latency_ms=0.0, failure_rate=0.0)


def test_settings_read_environment(monkeypatch: pytest.MonkeyPatch) -> None:
    monkeypatch.setenv("MOCK_AI_API_KEY", "from-env")
    monkeypatch.setenv("MOCK_AI_LATENCY_MS", "25")
    monkeypatch.setenv("MOCK_AI_FAILURE_RATE", "0.25")
    assert Settings.resolve() == Settings(api_key="from-env", latency_ms=25.0, failure_rate=0.25)


def test_explicit_options_override_environment_even_when_falsy(
    monkeypatch: pytest.MonkeyPatch,
) -> None:
    monkeypatch.setenv("MOCK_AI_API_KEY", "from-env")
    monkeypatch.setenv("MOCK_AI_FAILURE_RATE", "1")
    settings = Settings.resolve(api_key="", failure_rate=0)
    assert settings.api_key == ""
    assert settings.failure_rate == 0


@pytest.mark.parametrize("bad", ["abc", "nan", "inf", "-inf", ""])
def test_invalid_numeric_environment_values_fall_back_to_zero(
    monkeypatch: pytest.MonkeyPatch, bad: str
) -> None:
    monkeypatch.setenv("MOCK_AI_LATENCY_MS", bad)
    monkeypatch.setenv("MOCK_AI_FAILURE_RATE", bad)
    settings = Settings.resolve()
    assert (settings.latency_ms, settings.failure_rate) == (0.0, 0.0)


def test_environment_configures_create_app_without_arguments(
    monkeypatch: pytest.MonkeyPatch,
) -> None:
    monkeypatch.setenv("MOCK_AI_API_KEY", "env-key")
    assert create_app().state.settings.api_key == "env-key"


def test_app_instances_are_independent() -> None:
    strict, open_ = create_app(api_key="a"), create_app(api_key="")
    assert strict.state.settings.api_key == "a"
    assert open_.state.settings.api_key == ""
