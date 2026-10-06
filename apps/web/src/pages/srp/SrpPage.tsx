import { useCallback, useMemo, useRef } from "react";
import { useSearchParams } from "react-router";
import { CartesianGrid, Line, LineChart, ResponsiveContainer, Tooltip, XAxis, YAxis } from "recharts";
import { AsOfBadge } from "../../components/AsOfBadge";
import { ErrorState } from "../../components/ErrorState";
import { Figure, type FigureColumn } from "../../components/Figure";
import { KpiTile } from "../../components/KpiTile";
import { PageHeader } from "../../components/PageHeader";
import { SidePanel } from "../../components/SidePanel";
import { SkeletonLoader } from "../../components/SkeletonLoader";
import { AccessibleMap, SiteShape, type MapPoint } from "../../components/map/AccessibleMap";
import { useSrpCoverage, type Schemas } from "../../hooks/useApi";
import { formatNumber } from "../../lib/format";
import { CHART_TOKENS, SERIES } from "../../theme";

type Snapshot = Schemas["SrpSnapshot"];
type Site = Schemas["SrpSite"];
type Citation = Schemas["SrpCitation"];

const HEC_URL = "https://www.hec.usace.army.mil/sustainablerivers/";
const IWR_URL = "https://www.iwr.usace.army.mil/Missions/Environment/Sustainable-Rivers-Program/";

const HERO: { key: string; label: string; unit?: string }[] = [
  { key: "river_systems", label: "River systems" },
  { key: "river_miles", label: "River miles" },
  { key: "dams_and_reservoirs", label: "Dams and reservoirs" },
  { key: "districts", label: "USACE districts" },
  { key: "states", label: "States" },
  { key: "floodplain_acres", label: "Floodplain acres" },
];

const growthColumns: FigureColumn<Snapshot>[] = [
  { key: "year", header: "Year", rowHeader: true },
  { key: "river_systems", header: "River systems", numeric: true },
  { key: "river_miles", header: "River miles", numeric: true },
  { key: "dams", header: "Dams", numeric: true },
  { key: "source", header: "Source" },
];

function num(headline: Record<string, number | string>, key: string): number | null {
  const v = headline[key];
  return typeof v === "number" ? v : null;
}

function siteId(s: Site): string {
  return s.nid_id ?? s.name;
}

/** /public/srp: cited headline figures, growth chart with table and CSV, site map with grouped list, economic value, what SRP does. */
export function SrpPage() {
  const q = useSrpCoverage();
  const [params, setParams] = useSearchParams();
  const selectedId = params.get("site");
  const trigger = useRef<HTMLElement | null>(null);

  const select = useCallback(
    (id: string | null, el?: HTMLElement | null) => {
      trigger.current = el ?? null;
      setParams(
        (prev) => {
          const next = new URLSearchParams(prev);
          if (id) next.set("site", id);
          else next.delete("site");
          return next;
        },
        { replace: false },
      );
    },
    [setParams],
  );

  const sites = useMemo(() => [...(q.data?.sites ?? [])].sort((a, b) => a.river.localeCompare(b.river) || a.name.localeCompare(b.name)), [q.data]);
  const byRiver = useMemo(() => {
    const m = new Map<string, Site[]>();
    for (const s of sites) m.set(s.river, [...(m.get(s.river) ?? []), s]);
    return [...m.entries()];
  }, [sites]);
  const points = useMemo<MapPoint[]>(
    () =>
      sites
        .filter((s) => s.latitude != null && s.longitude != null)
        .map((s) => ({
          id: siteId(s),
          latitude: s.latitude as number,
          longitude: s.longitude as number,
          name: `${s.name}, ${s.river}, ${s.state}`,
          shape: <SiteShape />,
          tooltip: (
            <>
              <p className="evs-maptip__title">{s.name}</p>
              <p>
                {s.river}, {s.state}
                {s.district ? `, ${s.district} district` : ""}
              </p>
              <p>{s.year_joined ? `In SRP since ${s.year_joined}` : "Join year not stated"}</p>
            </>
          ),
        })),
    [sites],
  );
  const growth = useMemo(() => (q.data?.snapshots ?? []).filter((s) => s.year >= 2002 && s.year <= 2024).sort((a, b) => a.year - b.year), [q.data]);

  if (q.isPending) {
    return (
      <div className="evs-page">
        <PageHeader title="Sustainable Rivers Program" />
        <SkeletonLoader label="Loading Sustainable Rivers Program figures" variant="kpi" />
      </div>
    );
  }
  if (q.isError) {
    return (
      <div className="evs-page">
        <PageHeader title="Sustainable Rivers Program" />
        <ErrorState message="The SRP coverage figures could not be loaded." error={q.error} onRetry={() => q.refetch()} />
      </div>
    );
  }

  const { headline, as_of } = q.data;
  const citations = q.data.citations ?? [];
  const cite = (key: string): Citation | undefined => citations.find((c) => c.figure === key);
  const tiles = HERO.filter((h) => num(headline, h.key) !== null);
  const npvLow = num(headline, "npv_usd_m_low");
  const npvHigh = num(headline, "npv_usd_m_high");
  const bcrLow = num(headline, "bcr_low");
  const bcrHigh = num(headline, "bcr_high");
  const npvCite = cite("npv_usd_m");
  const bcrCite = cite("bcr");
  const selectedSite = selectedId ? sites.find((s) => siteId(s) === selectedId) ?? null : null;
  const first = growth[0];
  const last = growth[growth.length - 1];
  const growthDescription =
    first && last ?
      `River systems in the program grew from ${formatNumber(first.river_systems)} in ${first.year} to ${formatNumber(last.river_systems)} in ${last.year}. River miles and dam counts are only stated for some years, so those lines have gaps.`
    : "No growth snapshots were returned by the API.";

  return (
    <div className="evs-page evs-page--srp">
      <PageHeader
        title="Sustainable Rivers Program"
        intro="Public figures on the USACE and The Nature Conservancy Sustainable Rivers Program, each shown with the source it was taken from. Nothing on this page is measured by this demo."
        actions={<AsOfBadge asOf={as_of} tickMs={0} />}
      />

      <section aria-labelledby="srp-scale">
        <h2 id="srp-scale">Program scale</h2>
        <div className="evs-grid evs-grid--kpis">
          {tiles.map((t) => {
            const c = cite(t.key);
            const v = num(headline, t.key) as number;
            return <KpiTile key={t.key} label={t.label} value={formatNumber(v, { integer: true })} unit={t.unit} deltaPct={null} context={c ? `${c.source}, ${c.year}` : "No citation supplied by the API"} headingLevel={3} />;
          })}
        </div>
        <ul className="evs-cite" aria-label="Sources for the program scale figures">
          {tiles.map((t) => {
            const c = cite(t.key);
            if (!c) return null;
            return (
              <li key={t.key}>
                <span className="evs-cite__value">{t.label}:</span> {c.value_text} ({c.source}, {c.year}
                {", "}
                <a className="usa-link usa-link--external" href={c.source_url} target="_blank" rel="noreferrer">
                  source
                </a>
                ){c.note ? ` ${c.note}` : ""}
              </li>
            );
          })}
        </ul>
      </section>

      <section aria-labelledby="srp-growth">
        <h2 id="srp-growth">Growth since 2002</h2>
        {growth.length > 0 ?
          <Figure<Snapshot>
            title="River systems, river miles and dams in the program, 2002 to 2024"
            description={growthDescription}
            data={growth}
            columns={growthColumns}
            headingLevel={3}
            csvName="srp-growth-2002-2024"
            legend={[
              { name: "River systems (left axis)", seriesIndex: 0 },
              { name: "Dams (left axis)", seriesIndex: 1 },
              { name: "River miles (right axis)", seriesIndex: 2 },
            ]}
            footer={<p className="evs-figure__hint">Sources per year are listed in the table view; each figure links to the page it came from.</p>}
            getRowKey={(r) => String(r.year)}
          >
            {({ reducedMotion }) => (
              <ResponsiveContainer width="100%" height="100%">
                <LineChart data={growth} accessibilityLayer margin={{ top: 8, right: 16, bottom: 8, left: 8 }}>
                  <CartesianGrid stroke={CHART_TOKENS.grid} vertical={false} />
                  <XAxis dataKey="year" tick={{ fill: CHART_TOKENS.axis }} />
                  <YAxis yAxisId="left" tick={{ fill: CHART_TOKENS.axis }} width={40} allowDecimals={false} />
                  <YAxis yAxisId="right" orientation="right" tick={{ fill: CHART_TOKENS.axis }} width={56} tickFormatter={(v: number) => formatNumber(v, { integer: true })} />
                  <Tooltip formatter={(v) => formatNumber(Number(v), { integer: true })} />
                  <Line yAxisId="left" name="River systems" dataKey="river_systems" stroke={SERIES[0].color} strokeWidth={2} dot={{ r: 4 }} connectNulls isAnimationActive={!reducedMotion} />
                  <Line yAxisId="left" name="Dams" dataKey="dams" stroke={SERIES[1].color} strokeDasharray={SERIES[1].strokeDasharray} strokeWidth={2} dot={{ r: 4 }} connectNulls isAnimationActive={!reducedMotion} />
                  <Line yAxisId="right" name="River miles" dataKey="river_miles" stroke={SERIES[2].color} strokeDasharray={SERIES[2].strokeDasharray} strokeWidth={2} dot={{ r: 4 }} connectNulls isAnimationActive={!reducedMotion} />
                </LineChart>
              </ResponsiveContainer>
            )}
          </Figure>
        : <p>No growth snapshots were returned by the API.</p>}
      </section>

      <section aria-labelledby="srp-sites">
        <h2 id="srp-sites">SRP sites</h2>
        <p className="evs-prose">
          {sites.length} named sites from the HEC site list, placed at the dam coordinates the API supplies (National Inventory of Dams where matched). Select a marker or a name in the list for site details.
        </p>
        <div className={["evs-layout", selectedId && "evs-layout--panel"].filter(Boolean).join(" ")}>
          <div>
            <AccessibleMap points={points} selectedId={selectedId} onSelect={(id, el) => select(id, el)} label="Map of Sustainable Rivers Program sites" alternativeText="The list below groups the same sites by river." />
            <h3 id="srp-site-list">Sites by river</h3>
            <ul className="evs-sitelist" aria-labelledby="srp-site-list">
              {byRiver.map(([riverName, group]) => (
                <li key={riverName}>
                  <h4>{riverName}</h4>
                  <ul>
                    {group.map((s) => (
                      <li key={siteId(s)}>
                        <button type="button" className="usa-button usa-button--unstyled" aria-pressed={siteId(s) === selectedId} onClick={(e) => select(siteId(s), e.currentTarget)}>
                          {s.name}
                        </button>{" "}
                        ({s.state}
                        {s.year_joined ? `, since ${s.year_joined}` : ""})
                      </li>
                    ))}
                  </ul>
                </li>
              ))}
            </ul>
          </div>
          <SidePanel title={selectedSite ? selectedSite.name : `Site ${selectedId ?? ""}`} open={Boolean(selectedId)} onClose={() => select(null)} returnFocusTo={trigger.current} headingLevel={3}>
            {selectedSite ?
              <dl className="evs-dl">
                <dt>River</dt>
                <dd>{selectedSite.river}</dd>
                <dt>State</dt>
                <dd>{selectedSite.state}</dd>
                <dt>District</dt>
                <dd>{selectedSite.district ?? "Not stated"}</dd>
                <dt>In SRP since</dt>
                <dd>{selectedSite.year_joined ?? "Not stated"}</dd>
                <dt>NID ID</dt>
                <dd>{selectedSite.nid_id ?? "Not matched"}</dd>
                <dt>Coordinates</dt>
                <dd>{selectedSite.latitude != null && selectedSite.longitude != null ? `${selectedSite.latitude.toFixed(3)}, ${selectedSite.longitude.toFixed(3)}` : "Not available"}</dd>
                <dt>Source</dt>
                <dd>
                  <a className="usa-link usa-link--external" href={selectedSite.source_url} target="_blank" rel="noreferrer">
                    HEC site page
                  </a>
                </dd>
              </dl>
            : <p>No site with that identifier is in the list.</p>}
          </SidePanel>
        </div>
      </section>

      <section aria-labelledby="srp-value">
        <h2 id="srp-value">Economic value</h2>
        {npvLow !== null && npvHigh !== null && bcrLow !== null && bcrHigh !== null ?
          <div className="evs-callout" data-testid="srp-economic">
            <div className="evs-callout__values">
              <div>
                <span className="evs-callout__n">
                  ${formatNumber(npvLow, { integer: true })}M to ${formatNumber(npvHigh, { integer: true })}M
                </span>
                <span className="evs-callout__l">Portfolio net present value{npvCite ? `, ${npvCite.value_text.replace(/^\$[^ ]+ to \$[^ ]+ ?/, "")}` : ""}</span>
              </div>
              <div>
                <span className="evs-callout__n">
                  {formatNumber(bcrLow)} to {formatNumber(bcrHigh)}
                </span>
                <span className="evs-callout__l">Benefit-cost ratio</span>
              </div>
            </div>
            <p>
              Source: {npvCite ? `${npvCite.source}, ${npvCite.year}` : "not supplied"}
              {bcrCite && bcrCite.source !== npvCite?.source ? `; BCR from ${bcrCite.source}, ${bcrCite.year}` : ""}
              {npvCite && (
                <>
                  {" "}
                  (
                  <a className="usa-link usa-link--external" href={npvCite.source_url} target="_blank" rel="noreferrer">
                    source
                  </a>
                  )
                </>
              )}
              {npvCite?.note ? ` ${npvCite.note}` : ""}
            </p>
          </div>
        : <p>No cited economic figures were returned by the API.</p>}
      </section>

      <section aria-labelledby="srp-what">
        <h2 id="srp-what">What the program does</h2>
        <p className="evs-prose">
          The Sustainable Rivers Program is a partnership between USACE and The Nature Conservancy that re-examines how existing dams are operated. Teams define environmental flow targets for the river below a dam, test changed release schedules against the authorized purposes (flood risk, water supply, hydropower, navigation) and keep the changes that improve river health without giving those purposes up. Program history, site pages and workshop reports are published by the{" "}
          <a className="usa-link usa-link--external" href={HEC_URL} target="_blank" rel="noreferrer">
            Hydrologic Engineering Center (HEC)
          </a>{" "}
          and the{" "}
          <a className="usa-link usa-link--external" href={IWR_URL} target="_blank" rel="noreferrer">
            Institute for Water Resources (IWR)
          </a>
          .
        </p>
      </section>
    </div>
  );
}
