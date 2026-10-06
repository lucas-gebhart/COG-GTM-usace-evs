"""Section 508 read-out: axe CI results + manual attestation + OpenACR download (WP6).

The read-out fixture and the artefacts are written by `uv run evs-acr-gen` (tools/acr) in the CI `acr` job.
Artefacts are served from an allow-list only; the path segment never reaches the filesystem unresolved."""

from fastapi import APIRouter, HTTPException
from fastapi.responses import FileResponse

from evs.fixtures import load
from evs.schemas.ops import AccessibilityReadout
from evs.settings import get_settings

router = APIRouter(prefix="/accessibility", tags=["accessibility"])

ARTIFACTS: dict[str, str] = {
    "evs-openacr.yaml": "application/yaml",
    "evs-acr.md": "text/markdown; charset=utf-8",
    "evs-acr.html": "text/html; charset=utf-8",
    "evs-axe-results.json": "application/json",
}


@router.get("/readout", response_model=AccessibilityReadout)
def readout() -> AccessibilityReadout:
    return AccessibilityReadout(**load("accessibility"))


@router.get(
    "/artifacts/{name}",
    response_class=FileResponse,
    summary="Download a generated accessibility artefact",
    responses={
        200: {
            "description": "The artefact file",
            "content": {media: {} for media in sorted(set(ARTIFACTS.values()))},
        },
        404: {"description": "Unknown artefact name or artefact not generated yet"},
    },
)
def artifact(name: str) -> FileResponse:
    media_type = ARTIFACTS.get(name)
    if media_type is None:
        raise HTTPException(status_code=404, detail=f"Unknown artefact; allowed: {', '.join(ARTIFACTS)}")
    path = get_settings().a11y_docs_dir / name
    if not path.is_file():
        raise HTTPException(status_code=404, detail=f"{name} has not been generated (run evs-acr-gen)")
    return FileResponse(path, media_type=media_type, filename=name)
