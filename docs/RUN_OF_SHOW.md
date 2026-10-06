# EVS demo run of show

Audience: USACE modernization stakeholders. Length: 35 to 45 minutes plus Q&A. One presenter, one browser,
the terminal visible for the live migration segment.

## Before the session

| Check | Command or URL | Expect |
|---|---|---|
| Hosted demo | https://usace-evs-web.fly.dev | header, role switcher, Enterprise overview loads |
| API health | https://usace-evs-api.fly.dev/api/v1/health | `{"status":"ok", ... "feed_source":"live"}` |
| Live locks | https://usace-evs-web.fly.dev/public/locks | as-of badge under two hours old; if the badge says stale, say so on stage, that is the point of the badge |
| Local fallback | `make demo` (Compose) or `make api` plus `make web` | http://localhost:5173 with `EVS_FEED_SOURCE=fixtures` |
| No-network fallback | `cd apps/web && pnpm dev:mock` | MSW fixtures, every page works offline |
| Live migration branch | `git switch -c demo/live-migration integration && git rm -q apps/web/src/pages/Projects.tsx apps/web/src/pages/Projects.test.tsx` | `/projects` falls back to the WP0 placeholder |

Roles: auth is disabled on Fly and in Compose, so the header role switcher sets `X-Evs-Demo-Role`
(`evs_viewer`, `evs_pm`, `evs_admin`) and the API enforces it exactly as it enforces Keycloak roles when
`EVS_AUTH_DISABLED` is off (`apps/api/tests/test_auth_jwt.py`). Keycloak realm `evs` ships `demo.viewer`,
`demo.pm`, `demo.admin` (password `demo`) if the token flow is requested.

Data labels to keep straight: lock status and feed health are **live** public LPMS, NDC GIS, NOAA and USGS
data; Sustainable Rivers figures are **cited-public**; CEFMS, EMS, P2, CMP and BUILDER rows are **synthetic**
and say so in every as-of badge. Fly.io is a demo host, not an authorization boundary.

## Segments

### 1. Why leave APEX (3 min)

Three drivers from the brief: Oracle licence cost, one page layout for every device, slow to add a
visualization. Show the APEX "before" screenshots in `legacy/screenshots/pages.md` next to the EVS page for the
same APEX page number. Every EVS page carries a "Migrated from APEX page N" tag.

### 2. Inventory the real APEX application (5 min)

```bash
make inventory
```

Oracle's APEX 24.2 Strategic Planner export (application 7150, UPL 1.0): 262 pages, 917 regions, 88 Interactive
Reports, 341 processes of which 134 are PL/SQL, 111 schema scripts. Open `legacy/traceability.csv` (one row per
region, 917 rows) and `legacy/mapping.json`. Coverage today: 78 of 917 regions migrated (8.5 percent) on six
pages, 4 regions `planned` on the two pages migrated live below, 835 `not_migrated`. The number is honest and
recomputed on every run; CI fails if the checked-in artifacts drift.

### 3. Migrate two pages live (10 min)

Start on the `demo/live-migration` branch prepared above so `/projects` is a placeholder.

1. Page 86, Projects Interactive Report, to `/projects`. Ask Devin: "Migrate APEX page 86 from
   `legacy/inventory.json` following `docs/MIGRATION_PIPELINE.md`: IR columns to a `DataTable`, facets to URL
   filters over `GET /api/v1/projects`, CSV export, Vitest test with axe, then flip page 86 to `migrated` in
   `legacy/mapping.json` and run `make inventory`." Narrate the pipeline while it runs: SQL source columns in
   the inventory, the existing contract in `packages/contract/openapi.json`, the component kit from WP4a.
   Reference result is `apps/web/src/pages/Projects.tsx` on `integration`.
2. Page 161, the Cumulative Flow JET chart, to `/financial`. Already on `integration` as the execution curve
   figure (`apps/web/src/pages/Financial.tsx`): show the `Figure` wrapper that gives every chart a caption,
   description, table alternative and CSV download, then flip page 161 in `mapping.json` and re-run
   `make inventory` so the coverage line moves to 82 of 917 (8.9 percent).

Close with `legacy/traceability.csv` filtered to pages 86 and 161: every region now names its route,
component, endpoint and test id.

### 4. One codebase, every device (6 min)

Open `/projects/<any P2 number>` and `/schedule`, then use the browser device toolbar at 360 px, 768 px and
1280 px, plus 400 percent zoom. Tables become cards, the Kanban stacks, the header collapses to a menu. Switch
the theme to Leadership (1.4 scale type) for a conference room. As `evs_pm`, change a project's phase and
percent complete and save; switch to `evs_viewer` and show the form is read only and the API answers 403.

### 5. New visualization in minutes (8 min)

Ask Devin for something not in the app, for example "Add a lock delay by river bar chart to `/public/locks`
using `GET /api/v1/public/locks` and the `Figure` component, with table alternative and CSV." The point is the
component kit plus typed API client: the chart, its table alternative and its axe test come from the same
request. If time is short, show `/facilities` (BUILDER CI distribution and deficiency cost by work-plan year)
as a page that took one work package rather than an APEX release cycle.

### 6. Public value (5 min)

`/public/locks`: live status by river, table and map, green circle, yellow triangle, red octagon, grey hatched
ring for stale, each with text. Hover or press a lock for queue, delay, stoppage, river stage and the as-of
time; the SSE stream updates without a reload. Mention the feed realities the engine handles: LPMS latitude and
longitude arrive swapped, `lock_delay_json` is sometimes malformed, operator timestamps lag 6 to 10 hours, and
the ORDS endpoints return 500 or 555 on bad days, which is why every row shows a source time and the status
goes stale after two hours instead of silently staying green.

`/public/srp`: Sustainable Rivers Program growth from 8 rivers (2002) to about 65 river systems, roughly
14,500 river miles and 100+ dams today, with the HEC, IWR and TNC citations on the page. Say plainly that no
per-dam official dataset exists; the map joins named SRP dams to NID coordinates.

### 7. Cost, IL5, Section 508 (5 min)

`/admin` (as `evs_admin`): feed health and the status engine thresholds, the APEX "Administration Rights"
scheme turned into a role check on the API. `/accessibility`: the Section 508 read-out, axe matrix over every
route in light and leadership themes at desktop and 320 px, Lighthouse scores, reflow results, and the
downloadable OpenACR. Manual screen reader attestations are marked planned, not claimed.

Infrastructure: the same two images run in Compose, on Fly and (code only, `terraform validate` in CI) on ECS
Fargate with Aurora PostgreSQL in GovCloud; `infra/compose/README.md` has the three-column table. Cost
argument: PostgreSQL with PostGIS replaces the Oracle database and APEX runtime licence; the ora2pg assessment
in `db/` sizes the schema conversion.

### 8. Q&A

Likely questions and where the evidence lives:

- "How much of the app is really migrated?" `legacy/traceability.csv`, coverage line on `/`.
- "Is the lock data real?" Yes, every row has `source: live` and a source timestamp; `docs/ingest.md`.
- "Is the financial data real?" No, synthetic with CEFMS vocabulary, labelled in every badge.
- "Is this IL5 authorized?" No. GovCloud services on the IL5 list, reference Terraform, no ATO.
- "Can we keep Oracle for now?" Yes, the repositories are behind one interface; the ora2pg output shows the
  schema path when ready.

## Recovery

| Problem | Do |
|---|---|
| Fly is slow or down | `make demo` locally, or `pnpm dev:mock` for a no-network run |
| LPMS feed stale during the demo | leave it: the stale badge and grey ring are the feature; the API serves last-known-good rows |
| Role switcher missing | the header shows it only when auth is disabled (`VITE_AUTH_DISABLED=1`, mock mode, or dev) |
| Live migration runs long | show `apps/web/src/pages/Projects.tsx` on `integration` and `git diff integration -- legacy/` |
