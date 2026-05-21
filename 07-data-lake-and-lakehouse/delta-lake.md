# Delta Lake

## 1. What It Is

Delta Lake is an open table format that adds reliability features to data lakes. It is commonly used with Parquet files and provides a transaction log that tracks table changes.

The goal is to make data lake tables behave more like reliable database tables while still using lake storage.

## 2. Why It Matters

Plain files in object storage can be difficult to manage when data changes over time. Delta Lake helps with reliability, consistency, and table management.

It can support:

- ACID transactions
- Schema enforcement
- Schema evolution
- Time travel
- Upserts and deletes
- Streaming and batch workloads
- More reliable lakehouse tables

These features are useful when raw files become managed analytical tables.

## 3. When to Use It

Use Delta Lake when:

- You are building lakehouse tables that need reliable updates.
- Multiple jobs may read and write data.
- You need upserts, deletes, or merges.
- You want table history or rollback capability.
- You need stronger schema enforcement than plain files provide.
- Your processing stack supports Delta Lake.

It may be overkill for simple static CSV exports or small local learning projects.

## 4. Real Business Example

A retail company keeps inventory snapshots in a lakehouse.

Inventory data may arrive multiple times per day. Some files correct earlier mistakes. The business needs current stock levels and historical snapshots.

Delta Lake can help manage updates, enforce schema, and keep table history so incorrect loads can be investigated or rolled back.

## 5. Technical Example

Conceptual Delta table flow:

```text
bronze raw files
  -> silver Delta table with cleaned inventory
  -> gold Delta table with reorder recommendations
```

Conceptual merge pattern:

```sql
MERGE INTO silver_inventory AS target
USING staging_inventory AS source
ON target.product_id = source.product_id
AND target.snapshot_date = source.snapshot_date
WHEN MATCHED THEN UPDATE SET
    quantity_on_hand = source.quantity_on_hand,
    reorder_level = source.reorder_level
WHEN NOT MATCHED THEN INSERT (
    product_id,
    snapshot_date,
    quantity_on_hand,
    reorder_level
)
VALUES (
    source.product_id,
    source.snapshot_date,
    source.quantity_on_hand,
    source.reorder_level
);
```

Exact syntax depends on the execution engine.

## 6. Production Considerations

- Confirm your processing platform supports Delta Lake well.
- Manage table versions and retention policies.
- Monitor small files and optimize table layout.
- Define schema evolution rules.
- Control concurrent writes.
- Document merge keys and update logic.
- Apply access controls to sensitive tables.
- Test recovery and rollback processes.

## 7. Common Mistakes

- Using Delta Lake without understanding table grain.
- Treating Delta features as a replacement for data quality checks.
- Allowing uncontrolled schema evolution.
- Creating many tiny files.
- Not documenting merge logic.
- Forgetting retention settings for table history.
- Choosing Delta when simple Parquet files are enough.

## 8. Practice Task

Design a Delta Lake table for inventory snapshots.

Define:

1. Table grain.
2. Natural key or merge key.
3. Required columns.
4. Schema enforcement rules.
5. Update behavior.
6. History or rollback needs.
7. Data quality checks.

## 9. Related Project

- `07-data-lake-and-lakehouse/lakehouse-project/`: Delta Lake can be used for Silver and Gold managed tables.
- `05-etl-elt-pipelines/incremental-loading.md`: Merge and upsert logic supports incremental loading.
- `12-data-quality-testing-observability/`: Managed tables still need quality checks and observability.
