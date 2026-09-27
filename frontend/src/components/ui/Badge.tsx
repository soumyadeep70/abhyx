import React from 'react';
import clsx from 'clsx';

const toneClasses: Record<string, string> = {
  neutral: 'bg-ink-100 text-ink-600',
  positive: 'bg-momentum-50 text-momentum-600',
  warning: 'bg-signal-50 text-signal-700',
  danger: 'bg-alert-50 text-alert-500',
};

export function Pill({ tone = 'neutral', children }: { tone?: keyof typeof toneClasses; children: React.ReactNode }) {
  return <span className={clsx('chip', toneClasses[tone])}>{children}</span>;
}
