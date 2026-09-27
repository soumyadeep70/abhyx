import { useEffect, useState } from 'react';
import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import { useAuth } from '../../lib/auth-context';
import { usersApi } from '../../lib/api/users';
import { companiesApi } from '../../lib/api/companies';
import { Spinner } from '../../components/ui/Spinner';
import { ErrorState } from '../../components/ui/ErrorState';
import { StatCard } from '../../components/ui/StatCard';
import { ApiClientError } from '../../lib/apiClient';

export function ProfilePage() {
  const { user } = useAuth();
  const queryClient = useQueryClient();

  const profileQuery = useQuery({ queryKey: ['profile', user!.id], queryFn: () => usersApi.getProfile(user!.id) });
  const activityQuery = useQuery({ queryKey: ['activity', user!.id], queryFn: () => usersApi.getActivity(user!.id) });
  const companiesQuery = useQuery({ queryKey: ['companies'], queryFn: companiesApi.list });

  const [selectedTiers, setSelectedTiers] = useState<string[]>([]);

  useEffect(() => {
    if (profileQuery.data) {
      setSelectedTiers(profileQuery.data.target_companies.map((t) => t.company_tier_id));
    }
  }, [profileQuery.data]);

  const updateMutation = useMutation({
    mutationFn: (tierIds: string[]) => usersApi.updateTargetCompanies(user!.id, tierIds),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['profile', user!.id] });
      queryClient.invalidateQueries({ queryKey: ['readiness', user!.id] });
      queryClient.invalidateQueries({ queryKey: ['dashboard', user!.id] });
    },
  });

  function toggleTier(tierId: string) {
    setSelectedTiers((prev) => (prev.includes(tierId) ? prev.filter((id) => id !== tierId) : prev.length < 10 ? [...prev, tierId] : prev));
  }

  if (profileQuery.isLoading) return <Spinner label="Loading profile…" />;
  if (profileQuery.isError)
    return <ErrorState message={profileQuery.error instanceof ApiClientError ? profileQuery.error.message : 'Failed to load'} onRetry={() => profileQuery.refetch()} />;

  const profile = profileQuery.data!;
  const dirty = JSON.stringify([...selectedTiers].sort()) !== JSON.stringify(profile.target_companies.map((t) => t.company_tier_id).sort());

  return (
    <div className="space-y-6">
      <div>
        <h1 className="font-display text-2xl font-bold text-ink-900">Profile</h1>
        <p className="mt-1 text-sm text-ink-400">Your account details and target companies.</p>
      </div>

      <div className="card max-w-lg">
        <p className="font-display font-semibold text-ink-900">{profile.profile.full_name}</p>
        <p className="text-sm text-ink-400">{profile.profile.email}</p>
        <div className="mt-3 flex flex-wrap gap-x-6 gap-y-1 text-sm text-ink-600">
          {profile.profile.college && <span>College: {profile.profile.college}</span>}
          {profile.profile.graduation_year && <span>Class of {profile.profile.graduation_year}</span>}
          <span className="capitalize">Role: {profile.profile.role}</span>
        </div>
      </div>

      <div className="grid grid-cols-2 gap-4 sm:grid-cols-3">
        <StatCard label="Current streak" value={`${profile.streak.current_streak ?? 0}d`} tone="positive" />
        <StatCard label="Longest streak" value={`${profile.streak.longest_streak ?? 0}d`} />
        <StatCard label="Active days (1yr)" value={activityQuery.data?.activity_dates.length ?? '—'} />
      </div>

      <div className="card max-w-lg">
        <p className="font-display font-semibold text-ink-900">Target companies (up to 10)</p>
        <p className="text-xs text-ink-400 mb-3">Drives your readiness dashboard and roadmap.</p>
        {companiesQuery.isLoading && <Spinner />}
        <div className="max-h-64 overflow-y-auto rounded-sm border border-ink-100 divide-y divide-ink-50">
          {(companiesQuery.data ?? []).map((tier) => (
            <label key={tier.tier_id} className="flex items-center gap-2 px-3 py-2 text-sm hover:bg-ink-50">
              <input
                type="checkbox"
                checked={selectedTiers.includes(tier.tier_id)}
                onChange={() => toggleTier(tier.tier_id)}
                className="h-4 w-4 rounded border-ink-300 text-signal-500 focus:ring-signal-500"
              />
              <span className="text-ink-800">
                {tier.company_name} <span className="text-ink-400">· {tier.tier_name}</span>
              </span>
            </label>
          ))}
        </div>
        {updateMutation.isError && (
          <p className="mt-2 text-sm text-alert-500">{updateMutation.error instanceof ApiClientError ? updateMutation.error.message : 'Failed to save'}</p>
        )}
        <button className="btn-primary mt-4" disabled={!dirty || updateMutation.isPending} onClick={() => updateMutation.mutate(selectedTiers)}>
          {updateMutation.isPending ? 'Saving…' : 'Save target companies'}
        </button>
      </div>
    </div>
  );
}
