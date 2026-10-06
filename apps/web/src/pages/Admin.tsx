import { useEffect, useId, useMemo, useState, type FormEvent } from "react";
import type { ColumnDef } from "@tanstack/react-table";
import { Alert, AlertHeading, AlertText, Button, ErrorMessage, FormGroup, Label } from "@trussworks/react-uswds";
import { AsOfBadge, DataTable, KpiTile, StatusChip, type StatusValue } from "../components";
import { ApiError, useFeeds, useThresholds, useUpdateThresholds, validationItems, type Schemas, type ThresholdUpdate } from "../hooks/useApi";
import { useRole } from "../hooks/useRole";
import { useAnnounce } from "../hooks/useAnnounce";
import { formatDateTime, formatNumber, formatRelative } from "../lib/format";
import { PageFrame, QueryBoundary } from "./shared/PageFrame";

type Feed = Schemas["FeedHealth"];
type Thresholds = Schemas["Thresholds"];

const FEED_STATUS: Record<Feed["status"], { status: StatusValue; label: string }> = {
  healthy: { status: "operating", label: "Healthy" },
  degraded: { status: "delayed", label: "Degraded" },
  down: { status: "closed", label: "Down" },
  simulated: { status: "unknown", label: "Simulated" },
  fixtures: { status: "unknown", label: "Fixtures" },
};

const feedColumns: ColumnDef<Feed, unknown>[] = [
  { id: "source", accessorKey: "source", header: "Feed" },
  { id: "status", accessorKey: "status", header: "Health", cell: (c) => { const s = FEED_STATUS[c.getValue<Feed["status"]>()]; return <StatusChip status={s.status} label={s.label} />; } },
  { id: "mode", accessorFn: (r) => r.mode ?? r.status, header: "Mode" },
  { id: "cadence_minutes", accessorKey: "cadence_minutes", header: "Cadence", meta: { numeric: true }, cell: (c) => `${formatNumber(c.getValue<number>(), { integer: true })} min` },
  { id: "last_success_at", accessorKey: "last_success_at", header: "Last success", cell: (c) => { const v = c.getValue<string | null>(); return v ? <time dateTime={v} title={formatDateTime(v)}>{formatRelative(v)}</time> : "never"; } },
  { id: "latency_ms", accessorKey: "latency_ms", header: "Latency", meta: { numeric: true }, cell: (c) => { const v = c.getValue<number | null>(); return v === null ? "n/a" : `${formatNumber(v, { integer: true })} ms`; } },
  { id: "rows_parsed", accessorFn: (r) => r.rows_parsed ?? null, header: "Rows", meta: { numeric: true }, cell: (c) => { const v = c.getValue<number | null>(); return v === null ? "n/a" : formatNumber(v, { integer: true }); } },
  { id: "consecutive_failures", accessorFn: (r) => r.consecutive_failures ?? 0, header: "Consecutive failures", meta: { numeric: true } },
  { id: "last_error", accessorKey: "last_error", header: "Last error", cell: (c) => c.getValue<string | null>() ?? "none" },
  { id: "endpoint", accessorKey: "endpoint", header: "Endpoint", cell: (c) => { const v = c.getValue<string>(); return v.startsWith("http") ? <a href={v} className="usa-link usa-link--external evs-break-anywhere" rel="noreferrer" target="_blank">{v.replace(/^https?:\/\//, "")}</a> : v; } },
];

interface ThresholdField {
  name: keyof ThresholdUpdate;
  label: string;
  hint: string;
  min: number;
  max: number;
}

/** Status engine inputs (WP5a rules): ranges mirror evs.schemas.ops.ThresholdUpdate. */
export const THRESHOLD_FIELDS: readonly ThresholdField[] = [
  { name: "stale_after_minutes", label: "Stale after", hint: "minutes since the newest input before a lock is flagged stale (1 to 1440)", min: 1, max: 1440 },
  { name: "delay_yellow_minutes", label: "Yellow delay", hint: "average 4 hour delay in minutes that turns a lock yellow (1 to 1440)", min: 1, max: 1440 },
  { name: "delay_red_minutes", label: "Red delay", hint: "average 4 hour delay in minutes that turns a lock red, must exceed yellow (1 to 2880)", min: 1, max: 2880 },
  { name: "queue_yellow_vessels", label: "Yellow queue", hint: "vessels waiting that turns a lock yellow (1 to 100)", min: 1, max: 100 },
  { name: "lpms_failover_hours", label: "LPMS failover", hint: "hours of LPMS failures before the labelled simulator takes over (1 to 168)", min: 1, max: 168 },
];

type Draft = Record<keyof ThresholdUpdate, string>;

function draftOf(t: Thresholds): Draft {
  return {
    stale_after_minutes: String(t.stale_after_minutes),
    delay_yellow_minutes: String(t.delay_yellow_minutes),
    delay_red_minutes: String(t.delay_red_minutes),
    queue_yellow_vessels: String(t.queue_yellow_vessels),
    lpms_failover_hours: String(t.lpms_failover_hours),
  };
}

export function validateThresholds(d: Draft): Partial<Record<keyof ThresholdUpdate, string>> {
  const errors: Partial<Record<keyof ThresholdUpdate, string>> = {};
  for (const f of THRESHOLD_FIELDS) {
    const n = Number(d[f.name]);
    if (d[f.name].trim() === "" || !Number.isInteger(n) || n < f.min || n > f.max) errors[f.name] = `${f.label} must be a whole number between ${f.min} and ${f.max}.`;
  }
  if (!errors.delay_red_minutes && !errors.delay_yellow_minutes && Number(d.delay_red_minutes) <= Number(d.delay_yellow_minutes)) {
    errors.delay_red_minutes = "Red delay must exceed yellow delay.";
  }
  return errors;
}

function toBody(d: Draft): ThresholdUpdate {
  return {
    stale_after_minutes: Number(d.stale_after_minutes),
    delay_yellow_minutes: Number(d.delay_yellow_minutes),
    delay_red_minutes: Number(d.delay_red_minutes),
    queue_yellow_vessels: Number(d.queue_yellow_vessels),
    lpms_failover_hours: Number(d.lpms_failover_hours),
  };
}

/** APEX page 10000 "Look Up Values" region: the lookup table becomes a validated settings form behind evs_admin. */
function ThresholdsForm({ thresholds }: { thresholds: Thresholds }) {
  const id = useId();
  const { announce } = useAnnounce();
  const [draft, setDraft] = useState<Draft>(() => draftOf(thresholds));
  const [touched, setTouched] = useState(false);
  const [serverErrors, setServerErrors] = useState<Partial<Record<keyof ThresholdUpdate, string>>>({});
  const [forbidden, setForbidden] = useState(false);
  const [saved, setSaved] = useState<string | null>(null);
  const update = useUpdateThresholds();

  useEffect(() => {
    setDraft(draftOf(thresholds));
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [thresholds.updated_at, thresholds.stale_after_minutes, thresholds.delay_yellow_minutes, thresholds.delay_red_minutes, thresholds.queue_yellow_vessels, thresholds.lpms_failover_hours]);

  const clientErrors = useMemo(() => validateThresholds(draft), [draft]);
  const errors = touched ? { ...clientErrors, ...serverErrors } : serverErrors;
  const readOnly = forbidden;
  const busy = update.isPending;

  const submit = async (e: FormEvent) => {
    e.preventDefault();
    setTouched(true);
    setSaved(null);
    setServerErrors({});
    const firstError = Object.keys(clientErrors)[0];
    if (firstError) {
      announce("The form has errors. Fix the highlighted fields.", "assertive");
      document.getElementById(`${id}-${firstError}`)?.focus();
      return;
    }
    try {
      const result = await update.mutateAsync(toBody(draft));
      const msg = `Thresholds saved${result.updated_by ? ` by ${result.updated_by}` : ""}. New lock evaluations use them on the next ingest cycle.`;
      setSaved(msg);
      announce(msg);
    } catch (err) {
      if (err instanceof ApiError && err.status === 403) {
        setForbidden(true);
        announce("Saving was refused: the administrator role is required.", "assertive");
        return;
      }
      const items = validationItems(err);
      if (items.length) {
        setServerErrors(Object.fromEntries(items.map((i) => [i.item, i.message])));
        announce("The server rejected the form. Fix the highlighted fields.", "assertive");
        document.getElementById(`${id}-${items[0].item}`)?.focus();
        return;
      }
      announce("Saving failed. The previous values were restored.", "assertive");
    }
  };

  return (
    <form className="evs-status-form margin-top-3" onSubmit={(e) => void submit(e)} noValidate aria-labelledby={`${id}-title`} data-testid="thresholds-form">
      <h2 id={`${id}-title`} className="evs-section__heading">Status engine thresholds</h2>
      <p className="margin-top-0 evs-muted">
        Source: {thresholds.source}
        {thresholds.updated_at ? `, last changed ${formatDateTime(thresholds.updated_at)} by ${thresholds.updated_by ?? "unknown"}` : ", defaults from settings, never changed"}.
      </p>
      {readOnly && (
        <Alert type="info" slim role="status">
          <p className="usa-alert__text">The server refused the last save (403). The administrator role is required to change thresholds.</p>
        </Alert>
      )}
      {saved && !busy && <Alert type="success" slim role="status"><p className="usa-alert__text">{saved}</p></Alert>}
      {update.isError && update.error.status !== 403 && update.error.status !== 422 && <Alert type="error" slim role="alert"><p className="usa-alert__text">Saving failed ({update.error.referenceId}). The previous values were restored.</p></Alert>}
      <div className="evs-status-form__grid">
        {THRESHOLD_FIELDS.map((f) => {
          const error = errors[f.name];
          const fieldId = `${id}-${f.name}`;
          return (
            <FormGroup key={f.name} error={Boolean(error)}>
              <Label htmlFor={fieldId} error={Boolean(error)} hint={` (${f.hint})`}>{f.label}</Label>
              {error && <ErrorMessage id={`${fieldId}-error`}>{error}</ErrorMessage>}
              <input
                id={fieldId}
                name={f.name}
                type="number"
                inputMode="numeric"
                min={f.min}
                max={f.max}
                step={1}
                className={["usa-input", error && "usa-input--error"].filter(Boolean).join(" ")}
                value={draft[f.name]}
                onChange={(e) => setDraft((d) => ({ ...d, [f.name]: e.target.value }))}
                disabled={readOnly}
                aria-describedby={error ? `${fieldId}-error` : undefined}
                aria-invalid={Boolean(error)}
                required
              />
            </FormGroup>
          );
        })}
      </div>
      <div className="evs-status-form__actions">
        <Button type="submit" disabled={readOnly || busy}>{busy ? "Saving" : "Save thresholds"}</Button>
        <Button type="button" outline onClick={() => { setDraft(draftOf(thresholds)); setTouched(false); setServerErrors({}); setSaved(null); }} disabled={readOnly || busy}>Reset</Button>
        <span className="font-body-2xs evs-muted">Writes go to PUT /api/v1/admin/thresholds (role evs_admin, APEX scheme Administration Rights).</span>
      </div>
    </form>
  );
}

/** APEX page 10000 Administration: feed monitoring table and the status engine lookups, administrator only. */
export function Admin() {
  const { isAdmin, role } = useRole();
  const feeds = useFeeds({ enabled: isAdmin });
  const thresholds = useThresholds({ enabled: isAdmin });

  const counts = useMemo(() => {
    const rows = feeds.data?.feeds ?? [];
    const by = (s: Feed["status"]) => rows.filter((r) => r.status === s).length;
    return { total: rows.length, healthy: by("healthy"), degraded: by("degraded"), down: by("down"), generated: rows.length ? by("fixtures") + by("simulated") : 0 };
  }, [feeds.data]);

  return (
    <PageFrame path="/admin" intro="Health of the public feeds behind the lock status pages and the thresholds the status engine applies. The APEX Administration page's access control and lookup regions become role checks in the API and this form.">
      {!isAdmin ? (
        <Alert type="info" role="status" data-testid="admin-gate">
          <AlertHeading level="h2">Administrator role required</AlertHeading>
          <AlertText>Role {role} can view dashboards but not feed health or thresholds. Switch to Administrator in the header to use this page.</AlertText>
        </Alert>
      ) : (
        <>
          <QueryBoundary query={feeds} label="Loading feed health" variant="kpi" isEmpty={(d) => d.feeds.length === 0} emptyTitle="No feeds registered" emptyMessage="The ingestion worker has not reported any feed yet.">
            {(data) => (
              <>
                <div className="evs-grid evs-grid--kpis" data-testid="feed-kpis">
                  <KpiTile label="Feeds monitored" value={formatNumber(counts.total, { integer: true })} context={`Generated ${formatDateTime(data.generated_at)}`} headingLevel={2} />
                  <KpiTile label="Healthy" value={formatNumber(counts.healthy, { integer: true })} context="Last poll parsed within cadence" headingLevel={2} />
                  <KpiTile label="Degraded" value={formatNumber(counts.degraded, { integer: true })} context="Parsed with repairs or late" headingLevel={2} />
                  <KpiTile label="Down or generated" value={formatNumber(counts.down + counts.generated, { integer: true })} context={counts.generated ? `${counts.generated} serving fixtures or the labelled simulator` : "Feeds failing or replaced by the simulator"} headingLevel={2} />
                </div>
                <DataTable
                  caption="Feed health (APEX page 10000 Monitoring region)"
                  captionMeta={<AsOfBadge asOf={{ source_as_of: data.generated_at, fetched_at: data.generated_at, freshness: "fresh", source: data.feeds.every((f) => f.status === "fixtures") ? "fixtures" : "live" }} tickMs={0} />}
                  columns={feedColumns}
                  data={data.feeds}
                  getRowId={(r) => r.source}
                  rowHeaderColumnId="source"
                  pageSize={10}
                  initialSorting={[{ id: "cadence_minutes", desc: false }]}
                  className="margin-top-3"
                />
              </>
            )}
          </QueryBoundary>
          <QueryBoundary query={thresholds} label="Loading thresholds" variant="text">
            {(data) => <ThresholdsForm thresholds={data} />}
          </QueryBoundary>
        </>
      )}
    </PageFrame>
  );
}

export default Admin;
