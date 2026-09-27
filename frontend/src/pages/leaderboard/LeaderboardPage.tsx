import { useState } from 'react';
import { useQuery } from '@tanstack/react-query';
import { useAuth } from '../../lib/auth-context';
import { leaderboardApi } from '../../lib/api/leaderboard';
import { Spinner } from '../../components/ui/Spinner';
import { ErrorState } from '../../components/ui/ErrorState';
import { EmptyState } from '../../components/ui/EmptyState';
import { Tabs } from '../../components/ui/Tabs';
import { Pill } from '../../components/ui/Badge';
import { ApiClientError } from '../../lib/apiClient';

export function LeaderboardPage() {
  const { user } = useAuth();
  const [scope, setScope] = useState<'overall' | 'college' | 'streak'>('overall');

  const query = useQuery({
    queryKey: ['leaderboard', scope, scope === 'college' ? user?.college : undefined],
    queryFn: () =>
      leaderboardApi.get({
        scope,
        college: scope === 'college' ? user?.college ?? undefined : undefined,
        limit: 50,
      }),
  });

  return (
    <div className="space-y-6">
      <div className="flex flex-wrap items-center justify-between gap-3">
        <div>
          <h1 className="font-display text-2xl font-bold text-ink-900">Leaderboard</h1>
          <p className="mt-1 text-sm text-ink-400">See how you stack up against other candidates.</p>
        </div>
        <Tabs
          value={scope}
          onChange={setScope}
          options={[
            { value: 'overall', label: 'Overall' },
            { value: 'college', label: 'My college' },
            { value: 'streak', label: 'Streaks' },
          ]}
        />
      </div>

      {scope === 'college' && !user?.college && (
        <p className="rounded-sm bg-signal-50 px-3 py-2 text-sm text-signal-700">
          Add your college in your profile to see the college leaderboard.
        </p>
      )}

      {query.isLoading && <Spinner label="Loading leaderboard…" />}
      {query.isError && <ErrorState message={query.error instanceof ApiClientError ? query.error.message : 'Failed to load'} onRetry={() => query.refetch()} />}
      {query.data && query.data.length === 0 && <EmptyState title="No leaderboard data yet" />}
      {query.data && query.data.length > 0 && (
        <div className="card divide-y divide-ink-50 p-0">
          {query.data.map((row, i) => {
            const isMe = row.user_id === user?.id;
            return (
              <div key={row.user_id} className={`flex items-center justify-between px-5 py-3 ${isMe ? 'bg-signal-50' : ''}`}>
                <div className="flex items-center gap-4">
                  <span className="w-6 text-center font-display font-semibold text-ink-400">{row.rank ?? i + 1}</span>
                  <div>
                    <p className="text-sm font-medium text-ink-900">
                      {row.full_name} {isMe && <Pill tone="warning">you</Pill>}
                    </p>
                    {row.college && <p className="text-xs text-ink-400">{row.college}</p>}
                  </div>
                </div>
                <p className="font-display font-semibold text-ink-900">
                  {scope === 'streak' ? `${row.current_streak ?? 0}d` : row.score ?? '—'}
                </p>
              </div>
            );
          })}
        </div>
      )}
    </div>
  );
}
