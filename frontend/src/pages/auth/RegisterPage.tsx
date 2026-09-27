import { FormEvent, useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { useQuery } from '@tanstack/react-query';
import { useAuth } from '../../lib/auth-context';
import { ApiClientError } from '../../lib/apiClient';
import { companiesApi } from '../../lib/api/companies';
import { Spinner } from '../../components/ui/Spinner';

export function RegisterPage() {
  const { register } = useAuth();
  const navigate = useNavigate();
  const [form, setForm] = useState({ email: '', password: '', full_name: '', college: '', graduation_year: '' });
  const [selectedTiers, setSelectedTiers] = useState<string[]>([]);
  const [error, setError] = useState<string | null>(null);
  const [submitting, setSubmitting] = useState(false);

  const companiesQuery = useQuery({ queryKey: ['companies'], queryFn: companiesApi.list });

  function toggleTier(tierId: string) {
    setSelectedTiers((prev) =>
      prev.includes(tierId) ? prev.filter((id) => id !== tierId) : prev.length < 10 ? [...prev, tierId] : prev
    );
  }

  async function onSubmit(e: FormEvent) {
    e.preventDefault();
    setError(null);
    setSubmitting(true);
    try {
      await register({
        email: form.email,
        password: form.password,
        full_name: form.full_name,
        college: form.college || undefined,
        graduation_year: form.graduation_year ? Number(form.graduation_year) : undefined,
        target_company_tier_ids: selectedTiers,
      });
      navigate('/', { replace: true });
    } catch (err) {
      setError(err instanceof ApiClientError ? err.message : 'Registration failed');
    } finally {
      setSubmitting(false);
    }
  }

  const companiesByName = new Map<string, typeof companiesQuery.data>();
  (companiesQuery.data ?? []).forEach((row) => {
    const list = companiesByName.get(row.company_name) ?? [];
    list.push(row as never);
    companiesByName.set(row.company_name, list as never);
  });

  return (
    <div className="min-h-screen bg-paper px-4 py-10">
      <div className="mx-auto w-full max-w-lg">
        <div className="mb-8 text-center">
          <p className="font-display text-2xl font-bold text-ink-900">Ascent</p>
          <p className="mt-1 text-sm text-ink-400">Create your account and pick target companies to get started.</p>
        </div>
        <form onSubmit={onSubmit} className="card space-y-5">
          {error && <p className="rounded-sm bg-alert-50 px-3 py-2 text-sm text-alert-500">{error}</p>}

          <div className="grid grid-cols-1 gap-4 sm:grid-cols-2">
            <div className="sm:col-span-2">
              <label className="field-label" htmlFor="full_name">
                Full name
              </label>
              <input
                id="full_name"
                required
                className="field-input"
                value={form.full_name}
                onChange={(e) => setForm({ ...form, full_name: e.target.value })}
              />
            </div>
            <div className="sm:col-span-2">
              <label className="field-label" htmlFor="email">
                Email
              </label>
              <input
                id="email"
                type="email"
                required
                className="field-input"
                value={form.email}
                onChange={(e) => setForm({ ...form, email: e.target.value })}
                autoComplete="email"
              />
            </div>
            <div className="sm:col-span-2">
              <label className="field-label" htmlFor="password">
                Password (min 8 characters)
              </label>
              <input
                id="password"
                type="password"
                required
                minLength={8}
                className="field-input"
                value={form.password}
                onChange={(e) => setForm({ ...form, password: e.target.value })}
                autoComplete="new-password"
              />
            </div>
            <div>
              <label className="field-label" htmlFor="college">
                College (optional)
              </label>
              <input
                id="college"
                className="field-input"
                value={form.college}
                onChange={(e) => setForm({ ...form, college: e.target.value })}
              />
            </div>
            <div>
              <label className="field-label" htmlFor="graduation_year">
                Graduation year (optional)
              </label>
              <input
                id="graduation_year"
                type="number"
                min={2000}
                max={2100}
                className="field-input"
                value={form.graduation_year}
                onChange={(e) => setForm({ ...form, graduation_year: e.target.value })}
              />
            </div>
          </div>

          <div>
            <p className="field-label mb-2">Target companies (up to 10)</p>
            {companiesQuery.isLoading && <Spinner label="Loading companies…" />}
            {companiesQuery.isError && <p className="text-sm text-alert-500">Could not load companies.</p>}
            <div className="max-h-56 overflow-y-auto rounded-sm border border-ink-100 divide-y divide-ink-50">
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
            <p className="mt-1 text-xs text-ink-400">{selectedTiers.length} selected</p>
          </div>

          <button type="submit" disabled={submitting} className="btn-primary w-full">
            {submitting ? 'Creating account…' : 'Create account'}
          </button>
        </form>
        <p className="mt-4 text-center text-sm text-ink-400">
          Already have an account?{' '}
          <Link to="/login" className="font-medium text-ink-900 underline underline-offset-2">
            Sign in
          </Link>
        </p>
      </div>
    </div>
  );
}
