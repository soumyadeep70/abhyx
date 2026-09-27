import React from 'react';
import clsx from 'clsx';

export function StatCard({
  label,
  value,
  sub,
  tone = 'default',
}: {
  label: string;
  value: React.ReactNode;
  sub?: React.ReactNode;
  tone?: 'default' | 'positive' | 'warning';
}) {
  return (
    <div className="card">
      <p className="text-xs font-medium uppercase tracking-wide text-ink-400">{label}</p>
      <p
        className={clsx(
          'mt-2 font-display text-3xl font-semibold',
          tone === 'positive' && 'text-momentum-600',
          tone === 'warning' && 'text-alert-500',
          tone === 'default' && 'text-ink-900'
        )}
      >
        {value}
      </p>
      {sub && <p className="mt-1 text-xs text-ink-400">{sub}</p>}
    </div>
  );
}
