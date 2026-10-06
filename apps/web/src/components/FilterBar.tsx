import { useEffect, useId, useState, type FormEvent } from "react";
import { Button, Icon } from "@trussworks/react-uswds";
import { useIsMobile } from "../hooks/useMediaQuery";
import { useAnnounce } from "../hooks/useAnnounce";

export interface FilterOption {
  value: string;
  label: string;
  /** Optional optgroup label, e.g. the USACE division a river belongs to. */
  group?: string;
}

export interface FilterField {
  id: string;
  label: string;
  type?: "select" | "text" | "search" | "date";
  options?: FilterOption[];
  placeholder?: string;
  hint?: string;
}

export type FilterValues = Record<string, string>;

/** Keeps ungrouped options first, then one optgroup per distinct group label in first-seen order. */
function groupOptions(options: FilterOption[]): Array<[string | null, FilterOption[]]> {
  const out = new Map<string | null, FilterOption[]>();
  for (const o of options) {
    const key = o.group ?? null;
    if (!out.has(key)) out.set(key, []);
    out.get(key)!.push(o);
  }
  return [...out.entries()].sort(([a], [b]) => (a === null ? -1 : b === null ? 1 : 0));
}

export interface FilterBarProps {
  legend?: string;
  fields: FilterField[];
  values: FilterValues;
  /** Called only on explicit apply (button or Enter). Nothing filters on change (508 report 1.2.7). */
  onApply: (values: FilterValues) => void;
  onReset?: () => void;
  /** Result count after the last apply; announced politely and shown as text. */
  resultCount?: number | null;
  resultNoun?: string;
  className?: string;
}

/** USWDS form controls that apply with a button or Enter and announce the result count. Collapsible on mobile. */
export function FilterBar({ legend = "Filters", fields, values, onApply, onReset, resultCount, resultNoun = "results", className }: FilterBarProps) {
  const id = useId();
  const [draft, setDraft] = useState<FilterValues>(values);
  const [open, setOpen] = useState(false);
  const isMobile = useIsMobile();
  const { announce } = useAnnounce();

  useEffect(() => setDraft(values), [values]);
  useEffect(() => {
    if (resultCount !== null && resultCount !== undefined) announce(`${resultCount} ${resultNoun}`);
  }, [resultCount, resultNoun, announce]);

  const submit = (e: FormEvent) => {
    e.preventDefault();
    onApply(draft);
    if (isMobile) setOpen(false);
  };
  const reset = () => {
    const cleared = Object.fromEntries(fields.map((f) => [f.id, ""]));
    setDraft(cleared);
    if (onReset) onReset();
    else onApply(cleared);
  };
  const active = Object.values(values).filter(Boolean).length;
  const showFields = !isMobile || open;

  return (
    <form className={["evs-filterbar", className].filter(Boolean).join(" ")} onSubmit={submit} aria-labelledby={`${id}-legend`} data-testid="filter-bar">
      <fieldset>
        <legend id={`${id}-legend`}>{legend}{active > 0 && <span className="evs-sr-only">, {active} active</span>}</legend>
        {isMobile && (
          <Button type="button" outline onClick={() => setOpen((o) => !o)} aria-expanded={open} aria-controls={`${id}-fields`} className="margin-bottom-1">
            <Icon.FilterList aria-hidden="true" focusable={false} /> {open ? "Hide filters" : `Show filters${active ? ` (${active} active)` : ""}`}
          </Button>
        )}
        <div id={`${id}-fields`} className="evs-filterbar__fields" hidden={!showFields}>
          {fields.map((f) => {
            const fid = `${id}-${f.id}`;
            const hintId = f.hint ? `${fid}-hint` : undefined;
            return (
              <div key={f.id} className="evs-filterbar__field">
                <label className="usa-label" htmlFor={fid}>{f.label}</label>
                {f.hint && <span id={hintId} className="usa-hint">{f.hint}</span>}
                {f.type === "select" || f.options ? (
                  <select id={fid} name={f.id} className="usa-select" value={draft[f.id] ?? ""} onChange={(e) => setDraft({ ...draft, [f.id]: e.target.value })} aria-describedby={hintId}>
                    <option value="">{f.placeholder ?? "All"}</option>
                    {groupOptions(f.options ?? []).map(([group, opts]) =>
                      group ? (
                        <optgroup key={group} label={group}>
                          {opts.map((o) => (
                            <option key={o.value} value={o.value}>{o.label}</option>
                          ))}
                        </optgroup>
                      ) : (
                        opts.map((o) => (
                          <option key={o.value} value={o.value}>{o.label}</option>
                        ))
                      ),
                    )}
                  </select>
                ) : (
                  <input id={fid} name={f.id} className="usa-input" type={f.type ?? "text"} value={draft[f.id] ?? ""} placeholder={f.placeholder} onChange={(e) => setDraft({ ...draft, [f.id]: e.target.value })} aria-describedby={hintId} />
                )}
              </div>
            );
          })}
        </div>
        <div className="evs-filterbar__actions" hidden={!showFields}>
          <Button type="submit">Apply filters</Button>
          <Button type="button" outline onClick={reset}>Reset</Button>
          {resultCount !== null && resultCount !== undefined && (
            <p className="evs-filterbar__status" data-testid="filter-count">{resultCount} {resultNoun}</p>
          )}
        </div>
      </fieldset>
    </form>
  );
}
