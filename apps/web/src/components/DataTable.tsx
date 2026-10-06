import { useEffect, useId, useMemo, useState, type KeyboardEvent, type MouseEvent, type ReactNode } from "react";
import { Link } from "react-router";
import { Button, Icon, Table } from "@trussworks/react-uswds";
import {
  type ColumnDef,
  type ColumnFiltersState,
  type Row,
  type SortingState,
  flexRender,
  getCoreRowModel,
  getFilteredRowModel,
  getPaginationRowModel,
  getSortedRowModel,
  useReactTable,
} from "@tanstack/react-table";
import { useIsMobile } from "../hooks/useMediaQuery";
import { useAnnounce } from "../hooks/useAnnounce";

export interface DataTableProps<T> {
  caption: string;
  /** Secondary caption line (source, as-of). */
  captionMeta?: ReactNode;
  columns: ColumnDef<T, unknown>[];
  data: T[];
  getRowId?: (row: T, index: number) => string;
  /** Column id rendered as the row header (<th scope="row">). Defaults to the first column. */
  rowHeaderColumnId?: string;
  /** Link target for a row. The row header becomes the link; the whole row is also clickable. */
  getRowHref?: (row: T) => string;
  /** Alternative to getRowHref: callback for click or Enter on the row header button. */
  onRowActivate?: (row: T) => void;
  pageSize?: number;
  /** Show per-column filter inputs for columns with `enableColumnFilter !== false`. */
  enableFilters?: boolean;
  enableSorting?: boolean;
  stickyHeader?: boolean;
  /** Force card mode (defaults to the viewport under 640 px). */
  stacked?: boolean;
  emptyMessage?: string;
  initialSorting?: SortingState;
  className?: string;
}

const PAGE_SIZES = [10, 25, 50];

function sortIcon(dir: false | "asc" | "desc") {
  if (dir === "asc") return <Icon.ArrowUpward aria-hidden="true" focusable={false} />;
  if (dir === "desc") return <Icon.ArrowDownward aria-hidden="true" focusable={false} />;
  return <Icon.UnfoldMore aria-hidden="true" focusable={false} />;
}

/**
 * TanStack Table v8 rendered as a USWDS table (508 report 1.2.6): caption, scope on headers,
 * aria-sort on sortable columns, labelled filters, pagination with a status line, sticky header on
 * desktop, stacked cards under 640 px. Row navigation goes through a link or button in the row header
 * so keyboard users have a real control; the row surface is a mouse convenience.
 */
export function DataTable<T>({
  caption, captionMeta, columns, data, getRowId, rowHeaderColumnId, getRowHref, onRowActivate, pageSize = 10,
  enableFilters = false, enableSorting = true, stickyHeader = true, stacked, emptyMessage = "No rows match the current filters.", initialSorting = [], className,
}: DataTableProps<T>) {
  const id = useId();
  const isMobile = useIsMobile();
  const cards = stacked ?? isMobile;
  const [sorting, setSorting] = useState<SortingState>(initialSorting);
  const [columnFilters, setColumnFilters] = useState<ColumnFiltersState>([]);
  const [pagination, setPagination] = useState({ pageIndex: 0, pageSize });
  const { announce } = useAnnounce();

  const table = useReactTable({
    data,
    columns,
    state: { sorting, columnFilters, pagination },
    onSortingChange: setSorting,
    onColumnFiltersChange: setColumnFilters,
    onPaginationChange: setPagination,
    getRowId: getRowId ? (row, index) => getRowId(row, index) : undefined,
    getCoreRowModel: getCoreRowModel(),
    getSortedRowModel: getSortedRowModel(),
    getFilteredRowModel: getFilteredRowModel(),
    getPaginationRowModel: getPaginationRowModel(),
    enableSorting,
    sortDescFirst: false,
    enableColumnFilters: enableFilters,
    autoResetPageIndex: true,
  });

  const rows = table.getRowModel().rows;
  const total = table.getFilteredRowModel().rows.length;
  const first = total === 0 ? 0 : pagination.pageIndex * pagination.pageSize + 1;
  const last = Math.min(total, (pagination.pageIndex + 1) * pagination.pageSize);
  const pageCount = table.getPageCount();
  const status = total === 0 ? "No rows to show" : `Showing ${first} to ${last} of ${total} rows${sorting[0] ? `, sorted by ${String(sorting[0].id).replace(/[_-]/g, " ")} ${sorting[0].desc ? "descending" : "ascending"}` : ""}`;

  const announceable = useMemo(() => `${total} rows match`, [total]);
  useEffect(() => {
    if (columnFilters.length > 0) announce(announceable);
  }, [announceable, columnFilters.length, announce]);

  const headerColumnId = rowHeaderColumnId ?? columns[0]?.id ?? (columns[0] as { accessorKey?: string } | undefined)?.accessorKey;

  const activate = (row: Row<T>) => onRowActivate?.(row.original);
  const onRowClick = (e: MouseEvent<HTMLTableRowElement>) => {
    if (!(getRowHref || onRowActivate)) return;
    const target = e.target as HTMLElement;
    if (target.closest("a, button, input, select")) return;
    const control = e.currentTarget.querySelector<HTMLElement>("th a, th button");
    control?.click();
  };
  const onRowKey = (row: Row<T>) => (e: KeyboardEvent<HTMLTableRowElement>) => {
    if (e.key === "Enter" && e.target === e.currentTarget) {
      e.preventDefault();
      if (getRowHref) e.currentTarget.querySelector<HTMLElement>("th a")?.click();
      else activate(row);
    }
  };

  const tableClass = ["usa-table", "usa-table--borderless", !cards && stickyHeader && "usa-table--sticky-header", cards && "usa-table--stacked"].filter(Boolean).join(" ");

  return (
    <div className={["evs-table", cards && "evs-table--stacked", className].filter(Boolean).join(" ")} data-testid="data-table" data-mode={cards ? "cards" : "table"}>
      <div className="evs-table__wrap evs-scroll-x" role="region" tabIndex={cards ? -1 : 0} aria-labelledby={`${id}-caption`}>
        <Table className={tableClass} fullWidth stackedStyle={cards ? "default" : "none"} bordered={false}>
          <caption id={`${id}-caption`}>
            {caption}
            {captionMeta && <span className="evs-table__caption-meta">{captionMeta}</span>}
          </caption>
          <thead>
            {table.getHeaderGroups().map((hg) => (
              <tr key={hg.id}>
                {hg.headers.map((header) => {
                  const canSort = header.column.getCanSort();
                  const dir = header.column.getIsSorted();
                  const ariaSort = canSort ? (dir === "asc" ? "ascending" : dir === "desc" ? "descending" : "none") : undefined;
                  const label = flexRender(header.column.columnDef.header, header.getContext());
                  return (
                    <th key={header.id} scope="col" aria-sort={ariaSort} className={(header.column.columnDef.meta as { numeric?: boolean } | undefined)?.numeric ? "evs-table__num" : undefined}>
                      {canSort ? (
                        <button type="button" className="evs-table__sort" onClick={header.column.getToggleSortingHandler()}>
                          <span>{label}</span>
                          {sortIcon(dir)}
                          <span className="evs-sr-only">{dir === "asc" ? ", sorted ascending, activate to sort descending" : dir === "desc" ? ", sorted descending, activate to clear sort" : ", activate to sort ascending"}</span>
                        </button>
                      ) : (
                        label
                      )}
                    </th>
                  );
                })}
              </tr>
            ))}
            {enableFilters && (
              <tr className="evs-table__filter-row">
                {table.getHeaderGroups()[0].headers.map((header) => {
                  const col = header.column;
                  if (!col.getCanFilter()) return <th key={header.id} scope="col" aria-hidden="true" />;
                  const headerText = typeof col.columnDef.header === "string" ? col.columnDef.header : col.id;
                  const inputId = `${id}-filter-${col.id}`;
                  return (
                    <th key={header.id} scope="col">
                      <label htmlFor={inputId} className="evs-sr-only">Filter by {headerText}</label>
                      <input
                        id={inputId}
                        className="usa-input evs-table__filter"
                        type="search"
                        value={(col.getFilterValue() as string) ?? ""}
                        onChange={(e) => col.setFilterValue(e.target.value || undefined)}
                        placeholder={`Filter ${headerText}`}
                      />
                    </th>
                  );
                })}
              </tr>
            )}
          </thead>
          <tbody>
            {rows.length === 0 && (
              <tr>
                <td colSpan={columns.length} data-label="Result">{emptyMessage}</td>
              </tr>
            )}
            {rows.map((row) => {
              const interactive = Boolean(getRowHref || onRowActivate);
              return (
                <tr
                  key={row.id}
                  className={interactive ? "evs-table__row--link" : undefined}
                  onClick={interactive ? onRowClick : undefined}
                  onKeyDown={interactive ? onRowKey(row) : undefined}
                >
                  {row.getVisibleCells().map((cellCtx) => {
                    const meta = cellCtx.column.columnDef.meta as { numeric?: boolean } | undefined;
                    const headerText = typeof cellCtx.column.columnDef.header === "string" ? cellCtx.column.columnDef.header : cellCtx.column.id;
                    const content = flexRender(cellCtx.column.columnDef.cell, cellCtx.getContext());
                    if (cellCtx.column.id === headerColumnId) {
                      return (
                        <th key={cellCtx.id} scope="row" data-label={headerText}>
                          {getRowHref ? (
                            <Link to={getRowHref(row.original)} className="usa-link">{content}</Link>
                          ) : onRowActivate ? (
                            <Button type="button" unstyled onClick={() => activate(row)}>{content}</Button>
                          ) : (
                            content
                          )}
                        </th>
                      );
                    }
                    return (
                      <td key={cellCtx.id} data-label={headerText} className={meta?.numeric ? "evs-table__num" : undefined}>
                        {content}
                      </td>
                    );
                  })}
                </tr>
              );
            })}
          </tbody>
        </Table>
      </div>
      <div className="evs-table__footer">
        <p className="evs-table__status" role="status" aria-live="polite" data-testid="table-status">{status}</p>
        {total > Math.min(...PAGE_SIZES) && (
          <nav className="usa-pagination" aria-label={`${caption} pagination`}>
            <ul className="usa-pagination__list display-flex flex-align-center">
              <li className="usa-pagination__item usa-pagination__arrow">
                <Button type="button" unstyled className="usa-pagination__link usa-pagination__previous-page" onClick={() => table.previousPage()} disabled={!table.getCanPreviousPage()}>
                  <Icon.NavigateBefore aria-hidden="true" focusable={false} />
                  <span className="usa-pagination__link-text">Previous</span>
                </Button>
              </li>
              <li className="usa-pagination__item">
                <label htmlFor={`${id}-page`} className="evs-sr-only">Page</label>
                <select id={`${id}-page`} className="usa-select margin-0 width-auto" value={pagination.pageIndex} onChange={(e) => table.setPageIndex(Number(e.target.value))}>
                  {Array.from({ length: pageCount }, (_, i) => (
                    <option key={i} value={i}>Page {i + 1} of {pageCount}</option>
                  ))}
                </select>
              </li>
              <li className="usa-pagination__item usa-pagination__arrow">
                <Button type="button" unstyled className="usa-pagination__link usa-pagination__next-page" onClick={() => table.nextPage()} disabled={!table.getCanNextPage()}>
                  <span className="usa-pagination__link-text">Next</span>
                  <Icon.NavigateNext aria-hidden="true" focusable={false} />
                </Button>
              </li>
              <li className="usa-pagination__item">
                <label htmlFor={`${id}-size`} className="evs-sr-only">Rows per page</label>
                <select id={`${id}-size`} className="usa-select margin-0 width-auto" value={pagination.pageSize} onChange={(e) => table.setPageSize(Number(e.target.value))}>
                  {PAGE_SIZES.map((n) => (
                    <option key={n} value={n}>{n} per page</option>
                  ))}
                </select>
              </li>
            </ul>
          </nav>
        )}
      </div>
    </div>
  );
}
