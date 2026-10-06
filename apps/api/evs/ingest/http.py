"""Polite HTTP client for public feeds: timeouts, bounded retries, stable User-Agent, never raises."""

import logging
import time
from dataclasses import dataclass, field
from datetime import UTC, datetime

import httpx

from evs.ingest.timeparse import parse_http_date

log = logging.getLogger(__name__)
DEFAULT_USER_AGENT = "EVS-demo/0.1 (USACE EVS ingestion; +https://github.com/lucas-gebhart/COG-GTM-usace-evs)"
RETRY_STATUSES = {429, 500, 502, 503, 504, 555}


@dataclass
class FetchResult:
    url: str
    status_code: int | None
    text: str
    latency_ms: int
    fetched_at: datetime
    server_date: datetime | None = None
    error: str | None = None
    attempts: int = 1
    headers: dict[str, str] = field(default_factory=dict)

    @property
    def ok(self) -> bool:
        return self.error is None and self.status_code is not None and 200 <= self.status_code < 300


class FeedClient:
    def __init__(self, timeout: float = 20.0, retries: int = 3, user_agent: str = DEFAULT_USER_AGENT) -> None:
        self.retries = retries
        self._client = httpx.Client(
            timeout=httpx.Timeout(timeout, connect=10.0),
            headers={"User-Agent": user_agent, "Accept": "application/json, text/plain, */*"},
            follow_redirects=True,
        )

    def close(self) -> None:
        self._client.close()

    def get(self, url: str, params: dict | None = None) -> FetchResult:
        started = time.monotonic()
        fetched_at = datetime.now(UTC)
        last_error, last_status, last_text, headers = None, None, "", {}
        for attempt in range(1, self.retries + 1):
            try:
                resp = self._client.get(url, params=params)
                last_status, last_text, headers = resp.status_code, resp.text, dict(resp.headers)
                if resp.status_code in RETRY_STATUSES and attempt < self.retries:
                    last_error = f"HTTP {resp.status_code}"
                    time.sleep(min(2 ** (attempt - 1), 8))
                    continue
                latency = int((time.monotonic() - started) * 1000)
                error = None if 200 <= resp.status_code < 300 else f"HTTP {resp.status_code}"
                return FetchResult(
                    str(resp.url),
                    resp.status_code,
                    resp.text,
                    latency,
                    fetched_at,
                    parse_http_date(resp.headers.get("date")),
                    error,
                    attempt,
                    headers,
                )
            except httpx.HTTPError as exc:
                last_error = f"{type(exc).__name__}: {exc}"
                log.warning("fetch %s attempt %d failed: %s", url, attempt, last_error)
                if attempt < self.retries:
                    time.sleep(min(2 ** (attempt - 1), 8))
        latency = int((time.monotonic() - started) * 1000)
        return FetchResult(
            url, last_status, last_text, latency, fetched_at, None, last_error, self.retries, headers
        )
