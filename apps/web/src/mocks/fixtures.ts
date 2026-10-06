// The API fixtures in apps/api/fixtures are the single source for mock mode and Storybook.
// They are imported directly (Vite resolves JSON) rather than copied.
import accessibility from "../../../api/fixtures/accessibility.json";
import facilities from "../../../api/fixtures/facilities.json";
import feeds from "../../../api/fixtures/feeds.json";
import financialSummary from "../../../api/fixtures/financial_summary.json";
import laborSummary from "../../../api/fixtures/labor_summary.json";
import locks from "../../../api/fixtures/locks.json";
import programs from "../../../api/fixtures/programs.json";
import projects from "../../../api/fixtures/projects.json";
import srp from "../../../api/fixtures/srp.json";
import type { Schemas } from "../hooks/useApi";

export const fixtures = {
  accessibility: accessibility as unknown as Schemas["AccessibilityReadout"],
  facilities: facilities as unknown as Schemas["FacilitySummary"],
  feeds: feeds as unknown as Schemas["FeedHealthList"]["feeds"],
  financialSummary: financialSummary as unknown as Schemas["FinancialSummary"],
  laborSummary: laborSummary as unknown as Schemas["LaborSummary"],
  locks: locks as unknown as Schemas["LockList"],
  programs: programs as unknown as Schemas["Program"][],
  projects: projects as unknown as Schemas["Project"][],
  srp: srp as unknown as Schemas["SrpCoverage"],
};

/** Mirrors evs.schemas.common.AsOf defaults for list endpoints that build as_of at request time. */
export function syntheticAsOf(source = "synthetic"): Schemas["AsOf"] {
  const now = new Date().toISOString();
  return { source_as_of: now, fetched_at: now, freshness: "fresh", source } as Schemas["AsOf"];
}

/** Status engine thresholds (evs.settings defaults) as the fixtures-mode API returns them. */
export const thresholds: Schemas["Thresholds"] = {
  stale_after_minutes: 120,
  delay_yellow_minutes: 60,
  delay_red_minutes: 240,
  queue_yellow_vessels: 6,
  lpms_failover_hours: 6,
  source: "fixtures",
  updated_at: null,
  updated_by: null,
};
