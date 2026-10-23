"""Unit tests for the pure handler functions (no HTTP involved)."""

from __future__ import annotations

import pytest

from mock_ai_service import handlers
from mock_ai_service.handlers import KNOWN_SKILLS, MAX_WEEKS

# ---- analyze_resume ---------------------------------------------------------


def test_resume_detects_known_skills_in_taxonomy_order() -> None:
    result = handlers.analyze_resume(
        {"resume_text": "Experienced in javascript, react, node, docker, git and sql."}
    )
    assert result.skills_present == ["javascript", "react", "node", "sql", "docker", "git"]
    assert set(result.skills_present).isdisjoint(result.skills_missing)


def test_resume_missing_skills_capped_at_six_and_gaps_at_three() -> None:
    result = handlers.analyze_resume({})
    assert result.skills_present == []
    assert result.skills_missing == list(KNOWN_SKILLS[:6])
    assert result.keyword_gaps == list(KNOWN_SKILLS[:3])


def test_resume_matching_is_case_insensitive_and_whole_word() -> None:
    result = handlers.analyze_resume(
        {"resume_text": "PYTHON and Javascript; but not nodejs or javas"}
    )
    assert result.skills_present == ["javascript", "python"]


def test_resume_empty_text_gets_minimum_score_and_short_summary() -> None:
    result = handlers.analyze_resume({"resume_text": ""})
    assert result.ats_score == 5
    assert "very short" in result.summary


def test_resume_keyword_rich_resume_outscores_empty_and_is_capped_at_98() -> None:
    rich = "javascript typescript python java react node express sql postgresql docker "
    rich += "kubernetes aws git rest graphql testing ci cd " + "padding " * 400
    result = handlers.analyze_resume({"resume_text": rich})
    assert result.ats_score == 98
    assert result.summary == (
        "Mock analysis found 18 recognized skill keyword(s) and estimates an ATS score of 98."
    )


def test_resume_score_is_monotonic_in_length() -> None:
    scores = [
        handlers.analyze_resume({"resume_text": "x" * n}).ats_score for n in (0, 500, 1000, 2000)
    ]
    assert scores == sorted(scores)
    assert scores[0] == 5


def test_resume_length_is_measured_in_utf16_units_like_javascript() -> None:
    # 24 emoji = 48 UTF-16 units (< 50 -> "very short"), but only 24 code points.
    assert "very short" in handlers.analyze_resume({"resume_text": "\U0001f600" * 24}).summary
    assert "very short" not in handlers.analyze_resume({"resume_text": "\U0001f600" * 25}).summary


@pytest.mark.parametrize("value", [None, 0, False, ""])
def test_resume_falsy_text_is_treated_as_empty(value: object) -> None:
    assert handlers.analyze_resume({"resume_text": value}).ats_score == 5


# ---- score_interview_answer -------------------------------------------------

SCORE_FIELDS = (
    "technical_accuracy",
    "communication_clarity",
    "problem_solving_approach",
    "depth_of_knowledge",
)


def test_interview_scores_are_deterministic() -> None:
    body = {"question": "Explain closures", "answer": "x" * 80, "round_type": "hr"}
    assert handlers.score_interview_answer(body) == handlers.score_interview_answer(body)


def test_interview_hr_readiness_only_for_hr_rounds() -> None:
    body = {"question": "Q", "answer": "x" * 40}
    assert handlers.score_interview_answer({**body, "round_type": "technical"}).hr_readiness is None
    assert handlers.score_interview_answer({**body, "round_type": "HR"}).hr_readiness is None
    assert isinstance(
        handlers.score_interview_answer({**body, "round_type": "hr"}).hr_readiness, int
    )


def test_interview_scores_stay_within_bounds_for_extreme_answers() -> None:
    for answer in ("", "z" * 100_000):
        result = handlers.score_interview_answer(
            {"question": "q", "answer": answer, "round_type": "hr"}
        )
        for field in (*SCORE_FIELDS, "hr_readiness"):
            assert 10 <= getattr(result, field) <= 100


def test_interview_longer_answers_trend_higher() -> None:
    short = handlers.score_interview_answer({"question": "q", "answer": ""})
    long = handlers.score_interview_answer({"question": "q", "answer": "x" * 500})
    assert sum(getattr(long, f) for f in SCORE_FIELDS) > sum(
        getattr(short, f) for f in SCORE_FIELDS
    )


def test_interview_feedback_switches_at_twenty_characters() -> None:
    brief = handlers.score_interview_answer({"answer": "a" * 19}).feedback
    fuller = handlers.score_interview_answer({"answer": "a" * 20}).feedback
    assert "quite brief" in brief
    assert "solid structure" in fuller


def test_interview_follow_up_question_is_constant() -> None:
    assert handlers.score_interview_answer({}).follow_up_question.startswith("Mock follow-up")


# ---- generate_roadmap -------------------------------------------------------


def test_roadmap_splits_topics_across_weeks() -> None:
    result = handlers.generate_roadmap(
        {"weak_topics": ["DP", "Graphs", "Trees", "Greedy"], "weeks_available": 2}
    )
    assert [p.topics for p in result.phases] == [["DP", "Graphs"], ["Trees", "Greedy"]]
    assert [p.phase_number for p in result.phases] == [1, 2]
    assert {p.estimated_days for p in result.phases} == {7}
    assert result.phases[0].title == "Focus: DP, Graphs"
    assert result.phases[0].resources == ["Mock resource list for DP"]


def test_roadmap_defaults_to_four_weeks_for_missing_or_invalid_weeks() -> None:
    for weeks in (None, 0, -2, "abc", "", float("nan")):
        assert len(handlers.generate_roadmap({"weeks_available": weeks}).phases) == 4


def test_roadmap_pads_with_general_practice_when_topics_run_out() -> None:
    result = handlers.generate_roadmap({"weak_topics": ["DP"], "weeks_available": 3})
    assert result.phases[0].topics == ["DP"]
    assert result.phases[1].title == "General practice, week 2"
    assert result.phases[1].topics == ["Mixed review"]
    assert result.phases[1].resources == ["Mock resource list for general review"]


def test_roadmap_accepts_numeric_strings_and_ignores_non_list_topics() -> None:
    assert len(handlers.generate_roadmap({"weeks_available": "6"}).phases) == 6
    assert handlers.generate_roadmap({"weak_topics": "DP", "weeks_available": 1}).phases[
        0
    ].topics == ["Mixed review"]


def test_roadmap_fractional_weeks_round_up_like_the_js_loop() -> None:
    assert len(handlers.generate_roadmap({"weeks_available": 2.5}).phases) == 3


def test_roadmap_week_count_is_capped_to_protect_the_service() -> None:
    assert len(handlers.generate_roadmap({"weeks_available": 10**9}).phases) == MAX_WEEKS
    assert len(handlers.generate_roadmap({"weeks_available": "Infinity"}).phases) == MAX_WEEKS


def test_roadmap_every_topic_appears_exactly_once_when_weeks_allow() -> None:
    topics = [f"t{i}" for i in range(23)]
    result = handlers.generate_roadmap({"weak_topics": topics, "weeks_available": 5})
    flattened = [t for p in result.phases for t in p.topics if t != "Mixed review"]
    assert flattened == topics


# ---- analyze_weak_topics ----------------------------------------------------


def test_weak_topics_buckets_by_accuracy_thresholds() -> None:
    result = handlers.analyze_weak_topics(
        {
            "topic_performance": [
                {"topic": "Arrays", "accuracy": 0.9},
                {"topic": "Graphs", "accuracy": 0.3},
                {"topic": "Strings", "accuracy": 0.6},
            ]
        }
    )
    assert (result.strong, result.weak, result.improving) == (["Arrays"], ["Graphs"], ["Strings"])
    assert result.error_breakdown.model_dump() == {
        "conceptual": 1,
        "computational": 0,
        "careless": 0,
        "time_management": 0,
    }


@pytest.mark.parametrize(
    ("accuracy", "bucket"),
    [(0.75, "strong"), (0.7499, "improving"), (0.5, "improving"), (0.4999, "weak"), (0, "weak")],
)
def test_weak_topics_threshold_boundaries(accuracy: float, bucket: str) -> None:
    result = handlers.analyze_weak_topics(
        {"topic_performance": [{"topic": "T", "accuracy": accuracy}]}
    )
    assert getattr(result, bucket) == ["T"]


def test_weak_topics_tolerates_malformed_entries() -> None:
    result = handlers.analyze_weak_topics(
        {
            "topic_performance": [
                None,
                5,
                "x",
                {"topic": "ok", "accuracy": "0.9"},
                {"accuracy": "bad"},
            ]
        }
    )
    assert result.strong == ["ok"]
    assert result.weak == [None, None, None, None]
    assert result.error_breakdown.conceptual == 4


def test_weak_topics_empty_input() -> None:
    result = handlers.analyze_weak_topics({"topic_performance": "nope"})
    assert (result.strong, result.weak, result.improving) == ([], [], [])


# ---- get_readiness_insights -------------------------------------------------


@pytest.mark.parametrize(
    ("score", "expected"),
    [
        (80, "Strong readiness for Acme (T1)."),
        (79.99, "On track for Acme, with room to grow."),
        (50, "On track for Acme, with room to grow."),
        (49.9, "Early stage for Acme -- focus time on the basics."),
        ("abc", "Early stage for Acme -- focus time on the basics."),
    ],
)
def test_readiness_headline_tiers(score: object, expected: str) -> None:
    assert (
        handlers.get_readiness_insights({"company": "Acme", "tier": "T1", "score": score}).headline
        == expected
    )


def test_readiness_defaults_for_missing_company_and_tier() -> None:
    assert (
        handlers.get_readiness_insights({"score": 90}).headline
        == "Strong readiness for this company (tier)."
    )


def test_readiness_strengths_and_risks_from_breakdown() -> None:
    result = handlers.get_readiness_insights(
        {"breakdown": {"aptitude": 80, "coding": 40, "mid": 60, "edge70": 70, "edge50": 50}}
    )
    assert result.strengths == ["aptitude", "edge70"]
    assert result.risks == ["coding"]
    assert result.next_actions == [
        "Keep a daily practice streak",
        "Target the weakest sub-score first",
    ]


def test_readiness_non_collection_breakdown_is_ignored() -> None:
    result = handlers.get_readiness_insights({"breakdown": 5})
    assert (result.strengths, result.risks) == ([], [])


# ---- get_company_intelligence -----------------------------------------------


def test_company_intelligence_interpolates_company_name() -> None:
    result = handlers.get_company_intelligence({"company": "Infosys"})
    assert "Infosys" in result.recent_patterns[0]
    assert "Infosys" in result.interview_tips[0]
    assert result.commonly_asked_topics == ["Arrays", "Dynamic Programming", "System Design Basics"]
    assert result.sources == ["mock-ai-service (offline, deterministic placeholder data)"]


def test_company_intelligence_defaults_company() -> None:
    assert "this company" in handlers.get_company_intelligence({}).recent_patterns[0]
