import { useState } from 'react';
import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import { Link, useNavigate, useParams } from 'react-router-dom';
import { useAuth } from '../../lib/auth-context';
import { mockTestsApi } from '../../lib/api/mockTests';
import { assessmentApi } from '../../lib/api/assessment';
import { questionsApi } from '../../lib/api/questions';
import { Spinner } from '../../components/ui/Spinner';
import { ErrorState } from '../../components/ui/ErrorState';
import { Pill } from '../../components/ui/Badge';
import { ApiClientError } from '../../lib/apiClient';
import type { AptitudeQuestionDetail } from '../../lib/types';

const LETTERS = ['A', 'B', 'C', 'D', 'E', 'F'];

function AptitudeItem({ questionId, mockTestId, onAnswered }: { questionId: string; mockTestId: string; onAnswered: () => void }) {
  const detailQuery = useQuery({ queryKey: ['question', questionId], queryFn: () => questionsApi.get(questionId) });
  const [selected, setSelected] = useState<number | null>(null);
  const [answered, setAnswered] = useState(false);

  const submitMutation = useMutation({
    mutationFn: (choice: string) => assessmentApi.submit({ question_id: questionId, answer: { choice }, mock_test_id: mockTestId }),
    onSuccess: () => {
      setAnswered(true);
      onAnswered();
    },
  });

  if (detailQuery.isLoading) return <Spinner label="Loading question…" />;
  if (detailQuery.isError || !detailQuery.data) return <ErrorState message="Failed to load this question." />;

  const question = detailQuery.data as AptitudeQuestionDetail;

  return (
    <div className="space-y-2">
      {question.prompt && <p className="text-sm text-ink-700 whitespace-pre-wrap">{question.prompt}</p>}
      {(question.options ?? []).map((opt, i) => (
        <button
          key={i}
          disabled={answered}
          onClick={() => setSelected(i)}
          className={`w-full rounded-sm border px-4 py-2 text-left text-sm ${
            selected === i ? 'border-signal-500 bg-signal-50' : 'border-ink-200 hover:bg-ink-50'
          } disabled:opacity-70`}
        >
          <span className="mr-2 font-medium text-ink-400">{LETTERS[i] ?? i}.</span>
          {opt}
        </button>
      ))}
      {!answered ? (
        <button
          className="btn-primary mt-2"
          disabled={selected === null || submitMutation.isPending}
          onClick={() => selected !== null && submitMutation.mutate(LETTERS[selected] ?? String(selected))}
        >
          {submitMutation.isPending ? 'Submitting…' : 'Submit answer'}
        </button>
      ) : (
        <p className="text-sm font-medium text-momentum-600">Answer recorded.</p>
      )}
    </div>
  );
}

export function MockTestDetailPage() {
  const { mockTestId } = useParams<{ mockTestId: string }>();
  const { user } = useAuth();
  const navigate = useNavigate();
  const queryClient = useQueryClient();
  const [answeredIds, setAnsweredIds] = useState<Set<string>>(new Set());

  const testQuery = useQuery({ queryKey: ['mock-test', mockTestId], queryFn: () => mockTestsApi.get(mockTestId!), enabled: !!mockTestId });

  const completeMutation = useMutation({
    mutationFn: () => mockTestsApi.complete(mockTestId!),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['mock-tests', user!.id] });
      queryClient.invalidateQueries({ queryKey: ['mock-test', mockTestId] });
    },
  });
  const abandonMutation = useMutation({
    mutationFn: () => mockTestsApi.abandon(mockTestId!),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['mock-tests', user!.id] });
      navigate('/mock-tests');
    },
  });

  if (testQuery.isLoading) return <Spinner label="Loading mock test…" />;
  if (testQuery.isError || !testQuery.data)
    return <ErrorState message={testQuery.error instanceof ApiClientError ? testQuery.error.message : 'Failed to load mock test'} onRetry={() => testQuery.refetch()} />;

  const test = testQuery.data;
  const isInProgress = test.status === 'in_progress';

  return (
    <div className="space-y-6">
      <Link to="/mock-tests" className="text-sm text-ink-400 underline">
        ← Back to mock tests
      </Link>

      <div className="flex flex-wrap items-center justify-between gap-3">
        <div>
          <h1 className="font-display text-2xl font-bold text-ink-900">
            {test.company_name ? `${test.company_name} · ${test.tier_name}` : 'Mock test'}
          </h1>
          <p className="mt-1 text-sm text-ink-400">{test.questions?.length ?? 0} questions · started {new Date(test.started_at).toLocaleString()}</p>
        </div>
        <div className="flex items-center gap-3">
          <Pill tone={test.status === 'completed' ? 'positive' : test.status === 'abandoned' ? 'danger' : 'warning'}>{test.status.replace('_', ' ')}</Pill>
          {isInProgress && (
            <>
              <button className="btn-secondary text-sm" onClick={() => abandonMutation.mutate()} disabled={abandonMutation.isPending}>
                Abandon
              </button>
              <button className="btn-primary text-sm" onClick={() => completeMutation.mutate()} disabled={completeMutation.isPending}>
                {completeMutation.isPending ? 'Finishing…' : 'Finish test'}
              </button>
            </>
          )}
        </div>
      </div>

      {test.status === 'completed' && test.total_score != null && (
        <div className="card">
          <p className="text-xs font-medium uppercase tracking-wide text-ink-400">Final score</p>
          <p className="font-display text-3xl font-semibold text-momentum-600">{Math.round(test.total_score)}%</p>
        </div>
      )}

      <div className="space-y-4">
        {(test.questions ?? []).map((q) => (
          <div key={q.question_id} className="card">
            <div className="flex items-center justify-between">
              <p className="font-display font-semibold text-ink-900">
                {q.order_index}. {q.title}
              </p>
              <div className="flex gap-2">
                <Pill tone="neutral">{q.topic_name}</Pill>
                <Pill tone={q.difficulty === 'hard' ? 'danger' : q.difficulty === 'medium' ? 'warning' : 'positive'}>{q.difficulty}</Pill>
              </div>
            </div>
            <div className="mt-3">
              {q.type === 'coding' ? (
                <Link to={`/coding/${q.question_id}?mock_test_id=${mockTestId}`} className="btn-secondary text-sm">
                  Open in Coding Arena
                </Link>
              ) : isInProgress ? (
                <AptitudeItem
                  questionId={q.question_id}
                  mockTestId={mockTestId!}
                  onAnswered={() => setAnsweredIds((prev) => new Set(prev).add(q.question_id))}
                />
              ) : (
                <p className="text-sm text-ink-400">This test is no longer in progress.</p>
              )}
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
