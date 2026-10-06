"""Notices to Navigation Interests (NTNI) print pages linked from lock_status_report.ntniNoticesLinks.
The page is HTML; the header block is fixed-format text
("EFFECTIVE: 09/08/2026 00:00 thru 11/13/2026 00:00 EDT")."""

import html
import re
from dataclasses import dataclass, field
from datetime import datetime

from evs.ingest.lpms import lock_id
from evs.ingest.timeparse import parse_zoned

NTNI_BASE_URL = "https://ndc.ops.usace.army.mil/ords/ntni"
TAG_RE = re.compile(r"<[^>]+>")
EFFECTIVE_RE = re.compile(
    r"EFFECTIVE:\s*(\d{2}/\d{2}/\d{4} \d{2}:\d{2})\s*(?:thru|through|to|-)\s*"
    r"(\d{2}/\d{2}/\d{4} \d{2}:\d{2})?\s*([A-Z]{3,4})?",
    re.IGNORECASE,
)
NUMBER_RE = re.compile(r"NOTICE NUMBER:\s*([\w-]+)", re.IGNORECASE)
LOCKS_RE = re.compile(r"LOCK\(S\):\s*([A-Z]{2}\s*\d{1,2}(?:\s*[,;]\s*[A-Z]{2}\s*\d{1,2})*)", re.IGNORECASE)
LOCK_TOKEN_RE = re.compile(r"([A-Z]{2})\s*(\d{1,2})")
TITLE_RE = re.compile(r"_{10,}\s*(.+?)\s{2,}", re.DOTALL)


def notice_url(base: str, notice_no: str) -> str:
    return f"{base.rstrip('/')}/print_nav_notice?in_nav_notice_number={notice_no}"


@dataclass
class NtniNotice:
    notice_no: str
    lock_ids: list[str] = field(default_factory=list)
    title: str | None = None
    effective_from: datetime | None = None
    effective_to: datetime | None = None

    def active_at(self, now: datetime) -> bool:
        if self.effective_from is None or self.effective_from > now:
            return False
        return self.effective_to is None or self.effective_to >= now


def parse_notice(page: str, notice_no: str) -> NtniNotice:
    text = html.unescape(TAG_RE.sub(" ", page))
    text = re.sub(r"[ \t\r\n]+", " ", text)
    notice = NtniNotice(notice_no=notice_no)
    if m := NUMBER_RE.search(text):
        notice.notice_no = m.group(1).split("-")[0] if m.group(1).split("-")[0] == notice_no else notice_no
    if m := LOCKS_RE.search(text):
        notice.lock_ids = [lock_id(r, n) for r, n in LOCK_TOKEN_RE.findall(m.group(1).upper())]
    if m := EFFECTIVE_RE.search(text):
        zone = m.group(3) or "EST"
        notice.effective_from = parse_zoned(f"{m.group(1)}:00 {zone}")
        notice.effective_to = parse_zoned(f"{m.group(2)}:00 {zone}") if m.group(2) else None
    if m := TITLE_RE.search(text):
        notice.title = m.group(1).strip()[:200]
    return notice
