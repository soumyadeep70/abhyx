"""HTTP-level tests: every endpoint's contract and the request pipeline.

The first block mirrors the original vitest suite one-to-one; the rest covers
behaviour the original left untested (413, content-type independence, strict
routing, response format).
"""

from __future__ import annotations

import asyncio
from collections.abc import Awaitable, Callable
from typing import Any, cast

import pytest
from fastapi.testclient import TestClient
from starlette.exceptions import HTTPException as StarletteHTTPException
from starlette.requests import Request
from starlette.responses import Response

from mock_ai_service import create_app
from mock_ai_service.app import MAX_BODY_BYTES
from mock_ai_service.handlers import MAX_WEEKS

# ---- parity with the original vitest suite ---------------------------------


def test_health_returns_ok(client: TestClient) -> None:
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json() == {"status": "ok", "service": "mock-ai-service"}


def test_resume_analyze_returns_result_shape_and_reacts_to_keywords(client: TestClient) -> None:
    response = client.post(
        "/resume/analyze",
        json={"resume_text": "Experienced in javascript, react, node, docker, git and sql."},
    )
    body = response.json()
    assert response.status_code == 200
    assert set(body) == {"ats_score", "skills_present", "skills_missing", "keyword_gaps", "summary"}
    assert isinstance(body["ats_score"], int)
    assert {"javascript", "react", "node"} <= set(body["skills_present"])


def test_resume_analyze_scores_keyword_rich_resume_higher_than_empty(client: TestClient) -> None:
    rich_text = (
        "javascript typescript react node express sql postgresql docker kubernetes aws git rest "
        "graphql testing ci cd " + "padding " * 200
    )
    rich = client.post("/resume/analyze", json={"resume_text": rich_text}).json()
    empty = client.post("/resume/analyze", json={"resume_text": ""}).json()
    assert rich["ats_score"] > empty["ats_score"]


def test_interview_score_returns_result_shape(client: TestClient) -> None:
    response = client.post(
        "/interview/score",
        json={
            "question": "Explain closures",
            "answer": "A closure is a function bundled with its lexical scope.",
            "round_type": "technical",
        },
    )
    body = response.json()
    assert response.status_code == 200
    assert body["hr_readiness"] is None
    assert set(body) == {
        "technical_accuracy",
        "communication_clarity",
        "problem_solving_approach",
        "depth_of_knowledge",
        "hr_readiness",
        "feedback",
        "follow_up_question",
    }
    assert all(isinstance(body[k], int) for k in list(body)[:4])


def test_interview_score_sets_hr_readiness_for_hr_round(client: TestClient) -> None:
    body = client.post(
        "/interview/score",
        json={"question": "Tell me about yourself", "answer": "I am ...", "round_type": "hr"},
    ).json()
    assert isinstance(body["hr_readiness"], int)


def test_roadmap_generate_splits_weak_topics_across_weeks(client: TestClient) -> None:
    body = client.post(
        "/roadmap/generate",
        json={"weak_topics": ["DP", "Graphs", "Trees", "Greedy"], "weeks_available": 2},
    ).json()
    assert len(body["phases"]) == 2
    assert body["phases"][0] == {
        "phase_number": 1,
        "title": "Focus: DP, Graphs",
        "topics": ["DP", "Graphs"],
        "estimated_days": 7,
        "resources": ["Mock resource list for DP"],
    }


def test_weak_topics_buckets_by_accuracy(client: TestClient) -> None:
    body = client.post(
        "/analytics/weak-topics",
        json={
            "topic_performance": [
                {"topic": "Arrays", "accuracy": 0.9},
                {"topic": "Graphs", "accuracy": 0.3},
                {"topic": "Strings", "accuracy": 0.6},
            ]
        },
    ).json()
    assert body["strong"] == ["Arrays"]
    assert body["weak"] == ["Graphs"]
    assert body["improving"] == ["Strings"]
    assert body["error_breakdown"]["conceptual"] == 1


def test_readiness_insights_names_strengths_and_risks(client: TestClient) -> None:
    body = client.post(
        "/readiness/insights",
        json={
            "company": "TCS",
            "tier": "Ninja",
            "score": 75,
            "probability": 0.6,
            "breakdown": {"aptitude": 80, "coding": 40},
        },
    ).json()
    assert "aptitude" in body["strengths"]
    assert "coding" in body["risks"]
    assert "TCS" in body["headline"]


def test_company_intelligence_returns_result_shape(client: TestClient) -> None:
    body = client.post("/company/intelligence", json={"company": "Infosys"}).json()
    assert "Infosys" in body["recent_patterns"][0]
    assert len(body["commonly_asked_topics"]) > 0
    assert len(body["sources"]) > 0
    assert set(body) == {"recent_patterns", "commonly_asked_topics", "interview_tips", "sources"}


def test_unknown_route_returns_404(client: TestClient) -> None:
    response = client.post("/not/a/real/route", content="{}")
    assert response.status_code == 404
    assert response.json() == {"error": "No mock handler for POST /not/a/real/route"}


def test_invalid_json_returns_400(client: TestClient) -> None:
    response = client.post(
        "/resume/analyze", content="{not valid json", headers={"Content-Type": "application/json"}
    )
    assert response.status_code == 400
    assert response.json() == {"error": "Invalid JSON body"}


# ---- beyond the original suite ----------------------------------------------

POST_ENDPOINTS = [
    "/resume/analyze",
    "/interview/score",
    "/roadmap/generate",
    "/analytics/weak-topics",
    "/readiness/insights",
    "/company/intelligence",
]


@pytest.mark.parametrize("path", POST_ENDPOINTS)
def test_every_endpoint_accepts_an_empty_body_and_returns_json(
    client: TestClient, path: str
) -> None:
    response = client.post(path)
    assert response.status_code == 200
    assert response.headers["content-type"] == "application/json"
    assert isinstance(response.json(), dict)


@pytest.mark.parametrize("path", POST_ENDPOINTS)
def test_every_endpoint_is_deterministic(client: TestClient, path: str) -> None:
    payload: dict[str, Any] = {
        "resume_text": "python sql",
        "question": "q",
        "answer": "a" * 50,
        "round_type": "hr",
        "weak_topics": ["a", "b"],
        "topic_performance": [{"topic": "x", "accuracy": 0.2}],
        "score": 61,
        "breakdown": {"a": 90},
        "company": "Acme",
    }
    assert client.post(path, json=payload).json() == client.post(path, json=payload).json()


@pytest.mark.parametrize("path", POST_ENDPOINTS)
def test_body_is_parsed_regardless_of_content_type(client: TestClient, path: str) -> None:
    response = client.post(
        path, content='{"company": "Acme"}', headers={"Content-Type": "text/plain"}
    )
    assert response.status_code == 200


@pytest.mark.parametrize("path", POST_ENDPOINTS)
@pytest.mark.parametrize("method", ["GET", "PUT", "PATCH", "DELETE"])
def test_wrong_method_is_reported_as_404_not_405(
    client: TestClient, path: str, method: str
) -> None:
    response = client.request(method, path)
    assert response.status_code == 404
    assert response.json() == {"error": f"No mock handler for {method} {path}"}


def test_health_only_supports_get(client: TestClient) -> None:
    assert client.post("/health", content="{}").status_code == 404
    assert client.head("/health").status_code == 404


def test_trailing_slash_is_not_redirected(client: TestClient) -> None:
    response = client.post("/resume/analyze/", content="{}", follow_redirects=False)
    assert response.status_code == 404


def test_routes_are_case_sensitive(client: TestClient) -> None:
    assert client.post("/Resume/Analyze", content="{}").status_code == 404


def test_framework_docs_endpoints_are_not_exposed(client: TestClient) -> None:
    for path in ("/docs", "/redoc", "/openapi.json"):
        assert client.get(path).status_code == 404


def test_query_string_is_ignored_for_routing(client: TestClient) -> None:
    assert client.get("/health?verbose=1").status_code == 200
    assert client.post("/company/intelligence?x=1", json={"company": "Q"}).status_code == 200


@pytest.mark.parametrize(
    "raw",
    [b"   ", b'{"a": 1,}', b"{'a': 1}", b'{"a": NaN}', b'{"a": Infinity}', b'{"a": -Infinity}',
     b'\xef\xbb\xbf{"a": 1}', b"[", b"nul"],
)  # fmt: skip
def test_malformed_json_variants_return_400(client: TestClient, raw: bytes) -> None:
    response = client.post("/resume/analyze", content=raw)
    assert response.status_code == 400
    assert response.json() == {"error": "Invalid JSON body"}


def test_deeply_nested_json_is_a_400_not_a_crash(client: TestClient) -> None:
    response = client.post("/resume/analyze", content=b"[" * 100_000 + b"]" * 100_000)
    assert response.status_code == 400


@pytest.mark.parametrize("raw", [b"[]", b'"text"', b"42", b"true", b"null"])
def test_valid_json_that_is_not_an_object_is_treated_as_empty(
    client: TestClient, raw: bytes
) -> None:
    # (null deliberately deviates: the Node original crashes with a 500 here)
    response = client.post("/company/intelligence", content=raw)
    assert response.status_code == 200
    assert "this company" in response.json()["recent_patterns"][0]


def test_oversized_body_returns_413(client: TestClient) -> None:
    response = client.post("/resume/analyze", content=b" " * (MAX_BODY_BYTES + 1))
    assert response.status_code == 413
    assert response.json() == {"error": "Payload too large"}


def test_body_at_the_limit_is_accepted(client: TestClient) -> None:
    padding = " " * (MAX_BODY_BYTES - len(b"{}"))
    response = client.post("/company/intelligence", content=b"{}" + padding.encode())
    assert response.status_code == 200


def test_oversized_body_to_unknown_route_is_404_because_routing_comes_first(
    client: TestClient,
) -> None:
    assert client.post("/nope", content=b" " * (MAX_BODY_BYTES + 1)).status_code == 404


def test_unicode_round_trips_as_utf8(client: TestClient) -> None:
    company = "Caf\u00e9 \U0001f600 <b>&</b>"
    body = client.post("/company/intelligence", json={"company": company}).json()
    assert company in body["recent_patterns"][0]


def test_integral_floats_are_echoed_like_javascript_numbers(client: TestClient) -> None:
    body = client.post(
        "/roadmap/generate", content='{"weak_topics": [2.0, 1e2, 1.5], "weeks_available": 1}'
    ).json()
    assert body["phases"][0]["topics"] == [2, 100, 1.5]
    assert body["phases"][0]["title"] == "Focus: 2, 100, 1.5"


def test_roadmap_cap_applies_over_http(client: TestClient) -> None:
    body = client.post("/roadmap/generate", json={"weeks_available": 10**12}).json()
    assert len(body["phases"]) == MAX_WEEKS


def test_unexpected_errors_become_a_generic_500(
    make_client: Any, monkeypatch: pytest.MonkeyPatch
) -> None:
    def boom(_: object) -> None:
        raise RuntimeError("secret internal detail")

    monkeypatch.setattr("mock_ai_service.handlers.analyze_resume", boom)
    response = make_client().post("/resume/analyze", json={})
    assert response.status_code == 500
    assert response.json() == {"error": "Internal mock server error"}
    assert "secret" not in response.text


def test_other_http_errors_keep_their_status_and_detail() -> None:
    handler = cast(
        "Callable[[Request, Exception], Awaitable[Response]]",
        create_app().exception_handlers[StarletteHTTPException],
    )
    request = Request({"type": "http", "method": "GET", "path": "/", "headers": []})

    async def call() -> Response:
        return await handler(request, StarletteHTTPException(418, "teapot"))

    response = asyncio.run(call())
    assert response.status_code == 418
    assert bytes(response.body) == b'{"error":"teapot"}'
