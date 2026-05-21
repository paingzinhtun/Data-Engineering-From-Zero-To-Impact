# Idempotency

## 1. What It Is

Idempotency means a pipeline step can be run more than once and still produce the same correct result.

In Data Engineering, this is critical because pipelines fail, retry, rerun, and backfill. A rerun should not create duplicate records or incorrect totals.

## 2. Why It Matters

Production pipelines are not perfect. Files arrive late, APIs timeout, databases restart, and transformations fail.

Idempotency helps Data Engineers:

- Retry failed jobs safely.
- Avoid duplicate records.
- Support backfills.
- Recover from partial failures.
- Build trust in scheduled pipelines.
- Make operations less risky.

Without idempotency, every rerun can damage the data.

## 3. When to Use It

Use idempotent design for:

- File ingestion.
- API extraction.
- Batch loads.
- Incremental loads.
- Warehouse transformations.
- Marts and summary tables.
- Backfills.

Almost every production data pipeline should be designed with idempotency in mind.

## 4. Real Business Example

A daily sales file for a stationery shop is loaded twice because the first job timed out after loading data but before marking the run successful.

If the pipeline simply appends rows, daily revenue doubles.

An idempotent pipeline could prevent this by:

- Using a unique sales line ID.
- Loading into a staging table first.
- Deleting the target partition for that date before reloading.
- Using upserts.
- Recording processed file checksums.

## 5. Technical Example

Delete and reload a date partition:

```sql
BEGIN;

DELETE FROM fact_sales
WHERE sale_date = DATE '2026-01-15';

INSERT INTO fact_sales (
    sale_id,
    sale_date,
    product_id,
    customer_id,
    quantity,
    unit_price
)
SELECT
    sale_id,
    sale_date,
    product_id,
    customer_id,
    quantity,
    unit_price
FROM staging_sales
WHERE sale_date = DATE '2026-01-15';

COMMIT;
```

Upsert by business key:

```sql
INSERT INTO products (product_id, product_name, category)
VALUES ('P-100', 'Notebook A5', 'Stationery')
ON CONFLICT (product_id)
DO UPDATE SET
    product_name = EXCLUDED.product_name,
    category = EXCLUDED.category;
```

File checksum idea:

```text
If file_name + file_checksum already processed successfully, skip the file.
```

## 6. Production Considerations

- Define natural keys or business keys.
- Add unique constraints where possible.
- Use staging tables for risky loads.
- Use transactions for multi-step changes.
- Record pipeline run metadata.
- Track source file names and checksums.
- Make backfills use the same safe logic as daily runs.
- Validate row counts after reruns.

## 7. Common Mistakes

- Appending data without uniqueness checks.
- Assuming retries will never happen.
- Deleting too much data before reload.
- Updating state before data is committed.
- Not using transactions for delete-and-insert patterns.
- Designing daily runs and backfills differently.
- Ignoring duplicate source records.

## 8. Practice Task

Design an idempotent daily sales load.

Specify:

1. Business key for each sale line.
2. Staging table.
3. Target table.
4. Duplicate detection rule.
5. Rerun behavior.
6. Transaction boundary.
7. Row count validation.
8. Pipeline run metadata.

## 9. Related Project

- `02-sql-and-databases/transactions-and-acid.md`: Transactions support idempotent loading.
- `05-etl-elt-pipelines/incremental-loading.md`: Incremental loads require idempotency.
- `14-production-engineering/`: Safe retries and recovery are production concerns.
