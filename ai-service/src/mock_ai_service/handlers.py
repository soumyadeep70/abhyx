"""Pure business logic, one function per ``aiServiceClient`` method.

Every function takes the (already parsed) JSON body and returns a response
model. They are deterministic functions of the body, have no I/O and no
framework dependencies, which makes them trivial to unit test.
"""

from __future__ import annotations

import math
import re
from collections.abc import Mapping
from typing import Any

from .js_compat import (
    clamp,
    entries,
    hash_code,
    js_round,
    number_or_zero,
    str_or,
    to_number,
    to_str,
    utf16_length,
)
from .schemas import (
    CompanyIntelligenceResult,
    ErrorBreakdown,
    InterviewScoreResult,
    ReadinessInsightsResult,
    ResumeAnalysisResult,
    RoadmapPhase,
    RoadmapResult,
    WeakTopicsResult,
)

Body = Mapping[str, Any]

# A small, illustrative skills taxonomy -- enough to make ats_score and
# skills_present/missing react visibly to different resumes in tests.
KNOWN_SKILLS: tuple[str, ...] = (
    "javascript", "typescript", "python", "java", "react", "node",
    "express", "sql", "postgresql", "docker", "kubernetes", "aws",
    "git", "rest", "graphql", "testing", "ci", "cd",
)  # fmt: skip

DEFAULT_WEEKS = 4
# Safety valve (not in the Node original, where weeks_available=1e9 would
# allocate a billion phases): never generate more than this many phases.
MAX_WEEKS = 104

_NON_WORD = re.compile(r"\W+", re.ASCII)  # JS \W is ASCII-only


def _text(value: Any) -> str:
    """``String(value || '')``."""
    return str_or(value, "")


def analyze_resume(body: Body) -> ResumeAnalysisResult:
    text = _text(body.get("resume_text"))
    word_set = {word for word in _NON_WORD.split(text.lower()) if word}

    present = [skill for skill in KNOWN_SKILLS if skill in word_set]
    missing = [skill for skill in KNOWN_SKILLS if skill not in word_set][:6]

    length = utf16_length(text)
    length_score = clamp(js_round(length / 2000 * 40), 0, 40)
    skill_score = clamp(js_round(len(present) / len(KNOWN_SKILLS) * 60), 0, 60)
    ats_score = clamp(length_score + skill_score, 5, 98)

    if length < 50:
        summary = "Resume text is very short; the mock analyzer could not extract much signal."
    else:
        summary = (
            f"Mock analysis found {len(present)} recognized skill keyword(s) "
            f"and estimates an ATS score of {ats_score}."
        )

    return ResumeAnalysisResult(
        ats_score=ats_score,
        skills_present=present,
        skills_missing=missing,
        keyword_gaps=missing[:3],
        summary=summary,
    )


def score_interview_answer(body: Body) -> InterviewScoreResult:
    answer_length = utf16_length(_text(body.get("answer")))
    question = _text(body.get("question"))
    base = clamp(40 + js_round(answer_length / 10), 20, 95)

    def jitter(seed: str) -> int:
        return clamp(base + (hash_code(question + seed) % 15) - 7, 10, 100)

    is_hr = body.get("round_type") == "hr"
    if answer_length < 20:
        feedback = (
            "Answer was quite brief. Mock feedback: elaborate with a concrete example next time."
        )
    else:
        feedback = "Mock feedback: solid structure. Consider quantifying impact where possible."

    return InterviewScoreResult(
        technical_accuracy=jitter("tech"),
        communication_clarity=jitter("comm"),
        problem_solving_approach=jitter("prob"),
        depth_of_knowledge=jitter("depth"),
        hr_readiness=jitter("hr") if is_hr else None,
        feedback=feedback,
        follow_up_question="Mock follow-up: can you walk through a specific example of that?",
    )


def _join(items: list[Any]) -> str:
    """``Array.prototype.join(', ')`` (null renders as an empty string)."""
    return ", ".join("" if item is None else to_str(item) for item in items)


def generate_roadmap(body: Body) -> RoadmapResult:
    raw_topics = body.get("weak_topics")
    weak_topics: list[Any] = raw_topics if isinstance(raw_topics, list) else []

    requested = to_number(body.get("weeks_available"))
    weeks = requested if requested > 0 else DEFAULT_WEEKS  # NaN > 0 is False
    weeks = min(weeks, MAX_WEEKS)
    topics_per_phase = max(1, math.ceil((len(weak_topics) or 1) / weeks))

    phases: list[RoadmapPhase] = []
    # ``for (i = 0; i < weeks; i++)`` -- weeks may be fractional.
    for i in range(math.ceil(weeks)):
        chunk = weak_topics[i * topics_per_phase : (i + 1) * topics_per_phase]
        focus = str_or(chunk[0], "general review") if chunk else "general review"
        phases.append(
            RoadmapPhase(
                phase_number=i + 1,
                title=f"Focus: {_join(chunk)}" if chunk else f"General practice, week {i + 1}",
                topics=chunk if chunk else ["Mixed review"],
                estimated_days=7,
                resources=[f"Mock resource list for {focus}"],
            )
        )
    return RoadmapResult(phases=phases)


def analyze_weak_topics(body: Body) -> WeakTopicsResult:
    raw = body.get("topic_performance")
    performance: list[Any] = raw if isinstance(raw, list) else []

    strong: list[Any] = []
    weak: list[Any] = []
    improving: list[Any] = []
    conceptual = 0

    for item in performance:
        entry: Mapping[str, Any] = item if isinstance(item, dict) else {}
        topic = entry.get("topic")
        accuracy = number_or_zero(entry.get("accuracy"))
        if accuracy >= 0.75:
            strong.append(topic)
        elif accuracy < 0.5:
            weak.append(topic)
            conceptual += 1
        else:
            improving.append(topic)

    return WeakTopicsResult(
        strong=strong,
        weak=weak,
        improving=improving,
        error_breakdown=ErrorBreakdown(
            conceptual=conceptual, computational=0, careless=0, time_management=0
        ),
    )


def get_readiness_insights(body: Body) -> ReadinessInsightsResult:
    score = number_or_zero(body.get("score"))
    company = str_or(body.get("company"), "this company")
    tier = str_or(body.get("tier"), "tier")

    if score >= 80:
        headline = f"Strong readiness for {company} ({tier})."
    elif score >= 50:
        headline = f"On track for {company}, with room to grow."
    else:
        headline = f"Early stage for {company} -- focus time on the basics."

    breakdown = entries(body.get("breakdown"))

    return ReadinessInsightsResult(
        headline=headline,
        strengths=[key for key, value in breakdown if to_number(value) >= 70],
        risks=[key for key, value in breakdown if to_number(value) < 50],
        next_actions=["Keep a daily practice streak", "Target the weakest sub-score first"],
    )


def get_company_intelligence(body: Body) -> CompanyIntelligenceResult:
    company = str_or(body.get("company"), "this company")
    return CompanyIntelligenceResult(
        recent_patterns=[
            f"Mock pattern: {company} has recently emphasized data structures rounds."
        ],
        commonly_asked_topics=["Arrays", "Dynamic Programming", "System Design Basics"],
        interview_tips=[f"Research {company}'s recent product launches before the interview."],
        sources=["mock-ai-service (offline, deterministic placeholder data)"],
    )


__all__ = [
    "DEFAULT_WEEKS",
    "KNOWN_SKILLS",
    "MAX_WEEKS",
    "analyze_resume",
    "analyze_weak_topics",
    "generate_roadmap",
    "get_company_intelligence",
    "get_readiness_insights",
    "score_interview_answer",
]
