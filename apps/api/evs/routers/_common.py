"""Shared helpers for the data routers."""

from __future__ import annotations

from datetime import UTC, datetime

from fastapi import HTTPException

from evs.legacy_ports import ProjectValidationError
from evs.schemas.common import AsOf


def stamp(as_of: AsOf) -> AsOf:
    """Fill `fetched_at` with the request time when the repository did not provide one."""
    return as_of.model_copy(update={"fetched_at": as_of.fetched_at or datetime.now(UTC)})


def apex_validation_error(exc: ProjectValidationError) -> HTTPException:
    """APEX shows validation messages inline next to the page item; the API returns them as 422
    with the same item names so the web form can do the same."""
    return HTTPException(422, detail=exc.errors)
