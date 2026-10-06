"""FY26 O&M budget justification rows (public) used as the naming and scaling basis for synthetic data."""

from __future__ import annotations

import csv
from dataclasses import dataclass

from evs_seed import DATA

JSHEET_URL = "https://usace.contentdm.oclc.org/utils/getfile/collection/p16021coll6/id/2565"

# J-sheet business-line codes -> EVS business line names (key to abbreviations in the document).
BUSINESS_LINES = {
    "NIH": ("NAV", "Navigation"),
    "NIL": ("NAV", "Navigation"),
    "FDRR": ("FRM", "Flood Risk Management"),
    "FDRC": ("FRM", "Flood Risk Management"),
    "HYD": ("HYD", "Hydropower"),
    "REC": ("REC", "Recreation"),
    "ENS": ("ENS", "Environmental Stewardship"),
    "AER": ("ENS", "Environmental Stewardship"),
    "ENR": ("ENS", "Environmental Stewardship"),
    "WTR": ("WTR", "Water Supply"),
}

# State -> district within a division (real USACE districts). Used to attach a district to each
# J-sheet row, which lists only state and division.
DISTRICT_BY_DIVISION_STATE: dict[str, dict[str, list[str]]] = {
    "LRD": {
        "KY": ["LRL"],
        "IN": ["LRL"],
        "OH": ["LRH", "LRL", "LRB"],
        "WV": ["LRH"],
        "PA": ["LRP"],
        "TN": ["LRN"],
        "IL": ["LRL"],
        "NY": ["LRB"],
        "MI": ["LRE"],
        "VA": ["LRH"],
        "NC": ["LRN"],
        "*": ["LRL", "LRH", "LRN", "LRP"],
    },
    "MVD": {
        "MO": ["MVS"],
        "IL": ["MVS", "MVR"],
        "IA": ["MVR"],
        "MN": ["MVP"],
        "WI": ["MVP"],
        "AR": ["MVM"],
        "MS": ["MVK"],
        "LA": ["MVN"],
        "TN": ["MVM"],
        "KY": ["MVM"],
        "*": ["MVS", "MVR", "MVP"],
    },
    "SWD": {
        "OK": ["SWT"],
        "KS": ["SWT"],
        "AR": ["SWL"],
        "TX": ["SWF", "SWG"],
        "MO": ["SWL"],
        "LA": ["SWF"],
        "*": ["SWT", "SWL", "SWF"],
    },
    "NWD": {
        "OR": ["NWP"],
        "WA": ["NWS", "NWW"],
        "ID": ["NWW"],
        "MT": ["NWO"],
        "ND": ["NWO"],
        "SD": ["NWO"],
        "NE": ["NWO"],
        "KS": ["NWK"],
        "MO": ["NWK"],
        "IA": ["NWO"],
        "WY": ["NWO"],
        "CO": ["NWO"],
        "*": ["NWP", "NWW", "NWO", "NWK"],
    },
    "SAD": {
        "FL": ["SAJ"],
        "AL": ["SAM"],
        "GA": ["SAS", "SAM"],
        "SC": ["SAC"],
        "NC": ["SAW"],
        "MS": ["SAM"],
        "PR": ["SAJ"],
        "*": ["SAJ", "SAM", "SAS", "SAW"],
    },
}


@dataclass(frozen=True)
class JSheetRow:
    state: str
    division: str
    project_name: str
    amount: int
    business_lines: dict[str, int]

    @property
    def dominant_code(self) -> str:
        return max(self.business_lines.items(), key=lambda kv: (kv[1], kv[0]))[0]

    @property
    def business_line(self) -> tuple[str, str]:
        return BUSINESS_LINES[self.dominant_code]


def load_jsheet() -> list[JSheetRow]:
    rows: list[JSheetRow] = []
    with (DATA / "fy26_om_jsheet.csv").open() as f:
        for r in csv.DictReader(f):
            bls = {}
            for part in r["business_lines"].split(";"):
                if part:
                    code, amt = part.split(":")
                    bls[code] = bls.get(code, 0) + int(amt)
            rows.append(JSheetRow(r["state"], r["division"], r["project_name"], int(r["fy26_amount_usd"]), bls))
    return rows
