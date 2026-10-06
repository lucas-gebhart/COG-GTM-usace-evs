import { useParams } from "react-router";
import { AsOfBadge } from "../../components/AsOfBadge";
import { ErrorState } from "../../components/ErrorState";
import { PageHeader } from "../../components/PageHeader";
import { SkeletonLoader } from "../../components/SkeletonLoader";
import { useLock } from "../../hooks/useApi";
import { LockDetailPanel } from "./LockDetailPanel";

/** /public/locks/:id, the detail panel as a full page for deep links. */
export function LockDetailPage() {
  const { id = "" } = useParams();
  const q = useLock(id);
  const crumbs = [{ label: "Lock status by river", to: "/public/locks" }, { label: q.data ? q.data.lock_name : `Lock ${id}` }];
  if (q.isPending) {
    return (
      <div className="evs-page">
        <PageHeader title={`Lock ${id}`} breadcrumbs={crumbs} />
        <SkeletonLoader label="Loading lock detail" variant="text" lines={8} />
      </div>
    );
  }
  if (q.isError) {
    return (
      <div className="evs-page">
        <PageHeader title={`Lock ${id}`} breadcrumbs={crumbs} />
        <ErrorState message={q.error.status === 404 ? `No lock with ID ${id} is known to this demo. Choose one from the lock status table.` : "This lock could not be loaded."} error={q.error} onRetry={() => q.refetch()} headingLevel={2} />
      </div>
    );
  }
  return (
    <div className="evs-page">
      <PageHeader title={`${q.data.lock_name}, ${q.data.river_name}`} intro={`${q.data.lock_id}${q.data.river_mile != null ? `, river mile ${q.data.river_mile}` : ""}`} breadcrumbs={crumbs} actions={<AsOfBadge asOf={q.data.as_of} />} />
      <div className="evs-layout">
        <LockDetailPanel lockId={id} summary={q.data} headingLevel={2} />
      </div>
    </div>
  );
}
