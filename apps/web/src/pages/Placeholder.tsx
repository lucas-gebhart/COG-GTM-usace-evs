import { useQuery } from "@tanstack/react-query";
import { api } from "../api/client";

export function Placeholder({ title }: { title: string }) {
  const health = useQuery({
    queryKey: ["health"],
    queryFn: async () => (await api.GET("/api/v1/health")).data,
  });
  return (
    <section aria-labelledby="page-title">
      <h1 id="page-title">{title}</h1>
      <p className="usa-intro">This page is scaffolded. Its work package replaces this component.</p>
      <p className="font-body-2xs" aria-live="polite">
        API: {health.isLoading ? "checking" : health.data ? `${health.data.status} (${health.data.env}, feeds=${health.data.feed_source})` : "unavailable"}
      </p>
    </section>
  );
}
