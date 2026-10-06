import { useCallback, useEffect, useSyncExternalStore } from "react";

export type EvsTheme = "light" | "leadership";
export const THEME_STORAGE_KEY = "evs.theme";
const THEME_EVENT = "evs:theme";

function readTheme(): EvsTheme {
  if (typeof document === "undefined") return "light";
  return document.documentElement.dataset.theme === "leadership" ? "leadership" : "light";
}

export function applyTheme(theme: EvsTheme): void {
  if (typeof document === "undefined") return;
  if (theme === "leadership") document.documentElement.dataset.theme = "leadership";
  else delete document.documentElement.dataset.theme;
  try {
    localStorage.setItem(THEME_STORAGE_KEY, theme);
  } catch {
    // storage may be unavailable (private mode); the attribute still applies for this page
  }
  window.dispatchEvent(new Event(THEME_EVENT));
}

/** Restores the persisted theme (call once at startup, before first paint when possible). */
export function restoreTheme(): EvsTheme {
  let stored: string | null = null;
  try {
    stored = localStorage.getItem(THEME_STORAGE_KEY);
  } catch {
    stored = null;
  }
  const theme: EvsTheme = stored === "leadership" ? "leadership" : "light";
  if (typeof document !== "undefined") {
    if (theme === "leadership") document.documentElement.dataset.theme = "leadership";
    else delete document.documentElement.dataset.theme;
  }
  return theme;
}

function subscribe(onChange: () => void) {
  window.addEventListener(THEME_EVENT, onChange);
  const mo = typeof MutationObserver !== "undefined" ? new MutationObserver(onChange) : null;
  mo?.observe(document.documentElement, { attributes: true, attributeFilter: ["data-theme"] });
  return () => {
    window.removeEventListener(THEME_EVENT, onChange);
    mo?.disconnect();
  };
}

/** Current theme (driven by `<html data-theme>`) and a setter that persists it. */
export function useTheme(): { theme: EvsTheme; setTheme: (t: EvsTheme) => void; toggle: () => void; isLeadership: boolean } {
  const theme = useSyncExternalStore(subscribe, readTheme, () => "light" as EvsTheme);
  const setTheme = useCallback((t: EvsTheme) => applyTheme(t), []);
  const toggle = useCallback(() => applyTheme(readTheme() === "leadership" ? "light" : "leadership"), []);
  useEffect(() => {
    if (theme === "leadership") document.documentElement.style.colorScheme = "dark";
    else document.documentElement.style.removeProperty("color-scheme");
  }, [theme]);
  return { theme, setTheme, toggle, isLeadership: theme === "leadership" };
}
