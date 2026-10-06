"""APEX Interactive Report style list parameters: column filters, sort, limit/offset and CSV.

The same `ListQuery` is applied in SQL (`where_clause` / `order_clause`) in database mode and
in Python (`apply_in_memory`) in fixtures mode so both modes answer identically.

Filter syntax (repeatable `filter` query parameter): `column:op:value` with op one of
eq, ne, gt, gte, lt, lte, like, in (comma separated). Convenience parameters such as
`district=LRL` are folded into eq filters by the routers. `q` searches every text column.
Sort: `sort=-funded_amount,name` (leading `-` is descending).
"""

from __future__ import annotations

import csv
import io
from collections.abc import Iterable, Mapping
from dataclasses import dataclass, field
from datetime import date, datetime
from typing import Any

from fastapi import HTTPException, Query, Request, Response

OPS = {"eq", "ne", "gt", "gte", "lt", "lte", "like", "in"}
SQL_OPS = {"eq": "=", "ne": "<>", "gt": ">", "gte": ">=", "lt": "<", "lte": "<="}
MAX_LIMIT = 500


@dataclass(frozen=True)
class Filter:
    column: str
    op: str
    value: str


@dataclass
class ListQuery:
    filters: list[Filter] = field(default_factory=list)
    search: str | None = None
    sort: list[tuple[str, bool]] = field(default_factory=list)  # (column, descending)
    limit: int = 50
    offset: int = 0
    format: str = "json"

    def with_filter(self, column: str, value: str | None, op: str = "eq") -> ListQuery:
        if value is not None and value != "":
            self.filters.append(Filter(column, op, value))
        return self


def parse_sort(sort: str | None) -> list[tuple[str, bool]]:
    out: list[tuple[str, bool]] = []
    for part in (sort or "").split(","):
        part = part.strip()
        if not part:
            continue
        desc = part.startswith("-")
        out.append((part.lstrip("+-"), desc))
    return out


def parse_filters(raw: Iterable[str]) -> list[Filter]:
    out: list[Filter] = []
    for item in raw:
        bits = item.split(":", 2)
        if len(bits) != 3 or bits[1] not in OPS:
            raise HTTPException(422, f"Bad filter '{item}', expected column:op:value")
        out.append(Filter(bits[0], bits[1], bits[2]))
    return out


def list_query(
    request: Request,
    sort: str | None = Query(None, description="Comma separated columns, `-` prefix for descending"),
    q: str | None = Query(None, description="Free text search across text columns (IR search bar)"),
    limit: int = Query(50, ge=1, le=MAX_LIMIT),
    offset: int = Query(0, ge=0),
    format: str = Query("json", pattern="^(json|csv)$", description="`csv` streams the filtered rows"),
) -> ListQuery:
    """FastAPI dependency. The repeatable `filter` parameter is read from the raw query string."""
    return ListQuery(
        filters=parse_filters(request.query_params.getlist("filter")),
        search=q,
        sort=parse_sort(sort),
        limit=limit,
        offset=offset,
        format=format,
    )


class Columns:
    """Whitelist of API column name -> SQL expression, and which are text (searchable).

    `default_sort` doubles as the tie breaker: its columns are appended to every explicit sort so
    SQL and in-memory ordering are deterministic and identical.
    """

    def __init__(self, columns: Mapping[str, str], text_columns: Iterable[str], default_sort: str) -> None:
        self.columns = dict(columns)
        self.text_columns = set(text_columns)
        self.default_sort = default_sort

    def check(self, name: str) -> str:
        if name not in self.columns:
            raise HTTPException(422, f"Unknown column '{name}'")
        return self.columns[name]

    # SQL side ---------------------------------------------------------------

    def where_clause(self, q: ListQuery, params: dict[str, Any]) -> str:
        parts: list[str] = []
        for i, f in enumerate(q.filters):
            expr = self.check(f.column)
            key = f"f{i}"
            if f.op == "in":
                values = [v.strip() for v in f.value.split(",") if v.strip()]
                keys = []
                for j, v in enumerate(values):
                    params[f"{key}_{j}"] = v
                    keys.append(f"CAST(:{key}_{j} AS text)")
                parts.append(f"CAST({expr} AS text) IN ({', '.join(keys)})")
            elif f.op == "like":
                params[key] = f"%{f.value}%"
                parts.append(f"CAST({expr} AS text) ILIKE :{key}")
            else:
                params[key] = f.value
                if f.column in self.text_columns:
                    parts.append(f"CAST({expr} AS text) {SQL_OPS[f.op]} :{key}")
                else:
                    parts.append(f"{expr} {SQL_OPS[f.op]} CAST(:{key} AS numeric)")
        if q.search and self.text_columns:
            params["q"] = f"%{q.search}%"
            ors = " OR ".join(f"CAST({self.columns[c]} AS text) ILIKE :q" for c in sorted(self.text_columns))
            parts.append(f"({ors})")
        return (" WHERE " + " AND ".join(parts)) if parts else ""

    def effective_sort(self, q: ListQuery) -> list[tuple[str, bool]]:
        sort = list(q.sort)
        seen = {c for c, _ in sort}
        for c, d in parse_sort(self.default_sort):
            if c not in seen:
                sort.append((c, d))
                seen.add(c)
        return sort

    def order_clause(self, q: ListQuery) -> str:
        parts = [f"{self.check(c)} {'DESC' if d else 'ASC'} NULLS LAST" for c, d in self.effective_sort(q)]
        return " ORDER BY " + ", ".join(parts)

    # Python side (fixtures mode) --------------------------------------------

    def apply_in_memory(self, rows: list[dict], q: ListQuery) -> tuple[list[dict], int]:
        out = [r for r in rows if self._matches(r, q)]
        for col, desc in reversed(self.effective_sort(q)):
            self.check(col)
            out.sort(key=lambda r, c=col: _sort_key(r.get(c)), reverse=desc)
        total = len(out)
        return out[q.offset : q.offset + q.limit], total

    def _matches(self, row: dict, q: ListQuery) -> bool:
        for f in q.filters:
            self.check(f.column)
            v = row.get(f.column)
            if f.op == "in":
                if str(v) not in {s.strip() for s in f.value.split(",")}:
                    return False
            elif f.op == "like":
                if f.value.lower() not in str(v or "").lower():
                    return False
            elif f.column in self.text_columns or isinstance(v, str):
                if not _cmp(str(v) if v is not None else None, f.value, f.op):
                    return False
            else:
                if v is None or not _cmp(float(v), float(f.value), f.op):
                    return False
        if q.search:
            needle = q.search.lower()
            if not any(needle in str(row.get(c) or "").lower() for c in self.text_columns):
                return False
        return True


def _cmp(a: Any, b: Any, op: str) -> bool:
    if a is None:
        return op == "ne"
    return {
        "eq": a == b,
        "ne": a != b,
        "gt": a > b,
        "gte": a >= b,
        "lt": a < b,
        "lte": a <= b,
    }[op]


def _sort_key(v: Any) -> tuple[int, Any]:
    if v is None:
        return (1, 0)
    if isinstance(v, (int, float)):
        return (0, v)
    if isinstance(v, (date, datetime)):
        return (0, v.isoformat())
    return (0, str(v).lower())


def csv_response(rows: Iterable[Mapping[str, Any]], columns: Iterable[str], filename: str) -> Response:
    buf = io.StringIO()
    cols = list(columns)
    writer = csv.DictWriter(buf, fieldnames=cols, extrasaction="ignore")
    writer.writeheader()
    for row in rows:
        writer.writerow({c: _csv_cell(row.get(c)) for c in cols})
    return Response(
        content=buf.getvalue(),
        media_type="text/csv; charset=utf-8",
        headers={"Content-Disposition": f'attachment; filename="{filename}"'},
    )


def _csv_cell(v: Any) -> Any:
    if isinstance(v, (date, datetime)):
        return v.isoformat()
    if isinstance(v, (list, dict)):
        return ""
    return v
