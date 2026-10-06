import type { Meta, StoryObj } from "@storybook/react-vite";
import type { ColumnDef } from "@tanstack/react-table";
import { fn } from "storybook/test";
import { DataTable } from "./DataTable";
import { StatusChip } from "./StatusChip";
import { fixtures } from "../mocks/fixtures";
import { formatCurrency, formatDate, formatNumber } from "../lib/format";
import { leadershipStory, narrow } from "../stories/decorators";

type Project = (typeof fixtures.projects)[number];
type Lock = (typeof fixtures.locks.items)[number];

const projectColumns: ColumnDef<Project, unknown>[] = [
  { accessorKey: "name", header: "Project" },
  { accessorKey: "p2_project_no", header: "P2 number" },
  { accessorKey: "district", header: "District" },
  { accessorKey: "phase", header: "Phase" },
  { accessorKey: "pct_complete", header: "Percent complete", meta: { numeric: true }, cell: (c) => formatNumber(c.getValue<number>()), enableColumnFilter: false },
  { accessorKey: "funded_amount", header: "Funded", meta: { numeric: true }, cell: (c) => formatCurrency(c.getValue<number>()), enableColumnFilter: false },
  { accessorKey: "current_finish", header: "Current finish", cell: (c) => formatDate(c.getValue<string>()), enableColumnFilter: false },
];

const lockColumns: ColumnDef<Lock, unknown>[] = [
  { accessorKey: "lock_name", header: "Lock" },
  { accessorKey: "river_name", header: "River" },
  { accessorKey: "status", header: "Status", cell: (c) => <StatusChip status={c.getValue<string>()} /> },
  { accessorKey: "vessels_queued", header: "Vessels queued", meta: { numeric: true }, enableColumnFilter: false },
  { accessorKey: "avg_delay_24h_min", header: "Avg delay 24 h (min)", meta: { numeric: true }, cell: (c) => formatNumber(c.getValue<number | null>()), enableColumnFilter: false },
];

const meta = {
  title: "Components/DataTable",
  component: DataTable,
  tags: ["autodocs"],
  parameters: { layout: "padded" },
} satisfies Meta<typeof DataTable>;
export default meta;
type Story = StoryObj<Meta<typeof DataTable<Project>>>;

export const Projects: Story = {
  args: {
    caption: "Projects",
    captionMeta: "101 synthetic projects, source synthetic",
    columns: projectColumns,
    data: fixtures.projects,
    getRowId: (r) => r.p2_project_no,
    getRowHref: (r) => `/projects/${r.p2_project_no}`,
    enableFilters: true,
    pageSize: 10,
  },
};

export const WithRowActivate: Story = {
  args: { ...Projects.args, getRowHref: undefined, onRowActivate: fn() },
};

export const Locks: StoryObj<Meta<typeof DataTable<Lock>>> = {
  args: {
    caption: "Lock status by river",
    columns: lockColumns,
    data: fixtures.locks.items,
    getRowId: (r) => r.lock_id,
    getRowHref: (r) => `/public/locks/${r.lock_id}`,
    initialSorting: [{ id: "status", desc: false }],
    pageSize: 25,
  },
};

export const CardMode360: Story = { args: { ...Projects.args, stacked: true, pageSize: 5 }, decorators: [narrow(360)] };
export const Empty: Story = { args: { ...Projects.args, data: [] } };
export const ProjectsLeadership = leadershipStory(Projects);
export const CardModeLeadership = leadershipStory(CardMode360);
