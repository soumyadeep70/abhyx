import { useState } from 'react';
import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import { useAuth } from '../../lib/auth-context';
import { roadmapApi } from '../../lib/api/roadmap';
import { companiesApi } from '../../lib/api/companies';
import { Spinner } from '../../components/ui/Spinner';
import { ErrorState } from '../../components/ui/ErrorState';
import { EmptyState } from '../../components/ui/EmptyState';
import { Pill } from '../../components/ui/Badge';
import { ApiClientError } from '../../lib/apiClient';

export function RoadmapPage() {
  const { user } = useAuth();
  const queryClient = useQueryClient();
  const [tierId, setTierId] = useState('');
  const [weeks, setWeeks] = useState(8);

  const companiesQuery = useQuery({ queryKey: ['companies'], queryFn: companiesApi.list });
  const roadmapQuery = useQuery({
    queryKey: ['active-roadmap', user!.id],
    queryFn: () => roadmapApi.getActive(user!.id),
    retry: false,
  });

  const generateMutation = useMutation({
    mutationFn: () => roadmapApi.generate({ company_tier_id: tierId, weeks_available: weeks }),
    onSuccess: () => queryClient.invalidateQueries({ queryKey: ['active-roadmap', user!.id] }),
  });

  const completePhaseMutation = useMutation({
    mutationFn: (phaseId: string) => roadmapApi.completePhase(user!.id, phaseId),
    onSuccess: (roadmap) => queryClient.setQueryData(['active-roadmap', user!.id], roadmap),
  });

  const noActiveRoadmap = roadmapQuery.isError && roadmapQuery.error instanceof ApiClientError && roadmapQuery.error.status === 404;

  return (
    <div className="space-y-6">
      <div>
        <h1 className="font-display text-2xl font-bold text-ink-900">Personalized Roadmap</h1>
        <p className="mt-1 text-sm text-ink-400">An AI-phased plan based on your resume, weak topics, and target company.</p>
      </div>

      {roadmapQuery.isLoading && <Spinner label="Loading your roadmap…" />}

      {(noActiveRoadmap || (roadmapQuery.isSuccess && !roadmapQuery.data)) && (
        <div className="card max-w-lg space-y-4">
          <p className="font-display font-semibold text-ink-900">Generate a roadmap</p>
          <div>
            <label className="field-label">Target company</label>
            <select className="field-input" value={tierId} onChange={(e) => setTierId(e.target.value)}>
              <option value="">Select a company tier</option>
              {(companiesQuery.data ?? []).map((t) => (
                <option key={t.tier_id} value={t.tier_id}>
                  {t.company_name} · {t.tier_name}
                </option>
              ))}
            </select>
          </div>
          <div>
            <label className="field-label">Weeks available</label>
            <input type="number" min={1} max={52} className="field-input" value={weeks} onChange={(e) => setWeeks(Number(e.target.value))} />
          </div>
          {generateMutation.isError && (
            <p className="text-sm text-alert-500">{generateMutation.error instanceof ApiClientError ? generateMutation.error.message : 'Failed to generate'}</p>
          )}
          <button className="btn-primary w-full" disabled={!tierId || generateMutation.isPending} onClick={() => generateMutation.mutate()}>
            {generateMutation.isPending ? 'Generating…' : 'Generate roadmap'}
          </button>
        </div>
      )}

      {roadmapQuery.isError && !noActiveRoadmap && (
        <ErrorState message={roadmapQuery.error instanceof ApiClientError ? roadmapQuery.error.message : 'Failed to load roadmap'} onRetry={() => roadmapQuery.refetch()} />
      )}

      {roadmapQuery.data && (
        <div className="space-y-4">
          <div className="flex items-center justify-between">
            <p className="text-sm text-ink-500">
              Status: <Pill tone={roadmapQuery.data.status === 'completed' ? 'positive' : 'warning'}>{roadmapQuery.data.status}</Pill>
            </p>
          </div>
          {roadmapQuery.data.phases.length === 0 ? (
            <EmptyState title="No phases generated" />
          ) : (
            roadmapQuery.data.phases
              .slice()
              .sort((a, b) => a.phase_number - b.phase_number)
              .map((phase) => (
                <div key={phase.id} className="card">
                  <div className="flex items-center justify-between">
                    <p className="font-display font-semibold text-ink-900">
                      Phase {phase.phase_number}: {phase.title}
                    </p>
                    <Pill tone={phase.status === 'completed' ? 'positive' : phase.status === 'active' ? 'warning' : 'neutral'}>
                      {phase.status}
                    </Pill>
                  </div>
                  <div className="mt-2 flex flex-wrap gap-1.5">
                    {phase.topics.map((t) => (
                      <Pill key={t} tone="neutral">
                        {t}
                      </Pill>
                    ))}
                  </div>
                  {phase.status !== 'completed' && (
                    <button
                      className="btn-secondary mt-4 text-sm"
                      disabled={completePhaseMutation.isPending}
                      onClick={() => completePhaseMutation.mutate(phase.id)}
                    >
                      Mark phase complete
                    </button>
                  )}
                </div>
              ))
          )}
        </div>
      )}
    </div>
  );
}
