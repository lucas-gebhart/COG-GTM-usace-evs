import { useEffect, useRef, useState } from "react";
import { NavLink, Outlet, useLocation } from "react-router";
import { GovBanner, GridContainer, Header, NavMenuButton, PrimaryNav, Title } from "@trussworks/react-uswds";
import { routes } from "./routes";
import { ThemeToggle } from "../components/ThemeToggle";
import { LiveRegionProvider } from "../hooks/useAnnounce";

const NAV = routes.filter((r) => !r.path.includes(":"));

function matchRoute(pathname: string) {
  const exact = routes.find((r) => r.path === pathname);
  if (exact) return exact;
  const dynamic = routes.find((r) => {
    if (!r.path.includes(":")) return false;
    const re = new RegExp("^" + r.path.replace(/:[^/]+/g, "[^/]+") + "$");
    return re.test(pathname);
  });
  return dynamic ?? routes[0];
}

/**
 * Responsive shell: skip link, gov banner, header with a mobile menu that opens and closes, aria-current
 * on the active page, focus moved to <main> on route change, global live regions, provenance footer.
 */
export function AppLayout() {
  const location = useLocation();
  const main = useRef<HTMLElement>(null);
  const first = useRef(true);
  const [mobileOpen, setMobileOpen] = useState(false);

  useEffect(() => {
    setMobileOpen(false);
    if (first.current) {
      first.current = false;
      return;
    }
    main.current?.focus();
  }, [location.pathname]);

  useEffect(() => {
    if (!mobileOpen) return;
    const onKey = (e: KeyboardEvent) => {
      if (e.key === "Escape") setMobileOpen(false);
    };
    document.addEventListener("keydown", onKey);
    document.body.classList.add("usa-js-mobile-nav--active");
    return () => {
      document.removeEventListener("keydown", onKey);
      document.body.classList.remove("usa-js-mobile-nav--active");
    };
  }, [mobileOpen]);

  const current = matchRoute(location.pathname);
  useEffect(() => {
    document.title = `${current.title} | EVS`;
  }, [current.title]);

  return (
    <LiveRegionProvider>
      <a className="usa-skipnav evs-skipnav" href="#main-content">
        Skip to main content
      </a>
      <GovBanner aria-label="Official website of the United States government" />
      <div className={`usa-overlay evs-nav-overlay ${mobileOpen ? "is-visible" : "evs-nav-overlay--hidden"}`} onClick={() => setMobileOpen(false)} aria-hidden="true" />
      <Header basic className="evs-header">
        <div className="usa-nav-container">
          <div className="usa-navbar">
            <Title>
              <NavLink to="/" aria-label="EVS, Enterprise Visibility Suite, home">
                EVS <span className="text-normal">Enterprise Visibility Suite</span>
              </NavLink>
            </Title>
            <NavMenuButton label="Menu" onClick={() => setMobileOpen(true)} aria-expanded={mobileOpen} aria-controls="evs-primary-nav" />
          </div>
          <PrimaryNav
            id="evs-primary-nav"
            aria-label="Primary"
            items={NAV.map((r) => (
              <NavLink key={r.path} to={r.path} className="usa-nav-link" end={r.path === "/"}>
                <span>{r.title}</span>
              </NavLink>
            ))}
            mobileExpanded={mobileOpen}
            onToggleMobileNav={() => setMobileOpen(false)}
          >
            <div className="evs-header__tools">
              <ThemeToggle compact />
            </div>
          </PrimaryNav>
        </div>
      </Header>
      <main id="main-content" ref={main} tabIndex={-1} className="evs-main">
        <GridContainer className="padding-y-3">
          <Outlet />
        </GridContainer>
      </main>
      <footer className="usa-footer usa-footer--slim evs-footer" aria-label="Data provenance">
        <GridContainer className="padding-y-2">
          <dl className="evs-footer__provenance">
            <dt>Public data</dt>
            <dd>USACE Lock Performance Monitoring System (LPMS) and Sustainable Rivers Program documents.</dd>
            <dt>Synthetic data</dt>
            <dd>CEFMS financial, EMS labor, P2 schedule and BUILDER facility rows are generated for this demo and carry source "synthetic" or "simulated".</dd>
            <dt>Status</dt>
            <dd>Demo environment, not an operational USACE system.</dd>
          </dl>
        </GridContainer>
      </footer>
    </LiveRegionProvider>
  );
}
