import json
import sys
from pathlib import Path

import typer

app = typer.Typer(help="EVS operations CLI", no_args_is_help=True)
FIXTURE_DIR = Path(__file__).resolve().parents[1] / "fixtures"


def _seed_package() -> None:
    """Make db/seed importable (repo checkout or the /db copy baked into the API image)."""
    from evs.db.migrate import default_migrations_dir

    seed_dir = default_migrations_dir().parent / "seed"
    if str(seed_dir) not in sys.path:
        sys.path.insert(0, str(seed_dir))


@app.command()
def migrate() -> None:
    """Apply pending SQL migrations from db/migrations."""
    from evs.db.migrate import run
    from evs.settings import get_settings

    for name in run(get_settings().database_url_sync):
        typer.echo(f"applied {name}")


@app.command()
def seed(
    reset: bool = typer.Option(False, "--reset", help="Truncate evs.* and synth.* before seeding"),
) -> None:
    """Load public samples (GIS, LPMS, SRP) and generate the synthetic CEFMS/P2/EMS/CMP/BUILDER data."""
    from evs.settings import get_settings

    _seed_package()
    from evs_seed.run import seed as run_seed

    for table, count in run_seed(get_settings().database_url_sync, reset_first=reset, log=typer.echo).items():
        typer.echo(f"{table:28s} {count:>8}")


@app.command("dump-fixtures")
def dump_fixtures(out: Path = FIXTURE_DIR) -> None:
    """Regenerate apps/api/fixtures/*.json from the seeded database."""
    from evs.settings import get_settings

    _seed_package()
    from evs_seed.dump import dump

    dump(get_settings().database_url_sync, out, log=typer.echo)


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
