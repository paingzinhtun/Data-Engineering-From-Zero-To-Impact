# Apache Iceberg

## 1. What It Is

Apache Iceberg is an open table format for large analytical datasets. It helps manage data stored in files as reliable tables with metadata, schema evolution, partition evolution, and snapshot-based operations.

Iceberg is often used in lakehouse architectures where multiple engines need to query the same tables.

## 2. Why It Matters

Plain data lake files can become hard to manage at scale. Iceberg provides table metadata and reliability features that make large lakehouse tables easier to query, evolve, and govern.

It matters because it can support:

- Large analytical tables
- Schema evolution
- Hidden partitioning
- Snapshot isolation
- Time travel patterns
- Multiple processing engines
- Better management of table metadata

## 3. When to Use It

Use Apache Iceberg when:

- You need open lakehouse table management.
- Data is large and stored in object storage.
- Multiple engines need to read or write the same tables.
- You need schema and partition evolution.
- You want snapshot-based table behavior.
- Your platform supports Iceberg well.

It may be overkill for small projects, simple file storage, or single-engine workflows that do not need table-format features.

## 4. Real Business Example

A retail business stores years of POS sales, ecommerce orders, inventory logs, and customer events in object storage.

Different teams use different engines:

- Data Engineering uses Spark.
- Analysts use SQL query engines.
- Data science uses notebooks.
- BI tools query curated tables.

Iceberg can provide shared table structure and metadata so these teams can work with consistent lakehouse tables.

## 5. Technical Example

Conceptual table design:

```text
gold.fact_sales
grain: one row per sales transaction line
partition: sale_date by day or month
common filters: sale_date, product_category, sales_channel
```

Conceptual SQL:

```sql
CREATE TABLE gold.fact_sales (
    sale_id STRING,
    sale_line_id STRING,
    sale_date DATE,
    product_id STRING,
    customer_id STRING,
    quantity_sold INT,
    revenue DECIMAL(12, 2)
)
USING iceberg
PARTITIONED BY (sale_date);
```

Exact syntax depends on the catalog and execution engine.

## 6. Production Considerations

- Choose a catalog strategy carefully.
- Confirm engine compatibility.
- Define table ownership and access rules.
- Plan schema evolution.
- Monitor metadata and file layout.
- Avoid too many small files.
- Document partition strategy.
- Test rollback and snapshot workflows.
- Align table format choice with platform skills.

## 7. Common Mistakes

- Choosing Iceberg because it is popular rather than needed.
- Ignoring engine and catalog compatibility.
- Not defining table grain.
- Over-partitioning tables.
- Allowing schema changes without review.
- Forgetting metadata maintenance.
- Assuming a table format replaces governance.
- Using Iceberg for tiny datasets that do not need it.

## 8. Practice Task

Design an Iceberg table for retail sales.

Define:

1. Table grain.
2. Columns and data types.
3. Partition strategy.
4. Expected query patterns.
5. Schema evolution needs.
6. Engines that may read or write the table.
7. Governance and access requirements.

## 9. Related Project

- `07-data-lake-and-lakehouse/lakehouse-project/`: Iceberg can be used for managed Silver and Gold lakehouse tables.
- `10-big-data-processing/`: Large Iceberg tables are often processed by distributed engines.
- `13-cloud-data-engineering/`: Cloud object storage and catalogs are common parts of Iceberg deployments.
