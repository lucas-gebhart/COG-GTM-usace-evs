import type { ReactNode } from "react";

export interface EmptyStateProps {
  title?: string;
  /** Says what is missing and what the user can do about it (section 1.2.8). */
  message: string;
  action?: ReactNode;
  headingLevel?: 2 | 3 | 4;
  className?: string;
}

export function EmptyState({ title = "No data to show", message, action, headingLevel = 3, className }: EmptyStateProps) {
  const Heading = `h${headingLevel}` as const;
  return (
    <div className={["evs-empty", className].filter(Boolean).join(" ")} role="status">
      <Heading className="evs-empty__title">{title}</Heading>
      <p className="evs-empty__body">{message}</p>
      {action}
    </div>
  );
}
