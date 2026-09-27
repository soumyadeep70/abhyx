import React from 'react';
export function EmptyState({ title, description, action }: { title: string; description?: string; action?: React.ReactNode }) {
  return (
    <div className="rounded-md border border-dashed border-ink-200 p-8 text-center">
      <p className="font-display font-semibold text-ink-700">{title}</p>
      {description && <p className="mt-1 text-sm text-ink-400">{description}</p>}
      {action && <div className="mt-4">{action}</div>}
    </div>
  );
}
