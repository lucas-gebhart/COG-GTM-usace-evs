import maplibregl, { type LngLatBoundsLike, type Map as MapLibreMap } from "maplibre-gl";
import "maplibre-gl/dist/maplibre-gl.css";
import { useEffect, useId, useLayoutEffect, useRef, useState, type KeyboardEvent, type ReactNode } from "react";
import { createPortal } from "react-dom";
import { useReducedMotion } from "../../hooks/useReducedMotion";
import { chooseBasemap, type BasemapMode } from "../../lib/basemap";

export interface MapPoint {
  id: string;
  latitude: number;
  longitude: number;
  /** Accessible name of the marker button, e.g. "Lock and Dam 2, Allegheny River: Operating". */
  name: string;
  /** Shape rendered inside the 44 px button (StatusShape for locks, SiteShape for SRP sites). */
  shape: ReactNode;
  /** Hover and focus tooltip; the same facts the detail panel opens with. */
  tooltip: ReactNode;
}

export interface AccessibleMapProps {
  /** Memoise this array: markers are rebuilt when it changes. Order is the keyboard order. */
  points: MapPoint[];
  selectedId?: string | null;
  onSelect: (id: string, trigger: HTMLElement) => void;
  /** Region label, e.g. "Map of lock status". */
  label: string;
  /** Names the table or list that carries the same information. */
  alternativeText: string;
  className?: string;
}

interface Placed {
  point: MapPoint;
  el: HTMLDivElement;
  marker: maplibregl.Marker;
}

type Mode = BasemapMode | "loading" | "unsupported";

const CONUS: LngLatBoundsLike = [
  [-125, 24],
  [-66, 50],
];

/** Blue square with a dam glyph for SRP sites (not a status, so not a status shape). */
export function SiteShape({ size = 28 }: { size?: number }) {
  return (
    <svg className="evs-marker__svg evs-site-shape" viewBox="0 0 28 28" width={size} height={size} aria-hidden="true" focusable="false">
      <rect x="3" y="3" width="22" height="22" rx="4" fill="var(--evs-color-link)" stroke="var(--evs-status-stroke)" strokeWidth="2" />
      <path d="M8 19h12M9.5 19v-6.5h9V19M14 12.5V8.5" fill="none" stroke="#ffffff" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round" />
    </svg>
  );
}

const NAV_KEYS = ["ArrowRight", "ArrowDown", "ArrowLeft", "ArrowUp", "Home", "End"];

/**
 * MapLibre map with HTML marker buttons (44 x 44 CSS px, status shape inside, accessible name, tooltip on hover
 * and focus). Markers sit in the DOM in the order given, so Tab and the arrow keys traverse them in river-mile
 * order. The PMTiles basemap is used when /tiles/usace.pmtiles answers a HEAD request, else OSM raster tiles.
 * Without WebGL the map is replaced by a sentence pointing to the table alternative.
 */
export function AccessibleMap({ points, selectedId, onSelect, label, alternativeText, className }: AccessibleMapProps) {
  const container = useRef<HTMLDivElement>(null);
  const mapRef = useRef<MapLibreMap | null>(null);
  const [mode, setMode] = useState<Mode>("loading");
  const [ready, setReady] = useState(false);
  const [placed, setPlaced] = useState<Placed[]>([]);
  const reduced = useReducedMotion();
  const reducedRef = useRef(reduced);
  reducedRef.current = reduced;

  useEffect(() => {
    const node = container.current;
    if (!node) return;
    if (typeof window === "undefined" || !("WebGLRenderingContext" in window)) {
      setMode("unsupported");
      return;
    }
    let cancelled = false;
    let map: MapLibreMap | null = null;
    void chooseBasemap().then(({ style, mode: picked }) => {
      if (cancelled) return;
      try {
        map = new maplibregl.Map({
          container: node,
          style,
          bounds: CONUS,
          fitBoundsOptions: { padding: 16 },
          attributionControl: { compact: false },
          fadeDuration: reducedRef.current ? 0 : 300,
        });
      } catch {
        setMode("unsupported");
        return;
      }
      map.addControl(new maplibregl.NavigationControl({ showCompass: false, visualizePitch: false }), "top-right");
      map.on("load", () => {
        if (!cancelled) setReady(true);
      });
      mapRef.current = map;
      setMode(picked);
    });
    return () => {
      cancelled = true;
      setReady(false);
      map?.remove();
      mapRef.current = null;
    };
  }, []);

  useEffect(() => {
    const map = mapRef.current;
    if (!map || !ready) return;
    const next: Placed[] = points.map((point) => {
      const el = document.createElement("div");
      el.className = "evs-mapmarker-wrap";
      const marker = new maplibregl.Marker({ element: el, anchor: "center" }).setLngLat([point.longitude, point.latitude]).addTo(map);
      el.removeAttribute("aria-label");
      el.removeAttribute("tabindex");
      el.removeAttribute("role");
      return { point, el, marker };
    });
    setPlaced(next);
    if (next.length > 0) {
      const bounds = new maplibregl.LngLatBounds();
      for (const p of next) bounds.extend([p.point.longitude, p.point.latitude]);
      map.fitBounds(bounds, { padding: 48, maxZoom: 9, animate: !reducedRef.current, duration: reducedRef.current ? 0 : 600 });
    }
    return () => {
      for (const p of next) p.marker.remove();
    };
  }, [points, ready]);

  useEffect(() => {
    const map = mapRef.current;
    if (!map || !ready || !selectedId) return;
    const p = points.find((x) => x.id === selectedId);
    if (!p) return;
    const center: [number, number] = [p.longitude, p.latitude];
    if (map.getBounds().contains(center)) return;
    if (reducedRef.current) map.jumpTo({ center });
    else map.easeTo({ center, duration: 500 });
  }, [selectedId, points, ready]);

  const onMarkerKey = (e: KeyboardEvent<HTMLButtonElement>) => {
    if (!NAV_KEYS.includes(e.key)) return;
    const buttons = Array.from(container.current?.querySelectorAll<HTMLButtonElement>("button.evs-mapmarker") ?? []);
    const i = buttons.indexOf(e.currentTarget);
    if (i < 0) return;
    e.preventDefault();
    const last = buttons.length - 1;
    const target =
      e.key === "Home" ? 0
      : e.key === "End" ? last
      : e.key === "ArrowRight" || e.key === "ArrowDown" ? Math.min(last, i + 1)
      : Math.max(0, i - 1);
    buttons[target]?.focus();
  };

  const unsupported = mode === "unsupported";
  return (
    <div className={["evs-map", className].filter(Boolean).join(" ")} role="region" aria-label={label} data-testid="accessible-map" data-mode={mode}>
      <div ref={container} className="evs-map__canvas" aria-busy={mode === "loading"} hidden={unsupported} />
      {unsupported && (
        <p className="evs-map__fallback" role="status">
          The map needs WebGL, which this browser does not provide. {alternativeText}
        </p>
      )}
      {mode === "raster" && <p className="evs-map__mode">Basemap: OpenStreetMap raster tiles (PMTiles file not found)</p>}
      <p className="evs-map__hint">
        {points.length} markers. Tab or the arrow keys move between markers in river-mile order; Enter or click opens the detail panel; Escape closes it. {alternativeText}
      </p>
      {placed.map(({ point, el }) =>
        createPortal(<MarkerButton key={point.id} point={point} selected={point.id === selectedId} onSelect={onSelect} onKeyDown={onMarkerKey} />, el, point.id),
      )}
    </div>
  );
}

interface MarkerButtonProps {
  point: MapPoint;
  selected: boolean;
  onSelect: (id: string, trigger: HTMLElement) => void;
  onKeyDown: (e: KeyboardEvent<HTMLButtonElement>) => void;
}

function MarkerButton({ point, selected, onSelect, onKeyDown }: MarkerButtonProps) {
  const tipId = useId();
  const [tip, setTip] = useState(false);
  const [placement, setPlacement] = useState("");
  const inner = useRef<HTMLDivElement>(null);
  const tipBox = useRef<HTMLDivElement>(null);
  // Keep the tooltip inside the map: flip below the marker near the top edge, hug the marker's side near the left or
  // right edge. MapLibre clips anything that leaves the map container.
  useLayoutEffect(() => {
    if (!tip) {
      setPlacement("");
      return;
    }
    const button = inner.current?.querySelector("button");
    const box = tipBox.current;
    const host = inner.current?.closest(".maplibregl-map") ?? inner.current?.closest(".evs-map");
    if (!button || !box || !host) return;
    const b = button.getBoundingClientRect();
    const h = host.getBoundingClientRect();
    const t = box.getBoundingClientRect();
    const classes: string[] = [];
    if (b.top - h.top < t.height + 8) classes.push("evs-maptip--below");
    const centre = b.left + b.width / 2;
    if (centre + t.width / 2 > h.right - 4) classes.push("evs-maptip--end");
    else if (centre - t.width / 2 < h.left + 4) classes.push("evs-maptip--start");
    setPlacement(classes.join(" "));
  }, [tip]);
  useEffect(() => {
    const wrap = inner.current?.parentElement;
    if (wrap) wrap.style.zIndex = tip || selected ? "5" : "";
  }, [tip, selected]);
  // Hover is tracked on the wrapper (button plus tooltip) so the pointer can move onto the tooltip without it closing.
  useEffect(() => {
    const node = inner.current;
    if (!node) return;
    const show = () => setTip(true);
    const hide = () => setTip(false);
    node.addEventListener("mouseenter", show);
    node.addEventListener("mouseleave", hide);
    return () => {
      node.removeEventListener("mouseenter", show);
      node.removeEventListener("mouseleave", hide);
    };
  }, []);
  return (
    <div ref={inner} className="evs-mapmarker-inner">
      <button
        type="button"
        className="evs-mapmarker"
        aria-label={point.name}
        aria-describedby={tipId}
        aria-current={selected ? "true" : undefined}
        onClick={(e) => onSelect(point.id, e.currentTarget)}
        onFocus={() => setTip(true)}
        onBlur={() => setTip(false)}
        onKeyDown={(e) => {
          if (e.key === "Escape") {
            setTip(false);
            return;
          }
          onKeyDown(e);
        }}
      >
        {point.shape}
      </button>
      <div role="tooltip" id={tipId} ref={tipBox} className={["evs-maptip", placement].filter(Boolean).join(" ")} hidden={!tip}>
        <div className="evs-maptip__box">{point.tooltip}</div>
      </div>
    </div>
  );
}
