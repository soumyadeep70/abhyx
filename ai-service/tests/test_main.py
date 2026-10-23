from __future__ import annotations

from typing import Any

import pytest

from mock_ai_service import __main__ as entrypoint


def test_main_starts_uvicorn_with_env_port_and_host(
    monkeypatch: pytest.MonkeyPatch, capsys: pytest.CaptureFixture[str]
) -> None:
    captured: dict[str, Any] = {}
    monkeypatch.setattr("uvicorn.run", lambda app, **kw: captured.update(app=app, **kw))
    monkeypatch.setenv("PORT", "9555")
    monkeypatch.setenv("HOST", "127.0.0.1")

    entrypoint.main()

    assert (captured["host"], captured["port"]) == ("127.0.0.1", 9555)
    assert captured["app"].title == "mock-ai-service"
    assert "listening on http://localhost:9555" in capsys.readouterr().out


def test_main_defaults_to_port_9000_on_all_interfaces(monkeypatch: pytest.MonkeyPatch) -> None:
    captured: dict[str, Any] = {}
    monkeypatch.setattr("uvicorn.run", lambda app, **kw: captured.update(kw))
    monkeypatch.delenv("PORT", raising=False)
    monkeypatch.delenv("HOST", raising=False)

    entrypoint.main()

    assert (captured["host"], captured["port"]) == ("0.0.0.0", 9000)
