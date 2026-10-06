import { createContext, useCallback, useContext, useMemo, useSyncExternalStore, type ReactNode } from "react";

/** EVS roles (WP3 OIDC groups). `evs_admin` implies `evs_pm`, which implies `evs_viewer`. */
export const ROLES = ["evs_viewer", "evs_pm", "evs_admin"] as const;
export type Role = (typeof ROLES)[number];
export const ROLE_LABEL: Record<Role, string> = { evs_viewer: "Viewer (read only)", evs_pm: "Project manager", evs_admin: "Administrator" };

export const ROLE_STORAGE_KEY = "evs.role";
/** Header the mock handlers (and a future auth-disabled API) read to decide the demo principal's role. */
export const ROLE_HEADER = "X-Evs-Demo-Role";
const ROLE_EVENT = "evs:role";
const DEFAULT_ROLE: Role = "evs_admin";

export function readRole(): Role {
  try {
    const stored = localStorage.getItem(ROLE_STORAGE_KEY);
    return (ROLES as readonly string[]).includes(stored ?? "") ? (stored as Role) : DEFAULT_ROLE;
  } catch {
    return DEFAULT_ROLE;
  }
}

export function writeRole(role: Role): void {
  try {
    localStorage.setItem(ROLE_STORAGE_KEY, role);
  } catch {
    // storage unavailable; the in-memory value still drives this page
  }
  window.dispatchEvent(new Event(ROLE_EVENT));
}

function subscribe(onChange: () => void) {
  window.addEventListener(ROLE_EVENT, onChange);
  window.addEventListener("storage", onChange);
  return () => {
    window.removeEventListener(ROLE_EVENT, onChange);
    window.removeEventListener("storage", onChange);
  };
}

export interface RoleContextValue {
  role: Role;
  setRole: (role: Role) => void;
  /** evs_pm or evs_admin: may edit project status, move Kanban cards and update milestones. */
  canWrite: boolean;
  isAdmin: boolean;
  /** True when the role can be switched in the header (mock mode or API with auth disabled). */
  switchable: boolean;
}

const RoleContext = createContext<RoleContextValue | null>(null);

/**
 * Role source for the pages. With OIDC enabled the role comes from the token (WP3); in mock mode and
 * when the API runs with EVS_AUTH_DISABLED the demo role is chosen in the header and sent as X-Evs-Demo-Role.
 */
export function RoleProvider({ children, switchable = true, initialRole }: { children: ReactNode; switchable?: boolean; initialRole?: Role }) {
  const stored = useSyncExternalStore(subscribe, readRole, () => DEFAULT_ROLE);
  const role = initialRole ?? stored;
  const setRole = useCallback((r: Role) => writeRole(r), []);
  const value = useMemo<RoleContextValue>(
    () => ({ role, setRole, canWrite: role !== "evs_viewer", isAdmin: role === "evs_admin", switchable }),
    [role, setRole, switchable],
  );
  return <RoleContext.Provider value={value}>{children}</RoleContext.Provider>;
}

const fallback: RoleContextValue = { role: DEFAULT_ROLE, setRole: () => {}, canWrite: true, isAdmin: true, switchable: false };

/** Current role; outside a provider (isolated component tests) behaves as an administrator. */
export function useRole(): RoleContextValue {
  return useContext(RoleContext) ?? fallback;
}
