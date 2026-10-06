import { Button, Icon } from "@trussworks/react-uswds";
import { useTheme } from "../hooks/useTheme";

export interface ThemeToggleProps {
  className?: string;
  /** Compact icon + short label for the header. */
  compact?: boolean;
}

/** Switches `<html data-theme="leadership">` (1920x1080 big-screen scale, dark palette). Persists to localStorage. */
export function ThemeToggle({ className, compact = false }: ThemeToggleProps) {
  const { isLeadership, toggle } = useTheme();
  return (
    <Button
      type="button"
      outline
      onClick={toggle}
      aria-pressed={isLeadership}
      className={["evs-theme-toggle", className].filter(Boolean).join(" ")}
      data-testid="theme-toggle"
    >
      {isLeadership ? <Icon.LightbulbOutline aria-hidden="true" focusable={false} /> : <Icon.Lightbulb aria-hidden="true" focusable={false} />}
      {compact ? (isLeadership ? "Standard view" : "Leadership view") : isLeadership ? "Switch to standard view" : "Switch to leadership view"}
    </Button>
  );
}
