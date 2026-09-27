import { useRef, useState } from 'react';
import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import { useAuth } from '../../lib/auth-context';
import { resumeApi } from '../../lib/api/resume';
import { companiesApi } from '../../lib/api/companies';
import { Spinner } from '../../components/ui/Spinner';
import { ErrorState } from '../../components/ui/ErrorState';
import { EmptyState } from '../../components/ui/EmptyState';
import { Pill } from '../../components/ui/Badge';
import { ApiClientError } from '../../lib/apiClient';

export function ResumeUploadPage() {
  const { user } = useAuth();
  const queryClient = useQueryClient();
  const fileInputRef = useRef<HTMLInputElement>(null);
  const [tierId, setTierId] = useState('');
  const [selectedFileName, setSelectedFileName] = useState<string | null>(null);

  const companiesQuery = useQuery({ queryKey: ['companies'], queryFn: companiesApi.list });
  const historyQuery = useQuery({ queryKey: ['resume-history', user!.id], queryFn: () => resumeApi.listForUser(user!.id) });

  const uploadMutation = useMutation({
    mutationFn: (file: File) => resumeApi.upload(file, tierId || undefined),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['resume-history', user!.id] });
      queryClient.invalidateQueries({ queryKey: ['dashboard', user!.id] });
      queryClient.invalidateQueries({ queryKey: ['active-roadmap', user!.id] });
      if (fileInputRef.current) fileInputRef.current.value = '';
      setSelectedFileName(null);
    },
  });

  return (
    <div className="space-y-6">
      <div>
        <h1 className="font-display text-2xl font-bold text-ink-900">Resume Intelligence</h1>
        <p className="mt-1 text-sm text-ink-400">Upload a PDF resume for an ATS score, gap analysis, and an auto-generated roadmap.</p>
      </div>

      <div className="card max-w-lg space-y-4">
        <div>
          <label className="field-label">Target company (optional, sharpens keyword gap analysis)</label>
          <select className="field-input" value={tierId} onChange={(e) => setTierId(e.target.value)}>
            <option value="">General analysis</option>
            {(companiesQuery.data ?? []).map((t) => (
              <option key={t.tier_id} value={t.tier_id}>
                {t.company_name} · {t.tier_name}
              </option>
            ))}
          </select>
        </div>
        <div>
          <label className="field-label">Resume (PDF only)</label>
          <input
            ref={fileInputRef}
            type="file"
            accept="application/pdf"
            className="field-input"
            onChange={(e) => setSelectedFileName(e.target.files?.[0]?.name ?? null)}
          />
        </div>
        {uploadMutation.isError && (
          <p className="text-sm text-alert-500">{uploadMutation.error instanceof ApiClientError ? uploadMutation.error.message : 'Upload failed'}</p>
        )}
        <button
          className="btn-primary w-full"
          disabled={!selectedFileName || uploadMutation.isPending}
          onClick={() => {
            const file = fileInputRef.current?.files?.[0];
            if (file) uploadMutation.mutate(file);
          }}
        >
          {uploadMutation.isPending ? 'Analyzing…' : 'Upload & analyze'}
        </button>
      </div>

      {uploadMutation.data && (
        <div className="card max-w-2xl">
          <div className="flex items-center justify-between">
            <p className="font-display font-semibold text-ink-900">Latest analysis</p>
            <p className="font-display text-3xl font-bold text-momentum-600">{uploadMutation.data.ats_score}/100</p>
          </div>
          <p className="mt-3 text-sm text-ink-700">{uploadMutation.data.summary}</p>
          <div className="mt-4 grid grid-cols-1 gap-4 sm:grid-cols-2">
            <div>
              <p className="text-xs font-medium uppercase tracking-wide text-ink-400">Skills present</p>
              <div className="mt-2 flex flex-wrap gap-1.5">
                {uploadMutation.data.skills_present.map((s) => (
                  <Pill key={s} tone="positive">
                    {s}
                  </Pill>
                ))}
              </div>
            </div>
            <div>
              <p className="text-xs font-medium uppercase tracking-wide text-ink-400">Skills / keywords missing</p>
              <div className="mt-2 flex flex-wrap gap-1.5">
                {[...uploadMutation.data.skills_missing, ...uploadMutation.data.keyword_gaps].map((s) => (
                  <Pill key={s} tone="danger">
                    {s}
                  </Pill>
                ))}
              </div>
            </div>
          </div>
        </div>
      )}

      <div>
        <p className="font-display font-semibold text-ink-900 mb-3">Version history</p>
        {historyQuery.isLoading && <Spinner />}
        {historyQuery.isError && <ErrorState message={historyQuery.error instanceof ApiClientError ? historyQuery.error.message : 'Failed to load'} onRetry={() => historyQuery.refetch()} />}
        {historyQuery.data && historyQuery.data.length === 0 && <EmptyState title="No resumes uploaded yet" />}
        {historyQuery.data && historyQuery.data.length > 0 && (
          <div className="card divide-y divide-ink-50 p-0">
            {historyQuery.data.map((r) => (
              <div key={r.id} className="flex items-center justify-between px-5 py-3">
                <div>
                  <p className="text-sm font-medium text-ink-900">
                    {new Date(r.uploaded_at).toLocaleString()} {r.is_current && <Pill tone="positive">current</Pill>}
                  </p>
                  <p className="text-xs text-ink-400">{r.status}</p>
                </div>
                <p className="font-display text-lg font-semibold text-ink-700">{r.ats_score != null ? `${r.ats_score}/100` : '—'}</p>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
}
