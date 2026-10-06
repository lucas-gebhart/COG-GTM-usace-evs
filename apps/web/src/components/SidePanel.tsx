import { useEffect, useId, useRef, type ReactNode } from "react";
import { Button, Icon } from "@trussworks/react-uswds";

export interface SidePanelProps {
  title: string;
  open: boolean;
  onClose: () => void;
  /** Element that opened the panel; focus returns there on close. Defaults to the element focused when the panel opened. */
  returnFocusTo?: HTMLElement | null;
  headingLevel?: 2 | 3;
  actions?: ReactNode;
  children: ReactNode;
  className?: string;
}

/**
 * Non-modal detail panel (not a floating popup): focus moves to its heading when it opens or changes subject,
 * Escape or the Close button dismisses it and focus returns to the marker or row that opened it.
 */
export function SidePanel({ title, open, onClose, returnFocusTo, headingLevel = 2, actions, children, className }: SidePanelProps) {
  const id = useId();
  const heading = useRef<HTMLHeadingElement>(null);
  const opener = useRef<HTMLElement | null>(null);
  const panel = useRef<HTMLElement>(null);
  const onCloseRef = useRef(onClose);
  onCloseRef.current = onClose;
  const Heading = `h${headingLevel}` as const;

  useEffect(() => {
    if (!open) return;
    const active = document.activeElement as HTMLElement | null;
    if (returnFocusTo) opener.current = returnFocusTo;
    else if (active && !heading.current?.parentElement?.parentElement?.contains(active)) opener.current = active;
    heading.current?.focus();
  }, [open, title, returnFocusTo]);

  const close = () => {
    const target = opener.current;
    onCloseRef.current();
    requestAnimationFrame(() => {
      if (target && target.isConnected) target.focus();
    });
  };
  const closeRef = useRef(close);
  closeRef.current = close;

  // Escape anywhere inside the panel closes it; the listener is attached natively because the section is not itself a control.
  useEffect(() => {
    const node = panel.current;
    if (!open || !node) return;
    const onKey = (e: globalThis.KeyboardEvent) => {
      if (e.key === "Escape") {
        e.stopPropagation();
        closeRef.current();
      }
    };
    node.addEventListener("keydown", onKey);
    return () => node.removeEventListener("keydown", onKey);
  }, [open]);

  if (!open) return null;

  return (
    <section
      className={["evs-panel", className].filter(Boolean).join(" ")}
      role="dialog"
      aria-modal="false"
      aria-labelledby={`${id}-title`}
      ref={panel}
      data-testid="side-panel"
    >
      <div className="evs-panel__head">
        <Heading id={`${id}-title`} ref={heading} tabIndex={-1} className="evs-panel__title">
          {title}
        </Heading>
        <div className="evs-panel__actions">
          {actions}
          <Button type="button" unstyled className="evs-panel__close" onClick={close} aria-label={`Close ${title} details`}>
            <Icon.Close aria-hidden="true" focusable={false} size={3} />
          </Button>
        </div>
      </div>
      <div className="evs-panel__body">{children}</div>
    </section>
  );
}
