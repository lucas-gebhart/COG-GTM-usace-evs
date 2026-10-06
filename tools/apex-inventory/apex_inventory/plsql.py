"""Tokenizer for the PL/SQL call blocks in an APEX export.

An export replays application metadata through `wwv_flow_imp*.create_*(...)` calls whose
arguments are named (`p_name=>value`). This module finds those calls and evaluates the
argument expressions the exports actually use: numbers, quoted strings (with `''` escapes),
`wwv_flow_imp.id(n)`, `wwv_flow_string.join(wwv_flow_t_varchar2(...))` string arrays,
`wwv_flow_t_plugin_attributes(...)` key/value arrays, `||` concatenation, `nvl(...)`,
`null`, `true` and `false`. Anything else is returned as the raw expression text.
"""

from __future__ import annotations

import bisect
import re
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any

CALL_RE = re.compile(r"^(wwv_flow_imp(?:_page|_shared)?|wwv_imp_workspace)\.([a-z_0-9]+)\s*\(", re.M)
TOKEN_RE = re.compile(r"'(?:[^']|'')*'|[(),]")
STRING_RE = re.compile(r"'(?:[^']|'')*'")
ARG_RE = re.compile(r"^\s*(p_[a-z_0-9]+)\s*=>\s*(.*)$", re.S)
ID_RE = re.compile(r"^wwv_flow_imp\.id\((\d+)\)$")
NUMBER_RE = re.compile(r"^-?\d+(\.\d+)?$")
JOIN_RE = re.compile(r"^wwv_flow_\w+\.join\(\s*wwv_flow_t_varchar2\((.*)\)\s*\)(?:\.to_clob)?$", re.S)
ATTRS_RE = re.compile(
    r"^wwv_flow_t_plugin_attributes\(\s*wwv_flow_t_varchar2\((.*)\)\s*\)(?:\.to_clob)?$", re.S
)
NVL_RE = re.compile(r"^nvl\((.*),\s*('(?:[^']|'')*')\s*\)$", re.S)


@dataclass
class Call:
    package: str
    name: str
    args: dict[str, Any]
    file: str
    line: int
    order: int = 0
    raw: dict[str, str] = field(default_factory=dict)

    @property
    def qualified(self) -> str:
        return f"{self.package}.{self.name}"

    def get(self, key: str, default: Any = None) -> Any:
        return self.args.get(key, default)

    def id(self, key: str = "p_id") -> str | None:
        value = self.args.get(key)
        return None if value is None else str(value)


def split_top_level(text: str, start: int) -> tuple[list[str], int]:
    """Split the argument list that starts just after an opening parenthesis.

    Returns the raw argument strings and the index just past the matching `)`.
    Quoted strings are skipped so commas and parentheses inside them are ignored.
    """
    depth = 0
    args: list[str] = []
    seg_start = start
    for m in TOKEN_RE.finditer(text, start):
        tok = m.group()
        if tok[0] == "'":
            continue
        if tok == "(":
            depth += 1
        elif tok == ")":
            if depth == 0:
                args.append(text[seg_start : m.start()])
                return args, m.end()
            depth -= 1
        elif depth == 0:
            args.append(text[seg_start : m.start()])
            seg_start = m.end()
    raise ValueError("unterminated argument list")


def unquote(literal: str) -> str:
    return literal[1:-1].replace("''", "'")


def _split_concat(expr: str) -> list[str]:
    """Split on top-level `||` (outside quotes and parentheses)."""
    parts: list[str] = []
    depth = 0
    i = 0
    seg = 0
    n = len(expr)
    while i < n:
        ch = expr[i]
        if ch == "'":
            m = STRING_RE.match(expr, i)
            i = m.end() if m else i + 1
            continue
        if ch == "(":
            depth += 1
        elif ch == ")":
            depth -= 1
        elif ch == "|" and depth == 0 and expr.startswith("||", i):
            parts.append(expr[seg:i])
            i += 2
            seg = i
            continue
        i += 1
    parts.append(expr[seg:])
    return parts


def eval_expr(expr: str) -> Any:
    s = expr.strip()
    if not s:
        return None
    low = s.lower()
    if low == "null":
        return None
    if low in ("true", "false"):
        return low == "true"
    if NUMBER_RE.match(s):
        return int(s) if "." not in s else float(s)
    m = ID_RE.match(s)
    if m:
        return int(m.group(1))
    m = JOIN_RE.match(s)
    if m:
        return "\n".join(str(v) if v is not None else "" for v in _eval_list(m.group(1)))
    m = ATTRS_RE.match(s)
    if m:
        items = [str(v) if v is not None else "" for v in _eval_list(m.group(1))]
        return dict(zip(items[::2], items[1::2], strict=False))
    m = NVL_RE.match(s)
    if m:
        return unquote(m.group(2))
    if s.startswith("'"):
        if STRING_RE.fullmatch(s):
            return unquote(s)
        out = []
        for part in _split_concat(s):
            value = eval_expr(part)
            out.append("" if value is None else str(value))
        return "".join(out)
    return s


def _eval_list(inner: str) -> list[Any]:
    args, _ = split_top_level(inner + ")", 0)
    return [eval_expr(a) for a in args if a.strip()]


def parse_args(raw_args: list[str]) -> tuple[dict[str, Any], dict[str, str]]:
    args: dict[str, Any] = {}
    raw: dict[str, str] = {}
    for a in raw_args:
        m = ARG_RE.match(a)
        if not m:
            continue
        key, expr = m.group(1), m.group(2)
        args[key] = eval_expr(expr)
        raw[key] = expr.strip()
    return args, raw


class _LineIndex:
    def __init__(self, text: str):
        self.offsets = [m.start() for m in re.finditer("\n", text)]

    def line(self, pos: int) -> int:
        return bisect.bisect_right(self.offsets, pos) + 1


def iter_calls(text: str, file: str = "<memory>") -> list[Call]:
    """Return every `wwv_flow_imp*.<name>(...)` call in document order."""
    calls: list[Call] = []
    lines = _LineIndex(text)
    pos = 0
    order = 0
    while True:
        m = CALL_RE.search(text, pos)
        if not m:
            break
        raw_args, end = split_top_level(text, m.end())
        args, raw = parse_args(raw_args)
        calls.append(Call(m.group(1), m.group(2), args, file, lines.line(m.start()), order, raw))
        order += 1
        pos = end
    return calls


def parse_file(path: Path, root: Path | None = None) -> list[Call]:
    text = path.read_text(encoding="utf-8", errors="replace")
    rel = str(path.relative_to(root)) if root else str(path)
    return iter_calls(text, rel)
