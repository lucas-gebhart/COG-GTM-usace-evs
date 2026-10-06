import { rmSync } from "node:fs";
import { resolve } from "node:path";
import { RESULTS_DIR } from "./matrix";

// Remove per-cell results from earlier runs so the ACR generator never merges stale evidence.
export default function globalSetup(): void {
  for (const dir of ["axe", "keyboard", "reflow"]) rmSync(resolve(RESULTS_DIR, dir), { recursive: true, force: true });
}
