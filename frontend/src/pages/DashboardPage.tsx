import { useQuery } from '@tanstack/react-query';
import {
  Bar,
  BarChart,
  CartesianGrid,
  Legend,
  Line,
  LineChart,
  PolarAngleAxis,
  PolarGrid,
  Radar,
  RadarChart,
  ResponsiveContainer,
  Tooltip,
  XAxis,
  YAxis,
} from 'recharts';
import { Link } from 'react-router-dom';
import { useAuth } from '../lib/auth-context';
import { analyticsApi } from '../lib/api/analytics';
import { Spinner } from '../components/ui/Spinner';
import { ErrorState } from '../components/ui/ErrorState';
import { EmptyState } from '../components/ui/EmptyState';
import { StatCard } from '../components/ui/StatCard';
import { ApiClientError } from '../lib/apiClient';

function accuracyColor(accuracy: number): string {
  if (accuracy >= 75) return '#0F8A7A';
  if (accuracy >= 50) return '#E0B36B';
  return '#B5473C';
}

export function DashboardPage() {
  const { user } = useAuth();
  const query = useQuery({
    queryKey: ['dashboard', user!.id],
    queryFn: () => analyticsApi.getDashboard(user!.id),
  });

  if (query.isLoading) return <Spinner label="Loading your dashboard…" />;
  if (query.isError)
    return <ErrorState message={query.error instanceof ApiClientError ? query.error.message : 'Failed to load'} onRetry={() => query.refetch()} />;

  const data = query.data!;
  const activitySet = new Set(data.activity_dates.map((d) => d.slice(0, 10)));
  const today = new Date();
  const days: { date: string; active: boolean }[] = [];
  for (let i = 111; i >= 0; i--) {
    const d = new Date(today);
    d.setDate(d.getDate() - i);
    const iso = d.toISOString().slice(0, 10);
    days.push({ date: iso, active: activitySet.has(iso) });
  }

  const topInterview = data.interview_radar[0];
  const radarData = topInterview
    ? [
        { dimension: 'Technical', value: topInterview.technical_accuracy },
        { dimension: 'Communication', value: topInterview.communication_clarity },
        { dimension: 'Problem solving', value: topInterview.problem_solving_approach },
        { dimension: 'Depth', value: topInterview.depth_of_knowledge },
        ...(topInterview.hr_readiness !== null ? [{ dimension: 'HR readiness', value: topInterview.hr_readiness }] : []),
      ]
    : [];

  // coding_progress arrives as one row per (week, difficulty); pivot into one row per
  // week with a column per difficulty so recharts can draw three comparable lines.
  const codingByWeek = new Map<string, { week: string; easy: number; medium: number; hard: number }>();
  for (const row of data.coding_progress) {
    const label = new Date(row.week).toLocaleDateString(undefined, { month: 'short', day: 'numeric' });
    const entry = codingByWeek.get(label) ?? { week: label, easy: 0, medium: 0, hard: 0 };
    entry[row.difficulty] = Number(row.solved);
    codingByWeek.set(label, entry);
  }
  const codingSeries = [...codingByWeek.values()];

  return (
    <div className="space-y-8">
      <div>
        <h1 className="font-display text-2xl font-bold text-ink-900">Welcome back, {user?.full_name.split(' ')[0]}</h1>
        <p className="mt-1 text-sm text-ink-400">Here's where your placement readiness stands today.</p>
      </div>

      <div className="grid grid-cols-2 gap-4 sm:grid-cols-4">
        <StatCard
          label="Current streak"
          value={`${data.streak.current_streak ?? 0}d`}
          sub={data.streak.longest_streak ? `Best: ${data.streak.longest_streak}d` : undefined}
          tone="positive"
        />
        <StatCard
          label="Top readiness score"
          value={data.readiness[0] ? `${Math.round(data.readiness[0].score)}` : '—'}
          sub={data.readiness[0] ? `${data.readiness[0].company_name} · ${data.readiness[0].tier_name}` : 'Pick target companies'}
        />
        <StatCard
          label="Companies tracked"
          value={data.readiness.length}
          sub={<Link to="/readiness" className="underline">View breakdown</Link>}
        />
        <StatCard
          label="Weak topics"
          value={data.topic_heatmap.filter((t) => t.label === 'weak').length}
          sub={<Link to="/assessment" className="underline">Practice now</Link>}
          tone={data.topic_heatmap.some((t) => t.label === 'weak') ? 'warning' : 'default'}
        />
      </div>

      <div className="grid grid-cols-1 gap-6 lg:grid-cols-2">
        <div className="card">
          <p className="font-display font-semibold text-ink-900">Readiness by company</p>
          <p className="text-xs text-ink-400">Weighted score out of 100</p>
          {data.readiness.length === 0 ? (
            <EmptyState title="No target companies yet" description="Add target companies from your profile to see readiness scores." />
          ) : (
            <div className="mt-4 h-64">
              <ResponsiveContainer width="100%" height="100%">
                <BarChart data={data.readiness.map((r) => ({ name: `${r.company_name} ${r.tier_name}`, score: r.score }))}>
                  <CartesianGrid strokeDasharray="3 3" stroke="#E4E6EC" />
                  <XAxis dataKey="name" tick={{ fontSize: 11 }} interval={0} angle={-15} textAnchor="end" height={50} />
                  <YAxis domain={[0, 100]} tick={{ fontSize: 11 }} />
                  <Tooltip />
                  <Bar dataKey="score" fill="#C88A2E" radius={[3, 3, 0, 0]} />
                </BarChart>
              </ResponsiveContainer>
            </div>
          )}
        </div>

        <div className="card">
          <p className="font-display font-semibold text-ink-900">Interview dimensions</p>
          <p className="text-xs text-ink-400">
            {topInterview ? `Latest ${topInterview.round_type.replace('_', ' ')} round` : 'No sessions yet'}
          </p>
          {!topInterview ? (
            <EmptyState title="No interview sessions yet" description="Start a mock interview to see your 5-dimension scorecard." action={<Link to="/interview" className="btn-signal">Start interview</Link>} />
          ) : (
            <div className="mt-4 h-64">
              <ResponsiveContainer width="100%" height="100%">
                <RadarChart data={radarData}>
                  <PolarGrid stroke="#E4E6EC" />
                  <PolarAngleAxis dataKey="dimension" tick={{ fontSize: 11 }} />
                  <Radar dataKey="value" stroke="#0F8A7A" fill="#0F8A7A" fillOpacity={0.35} />
                  <Tooltip />
                </RadarChart>
              </ResponsiveContainer>
            </div>
          )}
        </div>
      </div>

      <div className="card">
        <p className="font-display font-semibold text-ink-900">Topic accuracy heatmap</p>
        <p className="text-xs text-ink-400">Green = strong, red = weak</p>
        {data.topic_heatmap.length === 0 ? (
          <EmptyState title="No practice attempts yet" description="Answer some aptitude questions to populate this heatmap." action={<Link to="/assessment" className="btn-signal">Start practicing</Link>} />
        ) : (
          <div className="mt-4 flex flex-wrap gap-2">
            {data.topic_heatmap.map((t) => (
              <div
                key={t.topic_id}
                className="rounded-sm px-3 py-2 text-xs font-medium text-white min-w-[7rem]"
                style={{ backgroundColor: accuracyColor(t.accuracy * 100) }}
                title={`${t.attempts} attempts · ${t.category}`}
              >
                <p className="truncate">{t.topic_name}</p>
                <p className="text-white/80">{Math.round(t.accuracy * 100)}%</p>
              </div>
            ))}
          </div>
        )}
      </div>

      <div className="grid grid-cols-1 gap-6 lg:grid-cols-2">
        <div className="card">
          <p className="font-display font-semibold text-ink-900">Coding progress by difficulty</p>
          {data.coding_progress.length === 0 ? (
            <EmptyState title="No submissions yet" description="Solve a coding problem to start tracking progress." action={<Link to="/coding" className="btn-signal">Open Coding Arena</Link>} />
          ) : (
            <div className="mt-4 h-64">
              <ResponsiveContainer width="100%" height="100%">
                <LineChart data={codingSeries}>
                  <CartesianGrid strokeDasharray="3 3" stroke="#E4E6EC" />
                  <XAxis dataKey="week" tick={{ fontSize: 11 }} />
                  <YAxis allowDecimals={false} tick={{ fontSize: 11 }} />
                  <Tooltip />
                  <Legend />
                  <Line type="monotone" dataKey="easy" name="Easy" stroke="#0F8A7A" strokeWidth={2} />
                  <Line type="monotone" dataKey="medium" name="Medium" stroke="#E0B36B" strokeWidth={2} />
                  <Line type="monotone" dataKey="hard" name="Hard" stroke="#B5473C" strokeWidth={2} />
                </LineChart>
              </ResponsiveContainer>
            </div>
          )}
        </div>

        <div className="card">
          <p className="font-display font-semibold text-ink-900">Activity — last 16 weeks</p>
          <div className="mt-4 grid grid-flow-col grid-rows-7 gap-1" style={{ gridTemplateColumns: 'repeat(16, minmax(0,1fr))' }}>
            {days.map((d) => (
              <div
                key={d.date}
                title={d.date}
                className={`h-3 w-3 rounded-[2px] ${d.active ? 'bg-momentum-500' : 'bg-ink-100'}`}
              />
            ))}
          </div>
          <p className="mt-3 text-xs text-ink-400">
            Current streak: <span className="font-medium text-ink-700">{data.streak.current_streak ?? 0} days</span>
          </p>
        </div>
      </div>
    </div>
  );
}
