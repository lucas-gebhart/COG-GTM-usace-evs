import { describeDelta, formatCurrency, formatPercent, formatRelative, minutesSince } from "./format";
import { toCsv, slugify } from "./csv";

describe("format", () => {
  it("formats currency compactly and percentages with a sign", () => {
    expect(formatCurrency(1_420_000_000)).toBe("$1.42B");
    expect(formatPercent(-3.1, true)).toBe("-3.1%");
    expect(formatPercent(0.024)).toBe("+2.4%");
    expect(formatCurrency(null)).toBe("n/a");
  });
  it("describes relative time and deltas in words", () => {
    const now = new Date("2026-10-06T15:00:00Z");
    expect(formatRelative("2026-10-06T14:56:00Z", now)).toBe("4 minutes ago");
    expect(formatRelative("2026-10-06T12:00:00Z", now)).toBe("3 hours ago");
    expect(minutesSince("2026-10-06T14:40:00Z", now)).toBe(20);
    expect(describeDelta(-3.1, "vs plan")).toBe("down 3.1% vs plan");
    expect(describeDelta(0, "vs plan")).toBe("unchanged vs plan");
  });
});

describe("csv", () => {
  it("escapes quotes, commas and newlines", () => {
    const csv = toCsv([{ a: 'He said "hi"', b: "x,y", c: "line\nbreak" }], [{ key: "a", header: "A" }, { key: "b", header: "B" }, { key: "c", header: "C" }]);
    expect(csv).toBe('A,B,C\r\n"He said ""hi""","x,y","line\nbreak"\r\n');
  });
  it("slugifies titles", () => {
    expect(slugify("FY26 execution curve (CEFMS)")).toBe("fy26-execution-curve-cefms");
  });
});
