import type { Meta, StoryObj } from "@storybook/react-vite";
import type { ColumnDef } from "@tanstack/react-table";
import { useLocks, useFinancialSummary, type Schemas } from "../hooks/useApi";
import { DataTable } from "../components/DataTable";
import { StatusChip } from "../components/StatusChip";
import { AsOfBadge } from "../components/AsOfBadge";
import { KpiTile } from "../components/KpiTile";
import { SkeletonLoader } from "../components/SkeletonLoader";
import { ErrorState } from "../components/ErrorState";
import { formatCurrency } from "../lib/format";

type Lock = Schemas["LockSummary"];

const columns: ColumnDef<Lock, unknown>[] = [
  { accessorKey: "lock_name", header: "Lock" },
  { accessorKey: "river_name", header: "River" },
  { accessorKey: "status", header: "Status", cell: (c) => <StatusChip status={c.getValue<string>()} /> },
  { accessorKey: "vessels_queued", header: "Vessels queued", meta: { numeric: true } },
];

/** Exercises the hooks against the MSW handlers generated from apps/api/fixtures. */
function LocksFromApi({ river }: { river?: string }) {
  const q = useLocks(river);
  if (q.isPending) return <SkeletonLoader label="Loading lock status" variant="table" />;
  if (q.isError) return <ErrorState error={q.error} onRetry={() => q.refetch()} />;
  return (
    <>
      <div className="evs-grid evs-grid--kpis margin-bottom-2">
        <KpiTile label="Operating" value={String(q.data.counts.operating)} deltaPct={null} />
        <KpiTile label="Delayed" value={String(q.data.counts.delayed)} deltaPct={null} />
        <KpiTile label="Closed" value={String(q.data.counts.closed)} deltaPct={null} />
        <KpiTile label="Stale" value={String(q.data.counts.stale)} deltaPct={null} />
      </div>
      <DataTable caption="Lock status (from mock API)" captionMeta={<AsOfBadge asOf={q.data.as_of} tickMs={0} />} columns={columns} data={q.data.items} getRowId={(r) => r.lock_id} pageSize={10} />
    </>
  );
}

function FinancialFromApi() {
  const q = useFinancialSummary();
  if (q.isPending) return <SkeletonLoader label="Loading financial summary" variant="kpi" />;
  if (q.isError) return <ErrorState error={q.error} onRetry={() => q.refetch()} />;
  const last = q.data.execution_curve.at(-1)!;
  const delta = ((last.obligated_cumulative - last.plan_cumulative) / last.plan_cumulative) * 100;
  return <KpiTile label={`Obligated, FY${q.data.fiscal_year}`} value={formatCurrency(last.obligated_cumulative)} deltaPct={Number(delta.toFixed(1))} context={`Plan ${formatCurrency(last.plan_cumulative)}`} />;
}

const meta = {
  title: "Mock mode/Hooks against MSW",
  parameters: { layout: "padded" },
} satisfies Meta;
export default meta;
type Story = StoryObj;

export const Locks: Story = { render: () => <LocksFromApi /> };
export const LocksMississippi: Story = { render: () => <LocksFromApi river="MI" /> };
export const Financial: Story = { render: () => <FinancialFromApi /> };
