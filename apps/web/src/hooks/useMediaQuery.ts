import { useCallback, useSyncExternalStore } from "react";

/** Subscribes to a CSS media query. Safe in jsdom and SSR (returns `fallback` when matchMedia is missing). */
export function useMediaQuery(query: string, fallback = false): boolean {
  const subscribe = useCallback(
    (onChange: () => void) => {
      if (typeof window === "undefined" || typeof window.matchMedia !== "function") return () => {};
      const mql = window.matchMedia(query);
      mql.addEventListener("change", onChange);
      return () => mql.removeEventListener("change", onChange);
    },
    [query],
  );
  const getSnapshot = () => (typeof window !== "undefined" && typeof window.matchMedia === "function" ? window.matchMedia(query).matches : fallback);
  return useSyncExternalStore(subscribe, getSnapshot, () => fallback);
}

/** Breakpoints from the 508 report section 1.2.9. */
export const BREAKPOINTS = {
  mobile: "(max-width: 39.99em)", // 320 to 639
  tablet: "(min-width: 40em) and (max-width: 63.99em)", // 640 to 1023
  desktop: "(min-width: 64em)", // 1024+
  widescreen: "(min-width: 87.5em)", // 1400+
} as const;

export function useIsMobile(): boolean {
  return useMediaQuery(BREAKPOINTS.mobile);
}
