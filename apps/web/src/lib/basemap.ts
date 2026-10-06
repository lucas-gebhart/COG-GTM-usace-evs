import maplibregl, { type StyleSpecification } from "maplibre-gl";
import { Protocol } from "pmtiles";

/** WP7 extracts a z0-8 CONUS Protomaps build to this path (tools/basemap/fetch.sh). It is gitignored, so it may be missing. */
export const PMTILES_PATH = `${import.meta.env.BASE_URL ?? "/"}tiles/usace.pmtiles`.replace(/\/\/+tiles/, "/tiles");

let registered = false;
export function registerPmtilesProtocol(): void {
  if (registered) return;
  maplibregl.addProtocol("pmtiles", new Protocol().tile);
  registered = true;
}

/** HEAD request; Vite and nginx answer unknown paths with index.html, so a 200 with an HTML body still counts as missing. */
export async function pmtilesAvailable(path = PMTILES_PATH): Promise<boolean> {
  try {
    const res = await fetch(path, { method: "HEAD" });
    if (!res.ok) return false;
    const type = res.headers.get("content-type") ?? "";
    return !type.includes("text/html");
  } catch {
    return false;
  }
}

const OSM_ATTRIBUTION = '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors';
const PROTOMAPS_ATTRIBUTION = `<a href="https://protomaps.com">Protomaps</a> ${OSM_ATTRIBUTION}`;

export const RASTER_STYLE: StyleSpecification = {
  version: 8,
  sources: {
    osm: { type: "raster", tiles: ["https://tile.openstreetmap.org/{z}/{x}/{y}.png"], tileSize: 256, maxzoom: 19, attribution: OSM_ATTRIBUTION },
  },
  layers: [{ id: "osm", type: "raster", source: "osm" }],
};

/** Muted vector style over the Protomaps basemap schema (earth, water, landuse, roads, boundaries, places). */
export function vectorStyle(path = PMTILES_PATH): StyleSpecification {
  const url = new URL(path, typeof window === "undefined" ? "http://localhost" : window.location.origin).toString();
  return {
    version: 8,
    glyphs: "https://protomaps.github.io/basemaps-assets/fonts/{fontstack}/{range}.pbf",
    sources: { protomaps: { type: "vector", url: `pmtiles://${url}`, attribution: PROTOMAPS_ATTRIBUTION } },
    layers: [
      { id: "background", type: "background", paint: { "background-color": "#e9eef2" } },
      { id: "earth", type: "fill", source: "protomaps", "source-layer": "earth", paint: { "fill-color": "#f4f3ef" } },
      { id: "landuse-park", type: "fill", source: "protomaps", "source-layer": "landuse", filter: ["in", "kind", "park", "nature_reserve", "forest", "protected_area"], paint: { "fill-color": "#e3ecdc" } },
      { id: "water", type: "fill", source: "protomaps", "source-layer": "water", paint: { "fill-color": "#b9d3e6" } },
      { id: "boundaries", type: "line", source: "protomaps", "source-layer": "boundaries", filter: ["<=", "kind_detail", 4], paint: { "line-color": "#8c94a3", "line-width": 1, "line-dasharray": [3, 2] } },
      { id: "roads-major", type: "line", source: "protomaps", "source-layer": "roads", filter: ["in", "kind", "highway", "major_road"], paint: { "line-color": "#d5cfc3", "line-width": ["interpolate", ["linear"], ["zoom"], 4, 0.4, 8, 1.6] } },
      { id: "places", type: "symbol", source: "protomaps", "source-layer": "places", filter: ["in", "kind", "country", "region", "locality"], layout: { "text-field": ["get", "name"], "text-font": ["Noto Sans Regular"], "text-size": ["interpolate", ["linear"], ["zoom"], 3, 10, 8, 14], "symbol-sort-key": ["get", "min_zoom"] }, paint: { "text-color": "#3d4551", "text-halo-color": "#ffffff", "text-halo-width": 1.2 } },
    ],
  };
}

export type BasemapMode = "vector" | "raster";

/** Picks the PMTiles vector style when the file is served, else the OSM raster fallback. */
export async function chooseBasemap(): Promise<{ style: StyleSpecification; mode: BasemapMode }> {
  if (await pmtilesAvailable()) {
    registerPmtilesProtocol();
    return { style: vectorStyle(), mode: "vector" };
  }
  return { style: RASTER_STYLE, mode: "raster" };
}
