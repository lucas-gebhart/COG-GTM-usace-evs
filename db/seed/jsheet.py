"""Parse the FY26 Civil Works O&M budget justification (J-sheet summary, pdftotext -layout output)
into db/seed/data/fy26_om_jsheet.csv.

Source PDF: https://usace.contentdm.oclc.org/utils/getfile/collection/p16021coll6/id/2565
("Operation and Maintenance, FY 2026 Budget, Summary of Projects" tables, dated 30 MAY 2025).
Usage: pdftotext -layout fy26_om.pdf fy26_om.txt && python3 jsheet.py fy26_om.txt
The parser reconciles every project row against its business-line rows; the grand total must match
the document ($2,058,080,000). Only state, division, project name, FY26 amount and business-line
split are kept. Everything downstream in db/seed is synthetic and scaled from these figures.
"""

import collections
import csv
import re
import sys
from pathlib import Path

SRC = sys.argv[1] if len(sys.argv) > 1 else "/home/ubuntu/work/fy26_om.txt"
OUT = Path(__file__).resolve().parent / "data" / "fy26_om_jsheet.csv"
lines = open(SRC).read().splitlines()
AMT = re.compile(r"^\d{1,3}(?:,\d{3})+$")
BLC = re.compile(r"^[A-Z]{2,5}$")
SKIP = (
    "ARMY CIVIL WORKS",
    "FY 2026 BUDGET",
    "BUDGETED",
    "BUSINESS",
    "PROGRAM",
    "AMOUNT FOR",
    "Grand Total",
    "intentionally blank",
)
cols = None
events = []  # ('H', dict) or ('BL', (code, amt)) or ('F', frag) or ('A', amount)


def amt(s):
    return int(s.replace(",", ""))


for ln in lines:
    if ln.startswith("STATE") and "DIVISION" in ln:
        cols = dict(div=ln.find("DIVISION"), amt=ln.find("AMOUNT FOR FY"), desc=ln.find("DESCRIPTION"))
        continue
    if cols is None or not ln.strip():
        continue
    if any(k in ln for k in SKIP) or re.match(r"^\s*\d+\s+30 MAY 2025", ln):
        continue
    words = [(m.start(), m.group()) for m in re.finditer(r"\S+", ln)]
    p0, w0 = words[0]

    def is_bl(i, words=words, cols=cols):
        return i + 1 < len(words) and BLC.match(words[i][1]) and AMT.match(words[i + 1][1]) and words[i][0] >= cols["amt"] + 8

    if p0 >= cols["amt"] + 12 and not is_bl(0) and not AMT.match(w0):
        continue
    state = div = None
    amount = None
    bl = None
    name = []
    i = 0
    if p0 <= cols["div"] and re.fullmatch(r"[A-Z]{2}", w0):
        state = w0
        i = 1
        divs = []
        while i < len(words) and re.fullmatch(r"[A-Z]{3},?", words[i][1]) and abs(words[i][0] - cols["div"]) <= 8:
            divs.append(words[i][1])
            i += 1
        div = " ".join(divs)
    while i < len(words):
        pos, w = words[i]
        if AMT.match(w):
            amount = amt(w)
            i += 1
            if is_bl(i):
                bl = (words[i][1], amt(words[i + 1][1]))
            break
        if is_bl(i):
            bl = (w, amt(words[i + 1][1]))
            break
        if pos >= cols["amt"] + 12:
            break
        name.append(w)
        i += 1
    frag = " ".join(name)
    if state and div:
        events.append(("H", dict(state=state, division=div, name=frag, amount=amount, online=[bl] if bl else [])))
    else:
        if frag:
            events.append(("F", frag))
        if amount is not None:
            events.append(("A", amount))
        if bl:
            events.append(("BL", bl))
# pass 2: names. Fragment immediately after a header with no own name -> suffix; otherwise prefix to next header
projects = []
before = []
prev = None
prev_idx = None
for k, (t, v) in enumerate(events):
    if t == "H":
        v["name"] = " ".join(before + ([v["name"]] if v["name"] else []))
        v["own"] = bool(v["name"])
        before = []
        projects.append(v)
        prev = v
        prev_idx = k
    elif t == "F":
        # a fragment that is just states ("& MS", "MO & NE", "(REG WORKS), MO & IL") continues the previous name
        suffix = re.fullmatch(r"(\(.*\),?\s*)?(&\s*)?[A-Z]{2}(\s*[,&]\s*[A-Z]{2})*", v) is not None
        # every project name ends with its state(s) or a parenthetical; a header without that ending wrapped
        complete = prev is not None and re.search(r"(, [A-Z]{2}(\s*&\s*[A-Z]{2})*|\))$", prev["name"]) is not None
        if prev is not None and prev_idx == k - 1 and (not prev["own"] or suffix or not complete):
            prev["name"] = (prev["name"] + " " + v).strip()
            prev["own"] = True
            prev_idx = k
        else:
            before.append(v)
    elif t == "A":
        if prev is not None and prev["amount"] is None:
            prev["amount"] = v
# pass 3: BL rows. Gap rows between header i and i+1 are split so header i sums to its amount; the remainder carries to i+1.
gaps = [[] for _ in projects]
pre = []
hi = -1
for t, v in events:
    if t == "H":
        hi += 1
    elif t == "BL":
        if hi < 0:
            pre.append(v)
        else:
            gaps[hi].append(v)
carry = pre
mism = 0
for i, p in enumerate(projects):
    rows = gaps[i]
    base = sum(a for _, a in carry) + sum(a for _, a in p["online"])
    k = None
    for kk in range(len(rows) + 1):
        if base + sum(a for _, a in rows[:kk]) == p["amount"]:
            k = kk
            break
    if k is None:
        k = len(rows)
        mism += 1
        p["mismatch"] = True
    p["bl"] = carry + p["online"] + rows[:k]
    carry = rows[k:]

total = sum(p["amount"] or 0 for p in projects)
assert mism == 0 and not carry, f"{mism} projects do not reconcile; carry={carry}"
assert total == 2_058_080_000, f"grand total {total} does not match the document"
OUT.parent.mkdir(parents=True, exist_ok=True)
with OUT.open("w", newline="") as f:
    w = csv.writer(f)
    w.writerow(["state", "division", "project_name", "fy26_amount_usd", "business_lines", "source_url"])
    for p in projects:
        bls = ";".join(f"{code}:{a}" for code, a in p["bl"])
        w.writerow(
            [
                p["state"],
                p["division"],
                " ".join(p["name"].split()),
                p["amount"],
                bls,
                "https://usace.contentdm.oclc.org/utils/getfile/collection/p16021coll6/id/2565",
            ]
        )
print(f"{len(projects)} project rows, total ${total:,}, written to {OUT}")
print(collections.Counter(p["division"] for p in projects))
print(collections.Counter(code for p in projects for code, _ in p["bl"]))
