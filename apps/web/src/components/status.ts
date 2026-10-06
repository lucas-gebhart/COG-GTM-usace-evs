export const STATUS_VALUES = ["operating", "delayed", "closed", "stale", "unknown"] as const;
export type StatusValue = (typeof STATUS_VALUES)[number];

export interface StatusMeta {
  label: string;
  /** Shape named in the accessible description so the encoding is explicit for screen readers. */
  shape: string;
  description: string;
}

export const STATUS_META: Record<StatusValue, StatusMeta> = {
  operating: { label: "Operating", shape: "green circle", description: "Operating, normal service" },
  delayed: { label: "Delayed", shape: "yellow triangle", description: "Delayed, reduced service or queue" },
  closed: { label: "Closed", shape: "red octagon", description: "Closed, no service" },
  stale: { label: "Stale", shape: "grey hatched ring", description: "Stale, the feed has not refreshed in time" },
  unknown: { label: "Unknown", shape: "grey diamond", description: "Unknown, no status reported" },
};

export function normalizeStatus(value: string | null | undefined): StatusValue {
  const v = (value ?? "").toLowerCase();
  return (STATUS_VALUES as readonly string[]).includes(v) ? (v as StatusValue) : "unknown";
}
