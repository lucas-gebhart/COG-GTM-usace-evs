# Migration pipeline: APEX Strategic Planner to EVS

Six stages, each with a file you can open. Numbers below are what `make inventory` measures on
the Oracle APEX 24.2 Strategic Planner export (app 7150, APEX 24.2.15) checked in under
`legacy/strategic-planner/f7150/`. Nothing here describes a production system; it is the demo
"before" side and the pipeline the demo runs on stage.

```
 inventory  ->  mapping  ->  ora2pg  ->  generate  ->  test  ->  trace
 (WP1)          (WP1)        (WP2)       (WP3/WP4b)   (all)     (WP1 tool, re-run)
```

## 1. Inventory

`tools/apex-inventory` parses every `wwv_flow_imp*.create_*` call in the split export. The
tokenizer walks balanced parentheses and quoted strings, so multi-line `wwv_flow_string.join(
wwv_flow_t_varchar2(...))` SQL and PL/SQL bodies come out as plain text. Output is
`legacy/inventory.json` (`pages`, `regions`, `reports`, `charts`, `items`, `buttons`,
`processes`, `validations`, `computations`, `branches`, `dynamic_actions`, `lovs`, `authz`,
`summary`, `call_counts`, `coverage`).

Measured (research estimate in parentheses where one existed):

| Component | Count | Note |
|---|---|---|
| Pages | 262 (262) | 122 normal, 140 modal dialogs; plus global page 0 |
| Regions | 917 | 757 `create_page_plug` (757) plus 160 `create_report_region` classic reports |
| Interactive Reports | 88 (88) | 1,236 IR columns, 98 saved report definitions |
| Classic reports | 160 | `NATIVE_SQL_REPORT` |
| JET charts | 3 | 4 series; pages 157, 161, 162 |
| Regions with SQL source | 334 | 10,201 lines of SQL; 63 more regions bind directly to a table (forms, table IRs) |
| Page items | 1,233 | 490 hidden, 221 checkboxes, 116 text fields, 55 select lists, ... |
| Buttons | 718 | |
| Processes | 341 (341) | 134 `NATIVE_PLSQL` with 1,912 lines of PL/SQL; the rest are form init/DML (119), close dialog (73), workflow, task, REST invoke |
| Validations | 50 | |
| Computations | 168 | |
| Dynamic actions | 382 | 561 actions: 259 refresh, 49 execute PL/SQL, 32 JavaScript, 32 set value, ... |
| Lists of values | 34 | 23 SQL, 11 table based |
| Authorization schemes | 3 | Administration Rights, Contribution Rights, Reader Rights; referenced 242 times |
| `SP_` objects referenced from pages | 91 | tables, views and packages named in region SQL, PL/SQL, LOVs |
| Supporting-object install scripts | 111 | 72 tables, 101 indexes, 92 triggers, 6 views, 9 package specs, 8 bodies, 2 functions, 1 procedure, 2 sequences, 16 seed-data scripts |

The research estimate counted `create_page_plug` only. Classic reports are separate
`create_report_region` calls in the export, so the honest region denominator is 917.

## 2. Mapping

`legacy/mapping.json` is the hand-written map from APEX pages (and, where needed, individual
regions) to EVS routes, components, API endpoints and test ids. It encodes decision 5 in
`docs/PLAN.md` section 11:

| APEX page | EVS route | API endpoint (`x-apex-page`) |
|---|---|---|
| 1 home (dashboard) | `/` | `GET /api/v1/financial/summary` and list endpoints per region |
| 21 Initiatives | `/programs` | `GET /api/v1/programs` (21) |
| 3 Project Details | `/projects/:p2` | `GET /api/v1/projects/{p2_project_no}` (3) |
| 74 People | `/workforce` | `GET /api/v1/workforce/labor` (74) |
| 4 Kanban Board | `/schedule` | `GET /api/v1/projects` |
| 10000 Administration | `/admin` | `GET /api/v1/admin/feeds`, `/thresholds` (10000, Administration Rights) |
| 86 Projects IR | `/projects` | `GET /api/v1/projects` (86) |
| 161 Cumulative Flow chart | `/financial` | `GET /api/v1/financial/summary` (161) |

`apps/web/src/app/routes.ts` (`apexPage`) and the FastAPI routers (`openapi_extra={"x-apex-page"}`)
carry the same numbers, so the OpenAPI contract, the web router and the traceability matrix
agree. Changing the slice means editing `mapping.json`, the two code locations, then
`make contract` and `make inventory`.

## 3. ora2pg (schema and data)

`make inventory` re-emits the 111 supporting-object scripts as ordered files in
`legacy/strategic-planner/schema/` (`001_sequences.sql` ... `111_seed_first_user.sql`,
`install_all.sql`, `deinstall.sql`, `README.md` with the object list). WP2 runs ora2pg in file
mode against the DDL files (`ora2pg -t TABLE -i 031_sp_projects_tables.sql`, `-t VIEW`,
`-t TRIGGER`, `-t PACKAGE`) and lands the result in `db/migrations/` under the `legacy` schema.
ora2pg covers tables, constraints, indexes, sequences and views well; `sys_guid()` identity
defaults, `on delete cascade` and `check` constraints translate. Triggers and the nine packages
(`sp_util`, `sp_comment_util`, `sp_approvals`, `sp_summary_util`, ...) need review: the parts
that back page processes become API handlers (stage 4), not PL/pgSQL.

## 4. Generate

Per inventory entry, the generator (Devin, following `mapping.json`) produces:

* region with SQL -> React component under `apps/web/src/pages/<Page>/` plus a repository
  query in `apps/api/evs/repositories/`; IR columns become table columns, facets become query
  parameters, each chart gets a table alternative;
* `NATIVE_PLSQL` process or `NATIVE_EXECUTE_PLSQL_CODE` dynamic action -> FastAPI handler
  (the PL/SQL body is in `inventory.json` `processes[].plsql` / `dynamic_actions[].actions[].plsql`);
* validation -> Pydantic validator plus client-side message;
* LOV -> enum or lookup endpoint;
* authorization scheme -> `require_role` dependency (`Administration Rights` -> `evs_admin`,
  `Contribution Rights` -> `evs_contributor`, `Reader Rights` -> authenticated).

Items that have no EVS equivalent are recorded as `retired` in `mapping.json` so they stop
counting against coverage once reviewed (none yet).

## 5. Test

Every mapped page names its tests in `mapping.json` (`test_id`), and the traceability row
carries them: Vitest component tests, FastAPI tests (`apps/api/tests`), and Playwright a11y and
e2e specs. `tools/apex-inventory/tests` checks the parser on a fixture export and on the full
export, and `test_checked_in_artifacts_are_current` fails when `legacy/inventory.json` or
`legacy/traceability.csv` drifts from a fresh run. CI runs the same (`inventory` job).

## 6. Trace

`legacy/traceability.csv` has one row per region (917 rows) with the columns `apex_page,
apex_page_name, apex_region_id, apex_region_name, apex_region_type, evs_route, evs_component,
api_endpoint, sql_object, test_id, status`. `sql_object` lists the `SP_` objects the region's SQL
touches (semicolon separated), which is the hook into the ora2pg output.

Coverage formula:

```
coverage = migrated regions / total regions
```

Today: 0 / 917 = 0.0 % migrated; 82 regions on the eight slice pages are `planned`, so the
slice at completion is 82 / 917 = 8.9 %. Statuses: `not_migrated`, `planned`, `in_progress`,
`migrated`, `retired`. WP3/WP4b flip a page or region in `mapping.json` and re-run
`make inventory`; the summary table prints the new percentage, and the Projects IR (page 86,
`/projects`) and the Cumulative Flow chart (page 161, `/financial`) are the two entries meant to
flip live on stage.

```
$ make inventory
APEX application 7150 'Strategic Planner' v24.2.10 (APEX 24.2.15)
Pages 262 | Regions 917 (88 IR, 160 classic, 3 charts) | Items 1,233 | Processes 341 (134 PL/SQL)
Validations 50 | Computations 168 | Dynamic actions 382 (561 actions) | LOVs 34 | Authz 3
Regions in migration slice 82 | migrated 0 | coverage 0.0 % | if slice ships 8.9 %
```
