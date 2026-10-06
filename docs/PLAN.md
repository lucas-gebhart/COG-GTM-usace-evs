# USACE Enterprise Visibility Suite (EVS): Oracle APEX to Custom Code Demo Plan

Prepared 2026-10-06 for Lucas Gebhart. Status: approved 2026-10-06 with decisions recorded in section 11; build in progress.
Three parallel research sessions fed this plan; their full reports (architecture, public data, 508/design) are attached as supporting documents and every claim below carries a source there.

## 1. Recommendation in one table

| Layer | Choice | Why (short) |
|---|---|---|
| Front end | Vite 7 + React 19 + TypeScript, `@trussworks/react-uswds` 12 (USWDS 3), TanStack Table/Query, React Router 7 | Federal design system with 508 pedigree; SPA served as static files, no SSR runtime to authorize in IL5 |
| Charts | Recharts 3 (SVG, `accessibilityLayer` keyboard nav) wrapped in an EVS `<Figure>` with "View as table" + CSV; ECharts 6 for Gantt/leadership big-screen | Accessible by default and axe-inspectable; ECharts has built-in ARIA auto-descriptions and colour-blind decal patterns |
| Map | MapLibre GL JS + Protomaps PMTiles basemap (single file on S3/MinIO, HTTP range requests) | Works with no internet (IL5), one artefact, DOM `<button>` markers give full keyboard/screen-reader control |
| API | FastAPI + Python 3.12 (decision 2), OpenAPI 3.1 generated from Pydantic models, sse-starlette for live lock updates, OIDC bearer JWT | Every endpoint carries an `x-apex-page` tag back to the APEX page it replaced; Python also hosts ora2pg post-processing, synthetic data generators and ingestion |
| Identity | Keycloak 26 locally; Amazon Cognito (IL5 listed) federated to Army ICAM/EAMS-A in GovCloud | Same OIDC code path, issuer/JWKS swapped by env var |
| Data (PaaS) | Amazon Aurora PostgreSQL (or RDS PostgreSQL) in AWS GovCloud, IL5 checkmark on the AWS DoD CC SRG page (updated 2026-10-05); locally `postgis/postgis:17-3.5` in Docker | Only candidate that scores on IL5 + commercial parity + local run + PostGIS + Oracle migration tooling (20/21 in the decision matrix vs DynamoDB 12, DocumentDB 9, Snowflake/Databricks 11) |
| Extensions | `postgis`, `pg_partman`, `pg_trgm`, `pgcrypto` | All available on Aurora/RDS and Docker. TimescaleDB is not offered on RDS/Aurora, so it is excluded to keep one migration set |
| Hosting (Gov) | ECS Fargate (web, api, ingest) behind ALB + WAF; EventBridge Scheduler; S3; Secrets Manager; CloudWatch | All IL5 listed. CloudFront is IL2 East/West only and is excluded from the design |
| Hosting (local) | Docker Compose: traefik, web, api, ingest, postgis, keycloak, minio | Identical container images, 12-factor env config |
| Oracle migration tooling | ora2pg (schema, data, assessment report) + Devin for APEX pages, PL/SQL to API handlers, tests, traceability | ora2pg runs in the same Compose; AWS SCT/DMS shown on the architecture slide only |
| Legacy source | Oracle's own APEX 24.2 **Strategic Planner** starter app (262 pages, 757 regions, 88 Interactive Reports, 341 processes; UPL 1.0 licensed, download verified; measured counts in `docs/MIGRATION_PIPELINE.md`) re-skinned as a USACE PM dashboard | A real APEX export with a project-management data model (Projects, Initiatives, Releases, People, Kanban) that maps to Programs, P2 projects, milestones and labor |
| 508 target | WCAG 2.1 AA, plus 2.2 criteria 2.4.11, 2.5.7, 2.5.8 as design rules; read-out as OpenACR (GSA format, VPAT 2.5 compatible) | Revised 508 incorporates WCAG 2.0 AA; OMB M-23-22 points to 2.1; 2.1 adds the reflow/mobile criteria that answer the phone/tablet complaint |

A useful aside for the demo: `corpslocks.usace.army.mil` resolves to `ndc.ops.usace.army.mil/ords/r/lpms/corps-locks/home`. USACE's own public lock system is an Oracle APEX app on ORDS. EVS consumes it as a feed while showing where the same pattern goes next.

## 2. What the data situation actually is (verified 2026-10-06)

```
                PUBLIC, LIVE, VERIFIED                           NOT PUBLIC -> REALISTIC SYNTHETIC
  +--------------------------------------------+        +----------------------------------------------+
  | LPMS / Corps Locks ORDS JSON (no key)      |        | CEFMS financials  (ER 37-1-30 vocabulary:    |
  |   lock_status_report  77 locks, 15-min     |        |   work item, appropriation 96X3122/3123,     |
  |   lock_delay_json     192 locks (bad JSON) |        |   commitment/obligation/expenditure, PR&C)    |
  |   stall_stoppage_json 22 active closures   |        | P2 / CMP schedules (ER 5-1-11: PDT, PMP,      |
  |   lock_queue, traffic, river_at_a_glance,  |        |   phases, milestones FCSA/PPA/BCOES)          |
  |   monthly_tons, lookups, Swagger catalog   |        | EMS labor logs (pay period, work item, hours) |
  | NDC Locks ArcGIS layer: 234 chamber points |        | BUILDER SMS (component CI 0-100, BCI,         |
  |   lat/lon, river mile, lift, dims, district|        |   UNIFORMAT, deficiency cost, work plan year) |
  | NOAA NWPS gauges (flood categories), USGS  |        | Seeded from REAL FY26 J-sheets: 399 project   |
  |   NWIS IV + OGC API (stage/flow)           |        |   rows, business-line amounts, districts      |
  | NTNI closure notices (HTML per notice)     |        +----------------------------------------------+
  | National Inventory of Dams CSV (92,766)    |
  | SRP figures: HEC + TNC pages, RTI report   |
  +--------------------------------------------+
```

Key findings that shape the build:
- Lock status: the LPMS feed already carries the R/Y/G inputs (pending arrivals, 4-hour delay, active stoppage flag, NTNI links, gauges, notes). Gotchas found by fetching: `lock_delay_json` is invalid JSON (regex fix before parse), `latitude`/`longitude` are swapped in all 77 rows (use the GIS layer for geometry), `entryDatetime` lags 6 to 10 hours (so "as of" flagging is mandatory, which is what you asked for), one lookup endpoint returns HTTP 555, hydrology status covers 77 of 194 locks while delay covers 192.
- Lock R/Y/G engine: 11 ordered rules (Red: unscheduled traffic-stopped closure, single-chamber closure, 4h delay >= 240 min, NOAA moderate/major flood; Yellow: scheduled stoppage, delay 60 to 239 min or queue >= 6, NOAA action/minor, restrictive notes, open NTNI; Green otherwise; Grey "Stale" ring when newest input > 2 h). Status is computed server-side with `status_reason`, `as_of`, `inputs_used` stored per evaluation. A seeded Markov fallback using the 36 real stoppage reason codes runs if LPMS is down, and every simulated row is labelled "simulated".
- Sustainable Rivers Program: no official per-dam GeoJSON exists. Verified figures: 8 rivers (2002); 66 federal dams on 16 rivers, 5,111 river miles (TNC 2019); ~30 rivers (2020); 50+ teams in 27 districts (2024); "more than 60 river systems, 14,000 river miles, 150,000 floodplain acres" (HEC, USACE) and "65 rivers, nearly 15,000 miles, 100+ reservoirs and dams" (TNC, 2026); RTI economic study NPV $243M to $265M, BCR 12.6 to 13.7. 24 named sites and ~25 named dams join to NID lat/lon for the SRP map. Year-by-year counts are rebuilt from the HEC history timeline and cited as such.
- Akamai blocks `usace.army.mil`, `iwr.usace.army.mil`, `publications.usace.army.mil` for non-browser clients. `ndc.ops`, `nid.sec`, `hec.usace.army.mil`, NOAA and USGS are open. Ingestion runs server-side with retries and last-good caching.

## 3. Target architecture

```
 GovCloud IL5 (us-gov-west-1)                              Local demo (Docker Compose)
 ---------------------------------------------------        ------------------------------------------
 User (CAC/OIDC; desktop, tablet, phone)                    Browser + device emulation
   | HTTPS                                                    | HTTPS (traefik, self-signed)
 [WAF] -> [ALB] --> ECS Fargate "web"  (nginx, React)       [traefik] --> web  (same image)
                |-> ECS Fargate "api"  (Fastify, SSE)                  |-> api  (same image)
                |     |-- JWT verify -> Cognito (ICAM fed.)             |     |-- JWT verify -> Keycloak 26
                |     '-- SQL -------> Aurora PostgreSQL                |     '-- SQL -------> postgis/postgis:17
                |                      (PostGIS, pg_partman, KMS)       |
 EventBridge --cron--> ECS "ingest" ---> S3 raw drops -> Aurora         cron -> ingest (same image) -> MinIO -> pg
 PMTiles basemap on S3 (range requests)                                PMTiles on MinIO
 Legacy Oracle/APEX -> AWS DMS -> Aurora (slide only)                  Oracle export zip -> ora2pg container -> pg
 Secrets Manager, CloudWatch                                           .env, stdout JSON logs
```

Same code, same images, same SQL in both. Only `DATABASE_URL`, `OIDC_ISSUER`, `S3_ENDPOINT`, `PMTILES_URL`, `FEED_SOURCE=live|fixtures|simulated` change. The slide must say: an IL5 checkmark is a service-level DISA PA; EVS still needs its own RMF/ATO inside the USACE boundary.

## 4. The migration story we show

Conceptual before/after:

```
 ORACLE APEX (today)                                   EVS (target)
 +-------------------------------+                     +--------------------------------------+
 | f100.sql export               |                     | apps/web   React + USWDS, responsive |
 |  pages ---- regions ----+     |   Devin pipeline    | apps/api   Fastify + OpenAPI 3.1     |
 |  Interactive Reports    |     |  ================>  | db/        PostgreSQL via ora2pg     |
 |  JET charts             |     |  inventory ->       | ingest/    feeds + status engine     |
 |  PL/SQL processes       |     |  mapping ->         | traceability.csv: APEX page/region   |
 |  LOVs, authz schemes    |     |  generate ->        |   -> route -> endpoint -> SQL -> test |
 |  Dynamic Actions        |     |  test -> trace      | OpenACR accessibility read-out        |
 | fixed desktop layout    |     |                     | phone / tablet / desktop, big screen  |
 | Oracle EE license       |     |                     | Aurora/RDS PostgreSQL, no license     |
 +-------------------------------+                     +--------------------------------------+
```

Pipeline (what runs live): SQLcl split export of Strategic Planner -> `apex-inventory` parser over `wwv_flow_imp_page.create_page / create_page_plug / create_worksheet / create_jet_chart / create_page_process` -> `inventory.json` + `traceability.csv` -> ora2pg (DDL, data, assessment report) -> Devin generates React page + API route + SQL + Vitest/Playwright tests per inventory entry -> coverage percent of regions migrated.

Measured on the real export today: 262 pages, 757 regions, 88 IRs, 341 PL/SQL processes, 3 authorization schemes. We migrate a slice honestly (target 8 to 10 pages below) and show the coverage number.

USACE re-skin of Strategic Planner (labels and seed data only; the `SP_` schema stays so the ora2pg output is genuine): Initiative/Focus Area -> Program / Business Line; Project -> P2 Project (P2 number, district, PM); Release -> FY milestone / construction phase; Person -> labor resource (EMS); Activity -> CMP record. New tables: `cefms_obligation`, `ems_labor_log`, `builder_facility_condition`, `lock_dim`, `lock_status_fact`, `status_eval`, `srp_coverage`.

## 5. EVS pages and visualizations

| # | Route | Answers | Key widgets | APEX origin |
|---|---|---|---|---|
| 1 | `/` Enterprise overview | Are we executing plan, on schedule, with assets in condition? | KPI tiles; obligations vs plan (plan band); schedule health; facility CI distribution; data freshness strip | Dashboard page charts |
| 2 | `/programs` Portfolio | Which programs/business lines are off plan? | Diverging variance bar; program table; funding by appropriation | Initiatives IR |
| 3 | `/projects/:id` Project detail | Where does this P2 project stand? | Milestone timeline, obligations burn, labor hours, CMP records, documents | Project Details form + regions |
| 4 | `/financial` Execution (CEFMS) | Obligated vs plan, expiring funds, variance by program | Cumulative line with plan band; diverging bars; appropriation table | Chart + IR |
| 5 | `/workforce` Labor (EMS) | Hours vs plan by district/project type; overtime | Bullet chart per district; stacked hatched bars; labor table | IR |
| 6 | `/schedule` Lifecycle (P2/CMP) | Which milestones slip? | Gantt (ECharts) with list alternative; slip histogram | Kanban board + IR |
| 7 | `/facilities` BUILDER | Where is deferred maintenance concentrated? | CI histogram with threshold bands; CI by installation; facility table | IR |
| 8a | `/public/srp` Sustainable Rivers | How has coverage grown since 2002? | KPI tiles (river miles, dams/structures, river systems, states); cumulative line 2002-2026; systems-joined-by-year bars; SRP map + list | Chart |
| 8b | `/public/locks` Lock status | Which locks are operating right now, where are delays? | As-of banner + stale warning; live sortable table (lock, river, mile, status chip, vessels queued, avg delay, last lockage, as-of, Updated badge); MapLibre map with shape+colour markers, hover/press popover, legend, river filter, "Switch to list"; SSE updates | New |
| 9 | `/accessibility` Read-out | Does EVS conform, what is open? | Per-route axe results, 30-build trend, 48-criteria table, Download ACR, "Run axe now" | New |
| 10 | `/admin` Data freshness | Are feeds healthy? | Feed table (source, last success, latency, status), thresholds form (stale min, delay min, queue) | Form + IR |

Lock status encoding (colour is never the only channel): Green circle "Operating", Yellow triangle with dark edge "Delayed", Red octagon "Closed", Grey hatched ring "Stale". Palette from USWDS tokens, every text colour verified at 4.5:1 or better, marker edges at 3:1 or better against the basemap (green-cool-50v vs red-60v alone is 1.51:1, which is why shapes are required). Mobile: table becomes stacked cards, map goes below with "Switch to list" first in tab order, popovers become bottom sheets. Leadership mode: 1920x1080 dark theme, type scale x1.4, 60-second refresh with countdown and pause.

## 6. Section 508 design and compliance read-out

- Design spec covers palette, typography, focus rings, dashboard keyboard model (landmarks, skip links, roving tabindex), tables (caption, scope, `aria-live=polite` for as-of updates), charts (name/description, table alternative, keyboard point traversal, reduced motion), maps (list alternative, `<button>` markers, `focusAfterOpen`, 44x44 targets, hover/press parity), reflow at 320 px / 400% zoom, status messages (4.1.3). Component-to-success-criteria checklist is in the attached 508 report, Appendix A.
- CI produces the read-out on every run: `@axe-core/playwright` on every route x 2 viewports x 2 themes, `eslint-plugin-jsx-a11y`, Storybook a11y, Lighthouse, pa11y-ci. `evs-acr-gen` merges axe JSON with a signed manual attestation file and writes OpenACR YAML plus rendered Markdown/HTML. Of 48 WCAG 2.1 A/AA criteria: 19 auto-populated from axe, 24 manual attestation (screen reader scripts NVDA/JAWS/VoiceOver, keyboard pass, zoom, high contrast, colour-blind simulation), 5 Not Applicable. The attached skeleton validates with `openacr validate`; all rows start `not-evaluated` so no conformance is claimed before testing.
- The `/accessibility` page in EVS renders the same data, so the compliance read-out is itself a visualization in the demo.
- Flag for USACE's 508 coordinator: DoD CIO and army.mil accessibility pages were blocked from the research VM, so a stronger DoD/Army directive beyond WCAG 2.0 AA was not confirmed.

## 7. Cost comparison slide (public list prices, with caveats printed)

Oracle Database EE list $47,500 per processor + $10,450/yr support (Oracle Technology Global Price List, 15 Sep 2026); APEX itself is $0 on any edition. A 4-vCPU footprint = 2 processor licenses = $95,000 list + $20,900/yr. Aurora PostgreSQL in us-gov-west-1: db.r6g.large $0.313/hr (about $2,742/yr); writer + reader + 200 GB about $5,800/yr, no software license. Caveats: DoD ESI/ELA discounts, on-demand vs reserved, excludes labor/DMS/transfer, licensing driver only and not a TCO.

## 8. Build plan (child sessions, parallel where independent)

Prerequisite from you: create the empty public repo (Devin's GitHub App cannot create repos; your pattern is `lucas-gebhart/COG-GTM-<name>`, README on `main`). Suggested name `COG-GTM-usace-evs`.

```
 Batch 0 (1 session, ~half day)      Batch 1 (5 parallel sessions, ~1 day)        Batch 2 (3 parallel, ~1 day)        Batch 3
 ------------------------------      --------------------------------------        -----------------------------        -------
 WP0 Monorepo scaffold + OpenAPI     WP1 apex-inventory tool + legacy assets       WP5b Public pages: lock table/map,   WP8 Integration,
     contract stub + Compose +            + traceability.csv                          SRP page (consumes WP3, WP5a)       demo run-of-show,
     Keycloak realm + CI skeleton    WP2 ora2pg schema + migrations + synthetic    WP4b Internal pages 1-7 on real API    recording, cost
                                          CEFMS/EMS/P2/BUILDER generators (J-sheet  WP6b /accessibility page + ACR         slide, README
                                          seeded) + SRP dataset                        generator wired to CI output
                                     WP3 Fastify API: handlers from PL/SQL,
                                          SSE, auth, OpenAPI tags
                                     WP5a Ingestion worker: LPMS/NOAA/USGS/GIS
                                          adapters, status engine (11 rules),
                                          fallback simulator, fixtures
                                     WP4a Web shell: USWDS layout, <Figure>,
                                          DataTable, responsive grid, leadership
                                          theme, Storybook + axe (mock data)
                                     WP6a axe/Playwright/pa11y CI + manual test
                                          plan + OpenACR pipeline
                                     WP7 Terraform for GovCloud (code only,
                                          not applied) + Compose hardening
```

Each WP is one child session with its own PR into the shared repo; the contract (`packages/contract/openapi.json` from WP0) decouples WP3/WP4/WP5. Wall clock about 3 working days to a runnable demo, then polish. Optional add-on (+1 session, large image pull): run Oracle 23ai Free + APEX 24.2 in Compose so the "before" side is live rather than screenshots.

Definition of done for the demo:
1. `docker compose up` brings up EVS with seeded data and live LPMS feed (fixtures fallback) in under 5 minutes.
2. `pnpm apex-inventory legacy/f100.sql` prints the 262/757/88/341 inventory and writes `traceability.csv`.
3. At least 8 Strategic Planner pages migrated with tests and traceability rows; coverage percent displayed.
4. Lock table and map live-update with as-of flags, stale handling, keyboard and touch popovers; SRP page with cited figures.
5. CI green with axe on all routes; OpenACR generated and downloadable from `/accessibility`.
6. Same pages demonstrated at 320 px, tablet, desktop and 1920 leadership mode.

Run of show (30 to 45 min): drivers (3) -> live inventory of the APEX export (5) -> migrate two pages live, side by side (10) -> responsive on phone/tablet (6) -> "add a lock delay heatmap" new visualization in minutes (8) -> public value: locks map + SRP (5) -> cost + IL5 + 508 read-out (5) -> Q&A.

## 9. Risks

| Risk | Mitigation |
|---|---|
| LPMS feed stale or 5xx during the demo | Last-good cache, `FEED_SOURCE=fixtures` recorded today, labelled simulator |
| Only 77 locks report hydrology | Status from delay (192) + stoppage feeds for the rest; GIS gives all 234 chambers for the map |
| Strategic Planner is 262 pages | Migrate a slice, show coverage honestly, describe the remaining pipeline |
| "IL5" misread as an ATO | Caveat on the slide, AWS table screenshot attached |
| .mil Akamai blocks | Server-side poller with stable UA; never fetch .mil from the browser |
| CAC in local demo | Keycloak username/password locally; describe CAC via Cognito/ICAM federation |
| Repo access | Needs the `lucas-gebhart` GitHub App installation granted to the us-federal org (same issue as the MAH repos) |

## 10. Decisions I need from you

1. Repo: `lucas-gebhart/COG-GTM-usace-evs` created by you, or somewhere else?
2. API language: Fastify + TypeScript (recommended, one language across the stack) or FastAPI + Python?
3. "Before" side: static APEX export + screenshots + live inventory (recommended) or also run Oracle 23ai Free + APEX in Docker?
4. Hosted URL for the demo: local Compose only, or also deploy to Fly.io (you have a token) for a shareable link? GovCloud stays Terraform-as-code only.
5. Migration slice: Projects IR, Project Details, Initiatives, People, Kanban, Dashboard charts plus two more of your choice, or a different set?
6. Anything to add or drop from the 10-page set in section 5?

## Supporting documents (attached)
- `evs_architecture_report.md`: decision matrices, APEX export anatomy, measured inventories, Mermaid architecture, pinned versions, pricing sources.
- `evs_public_data_report.md`: every endpoint with samples, field dictionary, R/Y/G rules, SRP provenance, synthetic-data vocabulary from ER 37-1-30 / ER 5-1-11 / BUILDER, ingestion design. Sample payloads (80 files) are in the data session's `data_samples.zip`.
- `evs_508_and_design_report.md`: WCAG 2.1 AA spec, component checklist, CI/ACR pipeline, wireframes for SRP, locks and leadership mode, library accessibility evaluation.
- `evs_openacr_skeleton.yaml`: validated OpenACR starting point.

## 11. Decisions recorded (Lucas, 2026-10-06)

1. Repo: `lucas-gebhart/COG-GTM-usace-evs` (created by Lucas).
2. API: FastAPI + Python (replaces the Fastify recommendation in section 1; contract-first approach unchanged).
3. "Before" side: static APEX export, screenshots and live inventory. No Oracle container.
4. Hosting: Fly.io for the shareable demo URL. GovCloud stays Terraform as code only.
5. Migration slice (8 pages): Dashboard charts, Initiatives IR, Project Details form, People IR, Kanban board, Admin/lookups pre-migrated; Projects IR and one JET chart region migrated live on stage.
6. Page set in section 5 unchanged.
