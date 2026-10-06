"""Timestamp parsing for LPMS payloads.

LPMS writes local times with a bare zone abbreviation ("06/10/2015 00:00:00 CDT"), the feed refresh time in
GMT
("10/06/2026 14:26:17 GMT"), two-digit years in queue and traffic rows ("10/06/26 06:34" plus a `timezone`
field) and operator entry times with no zone at all ("2026-10-06T08:00:00"). Everything here returns aware
UTC datetimes or None; nothing raises on the blank values the feed emits (" EDT").
"""

from datetime import UTC, datetime, timedelta, timezone
from email.utils import parsedate_to_datetime
from zoneinfo import ZoneInfo

ZONE_OFFSETS = {
    "GMT": 0,
    "UTC": 0,
    "Z": 0,
    "EST": -5,
    "EDT": -4,
    "CST": -6,
    "CDT": -5,
    "MST": -7,
    "MDT": -6,
    "PST": -8,
    "PDT": -7,
    "AKST": -9,
    "AKDT": -8,
}

# LPMS operator entry times carry no zone; approximate by district (EROC). Only the first letter and a few
# known Ohio Valley districts are needed for the 11 rivers that report hydrology. Default: Central.
_EASTERN = ZoneInfo("America/New_York")
_CENTRAL = ZoneInfo("America/Chicago")
_PACIFIC = ZoneInfo("America/Los_Angeles")
EROC_ZONES = {"H1": _EASTERN, "H2": _EASTERN, "H4": _EASTERN, "H5": _EASTERN}
EROC_LETTER_ZONES = {"E": _EASTERN, "K": _EASTERN, "G": _PACIFIC}


def zone_for_eroc(eroc: str | None) -> ZoneInfo:
    if not eroc:
        return _CENTRAL
    return EROC_ZONES.get(eroc) or EROC_LETTER_ZONES.get(eroc[0].upper(), _CENTRAL)


def _tz(abbrev: str | None) -> timezone | None:
    if not abbrev:
        return None
    offset = ZONE_OFFSETS.get(abbrev.strip().upper())
    return None if offset is None else timezone(timedelta(hours=offset))


def parse_zoned(value: str | None, default_zone: str | None = None) -> datetime | None:
    """'MM/DD/YYYY HH:MM:SS ZZZ' or 'MM/DD/YY HH:MM[:SS] [ZZZ]'. Blank or zone-only strings return None."""
    if not value or not value.strip():
        return None
    parts = value.strip().split()
    if not parts or not parts[0][0].isdigit():
        return None
    abbrev = parts[2] if len(parts) > 2 else default_zone
    stamp = " ".join(parts[:2])
    for fmt in ("%m/%d/%Y %H:%M:%S", "%m/%d/%Y %H:%M", "%m/%d/%y %H:%M:%S", "%m/%d/%y %H:%M"):
        try:
            naive = datetime.strptime(stamp, fmt)
            break
        except ValueError:
            continue
    else:
        return None
    tz = _tz(abbrev) or UTC
    return naive.replace(tzinfo=tz).astimezone(UTC)


def parse_entry(value: str | None, eroc: str | None = None) -> datetime | None:
    """ISO operator entry time without zone, interpreted in the district's local zone."""
    if not value:
        return None
    try:
        naive = datetime.fromisoformat(value.strip())
    except ValueError:
        return None
    if naive.tzinfo is not None:
        return naive.astimezone(UTC)
    return naive.replace(tzinfo=zone_for_eroc(eroc)).astimezone(UTC)


def parse_http_date(value: str | None) -> datetime | None:
    if not value:
        return None
    try:
        return parsedate_to_datetime(value).astimezone(UTC)
    except (TypeError, ValueError):
        return None


def parse_iso(value: str | None) -> datetime | None:
    if not value:
        return None
    try:
        dt = datetime.fromisoformat(value.replace("Z", "+00:00"))
    except ValueError:
        return None
    return dt.astimezone(UTC) if dt.tzinfo else dt.replace(tzinfo=UTC)
