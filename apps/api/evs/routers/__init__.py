from fastapi import APIRouter

from evs.routers import accessibility, admin, facilities, financial, health, locks, portfolio, srp, workforce

api_router = APIRouter(prefix="/api/v1")
for module in (health, portfolio, financial, workforce, facilities, locks, srp, accessibility, admin):
    api_router.include_router(module.router)
