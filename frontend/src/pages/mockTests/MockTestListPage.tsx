import { useState } from 'react';
import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import { Link, useNavigate } from 'react-router-dom';
import { useAuth } from '../../lib/auth-context';
import { mockTestsApi } from '../../lib/api/mockTests';
import { companiesApi } from '../../lib/api/companies';
import { Spinner } from '../../components/ui/Spinner';
import { ErrorState } from '../../components/ui/ErrorState';
import { EmptyState } from '../../components/ui/EmptyState';
import { Pill } from '../../components/ui/Badge';
import { ApiClientError } from '../../lib/apiClient';

export function MockTestListPage() {
  const { user } = useAuth();
  const navigate = useNavigate();
  const queryClient = useQueryClient();
  const [tierId, setTierId] = useState('');
  const [aptitudeCount, setAptitudeCount] = useState(10);
  const [codingCount, setCodingCount] = useState(2);

  const companiesQuery = useQuery({ queryKey: ['companies'], queryFn: companiesApi.list });
  const testsQuery = useQuery({ queryKey: ['mock-tests', user!.id], queryFn: () => mockTestsApi.listForUser(user!.id) });

  const startMutation = useMutation({
    mutationFn: () =>
      mockTestsApi.start({
        company_tier_id: tierId,
        aptitude_question_count: aptitudeCount,
        coding_question_count: codingCount,
      }),
    onSuccess: (test) => {
      queryClient.invalidateQueries({ queryKey: ['mock-tests', user!.id] });
      navigate(`/mock-tests/${test.id}`);
    },
  });

  return (
    <div className="space-y-6">
      <div>
        <h1 className="font-display text-2xl font-bold text-ink-900">Mock Tests</h1>
        <p className="mt-1 text-sm text-ink-400">Full-length timed tests simulating real placement patterns.</p>
      </div>

      <div className="card max-w-lg">
        <p className="font-display font-semibold text-ink-900">Start a new mock test</p>
        <div className="mt-4 space-y-3">
          <div>
            <label className="field-label">Company tier</label>
            <select className="field-input" value={tierId} onChange={(e) => setTierId(e.target.value)}>
              <option value="">Select a company tier</option>
              {(companiesQuery.data ?? []).map((t) => (
                <option key={t.tier_id} value={t.tier_id}>
                  {t.company_name} · {t.tier_name}
                </option>
              ))}
            </select>
          </div>
          <div className="grid grid-cols-2 gap-3">
            <div>
              <label className="field-label">Aptitude questions</label>
              <input
                type="number"
                min={0}
                max={30}
                className="field-input"
                value={aptitudeCount}
                onChange={(e) => setAptitudeCount(Number(e.target.value))}
              />
            </div>
            <div>
              <label className="field-label">Coding questions</label>
              <input
                type="number"
                min={0}
                max={10}
                className="field-input"
                value={codingCount}
                onChange={(e) => setCodingCount(Number(e.target.value))}
              />
            </div>
          </div>
          {startMutation.isError && (
            <p className="text-sm text-alert-500">{startMutation.error instanceof ApiClientError ? startMutation.error.message : 'Failed to start'}</p>
          )}
          <button className="btn-primary w-full" disabled={!tierId || startMutation.isPending} onClick={() => startMutation.mutate()}>
            {startMutation.isPending ? 'Starting…' : 'Start mock test'}
          </button>
        </div>
      </div>

      <div>
        <p className="font-display font-semibold text-ink-900 mb-3">Your mock tests</p>
        {testsQuery.isLoading && <Spinner />}
        {testsQuery.isError && <ErrorState message={testsQuery.error instanceof ApiClientError ? testsQuery.error.message : 'Failed to load'} onRetry={() => testsQuery.refetch()} />}
        {testsQuery.data && testsQuery.data.length === 0 && <EmptyState title="No mock tests yet" description="Start your first mock test above." />}
        {testsQuery.data && testsQuery.data.length > 0 && (
          <div className="card divide-y divide-ink-50 p-0">
            {testsQuery.data.map((t) => (
              <Link key={t.id} to={`/mock-tests/${t.id}`} className="flex items-center justify-between px-5 py-3 hover:bg-ink-50">
                <div>
                  <p className="text-sm font-medium text-ink-900">{new Date(t.started_at).toLocaleString()}</p>
                  <p className="text-xs text-ink-400">
                    {t.company_name && `${t.company_name} · ${t.tier_name} · `}
                    {t.total_score != null && `score ${t.total_score}`}
                  </p>
                </div>
                <Pill tone={t.status === 'completed' ? 'positive' : t.status === 'abandoned' ? 'danger' : 'warning'}>
                  {t.status.replace('_', ' ')}
                </Pill>
              </Link>
            ))}
          </div>
        )}
      </div>
    </div>
  );
}
