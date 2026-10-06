"""Kanban Board column derivation and drop handling.

Source: APEX page 4 "Kanban Board": region SQL (column_id CASE on pct_complete) and dynamic action
"Drop Item" (PL/SQL: `update sp_projects set pct_complete = decode(:P4_DROP_COLUMN_ID,
1,20, 2,30, 3,40, 4,50, 5,80)`). Stack-rank (kb_stack_rank) reordering is not ported; EVS orders
cards by current_finish.
"""

from __future__ import annotations

# (column_id, heading, pct range label) from the page 4 region SQL CASE expression.
KANBAN_COLUMNS: list[tuple[int, str, str]] = [
    (1, "Identified", "10 to 20"),
    (2, "Architecting", "30"),
    (3, "Specification Approved", "40"),
    (4, "In Development", "50 to 70"),
    (5, "Merging and Verification", "80 to 100"),
]

# "Drop Item" dynamic action: landing pct_complete per target column.
_DROP_PCT = {1: 20, 2: 30, 3: 40, 4: 50, 5: 80}


def kanban_column(pct_complete: int | float) -> dict:
    """`case when pct_complete between 10 and 20 then 1 when = 30 then 2 when = 40 then 3
    when between 50 and 70 then 4 when between 80 and 100 then 5 end column_id`.
    Projects at 0 percent are not on the board in APEX; EVS places them in column 1."""
    pct = float(pct_complete)
    if pct <= 20:
        cid = 1
    elif pct < 40:
        cid = 2
    elif pct < 50:
        cid = 3
    elif pct < 80:
        cid = 4
    else:
        cid = 5
    _, heading, rng = next(c for c in KANBAN_COLUMNS if c[0] == cid)
    return {"column_id": cid, "heading": heading, "pct_complete_range": rng}


def pct_for_column(column_id: int) -> int:
    """pct_complete written by the "Drop Item" action when a card lands in `column_id`."""
    if column_id not in _DROP_PCT:
        raise ValueError(f"Kanban column {column_id} does not exist (1 to 5)")
    return _DROP_PCT[column_id]
