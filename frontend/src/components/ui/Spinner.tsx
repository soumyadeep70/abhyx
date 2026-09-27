export function Spinner({ label = 'Loading…' }: { label?: string }) {
  return (
    <div className="flex items-center gap-2 py-8 justify-center text-ink-400 text-sm">
      <span className="h-4 w-4 rounded-full border-2 border-ink-200 border-t-signal-500 animate-spin" />
      {label}
    </div>
  );
}
