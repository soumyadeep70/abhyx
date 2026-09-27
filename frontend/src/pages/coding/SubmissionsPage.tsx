import { useQuery } from '@tanstack/react-query';
import { Link } from 'react-router-dom';
import { useAuth } from '../../lib/auth-context';
import { codingApi } from '../../lib/api/coding';
import { Spinner } from '../../components/ui/Spinner';
import { ErrorState } from '../../components/ui/ErrorState';
import { EmptyState } from '../../components/ui/EmptyState';
import { Pill } from '../../components/ui/Badge';
import { ApiClientError } from '../../lib/apiClient';

export function SubmissionsPage() {
  const { user } = useAuth();
  const query = useQuery({
    queryKey: ['coding-submissions', user!.id],
    queryFn: () => codingApi.listSubmissions(user!.id),
  });

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h1 className="font-display text-2xl font-bold text-ink-900">My Submissions</h1>
        <Link to="/coding" className="btn-secondary text-sm">
          Back to problems
        </Link>
      </div>

      {query.isLoading && <Spinner label="Loading submissions…" />}
      {query.isError && <ErrorState message={query.error instanceof ApiClientError ? query.error.message : 'Failed to load'} onRetry={() => query.refetch()} />}
      {query.data && query.data.length === 0 && <EmptyState title="No submissions yet" description="Solve a problem in the Coding Arena to see it here." />}
      {query.data && query.data.length > 0 && (
        <div className="card divide-y divide-ink-50 p-0">
          {query.data.map((s) => (
            <div key={s.id} className="flex items-center justify-between px-5 py-3">
              <div>
                <p className="text-sm font-medium text-ink-900">{s.language}</p>
                <p className="text-xs text-ink-400">
                  {new Date(s.created_at).toLocaleString()} · {s.test_cases_passed}/{s.test_cases_total} passed
                  {s.runtime_ms !== null && ` · ${s.runtime_ms}ms`}
                </p>
              </div>
              <Pill tone={s.status === 'accepted' ? 'positive' : 'danger'}>{s.status.replace('_', ' ')}</Pill>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}
