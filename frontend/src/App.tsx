import { Navigate, Route, Routes } from 'react-router-dom';
import { Suspense, lazy } from 'react';
import { AppShell } from './components/layout/AppShell';
import { ProtectedRoute } from './components/layout/ProtectedRoute';
import { AdminRoute } from './components/layout/AdminRoute';
import { LoginPage } from './pages/auth/LoginPage';
import { RegisterPage } from './pages/auth/RegisterPage';
import { DashboardPage } from './pages/DashboardPage';
import { PracticePage } from './pages/assessment/PracticePage';
import { AssessmentAnalyticsPage } from './pages/assessment/AnalyticsPage';
import { ProblemListPage } from './pages/coding/ProblemListPage';
import { SubmissionsPage } from './pages/coding/SubmissionsPage';
import { MockTestListPage } from './pages/mockTests/MockTestListPage';
import { MockTestDetailPage } from './pages/mockTests/MockTestDetailPage';
import { InterviewStartPage } from './pages/interview/InterviewStartPage';
import { InterviewSessionPage } from './pages/interview/InterviewSessionPage';
import { InterviewScorecardPage } from './pages/interview/InterviewScorecardPage';
import { InterviewHistoryPage } from './pages/interview/InterviewHistoryPage';
import { ResumeUploadPage } from './pages/resume/ResumeUploadPage';
import { RoadmapPage } from './pages/roadmap/RoadmapPage';
import { ReadinessPage } from './pages/readiness/ReadinessPage';
import { ReadinessTierDetailPage } from './pages/readiness/ReadinessTierDetailPage';
import { CompaniesPage } from './pages/companies/CompaniesPage';
import { LeaderboardPage } from './pages/leaderboard/LeaderboardPage';
import { BadgesPage } from './pages/gamification/BadgesPage';
import { ProfilePage } from './pages/profile/ProfilePage';
import { QuestionsAdminPage } from './pages/admin/QuestionsAdminPage';
import { NotFoundPage } from './pages/NotFoundPage';
import { Spinner } from './components/ui/Spinner';

// Monaco editor is the single largest dependency in the app; only load it
// (and the page that uses it) when someone actually opens a problem.
const ProblemDetailPage = lazy(() => import('./pages/coding/ProblemDetailPage').then((m) => ({ default: m.ProblemDetailPage })));

export default function App() {
  return (
    <Routes>
      <Route path="/login" element={<LoginPage />} />
      <Route path="/register" element={<RegisterPage />} />

      <Route element={<ProtectedRoute />}>
        <Route element={<AppShell />}>
          <Route path="/" element={<DashboardPage />} />

          <Route path="/assessment" element={<PracticePage />} />
          <Route path="/assessment/analytics" element={<AssessmentAnalyticsPage />} />

          <Route path="/coding" element={<ProblemListPage />} />
          <Route path="/coding/submissions" element={<SubmissionsPage />} />
          <Route path="/coding/:questionId" element={<Suspense fallback={<Spinner label="Loading editor…" />}><ProblemDetailPage /></Suspense>} />

          <Route path="/mock-tests" element={<MockTestListPage />} />
          <Route path="/mock-tests/:mockTestId" element={<MockTestDetailPage />} />

          <Route path="/interview" element={<InterviewStartPage />} />
          <Route path="/interview/history" element={<InterviewHistoryPage />} />
          <Route path="/interview/session/:sessionId" element={<InterviewSessionPage />} />
          <Route path="/interview/session/:sessionId/scorecard" element={<InterviewScorecardPage />} />

          <Route path="/resume" element={<ResumeUploadPage />} />
          <Route path="/roadmap" element={<RoadmapPage />} />

          <Route path="/readiness" element={<ReadinessPage />} />
          <Route path="/readiness/:tierId" element={<ReadinessTierDetailPage />} />

          <Route path="/companies" element={<CompaniesPage />} />
          <Route path="/leaderboard" element={<LeaderboardPage />} />
          <Route path="/badges" element={<BadgesPage />} />
          <Route path="/profile" element={<ProfilePage />} />

          <Route element={<AdminRoute />}>
            <Route path="/admin/questions" element={<QuestionsAdminPage />} />
          </Route>

          <Route path="*" element={<NotFoundPage />} />
        </Route>
      </Route>

      <Route path="*" element={<Navigate to="/" replace />} />
    </Routes>
  );
}
