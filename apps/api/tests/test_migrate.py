from pathlib import Path

from evs.db.migrate import default_migrations_dir


def test_migrations_present_and_ordered():
    names = sorted(p.name for p in default_migrations_dir().glob("*.sql"))
    assert "0001_extensions.sql" in names and "0007_wp3_evs_state.sql" in names
    assert all(n[:4].isdigit() for n in names)
    assert "--" not in Path(default_migrations_dir() / "0007_wp3_evs_state.sql").read_text().replace(
        "-- ", ""
    )
