// Mirrors the JSON shapes returned by the Express backend (see
// backend/src/modules/**). Kept intentionally loose (optional fields,
// `unknown` for AI-authored free-form blobs) since the backend's own types
// aren't published as a package the frontend can import directly.

export type Role = 'student' | 'admin';

export interface PublicUser {
  id: string;
  email: string;
  full_name: string;
  role: Role;
  college: string | null;
  graduation_year: number | null;
}

export interface AuthResult {
  user: PublicUser;
  token: string;
}

export interface CompanyTier {
  company_id: string;
  company_name: string;
  logo_url?: string | null;
  tier_id: string;
  tier_name: string;
  aptitude_weight: number;
  coding_weight: number;
  resume_weight: number;
  interview_weight: number;
  consistency_weight: number;
}

export interface TargetCompanyRow {
  company_tier_id: string;
  priority?: number | null;
  added_at?: string;
  company_name: string;
  tier_name: string;
}

export interface Topic {
  id: string;
  name: string;
}

export interface QuestionListItem {
  id: string;
  type: 'aptitude' | 'coding';
  topic_id: string;
  topic_name: string;
  difficulty: 'easy' | 'medium' | 'hard';
  title: string;
  created_at: string;
}

export interface AptitudeQuestionDetail extends QuestionListItem {
  options: string[];
  correct_answer?: unknown;
  prompt?: string;
}

export interface CodingQuestionDetail extends QuestionListItem {
  prompt?: string;
  function_signature?: string;
  starter_code?: Record<string, string>;
  constraints_text?: string;
  time_limit_ms?: number;
  memory_limit_kb?: number;
  sample_test_cases?: { input: string; expected: string }[];
}

export interface NextAssessmentQuestion {
  id: string;
  type: 'aptitude';
  topic_id: string;
  topic_name: string;
  difficulty: 'easy' | 'medium' | 'hard';
  title: string;
  /** Question stem/body text (backend column name is `prompt`). */
  prompt?: string;
  options: string[];
}

export interface SubmitAnswerResult {
  is_correct: boolean;
  correct_answer?: unknown;
  explanation?: string;
  attempt_id?: string;
}

export interface TopicAnalyticsRow {
  topic_id: string;
  topic_name: string;
  category: 'aptitude' | 'coding';
  attempts: number;
  /** Fraction 0..1, not a percentage. */
  accuracy: number;
  label: 'insufficient_data' | 'strong' | 'weak' | 'improving';
}

export interface CodingSubmissionResult {
  submission_id: string;
  status: 'accepted' | 'wrong_answer' | 'compile_error' | 'runtime_error' | 'tle' | 'pending';
  test_cases_passed: number;
  test_cases_total: number;
  runtime_ms: number | null;
  memory_kb: number | null;
}

export interface CodeSubmissionSummary {
  id: string;
  question_id: string;
  language: string;
  status: string;
  test_cases_passed: number;
  test_cases_total: number;
  runtime_ms: number | null;
  memory_kb: number | null;
  created_at: string;
}

export interface MockTestQuestion {
  order_index: number;
  question_id: string;
  type: 'aptitude' | 'coding';
  title: string;
  difficulty: 'easy' | 'medium' | 'hard';
  topic_name: string;
}

export interface MockTest {
  id: string;
  user_id?: string;
  target_company_id?: string;
  company_name?: string;
  tier_name?: string;
  status: 'in_progress' | 'completed' | 'abandoned';
  /** Only present on the POST /mock-tests (start) response, not on GET. */
  question_count?: number;
  total_score?: number | null;
  started_at: string;
  completed_at?: string | null;
  questions?: MockTestQuestion[];
}

export interface InterviewStartResult {
  session_id: string;
  started_at: string;
  question: string;
}

export interface InterviewRespondResult {
  scores: {
    technical_accuracy: number;
    communication_clarity: number;
    problem_solving_approach: number;
    depth_of_knowledge: number;
    hr_readiness: number | null;
  };
  feedback: string;
  next_question: string;
  candidate_message_id: string;
  interviewer_message_id: string;
}

export interface InterviewScorecard {
  session_id: string;
  technical_accuracy: number;
  communication_clarity: number;
  problem_solving_approach: number;
  depth_of_knowledge: number;
  hr_readiness: number | null;
  overall_score: number;
  strengths: string[];
  weaknesses: string[];
  improvement_plan: string[];
  hiring_recommendation: 'hire' | 'borderline' | 'no_hire';
}

export interface InterviewSessionSummary {
  id: string;
  round_type: 'technical' | 'hr' | 'system_design';
  status: 'in_progress' | 'completed';
  started_at: string;
  completed_at?: string | null;
  company_name?: string | null;
}

export interface ResumeAnalysis {
  resume_id: string;
  status: 'analyzed';
  ats_score: number;
  skills_present: string[];
  skills_missing: string[];
  keyword_gaps: string[];
  summary: string;
}

export interface ResumeHistoryItem {
  id: string;
  status: 'processing' | 'analyzed' | 'failed';
  ats_score: number | null;
  extracted_skills: string[] | null;
  keyword_gaps: string[] | null;
  ai_summary: string | null;
  is_current: boolean;
  uploaded_at: string;
}

export interface RoadmapPhase {
  id: string;
  roadmap_id: string;
  phase_number: number;
  title: string;
  topics: string[];
  status: 'pending' | 'active' | 'completed';
}

export interface Roadmap {
  id: string;
  profile_id?: string;
  target_company?: string;
  target_date?: string | null;
  status: string;
  created_at?: string;
  phases: RoadmapPhase[];
}

export interface ReadinessScoreRow {
  company_tier_id: string;
  company_name: string;
  tier_name: string;
  score: number;
  probability: number;
  aptitude_score: number;
  coding_score: number;
  resume_score: number;
  interview_score: number;
  consistency_score: number;
  last_computed: string;
}

export interface ReadinessHistoryRow {
  score: number;
  probability: number;
  trigger_reason: string;
  computed_at: string;
}

export interface ReadinessInsights {
  summary?: string;
  recommendations?: string[];
  [key: string]: unknown;
}

export interface StreakInfo {
  current_streak: number;
  longest_streak?: number;
  last_active_date?: string | null;
}

export interface Badge {
  code: string;
  name: string;
  description: string;
  icon_url?: string | null;
  earned_at: string | null;
}

export interface LeaderboardRow {
  user_id: string;
  full_name: string;
  college?: string | null;
  score?: number;
  current_streak?: number;
  rank?: number;
}

export interface DashboardData {
  readiness: ReadinessScoreRow[];
  topic_heatmap: TopicAnalyticsRow[];
  /** One row per (week, difficulty). `solved` is a Postgres bigint, arrives as a numeric string. */
  coding_progress: { week: string; difficulty: 'easy' | 'medium' | 'hard'; solved: number | string }[];
  interview_radar: {
    round_type: string;
    technical_accuracy: number;
    communication_clarity: number;
    problem_solving_approach: number;
    depth_of_knowledge: number;
    hr_readiness: number | null;
    overall_score?: number;
  }[];
  streak: StreakInfo;
  activity_dates: string[];
}

export interface Paginated<T> {
  items: T[];
  page: number;
  page_size: number;
  total?: number;
}
