# Incremental Loading

## 1. What It Is

Incremental loading is the practice of loading only new or changed data instead of reloading all data every time.

For example, a daily sales pipeline may load only sales created or updated since the last successful run.

## 2. Why It Matters

Full refreshes are simple but can become slow, expensive, or risky as data grows. Incremental loading makes pipelines more efficient and scalable.

It matters because it can:

- Reduce processing time.
- Lower compute cost.
- Avoid unnecessary writes.
- Support larger datasets.
- Improve pipeline reliability.
- Make frequent updates practical.

## 3. When to Use It

Use incremental loading when:

- The source data is large.
- Only a small portion changes each run.
- The source provides timestamps, IDs, versions, or change logs.
- The pipeline runs frequently.
- Full refresh takes too long.

Use full refresh when:

- Data is small.
- Source data cannot reliably identify changes.
- You need to rebuild after logic changes.
- Simplicity is more important than efficiency.

## 4. Real Business Example

An ecommerce stationery shop has three years of order history.

Reloading all orders every hour is wasteful. Instead, the pipeline requests orders updated after the last successful extraction timestamp.

The pipeline loads only new or changed orders, then updates reporting tables.

This allows dashboards to refresh often without repeatedly processing old data.

## 5. Technical Example

High watermark pattern:

```text
last_successful_updated_at = 2026-01-15 09:00:00
extract records where updated_at > last_successful_updated_at
load records
update last_successful_updated_at after success
```

SQL example:

```sql
SELECT
    order_id,
    customer_id,
    updated_at,
    order_total
FROM source_orders
WHERE updated_at > TIMESTAMP '2026-01-15 09:00:00';
```

Upsert example:

```sql
INSERT INTO orders_clean (order_id, customer_id, updated_at, order_total)
VALUES ('ORD-1001', 'C-100', '2026-01-15 10:30:00', 59.90)
ON CONFLICT (order_id)
DO UPDATE SET
    customer_id = EXCLUDED.customer_id,
    updated_at = EXCLUDED.updated_at,
    order_total = EXCLUDED.order_total;
```

## 6. Production Considerations

- Choose a reliable incremental key.
- Store pipeline state after successful loads only.
- Handle late-arriving records.
- Use overlap windows when source timestamps may be delayed.
- Make loads idempotent with upserts or delete-and-insert by partition.
- Track inserts, updates, and rejected records.
- Keep a backfill process for historical reloads.
- Validate totals against source when possible.

## 7. Common Mistakes

- Updating the watermark before the load succeeds.
- Using a timestamp that does not change when records are updated.
- Missing late-arriving data.
- Creating duplicates instead of upserting.
- Assuming source system clocks are always correct.
- Not supporting backfills.
- Ignoring deleted records.

## 8. Practice Task

Design an incremental load for ecommerce orders.

Define:

1. Source table or API endpoint.
2. Incremental key.
3. Watermark storage location.
4. Overlap window.
5. Target table primary key.
6. Upsert behavior.
7. Late-arriving data handling.
8. Backfill process.

## 9. Related Project

- `05-etl-elt-pipelines/idempotency.md`: Incremental loads must be rerunnable safely.
- `08-orchestration/`: Orchestrators often manage incremental pipeline schedules.
- `14-production-engineering/`: Production pipelines need state management and recovery.
