import { useMemo, useState } from 'react';
import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import { Link, useParams, useSearchParams } from 'react-router-dom';
import Editor from '@monaco-editor/react';
import { useAuth } from '../../lib/auth-context';
import { codingApi } from '../../lib/api/coding';
import { Spinner } from '../../components/ui/Spinner';
import { ErrorState } from '../../components/ui/ErrorState';
import { Pill } from '../../components/ui/Badge';
import { ApiClientError } from '../../lib/apiClient';

const LANGUAGES: { value: 'python' | 'javascript' | 'java' | 'cpp'; label: string; monaco: string }[] = [
  { value: 'python', label: 'Python', monaco: 'python' },
  { value: 'javascript', label: 'JavaScript', monaco: 'javascript' },
  { value: 'java', label: 'Java', monaco: 'java' },
  { value: 'cpp', label: 'C++', monaco: 'cpp' },
];

const DEFAULT_STUBS: Record<string, string> = {
  python: '# Write your solution here\n\n',
  javascript: '// Write your solution here\n\n',
  java: '// Write your solution here\n\nclass Solution {\n\n}\n',
  cpp: '// Write your solution here\n\n#include <bits/stdc++.h>\nusing namespace std;\n\n',
};

export function ProblemDetailPage() {
  const { questionId } = useParams<{ questionId: string }>();
  const [searchParams] = useSearchParams();
  const mockTestId = searchParams.get('mock_test_id') ?? undefined;
  const { user } = useAuth();
  const queryClient = useQueryClient();
  const [language, setLanguage] = useState<'python' | 'javascript' | 'java' | 'cpp'>('python');
  const [startedAt] = useState(Date.now());
  const [code, setCode] = useState<string | null>(null);

  const problemQuery = useQuery({
    queryKey: ['coding-problem', questionId],
    queryFn: () => codingApi.getProblem(questionId!),
    enabled: !!questionId,
  });

  const starterForLanguage = useMemo(() => {
    const starter = problemQuery.data?.starter_code?.[language];
    return starter ?? DEFAULT_STUBS[language];
  }, [problemQuery.data, language]);

  const submitMutation = useMutation({
    mutationFn: () =>
      codingApi.submit({
        question_id: questionId!,
        language,
        source_code: code ?? starterForLanguage,
        time_taken_seconds: Math.max(1, Math.round((Date.now() - startedAt) / 1000)),
        mock_test_id: mockTestId,
      }),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['coding-submissions', user!.id] });
      queryClient.invalidateQueries({ queryKey: ['dashboard', user!.id] });
    },
  });

  if (problemQuery.isLoading) return <Spinner label="Loading problem…" />;
  if (problemQuery.isError)
    return <ErrorState message={problemQuery.error instanceof ApiClientError ? problemQuery.error.message : 'Failed to load problem'} onRetry={() => problemQuery.refetch()} />;

  const problem = problemQuery.data!;
  const activeCode = code ?? starterForLanguage;

  return (
    <div className="space-y-6">
      <Link to={mockTestId ? `/mock-tests/${mockTestId}` : '/coding'} className="text-sm text-ink-400 underline">
        {mockTestId ? '← Back to mock test' : '← Back to problems'}
      </Link>
      {mockTestId && (
        <p className="rounded-sm bg-signal-50 px-3 py-2 text-xs text-signal-700">
          This submission counts toward mock test {mockTestId.slice(0, 8)}…
        </p>
      )}

      <div className="grid grid-cols-1 gap-6 lg:grid-cols-2">
        <div className="card">
          <div className="flex items-center justify-between">
            <h1 className="font-display text-xl font-bold text-ink-900">{problem.title}</h1>
            <Pill tone={problem.difficulty === 'hard' ? 'danger' : problem.difficulty === 'medium' ? 'warning' : 'positive'}>
              {problem.difficulty}
            </Pill>
          </div>
          <p className="mt-1 text-xs text-ink-400">{problem.topic_name}</p>
          {problem.prompt && <p className="mt-4 whitespace-pre-wrap text-sm text-ink-700">{problem.prompt}</p>}
          {problem.function_signature && (
            <pre className="mt-3 overflow-x-auto rounded-sm bg-ink-900 px-3 py-2 text-xs text-paper">{problem.function_signature}</pre>
          )}
          {problem.sample_test_cases && problem.sample_test_cases.length > 0 && (
            <>
              <p className="mt-4 text-xs font-medium uppercase tracking-wide text-ink-400">Sample</p>
              {problem.sample_test_cases.map((tc, i) => (
                <div key={i} className="mt-1 rounded-sm bg-ink-50 px-3 py-2 text-xs text-ink-700">
                  <p>
                    <span className="font-medium">Input:</span> {tc.input}
                  </p>
                  <p>
                    <span className="font-medium">Expected:</span> {tc.expected}
                  </p>
                </div>
              ))}
            </>
          )}
          {problem.constraints_text && (
            <>
              <p className="mt-4 text-xs font-medium uppercase tracking-wide text-ink-400">Constraints</p>
              <p className="mt-1 whitespace-pre-wrap text-sm text-ink-600">{problem.constraints_text}</p>
            </>
          )}
        </div>

        <div className="card flex flex-col p-0 overflow-hidden">
          <div className="flex items-center justify-between border-b border-ink-100 px-4 py-2">
            <select
              className="field-input w-auto"
              value={language}
              onChange={(e) => {
                setLanguage(e.target.value as typeof language);
                setCode(null);
              }}
            >
              {LANGUAGES.map((l) => (
                <option key={l.value} value={l.value}>
                  {l.label}
                </option>
              ))}
            </select>
            <button className="btn-signal" disabled={submitMutation.isPending} onClick={() => submitMutation.mutate()}>
              {submitMutation.isPending ? 'Running…' : 'Run & Submit'}
            </button>
          </div>
          <div className="h-[420px]">
            <Editor
              height="100%"
              theme="vs-dark"
              language={LANGUAGES.find((l) => l.value === language)?.monaco}
              value={activeCode}
              onChange={(value) => setCode(value ?? '')}
              options={{ fontSize: 13, minimap: { enabled: false }, automaticLayout: true }}
            />
          </div>
          {submitMutation.isError && (
            <div className="border-t border-ink-100 p-4">
              <ErrorState message={submitMutation.error instanceof ApiClientError ? submitMutation.error.message : 'Submission failed'} />
            </div>
          )}
          {submitMutation.data && (
            <div className="border-t border-ink-100 p-4 space-y-2">
              <p
                className={`inline-block rounded-sm px-3 py-1.5 text-sm font-medium ${
                  submitMutation.data.status === 'accepted' ? 'bg-momentum-50 text-momentum-600' : 'bg-alert-50 text-alert-500'
                }`}
              >
                {submitMutation.data.status.replace('_', ' ')}
              </p>
              <p className="text-xs text-ink-500">
                {submitMutation.data.test_cases_passed}/{submitMutation.data.test_cases_total} test cases passed
                {submitMutation.data.runtime_ms !== null && ` · ${submitMutation.data.runtime_ms}ms`}
                {submitMutation.data.memory_kb !== null && ` · ${Math.round(submitMutation.data.memory_kb / 1024)}MB`}
              </p>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
