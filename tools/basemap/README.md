# EVS basemap (Protomaps PMTiles)

The lock and SRP maps use MapLibre GL JS with a single-file [PMTiles](https://docs.protomaps.com/pmtiles/)
basemap served by nginx with HTTP range requests. One file, no tile server, no third-party map calls from the
browser, which is what an IL5 enclave without internet egress needs.

`tools/basemap/fetch.sh` extracts the continental US (bbox -125,24 to -66,50) at zooms 0 to 8 from the public
Protomaps daily build `20261005` with `pmtiles extract`. Measured 2026-10-06: z0-z8 is 56 MB (z0-z7 is 19 MB).
Zoom 8 is enough for a national lock map; the detail panel does not need street-level tiles. To cover a region
at higher zoom, set `BASEMAP_BBOX` to the inland waterway corridor and `BASEMAP_MAXZOOM=10`.

| Where | How the file gets there |
|---|---|
| `make web` (Vite) | run `tools/basemap/fetch.sh` once; writes `apps/web/public/tiles/usace.pmtiles` (git-ignored) |
| Compose and Fly images | `apps/web/Dockerfile` stage `tiles` runs the same script at build time (`--build-arg FETCH_BASEMAP=false` to skip) |
| GovCloud | `infra/terraform-govcloud` creates an S3 bucket for the file; the web task proxies `/tiles/` to it (or the bucket is synced into the web image at build time in the pipeline) |

nginx serves `/tiles/` with `Accept-Ranges: bytes`; `curl -r 0-16383 -o /dev/null -w '%{http_code}' .../tiles/usace.pmtiles`
must return `206`.

## Licence and attribution (required on the map)

Protomaps basemap tiles are built from OpenStreetMap data, which is licensed under the
[Open Database License (ODbL) 1.0](https://opendatacommons.org/licenses/odbl/1-0/). The Protomaps schema and
build are released under the BSD-3 licence (https://github.com/protomaps/basemaps). The following attribution
must be visible on every map that renders these tiles (MapLibre `AttributionControl`, `customAttribution`):

```
© OpenStreetMap contributors (ODbL) | © Protomaps
```

HTML form for the MapLibre attribution control:

```html
<a href="https://www.openstreetmap.org/copyright">&copy; OpenStreetMap contributors</a> (ODbL) |
<a href="https://protomaps.com">&copy; Protomaps</a>
```

Lock, gauge and SRP overlays are USACE, NOAA and USGS public data and are not covered by ODbL.
