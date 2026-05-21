# Project 02: PySpark Batch Processing

## Business Problem

A retail business receives large daily sales and inventory files from multiple branches and online channels. The files are too large for comfortable processing with pandas on one machine, and transformations are becoming slow, memory-heavy, and unreliable.

The business needs a distributed batch processing pipeline that can process large datasets, produce daily analytics outputs, and scale as data grows.

## System Goal

Build a PySpark batch processing project that reads large sales files, cleans and joins data, calculates business metrics, writes partitioned Parquet outputs, and produces analytics-ready tables.

## Architecture

```text
Large sales, product, customer, and inventory files
  -> distributed PySpark job
  -> cleaned Parquet tables
  -> aggregated analytics outputs
  -> warehouse, BI dashboard, or lakehouse Gold layer
```

Recommended layers:

- Raw files
- Cleaned Parquet tables
- Aggregated business outputs
- Quality reports

## Tools

- PySpark for distributed batch processing
- Parquet for columnar storage
- Spark SQL for transformations
- Docker or local Spark for development
- Cloud Spark platform for production, such as Databricks, EMR, Glue, or Dataproc
- pytest for small transformation tests

## Data Sources

Suggested input datasets:

- Large sales files by date and store
- Product catalog
- Customer file
- Store file
- Inventory snapshots

Important fields:

- `sale_id`
- `sale_line_id`
- `sale_date`
- `store_id`
- `customer_id`
- `product_id`
- `quantity`
- `unit_price`
- `discount_amount`
- `unit_cost`

## Pipeline Design

1. Read raw CSV or JSON files with explicit schemas.
2. Validate required columns and types.
3. Clean IDs, dates, numeric fields, and null values.
4. Write cleaned data as Parquet.
5. Join sales with product, customer, and store data.
6. Calculate gross sales, net sales, cost amount, gross profit, and margin.
7. Aggregate by date, product, category, store, and customer segment.
8. Write partitioned outputs by date or reporting period.
9. Run quality checks and produce a run summary.

## Data Model

Suggested outputs:

- `clean.sales`
- `clean.products`
- `clean.customers`
- `clean.stores`
- `analytics.daily_sales`
- `analytics.product_performance`
- `analytics.store_performance`
- `analytics.customer_segment_summary`

Suggested grain:

- `clean.sales`: one row per sale line item
- `analytics.daily_sales`: one row per date
- `analytics.product_performance`: one row per product per period
- `analytics.store_performance`: one row per store per date

## Quality Checks

Minimum checks:

- Input files exist and are readable.
- Required columns exist.
- Sale line IDs are unique.
- Quantity is greater than zero.
- Net sales is not negative.
- Joins do not drop unexpected records.
- Output row counts are within expected ranges.
- Partition output exists for the processing date.

Spark-specific checks:

- Detect skewed joins.
- Track records with missing dimension references.
- Monitor small file counts.
- Validate partition counts and output sizes.

## Scalability Considerations

This architecture is useful when:

- Data exceeds single-machine memory.
- Jobs need distributed joins or aggregations.
- Files are large enough to benefit from parallel processing.
- The same pipeline must handle growing branch or ecommerce data.

Design considerations:

- Define schemas instead of inferring them repeatedly.
- Partition large outputs by date.
- Avoid unnecessary shuffles.
- Broadcast small dimension tables when appropriate.
- Cache only reused DataFrames.
- Tune file sizes to avoid thousands of tiny files.
- Use Parquet instead of CSV for repeated reads.

## Cost Considerations

Main cost drivers:

- Cluster size and runtime
- Shuffle-heavy jobs
- Reprocessing large historical ranges
- Storage of intermediate outputs
- Inefficient file layouts

Cost controls:

- Use the smallest cluster that meets SLA.
- Stop clusters after jobs finish.
- Process incrementally by date.
- Use partition pruning.
- Compact small files.
- Avoid caching large DataFrames without clear reuse.

## Security Considerations

Security requirements:

- Store credentials outside code.
- Restrict access to raw customer data.
- Mask or remove sensitive customer fields in analytics outputs.
- Encrypt data at rest and in transit.
- Log processing metadata without exposing secrets.
- Use separate paths for development and production data.

## Expected Output

Expected deliverables:

- PySpark batch job design
- Explicit source schemas
- Cleaned Parquet tables
- Aggregated sales and inventory outputs
- Quality check report
- Notes on partitioning, shuffling, caching, and file sizes

Business questions answered:

- What were daily sales across all stores?
- Which categories drive the most gross profit?
- Which stores are underperforming?
- Which customer segments are buying most often?
- Did the latest batch produce complete outputs?

## Future Improvements

- Add Airflow orchestration.
- Add incremental processing by date.
- Add cloud object storage.
- Add Spark job metrics collection.
- Add data lake table formats such as Delta or Iceberg.
- Add automated compaction.
- Add structured streaming for near real-time sales.

## Useful When

Use PySpark when data is genuinely large, transformations are heavy, or distributed processing provides clear runtime and reliability benefits.

## Overkill When

PySpark is overkill for small files, simple reports, or datasets that fit comfortably in pandas or PostgreSQL. Spark adds operational complexity, cluster costs, and debugging overhead.

## Related Concepts

- [Distributed Computing](../../../10-big-data-processing/distributed-computing.md)
- [Spark Basics](../../../10-big-data-processing/spark-basics.md)
- [PySpark DataFrames](../../../10-big-data-processing/pyspark-dataframes.md)
- [Partitioning Shuffling Caching](../../../10-big-data-processing/partitioning-shuffling-caching.md)
