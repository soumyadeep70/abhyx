import { useState } from 'react';
import { useQuery } from '@tanstack/react-query';
import { Link } from 'react-router-dom';
import { questionsApi } from '../../lib/api/questions';
import { Spinner } from '../../components/ui/Spinner';
import { ErrorState } from '../../components/ui/ErrorState';
import { EmptyState } from '../../components/ui/EmptyState';
import { Pill } from '../../components/ui/Badge';
import { ApiClientError } from '../../lib/apiClient';

export function ProblemListPage() {
  const [topicId, setTopicId] = useState('');
  const [difficulty, setDifficulty] = useState('');

  const topicsQuery = useQuery({ queryKey: ['topics'], queryFn: questionsApi.listTopics });
  const problemsQuery = useQuery({
    queryKey: ['coding-problems', topicId, difficulty],
    queryFn: () =>
      questionsApi.list({
        type: 'coding',
        topic_id: topicId || undefined,
        difficulty: (difficulty || undefined) as 'easy' | 'medium' | 'hard' | undefined,
        page: 1,
        page_size: 50,
      }),
  });

  return (
    <div className="space-y-6">
      <div>
        <h1 className="font-display text-2xl font-bold text-ink-900">Coding Arena</h1>
        <p className="mt-1 text-sm text-ink-400">DSA, SQL, and company-specific problems, judged by Judge0.</p>
      </div>

      <div className="flex flex-wrap gap-3">
        <select className="field-input w-auto" value={topicId} onChange={(e) => setTopicId(e.target.value)}>
          <option value="">All topics</option>
          {(topicsQuery.data ?? []).map((t) => (
            <option key={t.id} value={t.id}>
              {t.name}
            </option>
          ))}
        </select>
        <select className="field-input w-auto" value={difficulty} onChange={(e) => setDifficulty(e.target.value)}>
          <option value="">All difficulties</option>
          <option value="easy">Easy</option>
          <option value="medium">Medium</option>
          <option value="hard">Hard</option>
        </select>
        <Link to="/coding/submissions" className="btn-secondary ml-auto text-sm">
          My submissions
        </Link>
      </div>

      {problemsQuery.isLoading && <Spinner label="Loading problems…" />}
      {problemsQuery.isError && (
        <ErrorState message={problemsQuery.error instanceof ApiClientError ? problemsQuery.error.message : 'Failed to load'} onRetry={() => problemsQuery.refetch()} />
      )}
      {problemsQuery.data && problemsQuery.data.questions.length === 0 && (
        <EmptyState title="No problems match these filters" description="Try clearing a filter, or check back after an admin adds more problems." />
      )}
      {problemsQuery.data && problemsQuery.data.questions.length > 0 && (
        <div className="card divide-y divide-ink-50 p-0">
          {problemsQuery.data.questions.map((q) => (
            <Link key={q.id} to={`/coding/${q.id}`} className="flex items-center justify-between gap-4 px-5 py-3 hover:bg-ink-50">
              <div>
                <p className="font-medium text-ink-900">{q.title}</p>
                <p className="text-xs text-ink-400">{q.topic_name}</p>
              </div>
              <Pill tone={q.difficulty === 'hard' ? 'danger' : q.difficulty === 'medium' ? 'warning' : 'positive'}>{q.difficulty}</Pill>
            </Link>
          ))}
        </div>
      )}
    </div>
  );
}
