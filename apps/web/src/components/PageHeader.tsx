import type { ReactNode } from "react";
import { Link } from "react-router";
import { Breadcrumb, BreadcrumbBar } from "@trussworks/react-uswds";

export interface Crumb {
  label: string;
  to?: string;
}

export interface PageHeaderProps {
  title: string;
  intro?: string;
  /** Trail ending in the current page; the last item renders without a link and with aria-current. */
  breadcrumbs?: Crumb[];
  /** Right-aligned controls (AsOfBadge, RefreshControl, export). */
  actions?: ReactNode;
  children?: ReactNode;
}

/** One h1 per route plus intro and breadcrumb (section 1.2.5 heading model). */
export function PageHeader({ title, intro, breadcrumbs, actions, children }: PageHeaderProps) {
  return (
    <header className="evs-page-header">
      {breadcrumbs && breadcrumbs.length > 0 && (
        <BreadcrumbBar>
          {breadcrumbs.map((c, i) => {
            const current = i === breadcrumbs.length - 1;
            return (
              <Breadcrumb key={`${c.label}-${i}`} current={current}>
                {current || !c.to ? (
                  <span>{c.label}</span>
                ) : (
                  <Link className="usa-breadcrumb__link" to={c.to}>
                    <span>{c.label}</span>
                  </Link>
                )}
              </Breadcrumb>
            );
          })}
        </BreadcrumbBar>
      )}
      <div className="evs-page-header__row">
        <div>
          <h1>{title}</h1>
          {intro && <p className="evs-page-header__intro">{intro}</p>}
        </div>
        {actions && <div className="evs-page-header__actions">{actions}</div>}
      </div>
      {children}
    </header>
  );
}
