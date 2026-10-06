import { useId } from "react";
import { ROLES, ROLE_LABEL, useRole, type Role } from "../hooks/useRole";

/**
 * Demo role switcher shown in the header when the role is switchable (mock mode or auth disabled).
 * It changes which controls the pages offer and the X-Evs-Demo-Role header; with OIDC the token decides.
 */
export function RoleSwitcher({ className }: { className?: string }) {
  const id = useId();
  const { role, setRole, switchable } = useRole();
  if (!switchable) return null;
  return (
    <div className={["evs-role-switcher", className].filter(Boolean).join(" ")}>
      <label htmlFor={id} className="usa-label">Demo role</label>
      <select id={id} className="usa-select" value={role} onChange={(e) => setRole(e.target.value as Role)}>
        {ROLES.map((r) => (
          <option key={r} value={r}>{ROLE_LABEL[r]}</option>
        ))}
      </select>
    </div>
  );
}
