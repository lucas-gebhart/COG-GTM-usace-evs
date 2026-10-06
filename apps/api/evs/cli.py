import json
from pathlib import Path

import typer

app = typer.Typer(help="EVS operations CLI", no_args_is_help=True)


@app.command()
def migrate() -> None:
    """Apply pending SQL migrations from db/migrations."""
    from evs.db.migrate import run
    from evs.settings import get_settings

    for name in run(get_settings().database_url_sync):
        typer.echo(f"applied {name}")


@app.command()
def openapi(out: Path = Path("../../packages/contract/openapi.json")) -> None:
    """Write the OpenAPI 3.1 contract consumed by the web client generator."""
    from evs.main import create_app

    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(json.dumps(create_app().openapi(), indent=2) + "\n")
    typer.echo(f"wrote {out}")


@app.command()
def ingest(
    once: bool = typer.Option(False, "--once", help="Run GIS, gauges and LPMS cycles once and exit."),
    loop: bool = typer.Option(
        False, "--loop", help="Run forever: LPMS every 15 min, gauges 30 min, GIS daily."
    ),
    source: str | None = typer.Option(None, help="Override EVS_FEED_SOURCE: live, fixtures or simulated."),
) -> None:
    """Poll the public feeds (LPMS, NDC GIS, NOAA NWPS, USGS NWIS), evaluate lock status, notify the API."""
    import logging

    from evs.ingest.worker import IngestWorker
    from evs.settings import get_settings

    logging.basicConfig(level=logging.INFO, format="%(asctime)s %(levelname)s %(name)s %(message)s")
    settings = get_settings()
    if source:
        settings = settings.model_copy(update={"feed_source": source})
    worker = IngestWorker(settings)
    if loop:
        worker.run_loop()
    else:
        summary = worker.run_once()
        typer.echo(json.dumps(summary, indent=2, default=str))


if __name__ == "__main__":
    app()
