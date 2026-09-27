import { useQuery } from '@tanstack/react-query';
import { Link } from 'react-router-dom';
import { useAuth } from '../../lib/auth-context';
import { assessmentApi } from '../../lib/api/assessment';
import { Spinner } from '../../components/ui/Spinner';
import { ErrorState } from '../../components/ui/ErrorState';
import { EmptyState } from '../../components/ui/EmptyState';
import { ProgressBar } from '../../components/ui/ProgressBar';
import { Pill } from '../../components/ui/Badge';
import { ApiClientError } from '../../lib/apiClient';

const LABEL_TONE: Record<string, 'positive' | 'warning' | 'danger' | 'neutral'> = {
  strong: 'positive',
  improving: 'warning',
  weak: 'danger',
  insufficient_data: 'neutral',
};

export function AssessmentAnalyticsPage() {
  const { user } = useAuth();
  const query = useQuery({
    queryKey: ['topic-analytics', user!.id],
    queryFn: () => assessmentApi.analytics(user!.id),
  });

  if (query.isLoading) return <Spinner label="Loading topic analytics…" />;
  if (query.isError)
    return <ErrorState message={query.error instanceof ApiClientError ? query.error.message : 'Failed to load'} onRetry={() => query.refetch()} />;

  const topics = query.data!;

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="font-display text-2xl font-bold text-ink-900">Topic Accuracy</h1>
          <p className="mt-1 text-sm text-ink-400">Full breakdown of every topic you've attempted (5+ attempts needed for a strong/weak label).</p>
        </div>
        <Link to="/assessment" className="btn-secondary text-sm">
          Back to practice
        </Link>
      </div>

      {topics.length === 0 ? (
        <EmptyState title="No attempts yet" description="Practice a few questions to see your accuracy by topic." action={<Link to="/assessment" className="btn-signal">Start practicing</Link>} />
      ) : (
        <div className="card space-y-4">
          {topics
            .slice()
            .sort((a, b) => a.accuracy - b.accuracy)
            .map((t) => {
              const pct = Math.round(t.accuracy * 100);
              return (
                <div key={t.topic_id}>
                  <div className="flex items-center justify-between text-sm">
                    <span className="font-medium text-ink-800">
                      {t.topic_name} <span className="ml-1 text-xs font-normal text-ink-400 capitalize">({t.category})</span>
                    </span>
                    <span className="flex items-center gap-2 text-ink-400">
                      {t.attempts} attempts · {pct}%
                      <Pill tone={LABEL_TONE[t.label]}>{t.label.replace('_', ' ')}</Pill>
                    </span>
                  </div>
                  <div className="mt-1">
                    <ProgressBar value={pct} tone={pct >= 75 ? 'momentum' : pct >= 50 ? 'signal' : 'alert'} />
                  </div>
                </div>
              );
            })}
        </div>
      )}
    </div>
  );
}
