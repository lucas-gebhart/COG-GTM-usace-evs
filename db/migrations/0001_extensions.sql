-- Extensions available on Aurora PostgreSQL, RDS PostgreSQL and postgis/postgis Docker image alike.
CREATE EXTENSION IF NOT EXISTS postgis;
CREATE EXTENSION IF NOT EXISTS pgcrypto;
CREATE EXTENSION IF NOT EXISTS pg_trgm;
CREATE SCHEMA IF NOT EXISTS evs;      -- EVS-native tables (locks, SRP, status engine, feed health)
CREATE SCHEMA IF NOT EXISTS legacy;   -- ora2pg output of the APEX Strategic Planner SP_ schema
CREATE SCHEMA IF NOT EXISTS synth;    -- synthetic CEFMS / EMS / P2 / BUILDER fixtures
