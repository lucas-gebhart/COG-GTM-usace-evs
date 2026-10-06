from fastapi import APIRouter

from evs import __version__
from evs.settings import get_settings

router = APIRouter(tags=["meta"])


@router.get("/health")
def health() -> dict:
    s = get_settings()
    return {"status": "ok", "version": __version__, "env": s.env, "feed_source": s.feed_source}
