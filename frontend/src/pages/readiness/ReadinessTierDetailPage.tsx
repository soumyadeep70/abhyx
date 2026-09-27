import { useQuery } from '@tanstack/react-query';
import { Link, useParams } from 'react-router-dom';
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer } from 'recharts';
import { useAuth } from '../../lib/auth-context';
import { readinessApi } from '../../lib/api/readiness';
import { Spinner } from '../../components/ui/Spinner';
import { ErrorState } from '../../components/ui/ErrorState';
import { EmptyState } from '../../components/ui/EmptyState';
import { ApiClientError } from '../../lib/apiClient';

export function ReadinessTierDetailPage() {
  const { tierId } = useParams<{ tierId: string }>();
  const { user } = useAuth();

  const historyQuery = useQuery({
    queryKey: ['readiness-history', user!.id, tierId],
    queryFn: () => readinessApi.getHistory(user!.id, tierId!),
    enabled: !!tierId,
  });
  const insightsQuery = useQuery({
    queryKey: ['readiness-insights', user!.id, tierId],
    queryFn: () => readinessApi.getInsights(user!.id, tierId!),
    enabled: !!tierId,
  });

  return (
    <div className="space-y-6">
      <Link to="/readiness" className="text-sm text-ink-400 underline">
        ← Back to readiness overview
      </Link>
      <h1 className="font-display text-2xl font-bold text-ink-900">Score history & insights</h1>

      <div className="card">
        <p className="font-display font-semibold text-ink-900">Score trend</p>
        {historyQuery.isLoading && <Spinner />}
        {historyQuery.isError && (
          <ErrorState message={historyQuery.error instanceof ApiClientError ? historyQuery.error.message : 'Failed to load'} onRetry={() => historyQuery.refetch()} />
        )}
        {historyQuery.data && historyQuery.data.length === 0 && <EmptyState title="No history yet" description="Scores build up over time as you practice." />}
        {historyQuery.data && historyQuery.data.length > 0 && (
          <div className="mt-4 h-64">
            <ResponsiveContainer width="100%" height="100%">
              <LineChart
                data={historyQuery.data
                  .slice()
                  .reverse()
                  .map((h) => ({ date: new Date(h.computed_at).toLocaleDateString(), score: h.score, probability: Math.round(h.probability * 100) }))}
              >
                <CartesianGrid strokeDasharray="3 3" stroke="#E4E6EC" />
                <XAxis dataKey="date" tick={{ fontSize: 11 }} />
                <YAxis domain={[0, 100]} tick={{ fontSize: 11 }} />
                <Tooltip />
                <Line type="monotone" dataKey="score" stroke="#C88A2E" strokeWidth={2} dot={false} />
                <Line type="monotone" dataKey="probability" stroke="#0F8A7A" strokeWidth={2} dot={false} />
              </LineChart>
            </ResponsiveContainer>
          </div>
        )}
      </div>

      <div className="card">
        <p className="font-display font-semibold text-ink-900">AI insights</p>
        <p className="text-xs text-ink-400">Generated when your score changes significantly; may not be available yet.</p>
        {insightsQuery.isLoading && <Spinner />}
        {!insightsQuery.isLoading && !insightsQuery.data && (
          <EmptyState title="No insights cached yet" description="Keep practicing — insights populate after a significant score change." />
        )}
        {insightsQuery.data && (
          <div className="mt-3 space-y-3">
            {insightsQuery.data.summary && <p className="text-sm text-ink-700">{insightsQuery.data.summary}</p>}
            {Array.isArray(insightsQuery.data.recommendations) && insightsQuery.data.recommendations.length > 0 && (
              <ul className="list-disc list-inside space-y-1 text-sm text-ink-700">
                {insightsQuery.data.recommendations.map((r, i) => (
                  <li key={i}>{String(r)}</li>
                ))}
              </ul>
            )}
          </div>
        )}
      </div>
    </div>
  );
}
