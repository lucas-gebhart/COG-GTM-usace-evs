from functools import lru_cache
from typing import Literal

from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    """Twelve-factor configuration. Same image runs locally, on Fly.io and in GovCloud."""

    model_config = SettingsConfigDict(env_prefix="EVS_", env_file=".env", extra="ignore")

    env: Literal["local", "fly", "govcloud"] = "local"
    database_url: str = "postgresql+asyncpg://evs:evs@localhost:5432/evs"
    database_url_sync: str = "postgresql://evs:evs@localhost:5432/evs"
    # auto: use the database when reachable, otherwise fall back to fixtures with a logged warning.
    # db: fail at first use when the database is unreachable. fixtures: never touch the database.
    data_mode: Literal["auto", "db", "fixtures"] = "auto"
    database_connect_timeout_s: float = 3.0

    # Identity: Keycloak locally, Cognito / Army ICAM federation in GovCloud.
    oidc_issuer: str = "http://localhost:8080/realms/evs"
    oidc_audience: str = "evs-web"
    oidc_jwks_url: str | None = None  # discovered from the issuer when unset
    auth_disabled: bool = True  # local dev and fixtures mode only; CI asserts False for env=govcloud

    # Data source mode for public feeds (LPMS, NOAA, USGS).
    feed_source: Literal["live", "fixtures", "simulated"] = "fixtures"
    lpms_base_url: str = "https://ndc.ops.usace.army.mil/ords/lpms"
    stale_after_minutes: int = 120
    delay_yellow_minutes: int = 60
    delay_red_minutes: int = 240
    queue_yellow_vessels: int = 6

    s3_endpoint: str | None = "http://localhost:9000"
    s3_bucket: str = "evs-raw"
    pmtiles_url: str = "/tiles/usace.pmtiles"
    cors_origins: list[str] = ["http://localhost:5173", "http://localhost:3000"]


@lru_cache
def get_settings() -> Settings:
    return Settings()
