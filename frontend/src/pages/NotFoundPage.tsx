import { Link } from 'react-router-dom';

export function NotFoundPage() {
  return (
    <div className="flex flex-col items-center justify-center py-24 text-center">
      <p className="font-display text-4xl font-bold text-ink-900">404</p>
      <p className="mt-2 text-sm text-ink-400">This page doesn't exist.</p>
      <Link to="/" className="btn-primary mt-6">
        Back to dashboard
      </Link>
    </div>
  );
}
