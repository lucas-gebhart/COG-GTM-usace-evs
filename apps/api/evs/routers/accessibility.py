"""Section 508 read-out: axe CI results + manual attestation + OpenACR download (WP6)."""

from fastapi import APIRouter

from evs.fixtures import load
from evs.schemas.ops import AccessibilityReadout

router = APIRouter(prefix="/accessibility", tags=["accessibility"])


@router.get("/readout", response_model=AccessibilityReadout)
def readout() -> AccessibilityReadout:
    return AccessibilityReadout(**load("accessibility"))
