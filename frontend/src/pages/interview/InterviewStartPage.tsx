import { useState } from 'react';
import { useMutation, useQuery } from '@tanstack/react-query';
import { Link, useNavigate } from 'react-router-dom';
import { interviewApi } from '../../lib/api/interview';
import { companiesApi } from '../../lib/api/companies';
import { ApiClientError } from '../../lib/apiClient';

const ROUND_TYPES: { value: 'technical' | 'hr' | 'system_design'; label: string; description: string }[] = [
  { value: 'technical', label: 'Technical', description: 'DSA, CS fundamentals, and problem walkthroughs.' },
  { value: 'hr', label: 'HR', description: 'Behavioral and culture-fit questions.' },
  { value: 'system_design', label: 'System Design', description: 'High-level architecture and trade-off discussions.' },
];

export function InterviewStartPage() {
  const navigate = useNavigate();
  const [roundType, setRoundType] = useState<'technical' | 'hr' | 'system_design'>('technical');
  const [tierId, setTierId] = useState('');

  const companiesQuery = useQuery({ queryKey: ['companies'], queryFn: companiesApi.list });

  const startMutation = useMutation({
    mutationFn: () => interviewApi.start({ round_type: roundType, company_tier_id: tierId || undefined }),
    onSuccess: (result) =>
      navigate(`/interview/session/${result.session_id}`, { state: { openingQuestion: result.question, roundType } }),
  });

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="font-display text-2xl font-bold text-ink-900">AI Mock Interview</h1>
          <p className="mt-1 text-sm text-ink-400">Text-based interview with live 5-dimension scoring.</p>
        </div>
        <Link to="/interview/history" className="btn-secondary text-sm">
          Past sessions
        </Link>
      </div>

      <div className="card max-w-lg space-y-4">
        <div>
          <p className="field-label mb-2">Round type</p>
          <div className="space-y-2">
            {ROUND_TYPES.map((r) => (
              <label
                key={r.value}
                className={`block rounded-sm border px-4 py-3 cursor-pointer ${
                  roundType === r.value ? 'border-signal-500 bg-signal-50' : 'border-ink-200 hover:bg-ink-50'
                }`}
              >
                <input type="radio" name="round" className="sr-only" checked={roundType === r.value} onChange={() => setRoundType(r.value)} />
                <p className="text-sm font-medium text-ink-900">{r.label}</p>
                <p className="text-xs text-ink-400">{r.description}</p>
              </label>
            ))}
          </div>
        </div>

        <div>
          <label className="field-label">Target company (optional)</label>
          <select className="field-input" value={tierId} onChange={(e) => setTierId(e.target.value)}>
            <option value="">General interview</option>
            {(companiesQuery.data ?? []).map((t) => (
              <option key={t.tier_id} value={t.tier_id}>
                {t.company_name} · {t.tier_name}
              </option>
            ))}
          </select>
        </div>

        {startMutation.isError && (
          <p className="text-sm text-alert-500">{startMutation.error instanceof ApiClientError ? startMutation.error.message : 'Failed to start session'}</p>
        )}

        <button className="btn-primary w-full" disabled={startMutation.isPending} onClick={() => startMutation.mutate()}>
          {startMutation.isPending ? 'Starting…' : 'Start interview'}
        </button>
      </div>
    </div>
  );
}
