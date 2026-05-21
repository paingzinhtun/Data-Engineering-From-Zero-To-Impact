# Pipeline Design

## Steps

1. Extract CSV files from `data/sample`.
2. Validate files exist.
3. Read files with pandas.
4. Clean column names and types.
5. Validate required columns.
6. Join sales to products for cost data.
7. Calculate `gross_sales`, `net_sales`, `cost_amount`, and `gross_profit`.
8. Load cleaned raw tables into PostgreSQL.
9. Run SQL transformations.
10. Run SQL quality checks.

## Design Principles

- Configuration comes from environment variables.
- Credentials are not hardcoded.
- Logs show row counts and pipeline status.
- Transform logic is testable.
- SQL creates business-ready analytics tables.
- Quality checks are explicit.

## Rerun Behavior

This beginner project uses `replace` loading for raw tables and recreates analytics tables. That makes local reruns simple and predictable.

In a production system, you would usually move toward idempotent incremental loads, run metadata, and partitioned refreshes.
