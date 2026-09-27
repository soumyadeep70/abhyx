export function ErrorState({ message, onRetry }: { message: string; onRetry?: () => void }) {
  return (
    <div className="rounded-md border border-alert-300 bg-alert-50 p-4 text-sm text-alert-700">
      <p className="font-medium text-alert-500">Something went wrong</p>
      <p className="mt-1 text-ink-600">{message}</p>
      {onRetry && (
        <button onClick={onRetry} className="btn-secondary mt-3">
          Try again
        </button>
      )}
    </div>
  );
}
