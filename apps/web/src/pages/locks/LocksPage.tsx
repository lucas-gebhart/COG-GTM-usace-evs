import { useQueryClient } from "@tanstack/react-query";
import type { ColumnDef } from "@tanstack/react-table";
import { Button, Icon } from "@trussworks/react-uswds";
import { useCallback, useEffect, useMemo, useRef, useState } from "react";
import { Link, useSearchParams } from "react-router";
import { AsOfBadge } from "../../components/AsOfBadge";
import { DataTable } from "../../components/DataTable";
import { EmptyState } from "../../components/EmptyState";
import { ErrorState } from "../../components/ErrorState";
import { FilterBar, type FilterField, type FilterValues } from "../../components/FilterBar";
import { PageHeader } from "../../components/PageHeader";
import { RefreshControl } from "../../components/RefreshControl";
import { SidePanel } from "../../components/SidePanel";
import { SkeletonLoader } from "../../components/SkeletonLoader";
import { StatusChip } from "../../components/StatusChip";
import { StatusShape } from "../../components/StatusMarker";
import { AccessibleMap, type MapPoint } from "../../components/map/AccessibleMap";
import { STATUS_META, normalizeStatus } from "../../components/status";
import { useAnnounce } from "../../hooks/useAnnounce";
import { LOCKS_STREAM_URL, useLocks, type AsOf } from "../../hooks/useApi";
import { useReducedMotion } from "../../hooks/useReducedMotion";
import { useSse, type SseEvent } from "../../hooks/useSse";
import { downloadCsv, toCsv, type CsvColumn } from "../../lib/csv";
import { formatDateTime, formatNumber } from "../../lib/format";
import { LockDetailPanel } from "./LockDetailPanel";
import {
  COUNT_STATUSES,
  FreshnessTag,
  RelativeTime,
  STATUS_LEVEL,
  asOfSentence,
  compareRiverMile,
  countsSentence,
  formatMinutes,
  statusLabel,
  useNow,
  type LockCounts,
  type LockSummary,
} from "./lockUtils";

const DIVISION_NAME: Record<string, string> = {
  LRD: "Great Lakes and Ohio River Division (LRD)",
  MVD: "Mississippi Valley Division (MVD)",
  NAD: "North Atlantic Division (NAD)",
  NWD: "Northwestern Division (NWD)",
  POD: "Pacific Ocean Division (POD)",
  SAD: "South Atlantic Division (SAD)",
  SPD: "South Pacific Division (SPD)",
  SWD: "Southwestern Division (SWD)",
};

const csvColumns: CsvColumn<LockSummary>[] = [
  { key: "river_name", header: "River" },
  { key: "lock_name", header: "Lock" },
  { key: "lock_id", header: "Lock ID" },
  { key: "river_mile", header: "River mile" },
  { key: "chambers", header: "Chambers" },
  { key: "status", header: "Status", format: (v) => statusLabel(String(v)) },
  { key: "status_reason", header: "Reason" },
  { key: "avg_delay_4h_min", header: "4-hour delay (min)" },
  { key: "vessels_queued", header: "Queue" },
  { key: "active_stoppages", header: "Active stoppages" },
  { key: "as_of", header: "Source as of", format: (_v, r) => r.as_of.source_as_of },
  { key: "freshness", header: "Freshness", format: (_v, r) => r.as_of.freshness },
  { key: "source", header: "Source", format: (_v, r) => r.as_of.source },
];

function LockTooltip({ lock }: { lock: LockSummary }) {
  return (
    <>
      <p className="evs-maptip__title">
        {lock.lock_name}, {lock.river_name}
      </p>
      <p>
        {statusLabel(lock.status)}: {lock.status_reason}
      </p>
      <p>
        Queue {lock.vessels_queued ?? "no data"}, 4-hour delay {formatMinutes(lock.avg_delay_4h_min)}
        {lock.active_stoppages > 0 ? `, ${lock.active_stoppages} active stoppage${lock.active_stoppages === 1 ? "" : "s"}` : ""}
      </p>
      <p>As of {formatDateTime(lock.as_of.source_as_of)}</p>
    </>
  );
}

interface LiveMeta {
  counts: LockCounts;
  as_of: AsOf;
  at: Date;
}

/** /public/locks: counts strip with SSE updates, URL-backed filters, sortable table with CSV, map with accessible markers, detail side panel. */
export function LocksPage() {
  const [params, setParams] = useSearchParams();
  const river = params.get("river") ?? "";
  const statusFilter = params.get("status") ?? "";
  const search = params.get("q") ?? "";
  const view = params.get("view") === "map" ? "map" : "table";
  const selectedId = params.get("lock");

  const update = useCallback(
    (patch: Record<string, string | null>, replace = false) => {
      setParams(
        (prev) => {
          const next = new URLSearchParams(prev);
          for (const [k, v] of Object.entries(patch)) {
            if (v) next.set(k, v);
            else next.delete(k);
          }
          return next;
        },
        { replace },
      );
    },
    [setParams],
  );

  const locks = useLocks();
  const queryClient = useQueryClient();
  const { announce } = useAnnounce();
  const reduced = useReducedMotion();
  const now = useNow();
  const [liveChoice, setLiveChoice] = useState<boolean | null>(null);
  const live = liveChoice ?? !reduced;
  const [liveMeta, setLiveMeta] = useState<LiveMeta | null>(null);
  const [overrides, setOverrides] = useState<Record<string, LockSummary>>({});
  const trigger = useRef<HTMLElement | null>(null);

  useEffect(() => {
    setOverrides({});
  }, [locks.dataUpdatedAt]);

  const onEvent = useCallback(
    (ev: SseEvent<unknown>) => {
      if (ev.type === "locks") {
        const d = ev.data as { counts?: LockCounts; as_of?: AsOf } | null;
        if (d?.counts && d.as_of) {
          setLiveMeta({ counts: d.counts, as_of: d.as_of, at: ev.receivedAt });
          announce(`Lock status updated: ${countsSentence(d.counts)}. ${asOfSentence(d.as_of)}`);
        }
      } else if (ev.type === "lock") {
        const d = ev.data as LockSummary | null;
        if (d?.lock_id) {
          setOverrides((o) => ({ ...o, [d.lock_id]: d }));
          void queryClient.invalidateQueries({ queryKey: ["lock", d.lock_id] });
        }
      }
    },
    [announce, queryClient],
  );
  const sse = useSse<unknown>(LOCKS_STREAM_URL, { events: ["locks", "lock"], enabled: live, onEvent });

  const items = useMemo(() => {
    const seen = new Set<string>();
    const out: LockSummary[] = [];
    for (const i of locks.data?.items ?? []) {
      if (seen.has(i.lock_id)) continue;
      seen.add(i.lock_id);
      out.push(overrides[i.lock_id] ?? i);
    }
    return out.sort(compareRiverMile);
  }, [locks.data, overrides]);

  const filtered = useMemo(() => {
    const q = search.trim().toLowerCase();
    return items.filter(
      (l) =>
        (!river || l.river_code === river) &&
        (!statusFilter || normalizeStatus(l.status) === statusFilter) &&
        (!q || l.lock_name.toLowerCase().includes(q) || l.lock_id.toLowerCase().includes(q) || l.river_name.toLowerCase().includes(q)),
    );
  }, [items, river, statusFilter, search]);

  const riverOptions = useMemo(() => {
    const byCode = new Map<string, { label: string; group?: string }>();
    for (const l of items) {
      if (!byCode.has(l.river_code)) byCode.set(l.river_code, { label: l.river_name, group: l.division ? (DIVISION_NAME[l.division] ?? `${l.division} division`) : undefined });
    }
    return [...byCode.entries()].sort((a, b) => a[1].label.localeCompare(b[1].label)).map(([value, o]) => ({ value, ...o }));
  }, [items]);

  const fields: FilterField[] = useMemo(
    () => [
      { id: "river", label: "River system", type: "select", options: riverOptions, placeholder: "All rivers" },
      { id: "status", label: "Status", type: "select", options: [...COUNT_STATUSES, "unknown" as const].map((s) => ({ value: s, label: STATUS_META[s].label })), placeholder: "All statuses" },
      { id: "q", label: "Lock name", type: "search", placeholder: "Search by lock name or ID" },
    ],
    [riverOptions],
  );
  const filterValues: FilterValues = useMemo(() => ({ river, status: statusFilter, q: search }), [river, statusFilter, search]);

  const select = useCallback(
    (id: string, el: HTMLElement | null) => {
      trigger.current = el;
      update({ lock: id });
    },
    [update],
  );

  const columns = useMemo<ColumnDef<LockSummary, unknown>[]>(
    () => [
      { accessorKey: "river_name", header: "River" },
      {
        accessorKey: "lock_name",
        header: "Lock",
        cell: (c) => (
          <>
            {c.getValue<string>()}{" "}
            <span className="font-body-3xs text-base-dark">
              ({c.row.original.lock_id}
              {c.row.original.river_mile != null ? `, mile ${formatNumber(c.row.original.river_mile)}` : ""})
            </span>
          </>
        ),
      },
      { accessorKey: "chambers", header: "Chambers", meta: { numeric: true }, cell: (c) => c.getValue<number | null>() ?? "No data" },
      {
        accessorKey: "status",
        header: "Status",
        cell: (c) => <StatusChip status={c.getValue<string>()} />,
        sortingFn: (a, b) => STATUS_LEVEL[normalizeStatus(a.original.status)] - STATUS_LEVEL[normalizeStatus(b.original.status)],
      },
      { accessorKey: "status_reason", header: "Reason" },
      { accessorKey: "avg_delay_4h_min", header: "4-hour delay", meta: { numeric: true }, cell: (c) => formatMinutes(c.getValue<number | null>()) },
      { accessorKey: "vessels_queued", header: "Queue", meta: { numeric: true }, cell: (c) => c.getValue<number | null>() ?? "No data" },
      {
        accessorKey: "active_stoppages",
        header: "Active stoppage",
        cell: (c) => {
          const n = c.getValue<number>() ?? 0;
          return n > 0 ? `Yes (${n})` : "No";
        },
      },
      { id: "as_of", accessorFn: (r) => r.as_of.source_as_of, header: "As of", cell: (c) => <RelativeTime value={c.getValue<string>()} now={now} /> },
      { id: "freshness", accessorFn: (r) => r.as_of.freshness, header: "Freshness", cell: (c) => <FreshnessTag freshness={c.getValue<string>()} /> },
    ],
    [now],
  );

  const points = useMemo<MapPoint[]>(
    () =>
      filtered
        .filter((l) => l.latitude != null && l.longitude != null)
        .map((l) => ({
          id: l.lock_id,
          latitude: l.latitude as number,
          longitude: l.longitude as number,
          name: `${l.lock_name}, ${l.river_name}: ${statusLabel(l.status)}`,
          shape: <StatusShape status={normalizeStatus(l.status)} />,
          tooltip: <LockTooltip lock={l} />,
        })),
    [filtered],
  );

  const counts = liveMeta?.counts ?? locks.data?.counts;
  const asOf = liveMeta?.as_of ?? locks.data?.as_of;
  const lastRefresh = useMemo(() => {
    const fetched = locks.dataUpdatedAt ? new Date(locks.dataUpdatedAt) : null;
    const event = liveMeta?.at ?? null;
    if (fetched && event) return fetched > event ? fetched : event;
    return fetched ?? event;
  }, [locks.dataUpdatedAt, liveMeta]);
  const selected = selectedId ? items.find((l) => l.lock_id === selectedId) ?? null : null;
  const alternativeText = "The lock table below lists the same locks with the same status, reason and as-of fields.";

  const exportCsv = () => downloadCsv("lock-status.csv", toCsv(filtered, csvColumns));

  return (
    <div className="evs-page evs-page--locks">
      <PageHeader
        title="Lock status by river"
        intro="Operating status of inland navigation locks from public USACE LPMS feeds, evaluated by the demo status engine. Status is shown with a shape, a colour and text."
        actions={asOf ? <AsOfBadge asOf={asOf} /> : undefined}
      />

      {locks.isPending && <SkeletonLoader label="Loading lock status" variant="table" lines={8} />}
      {locks.isError && <ErrorState message="Lock status could not be loaded from the API." error={locks.error} onRetry={() => locks.refetch()} />}
      {locks.isSuccess && items.length === 0 && <EmptyState message="The API returned no locks. Run the ingestion worker (evs ingest --once) or check the feed settings on the admin page." />}

      {locks.isSuccess && items.length > 0 && (
        <>
          <div className="evs-strip" data-testid="locks-strip">
            {COUNT_STATUSES.map((s) => (
              <button key={s} type="button" className="evs-count" aria-pressed={statusFilter === s} onClick={() => update({ status: statusFilter === s ? null : s })} data-testid={`count-${s}`}>
                <StatusShape status={s} />
                <span className="evs-count__n">{counts?.[s] ?? 0}</span>
                <span className="evs-count__label">{STATUS_META[s].label}</span>
              </button>
            ))}
          </div>
          <div className="evs-live">
            <p className="evs-live__text" aria-live="polite" aria-atomic="true" data-testid="locks-asof">
              {asOfSentence(asOf)}
            </p>
            <div className="evs-live__controls">
              <Button type="button" outline className="evs-toggle" aria-pressed={live} onClick={() => setLiveChoice(!live)} data-testid="live-toggle">
                <span className="evs-toggle__dot" aria-hidden="true" /> Live updates {live ? "on" : "off"}
              </Button>
              <span className="font-body-3xs" data-testid="live-status">
                {live ? (sse.status === "open" ? "Connected" : sse.status === "connecting" || sse.status === "reconnecting" ? "Connecting" : "Not connected") : reduced && liveChoice === null ? "Off because reduced motion is on" : "Paused"}
              </span>
              <RefreshControl onRefresh={() => locks.refetch()} intervalSeconds={120} initiallyPaused lastRefreshed={lastRefresh} />
            </div>
          </div>

          <FilterBar legend="Filter locks" fields={fields} values={filterValues} onApply={(v) => update({ river: v.river || null, status: v.status || null, q: v.q || null })} onReset={() => update({ river: null, status: null, q: null })} resultCount={filtered.length} resultNoun="locks" />

          <div className="evs-viewswitch" role="group" aria-label="View">
            <Button type="button" outline={view !== "table"} aria-pressed={view === "table"} onClick={() => update({ view: null }, true)}>
              <Icon.List aria-hidden="true" focusable={false} /> Table
            </Button>
            <Button type="button" outline={view !== "map"} aria-pressed={view === "map"} onClick={() => update({ view: "map" }, true)} data-testid="view-map">
              <Icon.Map aria-hidden="true" focusable={false} /> Map
            </Button>
            <span className="evs-viewswitch__spacer" />
            <Button type="button" outline onClick={exportCsv} disabled={filtered.length === 0}>
              <Icon.FileDownload aria-hidden="true" focusable={false} /> Download CSV
            </Button>
          </div>

          <div className={["evs-layout", selectedId && "evs-layout--panel"].filter(Boolean).join(" ")}>
            <div>
              {view === "map" && <AccessibleMap points={points} selectedId={selectedId} onSelect={select} label="Map of lock status" alternativeText={alternativeText} />}
              <DataTable<LockSummary>
                caption={view === "map" ? "Lock status table (text alternative to the map)" : "Lock status"}
                captionMeta={`${filtered.length} of ${items.length} locks${river ? `, river ${riverOptions.find((r) => r.value === river)?.label ?? river}` : ""}`}
                columns={columns}
                data={filtered}
                getRowId={(r) => r.lock_id}
                rowHeaderColumnId="lock_name"
                onRowActivate={(row) => select(row.lock_id, document.activeElement as HTMLElement | null)}
                pageSize={25}
                emptyMessage="No locks match the current filters. Reset the filters to see every lock."
              />
            </div>
            <SidePanel
              title={selected ? `${selected.lock_name}, ${selected.river_name}` : `Lock ${selectedId ?? ""}`}
              open={Boolean(selectedId)}
              onClose={() => update({ lock: null })}
              returnFocusTo={trigger.current}
              headingLevel={2}
              actions={
                selectedId ?
                  <Link className="usa-button usa-button--outline margin-0" to={`/public/locks/${selectedId}`}>
                    Full page
                  </Link>
                : undefined
              }
            >
              {selectedId && <LockDetailPanel lockId={selectedId} summary={selected} headingLevel={3} />}
            </SidePanel>
          </div>
        </>
      )}
    </div>
  );
}
