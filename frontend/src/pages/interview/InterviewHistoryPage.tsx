import { useQuery } from '@tanstack/react-query';
import { Link } from 'react-router-dom';
import { useAuth } from '../../lib/auth-context';
import { interviewApi } from '../../lib/api/interview';
import { Spinner } from '../../components/ui/Spinner';
import { ErrorState } from '../../components/ui/ErrorState';
import { EmptyState } from '../../components/ui/EmptyState';
import { Pill } from '../../components/ui/Badge';
import { ApiClientError } from '../../lib/apiClient';

export function InterviewHistoryPage() {
  const { user } = useAuth();
  const query = useQuery({ queryKey: ['interview-sessions', user!.id], queryFn: () => interviewApi.listForUser(user!.id) });

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h1 className="font-display text-2xl font-bold text-ink-900">Interview History</h1>
        <Link to="/interview" className="btn-secondary text-sm">
          New interview
        </Link>
      </div>

      {query.isLoading && <Spinner label="Loading sessions…" />}
      {query.isError && <ErrorState message={query.error instanceof ApiClientError ? query.error.message : 'Failed to load'} onRetry={() => query.refetch()} />}
      {query.data && query.data.length === 0 && <EmptyState title="No sessions yet" description="Start a mock interview to build your history." action={<Link to="/interview" className="btn-signal">Start interview</Link>} />}
      {query.data && query.data.length > 0 && (
        <div className="card divide-y divide-ink-50 p-0">
          {query.data.map((s) => (
            <Link
              key={s.id}
              to={s.status === 'completed' ? `/interview/session/${s.id}/scorecard` : `/interview/session/${s.id}`}
              className="flex items-center justify-between px-5 py-3 hover:bg-ink-50"
            >
              <div>
                <p className="text-sm font-medium capitalize text-ink-900">{s.round_type.replace('_', ' ')}</p>
                <p className="text-xs text-ink-400">
                  {s.company_name ? `${s.company_name} · ` : ''}
                  {new Date(s.started_at).toLocaleString()}
                </p>
              </div>
              <Pill tone={s.status === 'completed' ? 'positive' : 'warning'}>{s.status.replace('_', ' ')}</Pill>
            </Link>
          ))}
        </div>
      )}
    </div>
  );
}
