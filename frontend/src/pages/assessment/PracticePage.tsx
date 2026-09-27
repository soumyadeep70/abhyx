import { useState } from 'react';
import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import { Link } from 'react-router-dom';
import { useAuth } from '../../lib/auth-context';
import { assessmentApi } from '../../lib/api/assessment';
import { Spinner } from '../../components/ui/Spinner';
import { ErrorState } from '../../components/ui/ErrorState';
import { EmptyState } from '../../components/ui/EmptyState';
import { Pill } from '../../components/ui/Badge';
import { ApiClientError } from '../../lib/apiClient';

const LETTERS = ['A', 'B', 'C', 'D', 'E', 'F'];

export function PracticePage() {
  const { user } = useAuth();
  const queryClient = useQueryClient();
  const [selected, setSelected] = useState<number | null>(null);
  const [result, setResult] = useState<{ isCorrect: boolean } | null>(null);
  const [startedAt, setStartedAt] = useState(Date.now());
  const [hintsUsed, setHintsUsed] = useState(0);

  const questionQuery = useQuery({
    queryKey: ['next-question'],
    queryFn: () => assessmentApi.next({ category: 'aptitude' }),
  });

  const submitMutation = useMutation({
    mutationFn: (choice: string) =>
      assessmentApi.submit({
        question_id: questionQuery.data!.id,
        answer: { choice },
        time_taken_seconds: Math.max(1, Math.round((Date.now() - startedAt) / 1000)),
        hints_used: hintsUsed,
      }),
    onSuccess: (data) => {
      setResult({ isCorrect: data.is_correct });
      queryClient.invalidateQueries({ queryKey: ['topic-analytics', user!.id] });
      queryClient.invalidateQueries({ queryKey: ['dashboard', user!.id] });
    },
  });

  function nextQuestion() {
    setSelected(null);
    setResult(null);
    setHintsUsed(0);
    setStartedAt(Date.now());
    questionQuery.refetch();
  }

  if (questionQuery.isLoading) return <Spinner label="Fetching an adaptive question…" />;
  if (questionQuery.isError)
    return (
      <ErrorState
        message={questionQuery.error instanceof ApiClientError ? questionQuery.error.message : 'Failed to load question'}
        onRetry={() => questionQuery.refetch()}
      />
    );

  const question = questionQuery.data;

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="font-display text-2xl font-bold text-ink-900">Aptitude Practice</h1>
          <p className="mt-1 text-sm text-ink-400">Questions are served adaptively based on your weak topics.</p>
        </div>
        <Link to="/assessment/analytics" className="btn-secondary text-sm">
          View topic analytics
        </Link>
      </div>

      {!question ? (
        <EmptyState title="You're all caught up" description="No more adaptive questions available right now — check back later." />
      ) : (
        <div className="card max-w-2xl">
          <div className="flex items-center justify-between">
            <Pill tone="neutral">{question.topic_name}</Pill>
            <Pill tone={question.difficulty === 'hard' ? 'danger' : question.difficulty === 'medium' ? 'warning' : 'positive'}>
              {question.difficulty}
            </Pill>
          </div>
          <p className="mt-4 font-display text-lg font-semibold text-ink-900">{question.title}</p>
          {question.prompt && <p className="mt-2 text-sm text-ink-600 whitespace-pre-wrap">{question.prompt}</p>}

          <div className="mt-5 space-y-2">
            {question.options.map((opt, i) => {
              const letter = LETTERS[i] ?? String(i);
              const isSelected = selected === i;
              return (
                <button
                  key={i}
                  disabled={!!result}
                  onClick={() => setSelected(i)}
                  className={`w-full rounded-sm border px-4 py-2.5 text-left text-sm transition-colors ${
                    isSelected ? 'border-signal-500 bg-signal-50' : 'border-ink-200 hover:bg-ink-50'
                  } disabled:opacity-70`}
                >
                  <span className="mr-2 font-medium text-ink-400">{letter}.</span>
                  {opt}
                </button>
              );
            })}
          </div>

          {!result ? (
            <div className="mt-5 flex items-center gap-3">
              <button
                className="btn-primary"
                disabled={selected === null || submitMutation.isPending}
                onClick={() => selected !== null && submitMutation.mutate(LETTERS[selected] ?? String(selected))}
              >
                {submitMutation.isPending ? 'Submitting…' : 'Submit answer'}
              </button>
              <button className="text-xs text-ink-400 underline" onClick={() => setHintsUsed((h) => h + 1)}>
                Use a hint ({hintsUsed})
              </button>
            </div>
          ) : (
            <div className="mt-5 space-y-3">
              <p
                className={`rounded-sm px-3 py-2 text-sm font-medium ${
                  result.isCorrect ? 'bg-momentum-50 text-momentum-600' : 'bg-alert-50 text-alert-500'
                }`}
              >
                {result.isCorrect ? 'Correct!' : 'Not quite — review and try the next one.'}
              </p>
              <button className="btn-primary" onClick={nextQuestion}>
                Next question
              </button>
            </div>
          )}
        </div>
      )}
    </div>
  );
}
