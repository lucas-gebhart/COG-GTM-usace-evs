import { useEffect, useRef } from "react";
import { NavLink, Outlet, useLocation } from "react-router";
import { GovBanner, Header, Title, PrimaryNav, GridContainer } from "@trussworks/react-uswds";
import { routes } from "./routes";

const NAV = routes.filter((r) => !r.path.includes(":"));

export function AppLayout() {
  const location = useLocation();
  const main = useRef<HTMLElement>(null);
  const first = useRef(true);
  useEffect(() => {
    // Move focus to main on client-side navigation so screen readers announce the new page (WCAG 2.4.3).
    if (first.current) { first.current = false; return; }
    main.current?.focus();
  }, [location.pathname]);
  const current = routes.find((r) => r.path === location.pathname) ?? routes[0];
  useEffect(() => { document.title = `${current.title} | EVS`; }, [current.title]);

  return (
    <>
      <a className="usa-skipnav evs-skipnav" href="#main-content">Skip to main content</a>
      <GovBanner aria-label="Official website of the United States government" />
      <Header basic>
        <div className="usa-nav-container">
          <div className="usa-navbar">
            <Title><NavLink to="/">EVS <span className="text-normal">Enterprise Visibility Suite</span></NavLink></Title>
          </div>
          <PrimaryNav
            items={NAV.map((r) => (
              <NavLink key={r.path} to={r.path} className="usa-nav-link" end={r.path === "/"}>
                {r.title}
              </NavLink>
            ))}
            mobileExpanded={false}
            onToggleMobileNav={() => {}}
          />
        </div>
      </Header>
      <main id="main-content" ref={main} tabIndex={-1} className="evs-main">
        <GridContainer className="padding-y-3">
          <Outlet />
        </GridContainer>
      </main>
      <footer className="usa-footer usa-footer--slim">
        <GridContainer className="padding-y-2 font-body-3xs text-base-dark">
          Demo environment. Public lock data from USACE LPMS; financial, labor, schedule and facility data are synthetic.
        </GridContainer>
      </footer>
    </>
  );
}
