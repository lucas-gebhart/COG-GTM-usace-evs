// USWDS fonts and images are not exported as package subpaths, so copy them into public/uswds.
import { cpSync, mkdirSync } from "node:fs";
import { join } from "node:path";

const dist = join(process.cwd(), "node_modules/@uswds/uswds/dist");
mkdirSync("public/uswds", { recursive: true });
for (const dir of ["fonts", "img"]) cpSync(join(dist, dir), join("public/uswds", dir), { recursive: true });
console.log("copied USWDS fonts and img to public/uswds");
