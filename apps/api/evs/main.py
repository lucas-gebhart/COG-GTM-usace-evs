from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from evs import __version__
from evs.routers import api_router
from evs.settings import get_settings

DESCRIPTION = """USACE Enterprise Visibility Suite API.

Every endpoint that replaces an Oracle APEX page carries an `x-apex-page` extension so the
traceability matrix (legacy/traceability.csv) can be regenerated from the contract.
"""


def create_app() -> FastAPI:
    settings = get_settings()
    app = FastAPI(
        title="EVS API",
        version=__version__,
        description=DESCRIPTION,
        openapi_version="3.1.0",
        openapi_tags=[
            {"name": "portfolio", "description": "Programs and P2 projects"},
            {"name": "financial", "description": "CEFMS execution (synthetic)"},
            {"name": "workforce", "description": "EMS labor (synthetic)"},
            {"name": "facilities", "description": "BUILDER SMS condition (synthetic)"},
            {"name": "public-locks", "description": "Live lock status from LPMS, public"},
            {"name": "public-srp", "description": "Sustainable Rivers Program coverage, public"},
            {"name": "accessibility", "description": "Section 508 read-out"},
            {"name": "admin", "description": "Feed health and thresholds"},
        ],
    )
    app.add_middleware(
        CORSMiddleware,
        allow_origins=settings.cors_origins,
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )
    app.include_router(api_router)
    return app


app = create_app()
