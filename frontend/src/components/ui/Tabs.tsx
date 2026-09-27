import clsx from 'clsx';

export function Tabs<T extends string>({
  value,
  onChange,
  options,
}: {
  value: T;
  onChange: (value: T) => void;
  options: { value: T; label: string }[];
}) {
  return (
    <div className="inline-flex rounded-md border border-ink-200 bg-white p-1">
      {options.map((opt) => (
        <button
          key={opt.value}
          onClick={() => onChange(opt.value)}
          className={clsx(
            'rounded-sm px-3 py-1.5 text-sm font-medium transition-colors',
            value === opt.value ? 'bg-ink-900 text-paper' : 'text-ink-500 hover:text-ink-900'
          )}
        >
          {opt.label}
        </button>
      ))}
    </div>
  );
}
