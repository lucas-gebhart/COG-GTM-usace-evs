#!/usr/bin/env sh
# Fetch the EVS basemap: a Protomaps PMTiles extract of the continental United States at zooms 0-8
# (about 56 MB). Runs on a developer machine, in CI and inside the web Dockerfile `tiles` stage.
#
#   tools/basemap/fetch.sh [output-path]      default apps/web/public/tiles/usace.pmtiles
#
# Environment overrides:
#   BASEMAP_BUILD    Protomaps daily build to extract from (default 20261005)
#   BASEMAP_BBOX     minLon,minLat,maxLon,maxLat (default continental US -125,24,-66,50)
#   BASEMAP_MAXZOOM  highest zoom to keep (default 8; z9 roughly triples the size)
#   PMTILES_VERSION  go-pmtiles release used when the `pmtiles` CLI is not on PATH (default 1.31.2)
#
# The file is git-ignored on purpose. Data is OpenStreetMap, licence ODbL; see tools/basemap/README.md
# for the attribution text that must appear on the map.
set -eu

OUT="${1:-$(dirname "$0")/../../apps/web/public/tiles/usace.pmtiles}"
BASEMAP_BUILD="${BASEMAP_BUILD:-20261005}"
BASEMAP_BBOX="${BASEMAP_BBOX:--125.0,24.0,-66.0,50.0}"
BASEMAP_MAXZOOM="${BASEMAP_MAXZOOM:-8}"
PMTILES_VERSION="${PMTILES_VERSION:-1.31.2}"
SOURCE="https://build.protomaps.com/${BASEMAP_BUILD}.pmtiles"

if [ -s "$OUT" ] && [ "${BASEMAP_FORCE:-0}" != "1" ]; then
  echo "basemap: $OUT exists ($(du -h "$OUT" | cut -f1)); set BASEMAP_FORCE=1 to re-extract"
  exit 0
fi

PMTILES="$(command -v pmtiles || true)"
if [ -z "$PMTILES" ]; then
  arch="$(uname -m)"
  case "$arch" in
    x86_64|amd64) arch="x86_64" ;;
    aarch64|arm64) arch="arm64" ;;
    *) echo "basemap: unsupported arch $arch, install pmtiles from https://github.com/protomaps/go-pmtiles" >&2; exit 1 ;;
  esac
  os="$(uname -s)"
  tmp="$(mktemp -d)"
  url="https://github.com/protomaps/go-pmtiles/releases/download/v${PMTILES_VERSION}/go-pmtiles_${PMTILES_VERSION}_${os}_${arch}.tar.gz"
  echo "basemap: downloading pmtiles CLI $PMTILES_VERSION"
  curl -fsSL "$url" | tar -xz -C "$tmp" pmtiles
  PMTILES="$tmp/pmtiles"
fi

mkdir -p "$(dirname "$OUT")"
echo "basemap: extracting $SOURCE bbox=$BASEMAP_BBOX maxzoom=$BASEMAP_MAXZOOM -> $OUT"
"$PMTILES" extract "$SOURCE" "$OUT" --bbox="$BASEMAP_BBOX" --maxzoom="$BASEMAP_MAXZOOM"
"$PMTILES" show "$OUT" | head -20
echo "basemap: wrote $OUT ($(du -h "$OUT" | cut -f1))"
