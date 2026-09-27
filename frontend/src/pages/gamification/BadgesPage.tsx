import { useQuery } from '@tanstack/react-query';
import { useAuth } from '../../lib/auth-context';
import { usersApi } from '../../lib/api/users';
import { Spinner } from '../../components/ui/Spinner';
import { ErrorState } from '../../components/ui/ErrorState';
import { EmptyState } from '../../components/ui/EmptyState';
import { ApiClientError } from '../../lib/apiClient';

export function BadgesPage() {
  const { user } = useAuth();
  const query = useQuery({ queryKey: ['badges', user!.id], queryFn: () => usersApi.getBadges(user!.id) });

  if (query.isLoading) return <Spinner label="Loading badges…" />;
  if (query.isError)
    return <ErrorState message={query.error instanceof ApiClientError ? query.error.message : 'Failed to load'} onRetry={() => query.refetch()} />;

  const badges = query.data!;
  const earned = badges.filter((b) => b.earned_at);
  const locked = badges.filter((b) => !b.earned_at);

  return (
    <div className="space-y-6">
      <div>
        <h1 className="font-display text-2xl font-bold text-ink-900">Badges</h1>
        <p className="mt-1 text-sm text-ink-400">Earned for consistency, coding milestones, and aptitude mastery.</p>
      </div>

      {badges.length === 0 ? (
        <EmptyState title="No badges configured yet" />
      ) : (
        <>
          <div>
            <p className="font-display font-semibold text-ink-900 mb-3">Earned ({earned.length})</p>
            {earned.length === 0 ? (
              <EmptyState title="No badges earned yet" description="Keep practicing daily to unlock your first badge." />
            ) : (
              <div className="grid grid-cols-2 gap-4 sm:grid-cols-3 md:grid-cols-4">
                {earned.map((b) => (
                  <div key={b.code} className="card text-center">
                    <div className="mx-auto flex h-12 w-12 items-center justify-center rounded-full bg-signal-50 text-2xl">🏅</div>
                    <p className="mt-2 text-sm font-medium text-ink-900">{b.name}</p>
                    <p className="text-xs text-ink-400">{b.description}</p>
                    <p className="mt-1 text-[11px] text-ink-300">{new Date(b.earned_at!).toLocaleDateString()}</p>
                  </div>
                ))}
              </div>
            )}
          </div>

          {locked.length > 0 && (
            <div>
              <p className="font-display font-semibold text-ink-900 mb-3">Locked ({locked.length})</p>
              <div className="grid grid-cols-2 gap-4 sm:grid-cols-3 md:grid-cols-4">
                {locked.map((b) => (
                  <div key={b.code} className="card text-center opacity-50">
                    <div className="mx-auto flex h-12 w-12 items-center justify-center rounded-full bg-ink-100 text-2xl grayscale">🏅</div>
                    <p className="mt-2 text-sm font-medium text-ink-900">{b.name}</p>
                    <p className="text-xs text-ink-400">{b.description}</p>
                  </div>
                ))}
              </div>
            </div>
          )}
        </>
      )}
    </div>
  );
}
