from fastapi import APIRouter

from evs.routers import (
    accessibility,
    admin,
    enterprise,
    facilities,
    financial,
    health,
    locks,
    portfolio,
    projects_write,
    schedule,
    srp,
    workforce,
)

api_router = APIRouter(prefix="/api/v1")
for module in (
    health,
    enterprise,
    portfolio,
    projects_write,
    schedule,
    financial,
    workforce,
    facilities,
    locks,
    srp,
    accessibility,
    admin,
):
    api_router.include_router(module.router)
