import { useQuery } from '@tanstack/react-query';
import { Link, useParams } from 'react-router-dom';
import { interviewApi } from '../../lib/api/interview';
import { Spinner } from '../../components/ui/Spinner';
import { ErrorState } from '../../components/ui/ErrorState';
import { Pill } from '../../components/ui/Badge';
import { ApiClientError } from '../../lib/apiClient';

const DIM_LABELS: { key: 'technical_accuracy' | 'communication_clarity' | 'problem_solving_approach' | 'depth_of_knowledge' | 'hr_readiness'; label: string }[] = [
  { key: 'technical_accuracy', label: 'Technical accuracy' },
  { key: 'communication_clarity', label: 'Communication clarity' },
  { key: 'problem_solving_approach', label: 'Problem-solving approach' },
  { key: 'depth_of_knowledge', label: 'Depth of knowledge' },
  { key: 'hr_readiness', label: 'HR readiness' },
];

const RECOMMENDATION_TONE: Record<string, 'positive' | 'warning' | 'danger'> = {
  hire: 'positive',
  borderline: 'warning',
  no_hire: 'danger',
};

export function InterviewScorecardPage() {
  const { sessionId } = useParams<{ sessionId: string }>();
  const query = useQuery({
    queryKey: ['interview-scorecard', sessionId],
    queryFn: () => interviewApi.getScorecard(sessionId!),
    enabled: !!sessionId,
  });

  if (query.isLoading) return <Spinner label="Compiling your scorecard…" />;
  if (query.isError || !query.data)
    return <ErrorState message={query.error instanceof ApiClientError ? query.error.message : 'Failed to load scorecard'} onRetry={() => query.refetch()} />;

  const s = query.data;

  return (
    <div className="space-y-6">
      <Link to="/interview/history" className="text-sm text-ink-400 underline">
        ← Back to sessions
      </Link>

      <div className="card">
        <div className="flex items-center justify-between">
          <div>
            <p className="text-xs font-medium uppercase tracking-wide text-ink-400">Overall score</p>
            <p className="font-display text-4xl font-semibold text-ink-900">{Math.round(s.overall_score)}</p>
          </div>
          <Pill tone={RECOMMENDATION_TONE[s.hiring_recommendation]}>{s.hiring_recommendation.replace('_', ' ')}</Pill>
        </div>

        <div className="mt-6 space-y-3">
          {DIM_LABELS.map(({ key, label }) => {
            const value = s[key];
            if (value === null || value === undefined) return null;
            return (
              <div key={key}>
                <div className="flex justify-between text-sm">
                  <span className="text-ink-700">{label}</span>
                  <span className="text-ink-400">{value}/10</span>
                </div>
                <div className="mt-1 h-1.5 rounded-full bg-ink-100">
                  <div className="h-1.5 rounded-full bg-momentum-500" style={{ width: `${(Number(value) / 10) * 100}%` }} />
                </div>
              </div>
            );
          })}
        </div>
      </div>

      <div className="grid grid-cols-1 gap-4 sm:grid-cols-2">
        <div className="card">
          <p className="font-display font-semibold text-momentum-600">Strengths</p>
          {s.strengths.length === 0 ? (
            <p className="mt-2 text-sm text-ink-400">None stood out this session.</p>
          ) : (
            <ul className="mt-2 space-y-1 text-sm text-ink-700 list-disc list-inside">
              {s.strengths.map((st, i) => (
                <li key={i}>{st}</li>
              ))}
            </ul>
          )}
        </div>
        <div className="card">
          <p className="font-display font-semibold text-alert-500">Areas to improve</p>
          {s.weaknesses.length === 0 ? (
            <p className="mt-2 text-sm text-ink-400">Nothing flagged — solid round.</p>
          ) : (
            <ul className="mt-2 space-y-1 text-sm text-ink-700 list-disc list-inside">
              {s.weaknesses.map((w, i) => (
                <li key={i}>{w}</li>
              ))}
            </ul>
          )}
        </div>
      </div>

      <div className="card">
        <p className="font-display font-semibold text-ink-900">Improvement plan</p>
        <ul className="mt-2 space-y-1 text-sm text-ink-700 list-disc list-inside">
          {s.improvement_plan.map((p, i) => (
            <li key={i}>{p}</li>
          ))}
        </ul>
      </div>
    </div>
  );
}
