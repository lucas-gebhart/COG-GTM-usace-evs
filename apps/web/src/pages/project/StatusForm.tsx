import { useEffect, useId, useMemo, useState, type FormEvent } from "react";
import { Alert, Button, ErrorMessage, FormGroup, Label, Select, Textarea } from "@trussworks/react-uswds";
import { formatDate } from "../../lib/format";
import { ApiError, useUpdateMilestone, useUpdateProjectStatus, validationItems, type Schemas } from "../../hooks/useApi";
import { useRole } from "../../hooks/useRole";
import { useAnnounce } from "../../hooks/useAnnounce";

type Project = Schemas["Project"];

export const PHASES = ["Feasibility", "PED", "Construction", "O&M"] as const;
const PCT_STEPS = Array.from({ length: 11 }, (_, i) => i * 10);

/** APEX item names from page 24, returned by the API's 422 detail, mapped to form fields. */
const ITEM_TO_FIELD: Record<string, string> = { P24_PCT_COMPLETE: "pct_complete", P24_TARGET_COMPLETE: "current_finish", P24_STATUS_SCALE: "phase" };

interface Draft {
  phase: string;
  pct_complete: string;
  current_finish: string;
  note: string;
  milestones: Record<string, { current_date: string; actual_date: string }>;
}

function draftOf(p: Project): Draft {
  return {
    phase: p.phase,
    pct_complete: String(Math.round(p.pct_complete / 10) * 10),
    current_finish: p.current_finish ?? "",
    note: "",
    milestones: Object.fromEntries(p.milestones.map((m) => [m.code, { current_date: m.current_date ?? "", actual_date: m.actual_date ?? "" }])),
  };
}

export function validate(d: Draft): Record<string, string> {
  const errors: Record<string, string> = {};
  const pct = Number(d.pct_complete);
  if (!Number.isFinite(pct) || pct < 0 || pct > 100 || pct % 10 !== 0) errors.pct_complete = "Percent complete must be a multiple of 10 between 0 and 100.";
  if (pct >= 50 && !d.current_finish) errors.current_finish = "Provide a current finish date when the project is 50 percent complete or more.";
  for (const [code, m] of Object.entries(d.milestones)) {
    if (m.actual_date && m.current_date && m.actual_date < m.current_date.slice(0, 4) + "-01-01") errors[`ms-${code}-actual_date`] = "Actual date is before the milestone year.";
  }
  return errors;
}

/**
 * Project status form (APEX page 24 "Project" form items): phase, percent complete, PM note, current finish
 * and milestone dates. Inline USWDS validation mirrors the API; the save is optimistic with rollback.
 * Read only for evs_viewer and after a server 403.
 */
export function StatusForm({ project }: { project: Project }) {
  const id = useId();
  const { canWrite, role } = useRole();
  const { announce } = useAnnounce();
  const [draft, setDraft] = useState<Draft>(() => draftOf(project));
  const [touched, setTouched] = useState(false);
  const [serverErrors, setServerErrors] = useState<Record<string, string>>({});
  const [forbidden, setForbidden] = useState(false);
  const [saved, setSaved] = useState<string | null>(null);
  const status = useUpdateProjectStatus(project.p2_project_no);
  const milestone = useUpdateMilestone(project.p2_project_no);

  useEffect(() => {
    setDraft(draftOf(project));
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [project.p2_project_no, project.pct_complete, project.phase, project.current_finish]);

  const clientErrors = useMemo(() => validate(draft), [draft]);
  const errors = touched ? { ...clientErrors, ...serverErrors } : serverErrors;
  const readOnly = !canWrite || forbidden;
  const busy = status.isPending || milestone.isPending;

  const field = (name: string) => ({ id: `${id}-${name}`, errorId: `${id}-${name}-error`, error: errors[name] });

  const submit = async (e: FormEvent) => {
    e.preventDefault();
    setTouched(true);
    setSaved(null);
    setServerErrors({});
    if (Object.keys(clientErrors).length) {
      announce("The form has errors. Fix the highlighted fields.", "assertive");
      document.getElementById(`${id}-${Object.keys(clientErrors)[0]}`)?.focus();
      return;
    }
    try {
      await status.mutateAsync({
        pct_complete: Number(draft.pct_complete),
        phase: draft.phase,
        current_finish: draft.current_finish || null,
        note: draft.note || null,
      });
      const changed = project.milestones.filter((m) => {
        const d = draft.milestones[m.code];
        return d && ((d.current_date || null) !== (m.current_date ?? null) || (d.actual_date || null) !== (m.actual_date ?? null));
      });
      for (const m of changed) {
        const d = draft.milestones[m.code];
        await milestone.mutateAsync({ code: m.code, body: { current_date: d.current_date || null, actual_date: d.actual_date || null } });
      }
      const msg = `Project ${project.p2_project_no} saved${changed.length ? ` with ${changed.length} milestone date change${changed.length === 1 ? "" : "s"}` : ""}.`;
      setSaved(msg);
      setDraft((d) => ({ ...d, note: "" }));
      announce(msg);
    } catch (err) {
      if (err instanceof ApiError && err.status === 403) {
        setForbidden(true);
        announce("Saving was refused: your role is read only.", "assertive");
        return;
      }
      const items = validationItems(err);
      if (items.length) {
        setServerErrors(Object.fromEntries(items.map((i) => [ITEM_TO_FIELD[i.item] ?? i.item, i.message])));
        announce("The server rejected the form. Fix the highlighted fields.", "assertive");
        document.getElementById(`${id}-${ITEM_TO_FIELD[items[0].item] ?? "pct_complete"}`)?.focus();
        return;
      }
      announce("Saving failed. The previous values were restored.", "assertive");
    }
  };

  const update = (patch: Partial<Draft>) => setDraft((d) => ({ ...d, ...patch }));
  const updateMilestone = (code: string, key: "current_date" | "actual_date", value: string) =>
    setDraft((d) => ({ ...d, milestones: { ...d.milestones, [code]: { ...d.milestones[code], [key]: value } } }));

  const phase = field("phase");
  const pct = field("pct_complete");
  const finish = field("current_finish");

  return (
    <form className="evs-status-form" onSubmit={(e) => void submit(e)} noValidate aria-labelledby={`${id}-title`} aria-describedby={readOnly ? `${id}-readonly` : undefined} data-testid="status-form">
      <h2 id={`${id}-title`} className="evs-section__heading">Status update</h2>
      {readOnly && (
        <Alert type="info" slim id={`${id}-readonly`} role="status">
          <p className="usa-alert__text">{forbidden ? "The server refused the last save (403). Your role cannot edit this project." : `Read only: role ${role} can view but not change project status. Switch to a project manager role in the header to edit.`}</p>
        </Alert>
      )}
      {saved && !busy && <Alert type="success" slim role="status"><p className="usa-alert__text">{saved}</p></Alert>}
      {status.isError && status.error.status !== 403 && status.error.status !== 422 && <Alert type="error" slim role="alert"><p className="usa-alert__text">Saving failed ({status.error.referenceId}). The previous values were restored.</p></Alert>}
      <div className="evs-status-form__grid">
        <FormGroup error={Boolean(phase.error)}>
          <Label htmlFor={phase.id} error={Boolean(phase.error)}>Phase</Label>
          {phase.error && <ErrorMessage id={phase.errorId}>{phase.error}</ErrorMessage>}
          <Select id={phase.id} name="phase" value={draft.phase} onChange={(e) => update({ phase: e.target.value })} disabled={readOnly} aria-describedby={phase.error ? phase.errorId : undefined} aria-invalid={Boolean(phase.error)}>
            {PHASES.map((p) => <option key={p} value={p}>{p}</option>)}
            {!PHASES.includes(draft.phase as (typeof PHASES)[number]) && <option value={draft.phase}>{draft.phase}</option>}
          </Select>
        </FormGroup>
        <FormGroup error={Boolean(pct.error)}>
          <Label htmlFor={pct.id} error={Boolean(pct.error)} hint=" (multiples of 10)">Percent complete</Label>
          {pct.error && <ErrorMessage id={pct.errorId}>{pct.error}</ErrorMessage>}
          <Select id={pct.id} name="pct_complete" value={draft.pct_complete} onChange={(e) => update({ pct_complete: e.target.value })} disabled={readOnly} aria-describedby={pct.error ? pct.errorId : undefined} aria-invalid={Boolean(pct.error)} required>
            {PCT_STEPS.map((p) => <option key={p} value={String(p)}>{p}%</option>)}
          </Select>
        </FormGroup>
        <FormGroup error={Boolean(finish.error)}>
          <Label htmlFor={finish.id} error={Boolean(finish.error)} hint={` (baseline ${project.baseline_finish ?? "n/a"})`}>Current finish</Label>
          {finish.error && <ErrorMessage id={finish.errorId}>{finish.error}</ErrorMessage>}
          <input id={finish.id} name="current_finish" type="date" className={["usa-input", finish.error && "usa-input--error"].filter(Boolean).join(" ")} value={draft.current_finish} onChange={(e) => update({ current_finish: e.target.value })} disabled={readOnly} aria-describedby={finish.error ? finish.errorId : undefined} aria-invalid={Boolean(finish.error)} />
        </FormGroup>
      </div>
      <FormGroup>
        <Label htmlFor={`${id}-note`} hint=" (optional, written to the change history)">PM note</Label>
        <Textarea id={`${id}-note`} name="note" value={draft.note} onChange={(e) => update({ note: e.target.value })} disabled={readOnly} rows={2} />
      </FormGroup>

      <fieldset className="usa-fieldset margin-top-2">
        <legend className="usa-legend">Milestone dates</legend>
        <ul className="evs-status-form__milestones">
          {project.milestones.map((m) => {
            const d = draft.milestones[m.code] ?? { current_date: "", actual_date: "" };
            return (
              <li key={m.code} className="evs-status-form__milestone">
                <p className="margin-0"><strong>{m.code}</strong> {m.name}</p>
                <p className="margin-0 font-body-2xs">Baseline {m.baseline_date ? formatDate(m.baseline_date) : "n/a"}</p>
                <div>
                  <Label htmlFor={`${id}-ms-${m.code}-current`} className="margin-top-0">{m.name} current date</Label>
                  <input id={`${id}-ms-${m.code}-current`} name={`ms-${m.code}-current`} type="date" className="usa-input margin-top-0" value={d.current_date} onChange={(e) => updateMilestone(m.code, "current_date", e.target.value)} disabled={readOnly} />
                </div>
                <div>
                  <Label htmlFor={`${id}-ms-${m.code}-actual`} className="margin-top-0">{m.name} actual date</Label>
                  <input id={`${id}-ms-${m.code}-actual`} name={`ms-${m.code}-actual`} type="date" className="usa-input margin-top-0" value={d.actual_date} onChange={(e) => updateMilestone(m.code, "actual_date", e.target.value)} disabled={readOnly} />
                </div>
              </li>
            );
          })}
        </ul>
      </fieldset>

      <div className="evs-status-form__actions">
        <Button type="submit" disabled={readOnly || busy}>{busy ? "Saving" : "Save status"}</Button>
        <Button type="button" outline onClick={() => { setDraft(draftOf(project)); setTouched(false); setServerErrors({}); setSaved(null); }} disabled={readOnly || busy}>Reset</Button>
        <span className="font-body-2xs evs-muted">Writes go to PUT /api/v1/projects/{project.p2_project_no}/status (role evs_pm).</span>
      </div>
    </form>
  );
}
