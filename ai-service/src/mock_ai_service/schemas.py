"""Response models -- the exact shapes ``aiServiceClient.ts`` expects.

Field order matches the original JSON payloads. Request bodies are
deliberately *not* modelled: the mock accepts any JSON and falls back to
defaults, exactly like the Node implementation.
"""

from __future__ import annotations

from typing import Any

from pydantic import BaseModel


class HealthResponse(BaseModel):
    status: str
    service: str


class ErrorResponse(BaseModel):
    error: str


class ResumeAnalysisResult(BaseModel):
    ats_score: int
    skills_present: list[str]
    skills_missing: list[str]
    keyword_gaps: list[str]
    summary: str


class InterviewScoreResult(BaseModel):
    technical_accuracy: int
    communication_clarity: int
    problem_solving_approach: int
    depth_of_knowledge: int
    hr_readiness: int | None
    feedback: str
    follow_up_question: str


class RoadmapPhase(BaseModel):
    phase_number: int
    title: str
    topics: list[Any]
    estimated_days: int
    resources: list[str]


class RoadmapResult(BaseModel):
    phases: list[RoadmapPhase]


class ErrorBreakdown(BaseModel):
    conceptual: int
    computational: int
    careless: int
    time_management: int


class WeakTopicsResult(BaseModel):
    strong: list[Any]
    weak: list[Any]
    improving: list[Any]
    error_breakdown: ErrorBreakdown


class ReadinessInsightsResult(BaseModel):
    headline: str
    strengths: list[str]
    risks: list[str]
    next_actions: list[str]


class CompanyIntelligenceResult(BaseModel):
    recent_patterns: list[str]
    commonly_asked_topics: list[str]
    interview_tips: list[str]
    sources: list[str]
