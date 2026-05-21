# Interview Questions

Use these questions for review and mock interviews. Answers are concise outlines; practice expanding them with examples from your own projects.

## SQL

### 1. What is the difference between `WHERE` and `HAVING`?

`WHERE` filters rows before aggregation. `HAVING` filters grouped results after aggregation.

### 2. How do you find duplicate records?

Group by the business key and use `HAVING COUNT(*) > 1`.

```sql
SELECT sale_line_id, COUNT(*)
FROM fact_sales
GROUP BY sale_line_id
HAVING COUNT(*) > 1;
```

### 3. What is a window function?

A window function calculates values across related rows without collapsing rows like `GROUP BY`. Examples include `ROW_NUMBER`, `RANK`, rolling sums, and moving averages.

### 4. How would you calculate daily sales?

Group sales by date and sum revenue fields.

```sql
SELECT sale_date, SUM(net_sales) AS net_sales
FROM fact_sales
GROUP BY sale_date;
```

## Python

### 5. Why is logging better than using `print` in pipelines?

Logging supports levels, timestamps, files, structured output, and production monitoring. `print` is harder to filter and operate.

### 6. How do you avoid hardcoding credentials?

Use environment variables, `.env` files for local development, Airflow connections, or a secret manager in production.

### 7. How would you handle a missing input file?

Validate the path before reading, log a clear error, fail the pipeline if the file is required, and alert the owner.

### 8. Why use type hints?

Type hints make code easier to read, review, test, and maintain. They help clarify expected inputs and outputs.

## Databases

### 9. What is a primary key?

A primary key uniquely identifies each row in a table and should be stable, unique, and not null.

### 10. What is an index?

An index helps the database find rows faster for filters, joins, and ordering. It improves reads but can slow writes and use storage.

### 11. What are transactions?

Transactions group database operations into a unit of work. They should either fully succeed or roll back to protect data consistency.

### 12. What does ACID mean?

Atomicity, Consistency, Isolation, Durability. These properties make database transactions reliable.

## ETL/ELT

### 13. What is the difference between ETL and ELT?

ETL transforms data before loading into the target. ELT loads raw data first and transforms inside the warehouse or lakehouse.

### 14. What is idempotency?

Idempotency means rerunning the same pipeline with the same input does not create duplicate or incorrect output.

### 15. What is incremental loading?

Incremental loading processes only new or changed records since the last successful run, often using timestamps, IDs, or partitions.

### 16. How do you design retries?

Retry temporary failures such as network or API timeouts. Do not blindly retry data quality failures or bad source data.

## Data Modeling

### 17. What is table grain?

Grain defines what one row represents. Example: `fact_sales` may have one row per sale line item.

### 18. What is the difference between facts and dimensions?

Facts store measurable business events, such as sales. Dimensions describe context, such as product, customer, date, or store.

### 19. What is normalization?

Normalization reduces duplication and improves consistency by separating data into related tables.

### 20. When is denormalization useful?

Denormalization is useful for analytics performance and simpler reporting, especially in marts and star schemas.

## Data Warehousing

### 21. What is a star schema?

A star schema has a central fact table connected to dimension tables. It is simple for analytics and BI queries.

### 22. What is a data mart?

A data mart is a business-ready table or group of tables designed for a specific domain, such as sales, inventory, or finance.

### 23. Why separate raw, staging, and mart layers?

Separation improves traceability, makes transformations easier to test, and protects business outputs from messy source data.

### 24. What is partitioning?

Partitioning splits large tables by values such as date so queries can scan less data and run faster.

## Airflow

### 25. What is a DAG?

A DAG is a Directed Acyclic Graph. In Airflow, it defines tasks and dependencies for a workflow.

### 26. What is a backfill?

A backfill reruns a pipeline for past dates or partitions. It must be designed to avoid duplicate records.

### 27. What should trigger an Airflow alert?

Critical pipeline failures, missed freshness SLAs, repeated task failures, or failed quality checks that block reporting.

### 28. Why avoid large XCom values?

XCom is for small metadata, not large datasets. Large XComs can slow Airflow and make metadata storage unstable.

## dbt

### 29. What is dbt used for?

dbt manages SQL transformations, tests, documentation, lineage, and deployment workflows inside a warehouse.

### 30. What is a dbt source?

A dbt source declares raw input tables and can include freshness checks and documentation.

### 31. What are dbt tests?

dbt tests validate assumptions such as not null, unique, relationships, accepted values, or custom business rules.

### 32. What is the difference between staging and marts in dbt?

Staging models clean one source at a time. Marts combine business logic into user-facing outputs.

## Spark

### 33. When is Spark useful?

Spark is useful for large datasets, distributed joins, heavy transformations, and workloads that exceed one machine.

### 34. When is Spark overkill?

Spark is overkill for small files or simple queries that fit comfortably in pandas, DuckDB, or PostgreSQL.

### 35. What is shuffling?

Shuffling moves data across the cluster, often for joins or aggregations. It can be expensive and should be minimized.

### 36. Why use Parquet with Spark?

Parquet is columnar, compressed, schema-aware, and efficient for analytical reads.

## Kafka

### 37. What is a Kafka topic?

A topic is a named stream of events. Producers write events to topics, and consumers read from them.

### 38. What is an offset?

An offset is the position of a message within a partition. Consumers track offsets to know what has been processed.

### 39. What is a consumer group?

A consumer group is a set of consumers sharing work from a topic. Each partition is consumed by one consumer in the group at a time.

### 40. What is at-least-once processing?

At-least-once processing means records are not lost, but duplicates may occur. Downstream logic must handle duplicates.

## Cloud

### 41. What is object storage used for?

Object storage stores files such as CSV, JSON, Parquet, logs, and raw data. Examples include S3, GCS, and Azure Data Lake Storage.

### 42. What is IAM?

IAM manages identities and permissions. Good IAM uses least privilege and role-based access.

### 43. What is serverless useful for?

Serverless is useful for event-driven or scheduled tasks without managing servers, but cost and cold starts should be considered.

### 44. How do you control cloud data costs?

Partition data, avoid unnecessary scans, stop idle compute, monitor usage, use lifecycle policies, and build focused marts.

## Data Quality

### 45. What are common data quality checks?

Null checks, duplicate checks, accepted values, row counts, freshness, referential integrity, and business sanity checks.

### 46. What is freshness?

Freshness measures whether data was updated within the expected time window.

### 47. What should happen when a critical quality check fails?

The pipeline should fail before publishing bad data, alert the owner, and log failed examples.

### 48. What is observability?

Observability is the ability to understand pipeline and data health through logs, metrics, lineage, freshness, volume, and alerts.

## System Design

### 49. Design a daily retail sales pipeline.

Clarify freshness, sources, and outputs. Use batch ingestion, raw tables, staging transformations, `fact_sales`, `mart_daily_sales`, quality checks, orchestration, logs, and alerts.

### 50. Design a real-time sales alert system.

Use POS event producers, Kafka topics, stream processing, rolling aggregates, alerting, checkpointing, dead-letter handling, and consumer lag monitoring.

### 51. Design a retail warehouse.

Use raw, staging, warehouse, and mart layers. Model dimensions for date, product, customer, and store. Model facts for sales and inventory snapshots. Add quality checks and BI marts.

### 52. How do you decide between batch and streaming?

Use batch when hourly or daily freshness is enough. Use streaming when business action depends on low-latency events.

## Behavioral/Business Impact

### 53. Tell me about a data project you built.

Use problem, users, data, system, quality, output, impact, and future improvements.

### 54. How do you handle unclear requirements?

Ask about users, decisions, metrics, freshness, source systems, quality expectations, and success criteria. Document assumptions.

### 55. How do you explain a technical project to a business user?

Focus on the problem, output, decisions enabled, data trust, and limitations. Avoid unnecessary tool detail.

### 56. How do you handle a pipeline failure?

Identify the failed task, check logs, verify source data, inspect recent changes, determine business impact, fix or rollback, rerun safely, and document the incident.
