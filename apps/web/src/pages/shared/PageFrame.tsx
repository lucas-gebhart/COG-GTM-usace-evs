import type { ReactNode } from "react";
import type { UseQueryResult } from "@tanstack/react-query";
import { routes } from "../../app/routes";
import { PageHeader, type Crumb } from "../../components/PageHeader";
import { SkeletonLoader } from "../../components/SkeletonLoader";
import { ErrorState } from "../../components/ErrorState";
import { EmptyState } from "../../components/EmptyState";

export type RoutePath = (typeof routes)[number]["path"];

export function findRoute(path: RoutePath) {
  return routes.find((r) => r.path === path) ?? routes[0];
}

/** Traceability tag at the foot of every migrated page, driven by routes.ts (legacy/mapping.json holds the region detail). */
export function ApexFooterTag({ path }: { path: RoutePath }) {
  const route = findRoute(path);
  return (
    <p className="evs-apex-tag" data-testid="apex-tag">
      {route.apexPage ? `Migrated from APEX page ${route.apexPage}` : "New in EVS, no APEX source page"}
      <span className="evs-apex-tag__sep" aria-hidden="true">|</span>
      Synthetic demo data unless the badge says otherwise
    </p>
  );
}

export interface PageFrameProps {
  path: RoutePath;
  /** Overrides the route title (project detail shows the project name). */
  title?: string;
  intro?: string;
  breadcrumbs?: Crumb[];
  actions?: ReactNode;
  headerChildren?: ReactNode;
  children: ReactNode;
}

/** USWDS page scaffold: single h1 from routes.ts, optional intro and actions, APEX provenance footer tag. */
export function PageFrame({ path, title, intro, breadcrumbs, actions, headerChildren, children }: PageFrameProps) {
  const route = findRoute(path);
  return (
    <>
      <PageHeader title={title ?? route.title} intro={intro} breadcrumbs={breadcrumbs} actions={actions}>
        {headerChildren}
      </PageHeader>
      {children}
      <ApexFooterTag path={path} />
    </>
  );
}

export interface QueryBoundaryProps<T> {
  query: UseQueryResult<T, Error>;
  /** Announced while loading, for example "Loading programs". */
  label: string;
  variant?: "text" | "kpi" | "chart" | "table";
  isEmpty?: (data: T) => boolean;
  emptyTitle?: string;
  emptyMessage?: string;
  emptyAction?: ReactNode;
  children: (data: T) => ReactNode;
}

/** Loading, error and empty states from the component kit around one TanStack query. */
export function QueryBoundary<T>({ query, label, variant = "table", isEmpty, emptyTitle, emptyMessage = "No rows match the current filters.", emptyAction, children }: QueryBoundaryProps<T>) {
  if (query.isPending) return <SkeletonLoader label={label} variant={variant} />;
  if (query.isError) return <ErrorState error={query.error} onRetry={() => void query.refetch()} />;
  if (isEmpty?.(query.data)) return <EmptyState title={emptyTitle} message={emptyMessage} action={emptyAction} />;
  return <>{children(query.data)}</>;
}
