import { useState } from 'react';
import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import { questionsApi } from '../../lib/api/questions';
import { Spinner } from '../../components/ui/Spinner';
import { ErrorState } from '../../components/ui/ErrorState';
import { EmptyState } from '../../components/ui/EmptyState';
import { Pill } from '../../components/ui/Badge';
import { Tabs } from '../../components/ui/Tabs';
import { ApiClientError } from '../../lib/apiClient';

const LETTERS = ['A', 'B', 'C', 'D', 'E', 'F'];

interface TestCaseDraft {
  input: string;
  expected: string;
}

function AptitudeForm({ onCreated }: { onCreated: () => void }) {
  const topicsQuery = useQuery({ queryKey: ['topics'], queryFn: questionsApi.listTopics });
  const [form, setForm] = useState({ topic_id: '', difficulty: 'easy' as 'easy' | 'medium' | 'hard', title: '', prompt: '' });
  const [options, setOptions] = useState(['', '']);
  const [correctIndex, setCorrectIndex] = useState(0);

  const createMutation = useMutation({
    mutationFn: () =>
      questionsApi.create({
        type: 'aptitude',
        topic_id: form.topic_id,
        difficulty: form.difficulty,
        title: form.title,
        prompt: form.prompt,
        options: options.filter((o) => o.trim().length > 0),
        correct_answer: { choice: LETTERS[correctIndex] },
      }),
    onSuccess: () => {
      setForm({ topic_id: '', difficulty: 'easy', title: '', prompt: '' });
      setOptions(['', '']);
      setCorrectIndex(0);
      onCreated();
    },
  });

  const validOptions = options.filter((o) => o.trim().length > 0);
  const canSubmit = form.topic_id && form.title && form.prompt && validOptions.length >= 2;

  return (
    <div className="space-y-3">
      <div>
        <label className="field-label">Topic</label>
        <select className="field-input" value={form.topic_id} onChange={(e) => setForm({ ...form, topic_id: e.target.value })}>
          <option value="">Select topic</option>
          {(topicsQuery.data ?? []).map((t) => (
            <option key={t.id} value={t.id}>
              {t.name}
            </option>
          ))}
        </select>
      </div>
      <div>
        <label className="field-label">Difficulty</label>
        <select className="field-input" value={form.difficulty} onChange={(e) => setForm({ ...form, difficulty: e.target.value as 'easy' | 'medium' | 'hard' })}>
          <option value="easy">Easy</option>
          <option value="medium">Medium</option>
          <option value="hard">Hard</option>
        </select>
      </div>
      <div>
        <label className="field-label">Title</label>
        <input className="field-input" value={form.title} onChange={(e) => setForm({ ...form, title: e.target.value })} />
      </div>
      <div>
        <label className="field-label">Prompt / question body</label>
        <textarea className="field-input" rows={3} value={form.prompt} onChange={(e) => setForm({ ...form, prompt: e.target.value })} />
      </div>
      <div>
        <label className="field-label">Options (mark the correct one)</label>
        <div className="space-y-2">
          {options.map((opt, i) => (
            <div key={i} className="flex items-center gap-2">
              <input type="radio" name="correct" checked={correctIndex === i} onChange={() => setCorrectIndex(i)} />
              <span className="w-5 text-xs text-ink-400">{LETTERS[i]}</span>
              <input
                className="field-input"
                value={opt}
                onChange={(e) => setOptions((prev) => prev.map((o, j) => (j === i ? e.target.value : o)))}
              />
              {options.length > 2 && (
                <button
                  type="button"
                  className="text-xs text-alert-500"
                  onClick={() => {
                    setOptions((prev) => prev.filter((_, j) => j !== i));
                    if (correctIndex >= i) setCorrectIndex((c) => Math.max(0, c - 1));
                  }}
                >
                  Remove
                </button>
              )}
            </div>
          ))}
          {options.length < 6 && (
            <button type="button" className="text-xs text-ink-500 underline" onClick={() => setOptions((prev) => [...prev, ''])}>
              + Add option
            </button>
          )}
        </div>
      </div>
      {createMutation.isError && (
        <p className="text-sm text-alert-500">{createMutation.error instanceof ApiClientError ? createMutation.error.message : 'Failed to create'}</p>
      )}
      <button className="btn-primary" disabled={!canSubmit || createMutation.isPending} onClick={() => createMutation.mutate()}>
        {createMutation.isPending ? 'Creating…' : 'Create aptitude question'}
      </button>
    </div>
  );
}

function CodingForm({ onCreated }: { onCreated: () => void }) {
  const topicsQuery = useQuery({ queryKey: ['topics'], queryFn: questionsApi.listTopics });
  const [form, setForm] = useState({ topic_id: '', difficulty: 'easy' as 'easy' | 'medium' | 'hard', title: '', prompt: '', constraints_text: '' });
  const [testCases, setTestCases] = useState<TestCaseDraft[]>([{ input: '', expected: '' }]);

  const createMutation = useMutation({
    mutationFn: () =>
      questionsApi.create({
        type: 'coding',
        topic_id: form.topic_id,
        difficulty: form.difficulty,
        title: form.title,
        prompt: form.prompt,
        constraints_text: form.constraints_text || undefined,
        test_cases: testCases.filter((tc) => tc.input.trim() && tc.expected.trim()),
      }),
    onSuccess: () => {
      setForm({ topic_id: '', difficulty: 'easy', title: '', prompt: '', constraints_text: '' });
      setTestCases([{ input: '', expected: '' }]);
      onCreated();
    },
  });

  const validTestCases = testCases.filter((tc) => tc.input.trim() && tc.expected.trim());
  const canSubmit = form.topic_id && form.title && form.prompt && validTestCases.length >= 1;

  return (
    <div className="space-y-3">
      <div>
        <label className="field-label">Topic</label>
        <select className="field-input" value={form.topic_id} onChange={(e) => setForm({ ...form, topic_id: e.target.value })}>
          <option value="">Select topic</option>
          {(topicsQuery.data ?? []).map((t) => (
            <option key={t.id} value={t.id}>
              {t.name}
            </option>
          ))}
        </select>
      </div>
      <div>
        <label className="field-label">Difficulty</label>
        <select className="field-input" value={form.difficulty} onChange={(e) => setForm({ ...form, difficulty: e.target.value as 'easy' | 'medium' | 'hard' })}>
          <option value="easy">Easy</option>
          <option value="medium">Medium</option>
          <option value="hard">Hard</option>
        </select>
      </div>
      <div>
        <label className="field-label">Title</label>
        <input className="field-input" value={form.title} onChange={(e) => setForm({ ...form, title: e.target.value })} />
      </div>
      <div>
        <label className="field-label">Prompt / problem statement</label>
        <textarea className="field-input" rows={4} value={form.prompt} onChange={(e) => setForm({ ...form, prompt: e.target.value })} />
      </div>
      <div>
        <label className="field-label">Constraints (optional)</label>
        <textarea className="field-input" rows={2} value={form.constraints_text} onChange={(e) => setForm({ ...form, constraints_text: e.target.value })} />
      </div>
      <div>
        <label className="field-label">Test cases (Judge0 stdin / expected stdout)</label>
        <div className="space-y-2">
          {testCases.map((tc, i) => (
            <div key={i} className="grid grid-cols-2 gap-2">
              <input
                className="field-input"
                placeholder="input"
                value={tc.input}
                onChange={(e) => setTestCases((prev) => prev.map((t, j) => (j === i ? { ...t, input: e.target.value } : t)))}
              />
              <input
                className="field-input"
                placeholder="expected output"
                value={tc.expected}
                onChange={(e) => setTestCases((prev) => prev.map((t, j) => (j === i ? { ...t, expected: e.target.value } : t)))}
              />
            </div>
          ))}
          <button type="button" className="text-xs text-ink-500 underline" onClick={() => setTestCases((prev) => [...prev, { input: '', expected: '' }])}>
            + Add test case
          </button>
        </div>
      </div>
      {createMutation.isError && (
        <p className="text-sm text-alert-500">{createMutation.error instanceof ApiClientError ? createMutation.error.message : 'Failed to create'}</p>
      )}
      <button className="btn-primary" disabled={!canSubmit || createMutation.isPending} onClick={() => createMutation.mutate()}>
        {createMutation.isPending ? 'Creating…' : 'Create coding question'}
      </button>
    </div>
  );
}

export function QuestionsAdminPage() {
  const queryClient = useQueryClient();
  const [createType, setCreateType] = useState<'aptitude' | 'coding'>('aptitude');
  const [filterType, setFilterType] = useState<'aptitude' | 'coding'>('aptitude');

  const listQuery = useQuery({
    queryKey: ['admin-questions', filterType],
    queryFn: () => questionsApi.list({ type: filterType, page: 1, page_size: 50 }),
  });

  const deactivateMutation = useMutation({
    mutationFn: (id: string) => questionsApi.deactivate(id),
    onSuccess: () => queryClient.invalidateQueries({ queryKey: ['admin-questions', filterType] }),
  });

  function refreshList() {
    queryClient.invalidateQueries({ queryKey: ['admin-questions'] });
  }

  return (
    <div className="space-y-8">
      <div>
        <h1 className="font-display text-2xl font-bold text-ink-900">Question Bank</h1>
        <p className="mt-1 text-sm text-ink-400">Admin-only: create and retire aptitude & coding questions.</p>
      </div>

      <div className="card max-w-2xl">
        <div className="flex items-center justify-between">
          <p className="font-display font-semibold text-ink-900">Create a question</p>
          <Tabs
            value={createType}
            onChange={setCreateType}
            options={[
              { value: 'aptitude', label: 'Aptitude' },
              { value: 'coding', label: 'Coding' },
            ]}
          />
        </div>
        <div className="mt-4">
          {createType === 'aptitude' ? <AptitudeForm onCreated={refreshList} /> : <CodingForm onCreated={refreshList} />}
        </div>
      </div>

      <div>
        <div className="flex items-center justify-between mb-3">
          <p className="font-display font-semibold text-ink-900">Existing questions</p>
          <Tabs
            value={filterType}
            onChange={setFilterType}
            options={[
              { value: 'aptitude', label: 'Aptitude' },
              { value: 'coding', label: 'Coding' },
            ]}
          />
        </div>
        {listQuery.isLoading && <Spinner />}
        {listQuery.isError && <ErrorState message={listQuery.error instanceof ApiClientError ? listQuery.error.message : 'Failed to load'} onRetry={() => listQuery.refetch()} />}
        {listQuery.data && listQuery.data.questions.length === 0 && <EmptyState title="No questions of this type yet" />}
        {listQuery.data && listQuery.data.questions.length > 0 && (
          <div className="card divide-y divide-ink-50 p-0">
            {listQuery.data.questions.map((q) => (
              <div key={q.id} className="flex items-center justify-between px-5 py-3">
                <div>
                  <p className="text-sm font-medium text-ink-900">{q.title}</p>
                  <p className="text-xs text-ink-400">{q.topic_name}</p>
                </div>
                <div className="flex items-center gap-3">
                  <Pill tone={q.difficulty === 'hard' ? 'danger' : q.difficulty === 'medium' ? 'warning' : 'positive'}>{q.difficulty}</Pill>
                  <button
                    className="text-xs text-alert-500 underline"
                    disabled={deactivateMutation.isPending}
                    onClick={() => deactivateMutation.mutate(q.id)}
                  >
                    Deactivate
                  </button>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
}
