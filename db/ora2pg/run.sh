#!/usr/bin/env bash
# Rebuild the legacy SP_ schema conversion end to end:
#   1. unwrap the APEX install scripts into plain Oracle SQL (oracle/)
#   2. run ora2pg per object type in file-input mode with cost estimation (output/)
#   3. post-process the ora2pg output into db/migrations/0002_legacy_sp_schema.sql
#      and the shipped seed/sample rows into db/migrations/0003_legacy_sp_data.sql
# Requires: ora2pg 25.x on PATH (apt install ora2pg, cpan Ora2Pg, or the georgmoser/ora2pg image
# with this directory mounted) and python3. SHOW_REPORT needs a live Oracle connection and is
# not available in file-input mode; ASSESSMENT.md is assembled from the per-type cost output.
set -euo pipefail
cd "$(dirname "$0")"
ZIP="${1:-strategic-planner.zip}"
if [ ! -f "$ZIP" ]; then
  curl -fsSL -o "$ZIP" https://raw.githubusercontent.com/oracle/apex/24.2/starter-apps/strategic-planner/strategic-planner.zip
fi
python3 extract_apex_install_scripts.py "$ZIP" oracle
mkdir -p output
run() { # type oracle-file
  ora2pg -c ora2pg.conf -t "$1" --estimate_cost -i "oracle/$2" -o "$1.sql" >"output/$1.log" 2>&1 || { cat "output/$1.log"; exit 1; }
  grep -v '^\[' "output/$1.log" > "output/$1.log.tmp" && mv "output/$1.log.tmp" "output/$1.log" || true
}
run SEQUENCE 01_sequences.sql
run TABLE 02_tables.sql
run VIEW 03_views.sql
# ora2pg's file-input trigger parser drops most units when one file holds many triggers (24 of 73
# survived), so triggers are converted one per file and concatenated.
rm -rf oracle/triggers output/TRIGGER.sql output/TRIGGER.log && mkdir -p oracle/triggers
python3 - <<'PY'
import re, pathlib
src = pathlib.Path("oracle/04_triggers.sql").read_text()
units = [u.strip() for u in re.split(r"^\s*/\s*$", src, flags=re.M) if "trigger" in u.lower()]
for i, u in enumerate(units, 1):
    name = re.search(r"trigger\s+(\w+)", u, re.I).group(1).lower()
    pathlib.Path(f"oracle/triggers/{i:03d}_{name}.sql").write_text(u + "\n/\n")
PY
for f in oracle/triggers/*.sql; do
  b=$(basename "$f" .sql)
  ora2pg -c ora2pg.conf -t TRIGGER --estimate_cost -i "$f" -o "trg_$b.sql" >>"output/TRIGGER.log" 2>&1 || { cat "output/TRIGGER.log"; exit 1; }
  cat "output/trg_$b.sql" >>"output/TRIGGER.sql" && rm -f "output/trg_$b.sql"
done
grep -v '^\[' output/TRIGGER.log | sort -u > output/TRIGGER.log.tmp && mv output/TRIGGER.log.tmp output/TRIGGER.log || true
run PACKAGE 05_packages.sql
run FUNCTION 06_functions_procedures.sql
run PROCEDURE 06_functions_procedures.sql
rm -f output/global_variables.conf
python3 postprocess.py
echo "done: db/migrations/0002_legacy_sp_schema.sql, 0003_legacy_sp_data.sql, ASSESSMENT.md"
