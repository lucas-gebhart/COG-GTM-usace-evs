"""Public-feed ingestion and the lock status engine (WP5a).

Adapters: lpms.py (status, delay, stoppage, queue), gis.py (NDC GIS Locks),
noaa.py (NWPS gauges), usgs.py (NWIS IV). status_engine.py evaluates the ordered
R/Y/G/Stale rules and writes status_eval rows. simulator.py is the labelled fallback.
"""
