import { useCallback, useEffect, useRef, useState } from "react";

export type SseStatus = "idle" | "connecting" | "open" | "reconnecting" | "paused" | "closed";

export interface SseEvent<T = unknown> {
  type: string;
  data: T;
  receivedAt: Date;
  lastEventId: string;
}

export interface UseSseOptions<T> {
  /** Named events to subscribe to (server `event:` lines). Unnamed `message` events are always received. */
  events?: readonly string[];
  enabled?: boolean;
  /** Parse the raw `data` string; defaults to JSON.parse with a fallback to the raw string. */
  parse?: (raw: string) => T;
  onEvent?: (event: SseEvent<T>) => void;
  /** Reconnect backoff bounds in milliseconds. */
  minDelayMs?: number;
  maxDelayMs?: number;
}

export interface UseSseResult<T> {
  status: SseStatus;
  lastEvent: SseEvent<T> | null;
  /** Number of reconnect attempts since the last successful open. */
  attempts: number;
  /** Pause live updates (WCAG 2.2.2); the connection is closed until `resume`. */
  pause: () => void;
  resume: () => void;
  paused: boolean;
}

function defaultParse<T>(raw: string): T {
  try {
    return JSON.parse(raw) as T;
  } catch {
    return raw as unknown as T;
  }
}

/**
 * EventSource with explicit reconnect and backoff. The browser reconnects on dropped connections by
 * itself, but not when the server closes the stream or answers with an HTTP error; this hook covers
 * both, exposes a text status for the UI and a pause control for live regions.
 */
export function useSse<T = unknown>(url: string | null, options: UseSseOptions<T> = {}): UseSseResult<T> {
  const { events = [], enabled = true, parse = defaultParse<T>, onEvent, minDelayMs = 1000, maxDelayMs = 30000 } = options;
  const [status, setStatus] = useState<SseStatus>("idle");
  const [lastEvent, setLastEvent] = useState<SseEvent<T> | null>(null);
  const [attempts, setAttempts] = useState(0);
  const [paused, setPaused] = useState(false);
  const attemptsRef = useRef(0);
  const onEventRef = useRef(onEvent);
  const parseRef = useRef(parse);
  onEventRef.current = onEvent;
  parseRef.current = parse;
  const eventsKey = events.join("|");

  useEffect(() => {
    if (!url || !enabled || paused || typeof EventSource === "undefined") {
      setStatus(paused ? "paused" : "idle");
      return;
    }
    let source: EventSource | null = null;
    let timer: ReturnType<typeof setTimeout> | null = null;
    let disposed = false;

    const handle = (type: string) => (ev: MessageEvent<string>) => {
      const event: SseEvent<T> = { type, data: parseRef.current(ev.data), receivedAt: new Date(), lastEventId: ev.lastEventId };
      setLastEvent(event);
      onEventRef.current?.(event);
    };

    const connect = () => {
      if (disposed) return;
      setStatus(attemptsRef.current === 0 ? "connecting" : "reconnecting");
      source = new EventSource(url);
      source.onopen = () => {
        attemptsRef.current = 0;
        setAttempts(0);
        setStatus("open");
      };
      source.onmessage = handle("message");
      for (const name of eventsKey ? eventsKey.split("|") : []) source.addEventListener(name, handle(name) as EventListener);
      source.onerror = () => {
        // readyState CONNECTING means the browser is retrying on its own; CLOSED means we must.
        if (source?.readyState === EventSource.CLOSED) {
          source.close();
          attemptsRef.current += 1;
          setAttempts(attemptsRef.current);
          const delay = Math.min(maxDelayMs, minDelayMs * 2 ** (attemptsRef.current - 1));
          setStatus("reconnecting");
          timer = setTimeout(connect, delay);
        } else {
          setStatus("reconnecting");
        }
      };
    };
    connect();

    return () => {
      disposed = true;
      if (timer) clearTimeout(timer);
      source?.close();
      setStatus("closed");
    };
  }, [url, enabled, paused, eventsKey, minDelayMs, maxDelayMs]);

  const pause = useCallback(() => setPaused(true), []);
  const resume = useCallback(() => {
    attemptsRef.current = 0;
    setAttempts(0);
    setPaused(false);
  }, []);

  return { status, lastEvent, attempts, pause, resume, paused };
}
