# apex-inventory

Stdlib-only Python parser for Oracle APEX split exports (SQLcl layout). It reads the
`wwv_flow_imp*.create_*` calls in every page and shared-component file, evaluates the named
arguments, and emits a structured inventory plus the APEX-to-EVS traceability matrix.

```
python -m apex_inventory <export_dir> \
  --mapping legacy/mapping.json \
  --out legacy/inventory.json \
  --trace legacy/traceability.csv \
  --schema-out legacy/strategic-planner/schema \
  --pages-md legacy/strategic-planner/screenshots/pages.md \
  --summary
```

`make inventory` at the repo root runs exactly that against `legacy/strategic-planner/f7150`.

| Module | Purpose |
|---|---|
| `plsql.py` | Balanced-call tokenizer and expression evaluator (`wwv_flow_imp.id`, `wwv_flow_string.join`, `||`, `nvl`, plugin attribute arrays) |
| `inventory.py` | Pages, regions (`create_page_plug` and `create_report_region`), Interactive Reports and columns, JET charts and series, items, buttons, processes (PL/SQL bodies), validations, computations, branches, dynamic actions, LOVs, authorization schemes and their references, `sp_*` object references, summary counts |
| `trace.py` | Traceability rows (one per region) from the inventory plus `mapping.json`; coverage = migrated regions / total regions |
| `schema.py` | Re-emits the supporting-object install scripts (SP_ DDL/DML) as ordered `.sql` files for ora2pg |
| `pages_md.py` | Page-definition Markdown tables (title, regions, items, processes, dynamic actions) |
| `split.py` | Splits a monolithic `f<app>.sql` into the directory layout when a zip ships unsplit |

Tests: `python -m pytest -q` (fixture export under `tests/fixtures/mini_export`; the full-export
tests skip when `legacy/strategic-planner/f7150` is absent).
