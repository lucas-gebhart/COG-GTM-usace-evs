import { Button } from "@trussworks/react-uswds";
import { ApiError } from "../hooks/useApi";

export interface ErrorStateProps {
  title?: string;
  /** Plain-language description. Technical detail goes in `error`. */
  message?: string;
  error?: unknown;
  onRetry?: () => void;
  retryLabel?: string;
  headingLevel?: 2 | 3 | 4;
  className?: string;
}

function detailOf(error: unknown): { text: string; ref?: string } {
  if (error instanceof ApiError) return { text: `Server responded ${error.status}: ${error.message}`, ref: error.referenceId };
  if (error instanceof Error) return { text: error.message };
  if (typeof error === "string") return { text: error };
  return { text: "" };
}

/** Failure message with a retry button and a reference id (section 1.2.8). Uses role=alert so it is announced. */
export function ErrorState({ title = "This data could not be loaded", message = "The service did not return data. Retry, or come back later.", error, onRetry, retryLabel = "Retry", headingLevel = 3, className }: ErrorStateProps) {
  const Heading = `h${headingLevel}` as const;
  const detail = detailOf(error);
  return (
    <div className={["evs-error", className].filter(Boolean).join(" ")} role="alert">
      <Heading className="evs-error__title">{title}</Heading>
      <p className="evs-error__body">{message}</p>
      {detail.text && <p className="evs-error__ref">{detail.text}{detail.ref ? ` (reference ${detail.ref})` : ""}</p>}
      {onRetry && (
        <Button type="button" onClick={onRetry} outline>
          {retryLabel}
        </Button>
      )}
    </div>
  );
}
