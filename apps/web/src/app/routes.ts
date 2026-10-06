// One entry per EVS page. WP4b/WP5b replace the placeholder with real pages; keep paths stable,
// they are referenced by the a11y matrix (e2e/) and legacy/traceability.csv.
export const routes = [
  { path: "/", title: "Enterprise overview", apexPage: "1" },
  { path: "/programs", title: "Programs and portfolio", apexPage: "20" },
  { path: "/projects", title: "Projects", apexPage: "30" },
  { path: "/projects/:p2", title: "Project detail", apexPage: "31" },
  { path: "/financial", title: "Financial execution (CEFMS)", apexPage: "1" },
  { path: "/workforce", title: "Workforce and labor (EMS)", apexPage: "40" },
  { path: "/schedule", title: "Schedule and lifecycle (P2 / CMP)", apexPage: "50" },
  { path: "/facilities", title: "Facilities (BUILDER SMS)", apexPage: null },
  { path: "/public/srp", title: "Sustainable Rivers Program", apexPage: null },
  { path: "/public/locks", title: "Lock status by river", apexPage: null },
  { path: "/accessibility", title: "Accessibility read-out", apexPage: null },
  { path: "/admin", title: "Data feeds and thresholds", apexPage: "60" },
] as const;

export type EvsRoute = (typeof routes)[number];
