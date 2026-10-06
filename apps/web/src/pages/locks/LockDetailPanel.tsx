import { CartesianGrid, Line, LineChart, ResponsiveContainer, Tooltip, XAxis, YAxis } from "recharts";
import { AsOfBadge } from "../../components/AsOfBadge";
import { ErrorState } from "../../components/ErrorState";
import { Figure, type FigureColumn } from "../../components/Figure";
import { SkeletonLoader } from "../../components/SkeletonLoader";
import { StatusChip } from "../../components/StatusChip";
import { normalizeStatus } from "../../components/status";
import { useLock } from "../../hooks/useApi";
import { formatDateTime, formatNumber, formatTime } from "../../lib/format";
import { CHART_TOKENS, SERIES } from "../../theme";
import { LEVEL_LABEL, STATUS_LEVEL, formatMinutes, sourceText, statusLabel, type LockDetail, type LockSummary } from "./lockUtils";

export interface LockDetailPanelProps {
  lockId: string;
  /** Row already on screen; shown while the detail request is in flight. */
  summary?: LockSummary | null;
  /** Level of the section headings inside the panel (the panel or page title is one level up). */
  headingLevel?: 2 | 3;
}

interface HistoryRow {
  time: string;
  level: number;
  status: string;
  reason: string;
  source: string;
}

type Row = Record<string, unknown>;

const historyColumns: FigureColumn<HistoryRow>[] = [
  { key: "time", header: "Evaluated at", rowHeader: true, format: (v) => formatDateTime(v as string) },
  { key: "status", header: "Status", format: (v) => statusLabel(String(v)) },
  { key: "reason", header: "Reason" },
  { key: "source", header: "Source", format: (v) => sourceText(String(v)) },
];

function text(v: unknown): string {
  if (v === null || v === undefined || v === "") return "No data";
  if (typeof v === "boolean") return v ? "Yes" : "No";
  if (typeof v === "number") return formatNumber(v);
  return String(v);
}

function when(v: unknown): string {
  return typeof v === "string" ? formatDateTime(v) : "No data";
}

/** Lock facts, status and reason, stoppages and NTNI notices, queue and traffic, 24-hour history, as-of fields. */
export function LockDetailPanel({ lockId, summary, headingLevel = 3 }: LockDetailPanelProps) {
  const q = useLock(lockId);
  const lock: LockDetail | LockSummary | undefined = q.data ?? summary ?? undefined;
  const H = `h${headingLevel}` as const;
  const figureLevel = (headingLevel + 1) as 3 | 4;

  if (!lock) {
    if (q.isError) return <ErrorState message="This lock could not be loaded." error={q.error} onRetry={() => q.refetch()} headingLevel={headingLevel} />;
    return <SkeletonLoader label="Loading lock detail" variant="text" lines={6} />;
  }
  const detail = q.data;
  const status = normalizeStatus(lock.status);
  const ruleNo = (detail?.status_inputs as Record<string, unknown> | undefined)?.rule_no ?? null;
  const inputs = Object.entries(detail?.status_inputs ?? {}).filter(([, v]) => v === null || ["string", "number", "boolean"].includes(typeof v));
  const stoppages = (detail?.stoppages ?? []) as Row[];
  const notices = (detail?.ntni_notices ?? []) as Row[];
  const queue = (detail?.queue ?? []) as Row[];
  const lockages = (detail?.recent_lockages ?? []) as Row[];
  const gauges = (detail?.gauges ?? []) as Row[];
  const history: HistoryRow[] = (detail?.history ?? []).map((h) => ({
    time: h.evaluated_at,
    level: STATUS_LEVEL[normalizeStatus(h.status)],
    status: h.status,
    reason: h.status_reason,
    source: h.source,
  }));
  const changes = history.reduce((n, h, i) => (i > 0 && h.status !== history[i - 1].status ? n + 1 : n), 0);
  const historyDescription =
    history.length === 0 ? "No status evaluations in the last 24 hours."
    : `${history.length} evaluation${history.length === 1 ? "" : "s"} from ${formatDateTime(history[0].time)} to ${formatDateTime(history[history.length - 1].time)}, ${changes} status change${changes === 1 ? "" : "s"}; latest status ${statusLabel(history[history.length - 1].status)}.`;

  return (
    <div className="evs-detail" data-testid="lock-detail">
      <div className="evs-detail__status">
        <StatusChip status={status} />
        {ruleNo != null && <span className="evs-detail__rule">Rule {String(ruleNo)}</span>}
      </div>
      <p className="evs-detail__reason">{lock.status_reason}</p>
      {q.isPending && <p className="evs-detail__muted" role="status">Loading detail</p>}
      {q.isError && <p className="evs-detail__muted" role="status">Detail unavailable; showing the table row.</p>}

      <H>Lock</H>
      <dl className="evs-dl">
        <dt>River</dt>
        <dd>
          {lock.river_name} ({lock.river_code}){lock.river_mile != null ? `, mile ${formatNumber(lock.river_mile)}` : ""}
        </dd>
        <dt>Lock ID</dt>
        <dd>{lock.lock_id}</dd>
        <dt>District</dt>
        <dd>
          {text(lock.district)}
          {lock.division ? `, ${lock.division} division` : ""}
          {lock.state ? `, ${lock.state}` : ""}
        </dd>
        <dt>Chambers</dt>
        <dd>
          {text(lock.chambers)}
          {detail?.chamber_dimensions ? `, ${detail.chamber_dimensions}` : ""}
        </dd>
        {detail?.lift_ft != null && (
          <>
            <dt>Lift</dt>
            <dd>{formatNumber(detail.lift_ft)} ft</dd>
          </>
        )}
        {detail?.year_opened != null && (
          <>
            <dt>Year opened</dt>
            <dd>{String(detail.year_opened)}</dd>
          </>
        )}
        {(detail?.owner || detail?.operator) && (
          <>
            <dt>Owner and operator</dt>
            <dd>
              {text(detail?.owner)} / {text(detail?.operator)}
            </dd>
          </>
        )}
        {lock.latitude != null && lock.longitude != null && (
          <>
            <dt>Coordinates</dt>
            <dd>
              {lock.latitude.toFixed(4)}, {lock.longitude.toFixed(4)}
            </dd>
          </>
        )}
      </dl>

      <H>Stoppages and notices</H>
      {stoppages.length === 0 && notices.length === 0 ?
        <p className="evs-detail__muted">No stoppages in the last 90 days and no Notices to Navigation Interests name this lock.</p>
      : <>
          {stoppages.length > 0 && (
            <ul aria-label="Stoppages">
              {stoppages.map((s, i) => (
                <li key={i}>
                  {s.active ? "Active: " : ""}
                  {text(s.reason_code)}
                  {s.chamber_no != null ? `, chamber ${text(s.chamber_no)}` : ""}
                  {s.is_scheduled ? ", scheduled" : ", unscheduled"}
                  {s.traffic_stopped ? ", traffic stopped" : ""}; {when(s.begin_at)} to {s.end_at ? when(s.end_at) : "open"}
                </li>
              ))}
            </ul>
          )}
          {notices.length > 0 && (
            <ul aria-label="Notices to Navigation Interests">
              {notices.map((n, i) => (
                <li key={i}>
                  NTNI {text(n.notice_no)}: {text(n.title)}
                  {n.effective_from ? ` (effective ${when(n.effective_from)}${n.effective_to ? ` to ${when(n.effective_to)}` : ""})` : ""}
                </li>
              ))}
            </ul>
          )}
        </>
      }

      <H>Queue and traffic</H>
      <dl className="evs-dl">
        <dt>Vessels queued</dt>
        <dd>{text(lock.vessels_queued)}</dd>
        <dt>Average delay, 4 hours</dt>
        <dd>{formatMinutes(lock.avg_delay_4h_min)}</dd>
        <dt>Average delay, 24 hours</dt>
        <dd>{formatMinutes(lock.avg_delay_24h_min)}</dd>
        <dt>Active stoppages</dt>
        <dd>{String(lock.active_stoppages ?? 0)}</dd>
        <dt>Last lockage</dt>
        <dd>{when(lock.last_lockage_at)}</dd>
        {lock.gauge_stage_ft != null && (
          <>
            <dt>Gauge stage</dt>
            <dd>
              {formatNumber(lock.gauge_stage_ft)} ft{lock.flood_category ? `, ${lock.flood_category}` : ""}
            </dd>
          </>
        )}
      </dl>
      {queue.length > 0 && (
        <ul aria-label="Vessels in queue">
          {queue.slice(0, 10).map((v, i) => (
            <li key={i}>
              {text(v.vessel_name ?? v.vessel_no)}, {text(v.direction)} bound, {text(v.num_barges)} barges, arrived {when(v.arrival_at)}
            </li>
          ))}
        </ul>
      )}
      {lockages.length > 0 && <p className="evs-detail__muted">{lockages.length} recent lockages recorded; most recent {when(lockages[0]?.end_of_lockage_at)}.</p>}
      {gauges.length > 0 && (
        <ul aria-label="Gauges">
          {gauges.map((g, i) => (
            <li key={i}>
              {String(g.provider ?? "gauge").toUpperCase()} {text(g.station_id)}: stage {text(g.stage_ft)} ft{g.flood_category ? `, ${text(g.flood_category)}` : ""}, observed {when(g.observed_at)}
            </li>
          ))}
        </ul>
      )}

      {history.length > 0 ?
        <Figure<HistoryRow>
          title="Status, last 24 hours"
          description={historyDescription}
          data={history}
          columns={historyColumns}
          headingLevel={figureLevel}
          height={160}
          csvName={`${lock.lock_id}-status-history`}
          legend={[{ name: "Status level (Operating, Delayed, Closed, Stale or unknown)", seriesIndex: 0 }]}
          getRowKey={(r) => r.time}
        >
          {({ reducedMotion }) => (
            <ResponsiveContainer width="100%" height="100%">
              <LineChart data={history} accessibilityLayer margin={{ top: 8, right: 16, bottom: 8, left: 8 }}>
                <CartesianGrid stroke={CHART_TOKENS.grid} vertical={false} />
                <XAxis dataKey="time" tickFormatter={(v: string) => formatTime(v)} tick={{ fill: CHART_TOKENS.axis }} />
                <YAxis domain={[0, 3]} ticks={[0, 1, 2, 3]} tickFormatter={(v: number) => LEVEL_LABEL[v] ?? ""} width={92} tick={{ fill: CHART_TOKENS.axis }} />
                <Tooltip formatter={(v) => LEVEL_LABEL[Number(v)] ?? String(v)} labelFormatter={(l) => formatDateTime(String(l))} />
                <Line type="stepAfter" name="Status" dataKey="level" stroke={SERIES[0].color} strokeWidth={2} dot={{ r: 4 }} isAnimationActive={!reducedMotion} />
              </LineChart>
            </ResponsiveContainer>
          )}
        </Figure>
      : <>
          <H>Status, last 24 hours</H>
          <p className="evs-detail__muted">{historyDescription}</p>
        </>
      }

      {inputs.length > 0 && (
        <>
          <H>Status engine inputs</H>
          <dl className="evs-dl">
            {inputs.map(([k, v]) => (
              <div key={k} className="display-contents">
                <dt>{k.replaceAll("_", " ")}</dt>
                <dd>{k.endsWith("_at") ? when(v) : text(v)}</dd>
              </div>
            ))}
          </dl>
        </>
      )}

      <H>As of</H>
      <AsOfBadge asOf={lock.as_of} tickMs={0} />
    </div>
  );
}
