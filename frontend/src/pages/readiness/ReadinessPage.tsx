import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import { Link } from 'react-router-dom';
import { useAuth } from '../../lib/auth-context';
import { readinessApi } from '../../lib/api/readiness';
import { Spinner } from '../../components/ui/Spinner';
import { ErrorState } from '../../components/ui/ErrorState';
import { EmptyState } from '../../components/ui/EmptyState';
import { ProgressBar } from '../../components/ui/ProgressBar';
import { ApiClientError } from '../../lib/apiClient';

const SUB_SCORES: { key: 'aptitude_score' | 'coding_score' | 'resume_score' | 'interview_score' | 'consistency_score'; label: string }[] = [
  { key: 'aptitude_score', label: 'Aptitude' },
  { key: 'coding_score', label: 'Coding' },
  { key: 'resume_score', label: 'Resume' },
  { key: 'interview_score', label: 'Interview' },
  { key: 'consistency_score', label: 'Consistency' },
];

export function ReadinessPage() {
  const { user } = useAuth();
  const queryClient = useQueryClient();
  const query = useQuery({ queryKey: ['readiness', user!.id], queryFn: () => readinessApi.getProfile(user!.id) });

  const recomputeMutation = useMutation({
    mutationFn: () => readinessApi.recompute(user!.id),
    onSuccess: (data) => queryClient.setQueryData(['readiness', user!.id], data),
  });

  if (query.isLoading) return <Spinner label="Loading readiness profile…" />;
  if (query.isError)
    return <ErrorState message={query.error instanceof ApiClientError ? query.error.message : 'Failed to load'} onRetry={() => query.refetch()} />;

  const rows = query.data!;

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="font-display text-2xl font-bold text-ink-900">Placement Readiness</h1>
          <p className="mt-1 text-sm text-ink-400">Company-specific readiness scores and placement probability.</p>
        </div>
        <button className="btn-secondary text-sm" disabled={recomputeMutation.isPending} onClick={() => recomputeMutation.mutate()}>
          {recomputeMutation.isPending ? 'Recomputing…' : 'Recompute now'}
        </button>
      </div>

      {rows.length === 0 ? (
        <EmptyState
          title="No target companies yet"
          description="Add target companies from your profile to start tracking readiness."
          action={<Link to="/profile" className="btn-signal">Go to profile</Link>}
        />
      ) : (
        <div className="grid grid-cols-1 gap-6 lg:grid-cols-2">
          {rows.map((r) => (
            <div key={r.company_tier_id} className="card">
              <div className="flex items-center justify-between">
                <div>
                  <p className="font-display font-semibold text-ink-900">
                    {r.company_name} · {r.tier_name}
                  </p>
                  <p className="text-xs text-ink-400">Last computed {new Date(r.last_computed).toLocaleString()}</p>
                </div>
                <div className="text-right">
                  <p className="font-display text-2xl font-bold text-ink-900">{Math.round(r.score)}</p>
                  <p className="text-xs text-ink-400">{Math.round(r.probability * 100)}% probability</p>
                </div>
              </div>
              <div className="mt-4 space-y-2">
                {SUB_SCORES.map(({ key, label }) => (
                  <div key={key}>
                    <div className="flex justify-between text-xs text-ink-500">
                      <span>{label}</span>
                      <span>{Math.round(r[key])}</span>
                    </div>
                    <ProgressBar value={r[key]} tone={r[key] >= 70 ? 'momentum' : r[key] >= 40 ? 'signal' : 'alert'} />
                  </div>
                ))}
              </div>
              <Link to={`/readiness/${r.company_tier_id}`} className="btn-secondary mt-4 inline-block text-sm">
                View trend & insights
              </Link>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}
