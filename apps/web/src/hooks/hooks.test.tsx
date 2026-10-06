import { renderHook, waitFor } from "@testing-library/react";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import type { ReactNode } from "react";
import { server } from "../mocks/server";
import { useLocks, useProject, useProjects, unwrap, ApiError } from "./useApi";
import { useSse } from "./useSse";
import { fixtures } from "../mocks/fixtures";

beforeAll(() => server.listen({ onUnhandledRequest: "error" }));
afterEach(() => server.resetHandlers());
afterAll(() => server.close());

const qc = new QueryClient({ defaultOptions: { queries: { retry: false } } });
afterEach(() => qc.clear());
function wrapper({ children }: { children: ReactNode }) {
  return <QueryClientProvider client={qc}>{children}</QueryClientProvider>;
}

describe("useApi against MSW fixtures", () => {
  it("loads locks and filters by river like the API router", async () => {
    const all = renderHook(() => useLocks(), { wrapper });
    await waitFor(() => expect(all.result.current.isSuccess).toBe(true));
    expect(all.result.current.data?.items).toHaveLength(fixtures.locks.items.length);
    expect(all.result.current.data?.as_of.source).toBe("fixtures");

    const mi = renderHook(() => useLocks("MI"), { wrapper });
    await waitFor(() => expect(mi.result.current.isSuccess).toBe(true));
    expect(mi.result.current.data?.items.every((i) => i.river_code === "MI")).toBe(true);
  });

  it("paginates projects and surfaces 404 as ApiError", async () => {
    const page = renderHook(() => useProjects({ limit: 5, offset: 5 }), { wrapper });
    await waitFor(() => expect(page.result.current.isSuccess).toBe(true));
    expect(page.result.current.data?.items).toHaveLength(5);
    expect(page.result.current.data?.page.total).toBe(fixtures.projects.length);

    const missing = renderHook(() => useProject("nope"), { wrapper });
    await waitFor(() => expect(missing.result.current.isError).toBe(true));
    expect(missing.result.current.error).toBeInstanceOf(ApiError);
    expect(missing.result.current.error?.status).toBe(404);
  });

  it("unwrap throws ApiError with a reference id", () => {
    expect(() => unwrap({ error: { detail: "boom" }, response: new Response(null, { status: 500 }) })).toThrowError(/boom/);
    try {
      unwrap({ error: { detail: "boom" }, response: new Response(null, { status: 500 }) });
    } catch (e) {
      expect((e as ApiError).referenceId).toMatch(/^EVS-/);
    }
  });
});

describe("useSse", () => {
  class FakeSource {
    static instances: FakeSource[] = [];
    static CONNECTING = 0;
    static OPEN = 1;
    static CLOSED = 2;
    readyState = 0;
    onopen: (() => void) | null = null;
    onmessage: ((e: MessageEvent) => void) | null = null;
    onerror: (() => void) | null = null;
    listeners = new Map<string, EventListener>();
    constructor(public url: string) {
      FakeSource.instances.push(this);
    }
    addEventListener(name: string, fn: EventListener) {
      this.listeners.set(name, fn);
    }
    close() {
      this.readyState = 2;
    }
  }

  beforeEach(() => {
    FakeSource.instances = [];
    vi.stubGlobal("EventSource", FakeSource);
    vi.useFakeTimers();
  });
  afterEach(() => {
    vi.unstubAllGlobals();
    vi.useRealTimers();
  });

  it("reports status, parses named events and reconnects with backoff after the server closes", async () => {
    const onEvent = vi.fn();
    const { result } = renderHook(() => useSse<{ counts: Record<string, number> }>("/api/v1/public/locks/stream/events", { events: ["locks"], onEvent, minDelayMs: 100 }));
    expect(result.current.status).toBe("connecting");
    const src = FakeSource.instances[0];

    await vi.waitFor(() => {
      src.readyState = 1;
      src.onopen?.();
      expect(result.current.status).toBe("open");
    });

    const payload = { counts: { operating: 57 } };
    src.listeners.get("locks")?.(new MessageEvent("locks", { data: JSON.stringify(payload), lastEventId: "1" }));
    await vi.waitFor(() => expect(result.current.lastEvent?.data).toEqual(payload));
    expect(onEvent).toHaveBeenCalledTimes(1);

    src.readyState = 2;
    src.onerror?.();
    await vi.waitFor(() => expect(result.current.status).toBe("reconnecting"));
    expect(result.current.attempts).toBe(1);
    vi.advanceTimersByTime(100);
    await vi.waitFor(() => expect(FakeSource.instances).toHaveLength(2));
    expect(FakeSource.instances[0].readyState).toBe(2);
  });

  it("pauses and resumes", async () => {
    const { result } = renderHook(() => useSse("/stream"));
    expect(FakeSource.instances).toHaveLength(1);
    result.current.pause();
    await vi.waitFor(() => expect(result.current.status).toBe("paused"));
    expect(FakeSource.instances[0].readyState).toBe(2);
    result.current.resume();
    await vi.waitFor(() => expect(FakeSource.instances).toHaveLength(2));
  });
});
