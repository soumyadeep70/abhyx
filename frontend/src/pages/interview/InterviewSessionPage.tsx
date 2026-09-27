import { useEffect, useState } from 'react';
import { useMutation } from '@tanstack/react-query';
import { Link, useLocation, useNavigate, useParams } from 'react-router-dom';
import { interviewApi } from '../../lib/api/interview';
import { ApiClientError } from '../../lib/apiClient';
import type { InterviewRespondResult } from '../../lib/types';

interface TranscriptEntry {
  role: 'interviewer' | 'candidate';
  message: string;
  scores?: InterviewRespondResult['scores'];
}

/**
 * The backend has no endpoint to re-fetch an in-progress conversation
 * (GET /interview/session/:id/scorecard auto-completes the session, so it
 * can't be used to poll history). The transcript therefore lives on the
 * client for the life of this session, persisted to sessionStorage so an
 * accidental reload in the same tab doesn't lose it.
 */
function storageKey(sessionId: string) {
  return `ascent.interview.${sessionId}`;
}

export function InterviewSessionPage() {
  const { sessionId } = useParams<{ sessionId: string }>();
  const location = useLocation();
  const navigate = useNavigate();
  const state = location.state as { openingQuestion?: string; roundType?: string } | null;

  const [transcript, setTranscript] = useState<TranscriptEntry[]>(() => {
    const saved = sessionId ? sessionStorage.getItem(storageKey(sessionId)) : null;
    if (saved) return JSON.parse(saved);
    if (state?.openingQuestion) return [{ role: 'interviewer', message: state.openingQuestion }];
    return [];
  });
  const [draft, setDraft] = useState('');

  useEffect(() => {
    if (sessionId) sessionStorage.setItem(storageKey(sessionId), JSON.stringify(transcript));
  }, [sessionId, transcript]);

  const respondMutation = useMutation({
    mutationFn: (message: string) => interviewApi.respond(sessionId!, message),
    onSuccess: (result, message) => {
      setTranscript((prev) => [
        ...prev,
        { role: 'candidate', message, scores: result.scores },
        { role: 'interviewer', message: result.next_question },
      ]);
      setDraft('');
    },
  });

  const completeMutation = useMutation({
    mutationFn: () => interviewApi.complete(sessionId!),
    onSuccess: () => {
      if (sessionId) sessionStorage.removeItem(storageKey(sessionId));
      navigate(`/interview/session/${sessionId}/scorecard`);
    },
  });

  if (!sessionId) return null;

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="font-display text-2xl font-bold text-ink-900">
            {state?.roundType ? `${state.roundType.replace('_', ' ')} interview` : 'Interview session'}
          </h1>
          <p className="mt-1 text-sm text-ink-400">Answer naturally — you'll get real-time feedback after each turn.</p>
        </div>
        <button className="btn-signal text-sm" onClick={() => completeMutation.mutate()} disabled={completeMutation.isPending || transcript.length === 0}>
          {completeMutation.isPending ? 'Finalizing…' : 'End & view scorecard'}
        </button>
      </div>

      <div className="card space-y-4 max-h-[28rem] overflow-y-auto">
        {transcript.length === 0 && <p className="text-sm text-ink-400">Loading opening question…</p>}
        {transcript.map((entry, i) => (
          <div key={i} className={entry.role === 'interviewer' ? '' : 'text-right'}>
            <div
              className={`inline-block max-w-[85%] rounded-md px-4 py-2 text-sm text-left ${
                entry.role === 'interviewer' ? 'bg-ink-100 text-ink-900' : 'bg-signal-500 text-white'
              }`}
            >
              {entry.message}
            </div>
            {entry.scores && (
              <div className="mt-1 flex flex-wrap justify-end gap-2 text-xs text-ink-400">
                <span>Technical {entry.scores.technical_accuracy}/10</span>
                <span>Communication {entry.scores.communication_clarity}/10</span>
                <span>Problem-solving {entry.scores.problem_solving_approach}/10</span>
                <span>Depth {entry.scores.depth_of_knowledge}/10</span>
                {entry.scores.hr_readiness !== null && <span>HR {entry.scores.hr_readiness}/10</span>}
              </div>
            )}
          </div>
        ))}
      </div>

      {respondMutation.isError && (
        <p className="text-sm text-alert-500">{respondMutation.error instanceof ApiClientError ? respondMutation.error.message : 'Failed to send'}</p>
      )}

      <form
        className="flex gap-3"
        onSubmit={(e) => {
          e.preventDefault();
          if (draft.trim()) respondMutation.mutate(draft.trim());
        }}
      >
        <textarea
          className="field-input flex-1"
          rows={3}
          placeholder="Type your answer…"
          value={draft}
          onChange={(e) => setDraft(e.target.value)}
          disabled={respondMutation.isPending || transcript.length === 0}
        />
        <button type="submit" className="btn-primary self-end" disabled={respondMutation.isPending || !draft.trim()}>
          {respondMutation.isPending ? 'Sending…' : 'Send'}
        </button>
      </form>

      <Link to="/interview" className="text-sm text-ink-400 underline">
        ← Back to interview setup
      </Link>
    </div>
  );
}
