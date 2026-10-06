"""Split a monolithic APEX `f<app_id>.sql` export into the SQLcl-style directory layout.

Oracle's full exports carry `prompt --application/pages/page_00001` markers before each
component. When present, each marker starts a new file at that relative path. Without markers,
pages are split on `wwv_flow_imp_page.create_page(` boundaries into `application/pages/`.
"""

from __future__ import annotations

import re
from pathlib import Path

PROMPT_RE = re.compile(r"^prompt --(application(?:/[A-Za-z0-9_./-]+)?)\s*$", re.M)
PAGE_RE = re.compile(r"^wwv_flow_imp_page\.create_page\(\n p_id=>(\d+)", re.M)


def split_export(sql_path: Path, out_dir: Path) -> list[Path]:
    text = Path(sql_path).read_text(encoding="utf-8", errors="replace")
    out_dir = Path(out_dir)
    written: list[Path] = []
    markers = list(PROMPT_RE.finditer(text))
    if markers:
        for i, m in enumerate(markers):
            end = markers[i + 1].start() if i + 1 < len(markers) else len(text)
            rel = m.group(1)
            target = out_dir / (rel if rel.endswith(".sql") else rel + ".sql")
            target.parent.mkdir(parents=True, exist_ok=True)
            target.write_text(text[m.start() : end], encoding="utf-8")
            written.append(target)
        return written

    pages_dir = out_dir / "application" / "pages"
    pages_dir.mkdir(parents=True, exist_ok=True)
    starts = list(PAGE_RE.finditer(text))
    if not starts:
        raise ValueError(f"{sql_path} has neither prompt markers nor create_page calls")
    head = text[: starts[0].start()]
    (out_dir / "application" / "create_application.sql").write_text(head, encoding="utf-8")
    for i, m in enumerate(starts):
        end = starts[i + 1].start() if i + 1 < len(starts) else len(text)
        target = pages_dir / f"page_{int(m.group(1)):05d}.sql"
        target.write_text(text[m.start() : end], encoding="utf-8")
        written.append(target)
    return written
