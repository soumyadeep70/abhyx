"""Differential tests against the original Node implementation.

``golden/cases.json`` was recorded by running the original ``server.js`` and
replaying each request over HTTP. Every case here must produce the same
status code and JSON body from the Python service.

Deliberate deviations (not recorded, covered in test_api.py instead):
  * a JSON ``null`` body / ``null`` list items crash the Node original (500);
    here they are tolerated.
  * ``weeks_available`` is capped at MAX_WEEKS instead of allocating unbounded memory.
"""

from __future__ import annotations

import json
from pathlib import Path
from typing import Any

import pytest
from fastapi.testclient import TestClient

GOLDEN = json.loads((Path(__file__).parent / "golden" / "cases.json").read_text(encoding="utf-8"))
CASES: list[dict[str, Any]] = GOLDEN["cases"]


@pytest.mark.parametrize("case", CASES, ids=[c["name"] for c in CASES])
def test_matches_original_node_service(client: TestClient, case: dict[str, Any]) -> None:
    kwargs: dict[str, Any] = {}
    if case["method"] != "GET":
        kwargs["content"] = case["raw_body"].encode("utf-8")
        kwargs["headers"] = {"Content-Type": "application/json"}

    response = client.request(case["method"], case["path"], **kwargs)

    assert response.status_code == case["status"]
    assert response.json() == case["response"]
