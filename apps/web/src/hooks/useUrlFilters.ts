import { useCallback, useMemo } from "react";
import { useSearchParams } from "react-router";
import type { FilterValues } from "../components/FilterBar";

/**
 * Interactive Report style saved filters: the applied filter values live in the URL search params so a
 * filtered view can be bookmarked or shared. Only `keys` are read and written; other params are kept.
 */
export function useUrlFilters(keys: readonly string[]): { values: FilterValues; apply: (next: FilterValues) => void; reset: () => void } {
  const [params, setParams] = useSearchParams();
  const values = useMemo(() => {
    const out: FilterValues = {};
    for (const k of keys) {
      const v = params.get(k);
      if (v) out[k] = v;
    }
    return out;
  }, [params, keys]);
  const apply = useCallback(
    (next: FilterValues) => {
      setParams(
        (prev) => {
          const p = new URLSearchParams(prev);
          for (const k of keys) {
            const v = next[k];
            if (v) p.set(k, v);
            else p.delete(k);
          }
          return p;
        },
        { replace: true },
      );
    },
    [keys, setParams],
  );
  const reset = useCallback(() => apply({}), [apply]);
  return { values, apply, reset };
}
