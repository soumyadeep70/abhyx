import { useQuery } from '@tanstack/react-query';
import { companiesApi } from '../../lib/api/companies';
import { Spinner } from '../../components/ui/Spinner';
import { ErrorState } from '../../components/ui/ErrorState';
import { EmptyState } from '../../components/ui/EmptyState';
import { ApiClientError } from '../../lib/apiClient';

const WEIGHT_FIELDS: { key: 'aptitude_weight' | 'coding_weight' | 'resume_weight' | 'interview_weight' | 'consistency_weight'; label: string }[] = [
  { key: 'aptitude_weight', label: 'Aptitude' },
  { key: 'coding_weight', label: 'Coding' },
  { key: 'resume_weight', label: 'Resume' },
  { key: 'interview_weight', label: 'Interview' },
  { key: 'consistency_weight', label: 'Consistency' },
];

export function CompaniesPage() {
  const query = useQuery({ queryKey: ['companies'], queryFn: companiesApi.list });

  if (query.isLoading) return <Spinner label="Loading companies…" />;
  if (query.isError)
    return <ErrorState message={query.error instanceof ApiClientError ? query.error.message : 'Failed to load'} onRetry={() => query.refetch()} />;

  const rows = query.data!;
  const byCompany = new Map<string, typeof rows>();
  rows.forEach((r) => {
    const list = byCompany.get(r.company_name) ?? [];
    list.push(r);
    byCompany.set(r.company_name, list);
  });

  return (
    <div className="space-y-6">
      <div>
        <h1 className="font-display text-2xl font-bold text-ink-900">Companies</h1>
        <p className="mt-1 text-sm text-ink-400">Each tier's readiness weighting — how much each dimension contributes to that score.</p>
      </div>

      {rows.length === 0 ? (
        <EmptyState title="No companies configured yet" />
      ) : (
        <div className="grid grid-cols-1 gap-6 md:grid-cols-2">
          {[...byCompany.entries()].map(([companyName, tiers]) => (
            <div key={companyName} className="card">
              <p className="font-display font-semibold text-ink-900">{companyName}</p>
              <div className="mt-3 space-y-4">
                {tiers.map((t) => (
                  <div key={t.tier_id} className="rounded-sm border border-ink-100 p-3">
                    <p className="text-sm font-medium text-ink-800">{t.tier_name}</p>
                    <div className="mt-2 flex flex-wrap gap-x-4 gap-y-1 text-xs text-ink-400">
                      {WEIGHT_FIELDS.map(({ key, label }) => (
                        <span key={key}>
                          {label} <span className="font-medium text-ink-600">{t[key]}%</span>
                        </span>
                      ))}
                    </div>
                  </div>
                ))}
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}
