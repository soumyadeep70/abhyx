import { NavLink, Outlet } from 'react-router-dom';
import clsx from 'clsx';
import { useAuth } from '../../lib/auth-context';

const NAV_SECTIONS: { title: string; items: { to: string; label: string }[] }[] = [
  {
    title: 'Overview',
    items: [{ to: '/', label: 'Dashboard' }],
  },
  {
    title: 'Practice',
    items: [
      { to: '/assessment', label: 'Aptitude Practice' },
      { to: '/coding', label: 'Coding Arena' },
      { to: '/mock-tests', label: 'Mock Tests' },
      { to: '/interview', label: 'Mock Interview' },
    ],
  },
  {
    title: 'Growth',
    items: [
      { to: '/resume', label: 'Resume Intelligence' },
      { to: '/roadmap', label: 'Roadmap' },
      { to: '/readiness', label: 'Placement Readiness' },
    ],
  },
  {
    title: 'Community',
    items: [
      { to: '/companies', label: 'Companies' },
      { to: '/leaderboard', label: 'Leaderboard' },
      { to: '/badges', label: 'Badges' },
    ],
  },
  {
    title: 'You',
    items: [{ to: '/profile', label: 'Profile' }],
  },
];

export function AppShell() {
  const { user, logout } = useAuth();

  return (
    <div className="min-h-screen flex bg-paper">
      <aside className="hidden md:flex w-64 shrink-0 flex-col border-r border-ink-100 bg-white">
        <div className="px-5 py-5 border-b border-ink-100">
          <p className="font-display text-lg font-bold tracking-tight text-ink-900">Ascent</p>
          <p className="text-xs text-ink-400">Placement readiness platform</p>
        </div>
        <nav className="flex-1 overflow-y-auto px-3 py-4 space-y-6">
          {NAV_SECTIONS.map((section) => (
            <div key={section.title}>
              <p className="px-2 text-[11px] font-semibold uppercase tracking-wider text-ink-300">{section.title}</p>
              <div className="mt-1 space-y-0.5">
                {section.items.map((item) => (
                  <NavLink
                    key={item.to}
                    to={item.to}
                    end={item.to === '/'}
                    className={({ isActive }) =>
                      clsx(
                        'block rounded-sm px-2.5 py-1.5 text-sm font-medium transition-colors',
                        isActive ? 'bg-ink-900 text-paper' : 'text-ink-600 hover:bg-ink-50'
                      )
                    }
                  >
                    {item.label}
                  </NavLink>
                ))}
              </div>
            </div>
          ))}
          {user?.role === 'admin' && (
            <div>
              <p className="px-2 text-[11px] font-semibold uppercase tracking-wider text-ink-300">Admin</p>
              <div className="mt-1 space-y-0.5">
                <NavLink
                  to="/admin/questions"
                  className={({ isActive }) =>
                    clsx(
                      'block rounded-sm px-2.5 py-1.5 text-sm font-medium transition-colors',
                      isActive ? 'bg-ink-900 text-paper' : 'text-ink-600 hover:bg-ink-50'
                    )
                  }
                >
                  Question Bank
                </NavLink>
              </div>
            </div>
          )}
        </nav>
        <div className="border-t border-ink-100 px-5 py-4">
          <p className="text-sm font-medium text-ink-900 truncate">{user?.full_name}</p>
          <p className="text-xs text-ink-400 truncate">{user?.email}</p>
          <button onClick={() => logout()} className="btn-secondary mt-3 w-full text-xs">
            Sign out
          </button>
        </div>
      </aside>

      <div className="flex-1 min-w-0 flex flex-col">
        <header className="md:hidden flex items-center justify-between border-b border-ink-100 bg-white px-4 py-3">
          <p className="font-display font-bold text-ink-900">Ascent</p>
          <button onClick={() => logout()} className="text-xs font-medium text-ink-500">
            Sign out
          </button>
        </header>
        <main className="flex-1 min-w-0 px-4 py-6 md:px-10 md:py-8">
          <div className="mx-auto max-w-6xl">
            <Outlet />
          </div>
        </main>
      </div>
    </div>
  );
}
