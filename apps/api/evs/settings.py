from functools import lru_cache
from typing import Literal

from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    """Twelve-factor configuration. Same image runs locally, on Fly.io and in GovCloud."""

    model_config = SettingsConfigDict(env_prefix="EVS_", env_file=".env", extra="ignore")

    env: Literal["local", "fly", "govcloud"] = "local"
    database_url: str = "postgresql+asyncpg://evs:evs@localhost:5432/evs"
    database_url_sync: str = "postgresql://evs:evs@localhost:5432/evs"

    # Identity: Keycloak locally, Cognito / Army ICAM federation in GovCloud.
    oidc_issuer: str = "http://localhost:8080/realms/evs"
    oidc_audience: str = "evs-web"
    auth_disabled: bool = True  # local dev and fixtures mode only; CI asserts False for env=govcloud

    # Data source mode for public feeds (LPMS, NOAA, USGS).
    feed_source: Literal["live", "fixtures", "simulated"] = "fixtures"
    lpms_base_url: str = "https://ndc.ops.usace.army.mil/ords/lpms"
    stale_after_minutes: int = 120
    delay_yellow_minutes: int = 60
    delay_red_minutes: int = 240
    queue_yellow_vessels: int = 6
    lpms_failover_hours: int = 6  # switch to the labelled simulator after LPMS has failed this long
    ingest_interval_seconds: int = 900  # LPMS cadence for `evs ingest --loop` (WP7 Fly process group)
    noaa_base_url: str = "https://api.water.noaa.gov/nwps/v1"
    usgs_iv_url: str = "https://waterservices.usgs.gov/nwis/iv/"
    ntni_base_url: str = "https://ndc.ops.usace.army.mil/ords/ntni"
    gis_locks_url: str = (
        "https://services7.arcgis.com/n1YM8pTrFmm7L4hs/ArcGIS/rest/services/Locks/FeatureServer/0/query"
        "?where=1%3D1&outFields=*&f=geojson"
    )
    ingest_user_agent: str = (
        "EVS-demo/0.1 (USACE EVS ingestion; +https://github.com/lucas-gebhart/COG-GTM-usace-evs)"
    )
    http_timeout_s: float = 30.0
    http_retries: int = 3
    noaa_detail_budget: int = 6  # NWPS detail calls per gauge cycle (rate limit is 10 per 5 minutes)
    lpms_detail_locks: int = (
        0  # how many locks get queue and traffic polled per cycle, 0 = all reporting locks
    )
    simulator_seed: int = 42
    samples_dir: str | None = None  # defaults to <repo>/legacy/data_samples or /legacy/data_samples

    s3_endpoint: str | None = "http://localhost:9000"
    s3_bucket: str = "evs-raw"
    s3_access_key: str | None = "evs"
    s3_secret_key: str | None = "evs-local-minio"
    s3_region: str = "us-gov-west-1"
    pmtiles_url: str = "/tiles/usace.pmtiles"
    cors_origins: list[str] = ["http://localhost:5173", "http://localhost:3000"]


@lru_cache
def get_settings() -> Settings:
    return Settings()
