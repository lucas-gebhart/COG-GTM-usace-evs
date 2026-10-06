import { useMediaQuery } from "./useMediaQuery";

/** True when the OS asks for reduced motion; charts then render without transitions (2.2.2, 2.3.1). */
export function useReducedMotion(): boolean {
  return useMediaQuery("(prefers-reduced-motion: reduce)");
}
