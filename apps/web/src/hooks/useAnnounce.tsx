import { createContext, useCallback, useContext, useMemo, useRef, useState, type ReactNode } from "react";

type Politeness = "polite" | "assertive";

interface LiveRegionApi {
  /** Writes a status message to the global polite region (4.1.3). Focus is never moved. */
  announce: (message: string, politeness?: Politeness) => void;
}

const LiveRegionContext = createContext<LiveRegionApi | null>(null);

/**
 * One global role=status region for non-urgent messages and one role=alert region for failures,
 * as the 508 report 1.2.10 prescribes. Render once in the shell; components call useAnnounce().
 */
export function LiveRegionProvider({ children }: { children: ReactNode }) {
  const [polite, setPolite] = useState("");
  const [assertive, setAssertive] = useState("");
  const timer = useRef<ReturnType<typeof setTimeout> | null>(null);
  const announce = useCallback((message: string, politeness: Politeness = "polite") => {
    const set = politeness === "assertive" ? setAssertive : setPolite;
    // Clear then set so identical consecutive messages are re-announced.
    set("");
    if (timer.current) clearTimeout(timer.current);
    timer.current = setTimeout(() => set(message), 50);
  }, []);
  const value = useMemo(() => ({ announce }), [announce]);
  return (
    <LiveRegionContext.Provider value={value}>
      {children}
      <div className="evs-live-region" role="status" aria-live="polite" aria-atomic="true" data-testid="evs-status-region">{polite}</div>
      <div className="evs-live-region" role="alert" aria-atomic="true" data-testid="evs-alert-region">{assertive}</div>
    </LiveRegionContext.Provider>
  );
}

const noop: LiveRegionApi = { announce: () => {} };

/** Returns the global announcer; a no-op outside the provider so components work standalone (Storybook). */
export function useAnnounce(): LiveRegionApi {
  return useContext(LiveRegionContext) ?? noop;
}
