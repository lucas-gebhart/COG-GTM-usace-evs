"""WCAG criteria to evidence mapping and the vendored GSA OpenACR catalog."""

from __future__ import annotations

import json
import re
from dataclasses import dataclass, field
from functools import lru_cache
from pathlib import Path
from typing import Any

import yaml

DATA = Path(__file__).resolve().parent / "data"
CATALOG_FILE = DATA / "catalog-2.5-edition-wcag-2.1-508-en.yaml"
SCHEMA_FILE = DATA / "openacr-0.1.0.json"

LEVELS = ("supports", "partially-supports", "does-not-support", "not-applicable", "not-evaluated")
# Worst first: used when several pieces of evidence disagree.
LEVEL_RANK = {
    "does-not-support": 0,
    "partially-supports": 1,
    "not-evaluated": 2,
    "not-applicable": 3,
    "supports": 4,
}

_TAG = re.compile(r"^wcag(\d)(\d)(\d{1,2})$")


@dataclass(frozen=True)
class Criterion:
    num: str
    name: str
    level: str  # A | AA
    method: str  # automated | manual | not_applicable
    axe_rules: tuple[str, ...] = ()
    manual_tests: tuple[str, ...] = ()
    manual_note: str = ""
    na_reason: str = ""
    smoke: str | None = None  # keyboard | reflow


@dataclass(frozen=True)
class Section508Row:
    num: str
    name: str
    manual_tests: tuple[str, ...] = ()
    manual_note: str = ""
    default_level: str = "not-evaluated"


@dataclass(frozen=True)
class Mapping:
    criteria: tuple[Criterion, ...]
    section508: tuple[Section508Row, ...]
    chapter_notes: dict[str, str] = field(default_factory=dict)

    def by_num(self) -> dict[str, Criterion]:
        return {c.num: c for c in self.criteria}

    def rule_index(self) -> dict[str, set[str]]:
        """axe rule id -> set of criterion numbers that cite it."""
        index: dict[str, set[str]] = {}
        for c in self.criteria:
            for rule in c.axe_rules:
                index.setdefault(rule, set()).add(c.num)
        return index


def tag_to_criterion(tag: str) -> str | None:
    """axe tag `wcag143` -> `1.4.3`; `wcag1410` -> `1.4.10`. Non-criterion tags return None."""
    m = _TAG.match(tag)
    if not m:
        return None
    return f"{m.group(1)}.{m.group(2)}.{int(m.group(3))}"


@lru_cache
def load_mapping(path: Path | None = None) -> Mapping:
    raw = yaml.safe_load((path or DATA / "wcag_mapping.yaml").read_text())
    criteria = tuple(
        Criterion(
            num=str(c["num"]),
            name=c["name"],
            level=c["level"],
            method=c["method"],
            axe_rules=tuple(c.get("axe_rules", [])),
            manual_tests=tuple(c.get("manual_tests", [])),
            manual_note=c.get("manual_note", ""),
            na_reason=c.get("na_reason", ""),
            smoke=c.get("smoke"),
        )
        for c in raw["criteria"]
    )
    section508 = tuple(
        Section508Row(
            num=str(r["num"]),
            name=r["name"],
            manual_tests=tuple(r.get("manual_tests", [])),
            manual_note=r.get("manual_note", ""),
            default_level=r.get("default_level", "not-evaluated"),
        )
        for r in raw["section508"]
    )
    return Mapping(criteria=criteria, section508=section508, chapter_notes=dict(raw.get("chapter_notes", {})))


@lru_cache
def load_catalog() -> dict[str, Any]:
    return yaml.safe_load(CATALOG_FILE.read_text())


@lru_cache
def load_schema() -> dict[str, Any]:
    return json.loads(SCHEMA_FILE.read_text())


def catalog_chapters() -> dict[str, dict[str, Any]]:
    return {ch["id"]: ch for ch in load_catalog()["chapters"]}
