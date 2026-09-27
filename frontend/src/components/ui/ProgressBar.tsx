import clsx from 'clsx';

export function ProgressBar({ value, tone = 'signal' }: { value: number; tone?: 'signal' | 'momentum' | 'alert' }) {
  const clamped = Math.max(0, Math.min(100, value));
  return (
    <div className="h-2 w-full rounded-full bg-ink-100">
      <div
        className={clsx(
          'h-2 rounded-full transition-all',
          tone === 'signal' && 'bg-signal-500',
          tone === 'momentum' && 'bg-momentum-500',
          tone === 'alert' && 'bg-alert-500'
        )}
        style={{ width: `${clamped}%` }}
      />
    </div>
  );
}
