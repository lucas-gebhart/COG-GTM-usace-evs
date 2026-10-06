import { useCallback, useEffect, useRef, useState } from "react";
import { Button, Icon } from "@trussworks/react-uswds";
import { useAnnounce } from "../hooks/useAnnounce";

export interface RefreshControlProps {
  /** Called when the countdown reaches zero or the user presses Refresh now. */
  onRefresh: () => void | Promise<unknown>;
  intervalSeconds?: number;
  /** Start paused (for Storybook and tests). */
  initiallyPaused?: boolean;
  /** Timestamp of the last successful refresh, shown as text. */
  lastRefreshed?: Date | string | null;
  className?: string;
}

/** 60 s auto refresh with pause, text status and manual refresh (WCAG 2.2.2 pause/stop). */
export function RefreshControl({ onRefresh, intervalSeconds = 60, initiallyPaused = false, lastRefreshed, className }: RefreshControlProps) {
  const [paused, setPaused] = useState(initiallyPaused);
  const [remaining, setRemaining] = useState(intervalSeconds);
  const [busy, setBusy] = useState(false);
  const { announce } = useAnnounce();
  const onRefreshRef = useRef(onRefresh);
  onRefreshRef.current = onRefresh;

  const run = useCallback(async () => {
    setBusy(true);
    try {
      await onRefreshRef.current();
    } finally {
      setBusy(false);
      setRemaining(intervalSeconds);
    }
  }, [intervalSeconds]);

  useEffect(() => {
    if (paused) return;
    const t = setInterval(() => {
      setRemaining((r) => {
        if (r <= 1) {
          void run();
          return intervalSeconds;
        }
        return r - 1;
      });
    }, 1000);
    return () => clearInterval(t);
  }, [paused, intervalSeconds, run]);

  const togglePause = () => {
    setPaused((p) => {
      announce(p ? "Auto refresh resumed" : "Auto refresh paused");
      return !p;
    });
  };

  const last = lastRefreshed ? new Date(lastRefreshed) : null;
  const lastText = last && !Number.isNaN(last.getTime()) ? ` Last refreshed ${last.toLocaleTimeString("en-US", { hour: "2-digit", minute: "2-digit", second: "2-digit", hour12: false })}.` : "";
  const text = busy ? "Refreshing" : paused ? "Auto refresh paused" : `Refresh in ${remaining} s`;

  return (
    <div className={["evs-refresh", className].filter(Boolean).join(" ")} role="group" aria-label="Auto refresh" data-testid="refresh-control">
      <p className="evs-refresh__text" aria-live="off" data-testid="refresh-status">
        {text}.{lastText}
      </p>
      <Button type="button" outline className="evs-refresh__btn" onClick={togglePause} aria-pressed={paused}>
        {paused ? <Icon.Autorenew aria-hidden="true" focusable={false} /> : <Icon.HighlightOff aria-hidden="true" focusable={false} />}
        {paused ? "Resume" : "Pause"}
      </Button>
      <Button type="button" outline className="evs-refresh__btn" onClick={() => void run()} disabled={busy}>
        <Icon.Autorenew aria-hidden="true" focusable={false} />
        Refresh now
      </Button>
    </div>
  );
}
