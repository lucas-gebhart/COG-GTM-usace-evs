import type { Meta, StoryObj } from "@storybook/react-vite";
import { useState } from "react";
import { FilterBar, type FilterValues } from "./FilterBar";
import { fixtures } from "../mocks/fixtures";
import { leadershipStory, narrow } from "../stories/decorators";

const districts = [...new Set(fixtures.projects.map((p) => p.district))].sort().map((d) => ({ value: d, label: d }));
const phases = [...new Set(fixtures.projects.map((p) => p.phase))].sort().map((d) => ({ value: d, label: d }));

function Demo({ initial = {} }: { initial?: FilterValues }) {
  const [values, setValues] = useState<FilterValues>(initial);
  const count = fixtures.projects.filter((p) => (!values.district || p.district === values.district) && (!values.phase || p.phase === values.phase) && (!values.q || p.name.toLowerCase().includes(values.q.toLowerCase()))).length;
  return (
    <FilterBar
      legend="Filter projects"
      fields={[
        { id: "q", label: "Project name", type: "search", placeholder: "Contains" },
        { id: "district", label: "District", options: districts },
        { id: "phase", label: "Phase", options: phases },
      ]}
      values={values}
      onApply={setValues}
      resultCount={count}
      resultNoun="projects"
    />
  );
}

const meta = {
  title: "Components/FilterBar",
  tags: ["autodocs"],
  parameters: { layout: "padded" },
  render: () => <Demo />,
} satisfies Meta;
export default meta;
type Story = StoryObj<typeof meta>;

export const Default: Story = {};
export const WithActiveFilters: Story = { render: () => <Demo initial={{ district: "LRN" }} /> };
export const Narrow360: Story = { decorators: [narrow(360)] };
export const DefaultLeadership = leadershipStory(Default);
