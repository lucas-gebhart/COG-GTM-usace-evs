"""Deterministic generators for the synthetic internal systems (schema synth).

Everything here is invented for the demo. Project names, states, divisions and FY26 amounts come
from the public FY26 O&M J-sheet (fy26.py); phases, districts, people, contracts, labor and
facility conditions are generated with random.Random(SEED). Built-in stories:
  over_obligated      one program obligates past its allotment
  slipped_milestones  two projects with slipped milestones and a late schedule
  overtime_spike      one district (SWT) with an overtime spike in pay periods 14 to 18
  low_ci              one installation (Olmsted Locks and Dam) with low condition indexes
"""

from __future__ import annotations

import math
import random
from dataclasses import dataclass, field
from datetime import date, timedelta

from evs_seed import FISCAL_YEAR, SEED
from evs_seed.fy26 import DISTRICT_BY_DIVISION_STATE, JSHEET_URL, JSheetRow, load_jsheet

DIVISIONS = ["LRD", "MVD", "SWD", "NWD", "SAD"]
LABOR_DISTRICTS = ["LRL", "LRH", "MVS", "MVR", "SWT", "SWL", "NWP", "SAM"]
PROJECT_TARGET = 120
PROGRAM_CAP = 20
APPROPRIATIONS = {
    "96X3121": "Investigations",
    "96X3122": "Construction",
    "96X3123": "Operation and Maintenance",
    "96X3112": "Mississippi River and Tributaries",
    "96X4902": "Revolving Fund",
}
PHASES = ["O&M"] * 11 + ["Construction"] * 5 + ["PED"] * 3 + ["Feasibility"] * 1
PHASE_APPROPRIATION = {
    "Feasibility": "96X3121",
    "Reconnaissance": "96X3121",
    "PED": "96X3122",
    "Construction": "96X3122",
    "O&M": "96X3123",
}
MILESTONES = {
    "Feasibility": [
        ("FCSA", "Feasibility Cost Share Agreement"),
        ("TSP", "Tentatively Selected Plan"),
        ("ADM", "Agency Decision Milestone"),
        ("CHIEF", "Chief's Report"),
        ("PPA", "Project Partnership Agreement"),
    ],
    "PED": [
        ("PPA", "Project Partnership Agreement"),
        ("DDR", "Design Documentation Report"),
        ("P&S", "Plans and Specifications"),
        ("BCOES", "BCOES Certification"),
        ("RTA", "Ready to Advertise"),
    ],
    "Construction": [
        ("RTA", "Ready to Advertise"),
        ("AWARD", "Contract Award"),
        ("NTP", "Notice to Proceed"),
        ("BOD", "Beneficial Occupancy"),
        ("FISCAL", "Fiscal Closeout"),
    ],
    "O&M": [
        ("AWP", "Annual Work Plan Approved"),
        ("PI", "Periodic Inspection"),
        ("MAJREH", "Major Rehab Report"),
        ("DEWATER", "Dewatering Window"),
        ("CLOSEOUT", "FY Closeout"),
    ],
}
FIRST_NAMES = ["A.", "B.", "C.", "D.", "E.", "J.", "K.", "L.", "M.", "N.", "P.", "R.", "S.", "T."]
LAST_NAMES = [
    "Alvarez",
    "Baker",
    "Chen",
    "Dawson",
    "Ellis",
    "Foster",
    "Garcia",
    "Hughes",
    "Ibarra",
    "Jensen",
    "Kim",
    "Lopez",
    "Mitchell",
    "Nguyen",
    "Okafor",
    "Patel",
    "Quinn",
    "Reyes",
    "Schmidt",
    "Turner",
    "Underwood",
    "Vasquez",
    "Walsh",
    "Young",
]
CONTRACTORS = [
    "Riverworks Marine Construction LLC",
    "Ohio Valley Dredging Co.",
    "Great Plains Civil JV",
    "Cascade Hydro Services Inc.",
    "Gulf Coast Structural Group",
    "Midwest Lock and Dam Builders",
    "Tri-State Electrical Contractors",
    "Heartland Heavy Civil JV",
]
UNIFORMAT = [
    ("B30", "Roofing", 25),
    ("D30", "HVAC", 20),
    ("D50", "Electrical", 30),
    ("D20", "Plumbing", 30),
    ("C10", "Interior Construction", 35),
    ("B20", "Exterior Enclosure", 40),
    ("D40", "Fire Protection", 25),
    ("G20", "Site Improvements", 20),
    ("A10", "Foundations", 75),
    ("B10", "Superstructure", 75),
]
COMPONENT_TYPES = {
    "B30": ["Built-up roof membrane", "Standing seam metal roof", "Roof drains"],
    "D30": ["Rooftop air handler", "Split system heat pump", "Boiler", "Chiller"],
    "D50": ["Switchgear", "Panelboard", "Emergency generator", "Lighting"],
    "D20": ["Domestic water piping", "Water heater", "Sanitary waste piping"],
    "C10": ["Partitions", "Interior doors", "Suspended ceilings"],
    "B20": ["Exterior wall panels", "Windows", "Exterior doors"],
    "D40": ["Sprinkler system", "Fire alarm panel"],
    "G20": ["Parking lot pavement", "Site lighting", "Fencing"],
    "A10": ["Spread footings", "Slab on grade"],
    "B10": ["Steel frame", "Concrete deck"],
}
INSTALLATIONS = [
    ("Olmsted Locks and Dam", "LRL", 6),
    ("McAlpine Locks and Dam Operations Complex", "LRL", 4),
    ("Robert C. Byrd Locks and Dam", "LRH", 4),
    ("Melvin Price Locks and Dam", "MVS", 5),
    ("Rock Island Arsenal District Office", "MVR", 4),
    ("Keystone Lake Project Office", "SWT", 3),
    ("Bonneville Lock and Dam", "NWP", 5),
    ("Mobile District Operations Center", "SAM", 4),
]
LOW_CI_INSTALLATION = "Olmsted Locks and Dam"
OVERTIME_DISTRICT = "SWT"
FY_START = date(FISCAL_YEAR - 1, 10, 1)
TODAY = date(2026, 10, 6)
SLIP_CUTOFF = date(2026, 4, 1)  # milestones baselined after this carry the project slip
STATES = {
    "AL",
    "AK",
    "AZ",
    "AR",
    "CA",
    "CO",
    "CT",
    "DE",
    "FL",
    "GA",
    "HI",
    "ID",
    "IL",
    "IN",
    "IA",
    "KS",
    "KY",
    "LA",
    "ME",
    "MD",
    "MA",
    "MI",
    "MN",
    "MS",
    "MO",
    "MT",
    "NE",
    "NV",
    "NH",
    "NJ",
    "NM",
    "NY",
    "NC",
    "ND",
    "OH",
    "OK",
    "OR",
    "PA",
    "RI",
    "SC",
    "SD",
    "TN",
    "TX",
    "UT",
    "VT",
    "VA",
    "WA",
    "WV",
    "WI",
    "WY",
    "PR",
    "DC",
}


def pretty_name(raw: str) -> str:
    """Title-case a J-sheet project name but keep state codes, ampersands and short words as written."""
    out = []
    toks = raw.split()
    for i, tok in enumerate(toks):
        core = tok.strip(",()&")
        prev = toks[i - 1] if i else ","
        is_state = core in STATES and (prev.endswith(",") or prev == "&" or tok != core or i == len(toks) - 1)
        if is_state or core in {"&", "L&D", "MKARNS", "GIWW"}:
            out.append(tok)
        elif tok.lower() in {"and", "of", "the", "at", "on"} and out:
            out.append(tok.lower())
        else:
            out.append(tok.title())
    return " ".join(out)


@dataclass
class Program:
    program_code: str
    name: str
    business_line: str
    business_line_code: str
    division: str
    appropriation: str
    funded_amount: float = 0.0
    schedule_health: str = "on_track"
    story: str | None = None


@dataclass
class Project:
    p2_project_no: str
    name: str
    program_code: str
    district: str
    division: str
    state: str
    business_line: str
    phase: str
    pdt_lead: str
    pmp_approved_date: date
    baseline_start: date
    baseline_finish: date
    current_finish: date
    pct_complete: float
    funded_amount: float
    jsheet_amount: int
    jsheet_source: str
    schedule_health: str
    story: str | None
    milestones: list[dict] = field(default_factory=list)
    work_items: list[dict] = field(default_factory=list)


@dataclass
class SynthData:
    programs: list[Program]
    projects: list[Project]
    funding: list[dict]
    labor_plan: list[dict]
    labor: list[dict]
    contracts: list[dict]
    components: list[dict]


def fiscal_month_start(fm: int) -> date:
    """Fiscal month 1 is October of the prior calendar year; 4 is January; 12 is September."""
    month = (fm + 8) % 12 + 1
    year = FISCAL_YEAR - 1 if fm <= 3 else FISCAL_YEAR
    return date(year, month, 1)


def plan_curve(fm: int) -> float:
    """Cumulative obligation plan: slow first quarter, steep spring, flat September."""
    x = fm / 12
    return round(0.15 * x + 0.85 * (x * x * (3 - 2 * x)), 4)


def pick_district(rng: random.Random, row: JSheetRow) -> str:
    table = DISTRICT_BY_DIVISION_STATE[row.division]
    return rng.choice(table.get(row.state) or table["*"])


def pick_projects(rng: random.Random) -> list[JSheetRow]:
    rows = [
        r
        for r in load_jsheet()
        if r.division in DIVISIONS and r.dominant_code in {"NIH", "NIL", "FDRR", "FDRC", "HYD", "REC", "ENS", "WTR"}
    ]
    per_division = PROJECT_TARGET // len(DIVISIONS)
    chosen: list[JSheetRow] = []
    for div in DIVISIONS:
        pool = sorted((r for r in rows if r.division == div), key=lambda r: (-r.amount, r.project_name))
        # keep the largest projects plus a deterministic sample of the rest so small sites appear too
        head, tail = pool[: per_division // 2], pool[per_division // 2 :]
        chosen += head + rng.sample(tail, min(len(tail), per_division - len(head)))
    return chosen


def generate() -> SynthData:
    rng = random.Random(SEED)
    rows = pick_projects(rng)

    # programs = division x business line, capped at PROGRAM_CAP by project count
    groups: dict[tuple[str, str, str], list[JSheetRow]] = {}
    for r in rows:
        code, name = r.business_line
        groups.setdefault((r.division, code, name), []).append(r)
    keys = sorted(groups, key=lambda k: (-len(groups[k]), k))[:PROGRAM_CAP]
    programs: list[Program] = []
    for div, code, name in keys:
        appropriation = "96X3112" if div == "MVD" and code in {"NAV", "FRM"} else "96X3123"
        programs.append(Program(f"{div}-{code}", f"{div} {name}", name, code, div, appropriation))
    over = next(p for p in programs if p.program_code == "LRD-NAV")
    over.story, over.schedule_health = "over_obligated", "at_risk"

    projects: list[Project] = []
    used_numbers: set[str] = set()
    slipped_quota = 2
    for div, code, name in keys:
        program = next(p for p in programs if p.program_code == f"{div}-{code}")
        for r in sorted(groups[(div, code, name)], key=lambda r: (-r.amount, r.project_name)):
            while (no := f"{rng.randint(100000, 999999)}") in used_numbers:
                pass
            used_numbers.add(no)
            phase = rng.choice(PHASES)
            start = FY_START - timedelta(days=rng.randint(200, 1500))
            duration = rng.randint(540, 1800) if phase != "O&M" else 365
            slip_days = 0
            story = None
            if slipped_quota and phase in {"Construction", "PED"} and r.amount > 5_000_000:
                slip_days, story, slipped_quota = (
                    rng.randint(120, 240),
                    "slipped_milestones",
                    slipped_quota - 1,
                )
                start, duration = FY_START - timedelta(days=300), 1200
            elif rng.random() < 0.25:
                slip_days = rng.randint(15, 75)
            baseline_finish = start + timedelta(days=duration)
            health = "late" if slip_days >= 90 else ("at_risk" if slip_days >= 30 else "on_track")
            if health != "on_track" and program.schedule_health == "on_track" and story is None:
                program.schedule_health = "at_risk" if rng.random() < 0.5 else program.schedule_health
            funded = float(r.amount) if phase == "O&M" else float(round(r.amount * rng.uniform(1.4, 3.0), -3))
            pct = min(99.0, max(1.0, (TODAY - start).days / duration * 100 * rng.uniform(0.8, 1.05)))
            if story:
                pct = round(rng.uniform(55, 70), 1)
            lead = f"{rng.choice(FIRST_NAMES)} {rng.choice(LAST_NAMES)}"
            proj = Project(
                no,
                pretty_name(r.project_name),
                program.program_code,
                pick_district(rng, r),
                div,
                r.state,
                name,
                phase,
                lead,
                start - timedelta(days=rng.randint(30, 120)),
                start,
                baseline_finish,
                baseline_finish + timedelta(days=slip_days),
                round(pct, 1),
                funded,
                r.amount,
                f"FY26 O&M J-sheet, {r.state} {r.division}: {JSHEET_URL}",
                health,
                story,
            )
            program.funded_amount += funded
            # milestones spread over the project duration
            codes = MILESTONES[phase]
            for i, (mc, mn) in enumerate(codes):
                baseline = start + timedelta(days=int(duration * (i + 1) / (len(codes) + 1)))
                forecast = baseline + timedelta(days=slip_days if baseline >= SLIP_CUTOFF else 0)
                if forecast <= TODAY:
                    actual = forecast + timedelta(days=rng.randint(-5, 5))
                    status = "complete"
                else:
                    actual = None
                    status = "slipped" if forecast > baseline else "scheduled"
                proj.milestones.append(
                    {
                        "seq": i + 1,
                        "code": mc,
                        "name": mn,
                        "baseline_date": baseline,
                        "forecast_date": forecast,
                        "actual_date": actual,
                        "status": status,
                    }
                )
            # 1 to 3 CEFMS work items, one of them cost shared for construction
            n_items = 1 if r.amount < 2_000_000 else rng.randint(2, 3)
            shares = [rng.random() + 0.3 for _ in range(n_items)]
            for k in range(n_items):
                code_wi = f"{rng.randint(0, 9)}{rng.randint(0, 9)}{rng.randint(0, 9)}" + "".join(
                    rng.choice("ABCDEFGHJKLMNPQRSTUVWXYZ") for _ in range(3)
                )
                appropriation = (
                    PHASE_APPROPRIATION[phase]
                    if k == 0
                    else rng.choice(
                        [
                            program.appropriation,
                            PHASE_APPROPRIATION[phase],
                            "96X4902" if k == 2 else program.appropriation,
                        ]
                    )
                )
                proj.work_items.append(
                    {
                        "work_item_code": code_wi,
                        "p2_project_no": no,
                        "district": proj.district,
                        "appropriation": appropriation,
                        "description": f"{proj.name} {['O&M', 'construction', 'engineering', 'plant'][min(k, 3)]} work item",
                        "cost_share_pct": 35.0 if phase == "Construction" and k == 0 else 0.0,
                        "customer_order_no": f"CO-{rng.randint(10000, 99999)}" if appropriation == "96X4902" else None,
                        "share": shares[k] / sum(shares),
                    }
                )
            projects.append(proj)
    for p in programs:
        p.funded_amount = round(p.funded_amount, 2)

    funding = _funding(rng, projects, programs)
    labor_plan, labor = _labor(rng, projects)
    contracts = _contracts(rng, projects)
    components = _components(rng)
    return SynthData(programs, projects, funding, labor_plan, labor, contracts, components)


def _funding(rng: random.Random, projects: list[Project], programs: list[Program]) -> list[dict]:
    over = {p.program_code for p in programs if p.story == "over_obligated"}
    rows = []
    for proj in projects:
        pace = rng.uniform(0.82, 1.02)
        if proj.program_code in over:
            pace = rng.uniform(1.06, 1.14)
        elif proj.schedule_health == "late":
            pace = rng.uniform(0.55, 0.7)
        for wi in proj.work_items:
            total = proj.funded_amount * wi["share"]
            noise = [rng.uniform(-0.03, 0.03) for _ in range(12)]
            for fm in range(1, 13):
                plan = plan_curve(fm)
                allot = min(1.0, math.ceil(fm / 3) * 0.25 + (0.0 if proj.program_code in over else 0.0))
                oblig = min(plan * pace + noise[fm - 1], 1.25)
                oblig = max(0.0, oblig)
                commit = min(allot if proj.program_code not in over else 1.3, oblig + 0.04 + 0.02 * rng.random())
                expend = oblig * (0.55 + 0.4 * fm / 12)
                disb = expend * (0.9 + 0.08 * fm / 12)
                rows.append(
                    {
                        "work_item_code": wi["work_item_code"],
                        "appropriation": wi["appropriation"],
                        "fiscal_year": FISCAL_YEAR,
                        "fiscal_month": fm,
                        "period": fiscal_month_start(fm),
                        "plan_obligation": round(total * plan, 2),
                        "allotment": round(total * allot, 2),
                        "commitment": round(total * commit, 2),
                        "obligation": round(total * oblig, 2),
                        "expenditure": round(total * expend, 2),
                        "disbursement": round(total * disb, 2),
                    }
                )
    return rows


def _labor(rng: random.Random, projects: list[Project]) -> tuple[list[dict], list[dict]]:
    plan, logs = [], []
    by_district = {d: [wi["work_item_code"] for p in projects if p.district == d for wi in p.work_items] for d in LABOR_DISTRICTS}
    all_codes = [wi["work_item_code"] for p in projects for wi in p.work_items]
    for district in LABOR_DISTRICTS:
        headcount = rng.randint(18, 28)
        employees = [(f"{district}-{rng.randint(100000, 999999)}", round(rng.uniform(42, 78), 2)) for _ in range(headcount)]
        codes = by_district[district] or all_codes
        for pp in range(1, 27):
            pp_end = date(FISCAL_YEAR - 1, 10, 11) + timedelta(days=14 * (pp - 1))
            label = f"{FISCAL_YEAR}-{pp:02d}"
            plan.append({"district": district, "pay_period": label, "hours_plan": headcount * 80.0})
            spike = district == OVERTIME_DISTRICT and 14 <= pp <= 18
            for emp, rate in employees:
                charge = rng.choices(
                    ["project", "customer order", "departmental overhead", "G&A", "leave"],
                    weights=[62, 10, 14, 6, 8],
                )[0]
                regular = 80.0 if charge != "leave" else round(rng.uniform(40, 72), 1)
                if charge == "leave":
                    ot = 0.0
                elif spike:
                    ot = round(rng.uniform(12, 30), 1)
                else:
                    ot = round(max(0.0, rng.gauss(2.5, 3.0)), 1) if rng.random() < 0.45 else 0.0
                code = rng.choice(codes) if charge in {"project", "customer order"} else None
                cost = round(regular * rate + ot * rate * 1.5, 2)
                logs.append(
                    {
                        "employee_id": emp,
                        "district": district,
                        "pay_period": label,
                        "pay_period_end": pp_end,
                        "work_item_code": code,
                        "hours_regular": regular,
                        "hours_overtime": ot,
                        "labor_cost": cost,
                        "charge_type": charge,
                        "labor_correction_flag": rng.random() < 0.02,
                    }
                )
    return plan, logs


def _contracts(rng: random.Random, projects: list[Project]) -> list[dict]:
    rows = []
    seq = 1
    for proj in projects:
        if proj.phase != "Construction":
            continue
        for _ in range(1 if proj.funded_amount < 20_000_000 else 2):
            award = proj.baseline_start + timedelta(days=rng.randint(60, 400))
            amount = round(proj.funded_amount * rng.uniform(0.35, 0.7), -3)
            pct = min(100.0, max(0.0, proj.pct_complete + rng.uniform(-15, 5)))
            rows.append(
                {
                    "contract_no": f"W912{proj.district[-2:]}-{str(award.year)[-2:]}-C-{seq:04d}",
                    "p2_project_no": proj.p2_project_no,
                    "contractor": rng.choice(CONTRACTORS),
                    "award_date": award,
                    "ntp_date": award + timedelta(days=rng.randint(10, 45)),
                    "contract_amount": amount,
                    "pct_complete": round(pct, 1),
                    "modifications": rng.randint(0, 9),
                    "contract_status": 5 if pct >= 100 else rng.choice([2, 3, 3, 4]),
                    "bcoes_review_date": award - timedelta(days=rng.randint(30, 120)),
                }
            )
            seq += 1
    return rows


def _components(rng: random.Random) -> list[dict]:
    rows = []
    n = 0
    for installation, district, buildings in INSTALLATIONS:
        for b in range(1, buildings + 1):
            building_id = f"{district}-{installation.split()[0][:4].upper()}-{b:03d}"
            for section, section_name, life in rng.sample(UNIFORMAT, rng.randint(5, 7)):
                n += 1
                install_year = rng.randint(1975, 2018)
                age = FISCAL_YEAR - install_year
                base_ci = max(15.0, 100 - 70 * age / life + rng.gauss(0, 6))
                if installation == LOW_CI_INSTALLATION:
                    base_ci = min(base_ci, rng.uniform(28, 52))
                ci = round(min(100.0, base_ci), 1)
                bci = round(min(100.0, max(20.0, ci + rng.uniform(-4, 8))), 1)
                deficiency = 0.0 if ci >= 70 else round((70 - ci) * rng.uniform(1800, 4200), 2)
                rows.append(
                    {
                        "component_id": f"{building_id}-{section}-{n:04d}",
                        "building_id": building_id,
                        "installation": installation,
                        "district": district,
                        "uniformat_section": f"{section} {section_name}",
                        "component_type": rng.choice(COMPONENT_TYPES[section]),
                        "install_year": install_year,
                        "service_life": life,
                        "last_inspection_date": date(FISCAL_YEAR - 1, 10, 1) + timedelta(days=rng.randint(0, 360)),
                        "ci": ci,
                        "bci": bci,
                        "deficiency_cost": deficiency,
                        "work_plan_year": FISCAL_YEAR + (0 if ci < 40 else 1 if ci < 55 else 2 if ci < 70 else 4),
                        "story": "low_ci" if installation == LOW_CI_INSTALLATION else None,
                    }
                )
    return rows
