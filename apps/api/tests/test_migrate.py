from evs.db.migrate import MIGRATIONS_DIR


def test_migrations_dir_contains_extensions_migration():
    assert (MIGRATIONS_DIR / "0001_extensions.sql").is_file()
