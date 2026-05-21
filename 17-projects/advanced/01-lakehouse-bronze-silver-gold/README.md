# Project 01: Lakehouse Bronze Silver Gold

## Business Problem

A growing retail company collects POS sales, ecommerce orders, inventory snapshots, supplier files, website events, and support tickets. Some data is structured, some is semi-structured, and some arrives as large files. Teams want reporting, machine learning, and historical analysis from the same data foundation, but the current warehouse-only setup is expensive and hard to adapt to raw or messy sources.

## System Goal

Design a lakehouse platform that stores raw data, cleaned data, and business-ready data in separate layers using Bronze, Silver, and Gold architecture.

The goal is to support analytics, data science, and AI-ready use cases while preserving raw history and improving data trust.

## Architecture

```text
CSV, API, logs, events, documents
  -> object storage
  -> Bronze raw layer
  -> Silver cleaned and conformed layer
  -> Gold business-ready layer
  -> warehouse, BI dashboard, ML features, AI applications
```

Layer purpose:

- Bronze: raw immutable data as received from sources
- Silver: cleaned, typed, deduplicated, conformed data
- Gold: aggregated, modeled, business-ready tables

## Tools

Possible tool choices:

- Object storage: S3, GCS, Azure Data Lake Storage, or MinIO
- Table format: Delta Lake, Apache Iceberg, or Apache Hudi
- Processing: Spark, PySpark, Databricks, EMR, Glue, or open-source Spark
- Catalog: Hive Metastore, Unity Catalog, AWS Glue Catalog, or Nessie
- Query: Spark SQL, Trino, Athena, BigQuery external tables, or Synapse
- Orchestration: Airflow, Dagster, Prefect, or cloud-native schedulers

## Data Sources

Suggested sources:

- POS sales CSV files
- Ecommerce order API responses
- Inventory snapshots
- Product catalog changes
- Supplier delivery files
- Website clickstream events
- Customer service ticket exports

Important metadata:

- Source system
- Ingestion timestamp
- Batch ID
- File path
- Record hash
- Schema version

## Pipeline Design

1. Land all source data in the Bronze layer with minimal changes.
2. Add ingestion metadata to every record.
3. Convert raw files to columnar tables where useful.
4. Clean and type data into Silver tables.
5. Deduplicate records using business keys and load timestamps.
6. Conform shared dimensions such as product, customer, date, and store.
7. Build Gold tables for sales, inventory, customer value, and operations reporting.
8. Run quality checks at Bronze-to-Silver and Silver-to-Gold boundaries.
9. Publish Gold tables to BI, warehouse, ML, or AI services.

## Data Model

Suggested Bronze tables:

- `bronze.pos_sales_raw`
- `bronze.ecommerce_orders_raw`
- `bronze.inventory_snapshots_raw`
- `bronze.website_events_raw`

Suggested Silver tables:

- `silver.sales`
- `silver.order_items`
- `silver.products`
- `silver.customers`
- `silver.inventory_snapshots`
- `silver.web_events`

Suggested Gold tables:

- `gold.daily_sales`
- `gold.product_performance`
- `gold.inventory_reorder`
- `gold.customer_360`
- `gold.ml_product_features`

## Quality Checks

Bronze checks:

- Files arrived for expected dates.
- Files are readable.
- Required metadata columns exist.
- Schema drift is detected.

Silver checks:

- Required IDs are not null.
- Dates parse correctly.
- Duplicates are removed or quarantined.
- Quantity and revenue fields are valid.
- Product and customer references are resolved.

Gold checks:

- Aggregates reconcile to Silver tables.
- Metrics match documented definitions.
- Gold tables meet freshness expectations.
- Sensitive fields are excluded or masked.

## Scalability Considerations

This architecture is useful when:

- Data volume is too large for a single database server.
- Multiple teams need raw, cleaned, and curated data.
- Historical replay and reprocessing are important.
- Data science and BI share the same data foundation.
- Sources include large files, logs, or semi-structured data.

Design considerations:

- Use partitioning by date and high-value query filters.
- Avoid too many small files.
- Compact files regularly.
- Use columnar formats such as Parquet.
- Maintain table statistics and catalog metadata.
- Separate compute for ingestion, transformation, and query workloads.

## Cost Considerations

Main cost drivers:

- Object storage volume
- Compute used for Spark jobs
- Query engine scans
- File compaction jobs
- Data transfer between services or regions

Cost controls:

- Partition and cluster tables carefully.
- Use lifecycle policies for old raw data.
- Compact small files.
- Avoid full-table rewrites when incremental processing works.
- Monitor query scan volume.
- Keep Gold tables focused on business use cases.

## Security Considerations

Security requirements:

- Restrict raw data access.
- Mask or remove personally identifiable information in curated layers.
- Use IAM roles or service principals.
- Encrypt data at rest and in transit.
- Audit access to sensitive tables.
- Separate development, staging, and production environments.
- Apply row-level or column-level security where needed.

## Expected Output

Expected deliverables:

- Lakehouse architecture diagram
- Bronze, Silver, and Gold table design
- Sample ingestion pipeline
- Sample transformation jobs
- Data quality check definitions
- Cost and security notes
- Example Gold tables for sales, inventory, and customer analytics

Business questions answered:

- What happened in sales across POS and ecommerce?
- Which products are at risk of stockout?
- Which customer groups are most valuable?
- Which raw records created a reported metric?
- Can we reprocess historical data after logic changes?

## Future Improvements

- Add streaming ingestion for near real-time events.
- Add table-level lineage and catalog documentation.
- Add automated schema evolution handling.
- Add data contracts for source systems.
- Add ML feature tables.
- Add RAG-ready document and metadata ingestion.
- Add cross-environment deployment automation.

## Useful When

Use this architecture when the organization has multiple data domains, large historical data, mixed workloads, and a need for raw-to-curated traceability.

## Overkill When

This is overkill for a small business with a few CSV files, one reporting database, and no need for large-scale reprocessing, ML, or raw data retention. A PostgreSQL warehouse or managed cloud warehouse is usually simpler and cheaper.

## Related Concepts

- [Data Lake Concepts](../../../07-data-lake-and-lakehouse/data-lake-concepts.md)
- [Bronze Silver Gold](../../../07-data-lake-and-lakehouse/bronze-silver-gold.md)
- [Parquet And Columnar Storage](../../../07-data-lake-and-lakehouse/parquet-and-columnar-storage.md)
- [Cloud Fundamentals](../../../13-cloud-data-engineering/cloud-fundamentals.md)
