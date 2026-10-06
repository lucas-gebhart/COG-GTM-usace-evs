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
def ingest(once: bool = True) -> None:
    """Run the public-feed ingestion cycle (implemented in WP5a)."""
    typer.echo("ingest: not implemented yet (WP5a)")
    raise typer.Exit(code=2)


if __name__ == "__main__":
    app()
