# Pipeline Template

Use this template when starting a new data pipeline project. It is intentionally generic so it can support CSV ingestion, API extraction, database replication, warehouse transformations, or reporting pipelines.

## 1. Pipeline Purpose

Describe the business reason for the pipeline.

Example:

> Load daily retail sales data into the warehouse so managers can track revenue, product performance, and stock movement every morning.

## 2. Business Questions

List the questions this pipeline should help answer.

- What changed since the last run?
- Which records are new or updated?
- Which business metrics will this pipeline support?
- Who uses the output?

## 3. Source Data

Document each source.

| Source | Type | Owner | Refresh Frequency | Expected Arrival |
| --- | --- | --- | --- | --- |
| `sales.csv` | CSV | Store operations | Daily | 7:00 AM |
| Ecommerce orders API | API | Ecommerce team | Hourly | Continuous |

## 4. Target Tables

| Table | Layer | Grain | Purpose |
| --- | --- | --- | --- |
| `raw.sales` | Raw | One row per source record | Preserve source data |
| `staging.stg_sales` | Staging | One row per cleaned sale line | Standardize source data |
| `mart.daily_sales` | Mart | One row per date | Business reporting |

## 5. Pipeline Steps

1. Load configuration.
2. Extract source data.
3. Validate source schema.
4. Store raw data.
5. Transform and clean data.
6. Load target tables.
7. Run data quality checks.
8. Log run results.
9. Notify success or failure.

## 6. Configuration

Use environment variables for credentials and deployment-specific values.

```text
SOURCE_PATH=
DATABASE_HOST=
DATABASE_PORT=
DATABASE_NAME=
DATABASE_USER=
DATABASE_PASSWORD=
LOG_LEVEL=INFO
```

## 7. Error Handling

Define how the pipeline should behave when something goes wrong.

- Missing source file: fail the run and alert.
- Empty source file: fail unless empty files are expected.
- Schema change: quarantine file or fail before loading.
- Duplicate records: reject, deduplicate, or mark for review.
- Database connection failure: retry with backoff.

## 8. Idempotency

A pipeline is idempotent when rerunning the same input does not create incorrect duplicates or inconsistent outputs.

Recommended patterns:

- Use stable business keys.
- Load by partition or processing date.
- Use staging tables before final merge.
- Record batch IDs and load timestamps.
- Make backfills explicit.

## 9. Data Quality Checks

Minimum checks:

- Required columns exist.
- Required IDs are not null.
- Primary keys are unique.
- Row count is reasonable.
- Freshness meets expectations.
- Numeric fields are not negative unless allowed.
- Referential integrity is valid.

## 10. Logging

Log:

- Pipeline start and finish time
- Source file names or API endpoints
- Row counts extracted, transformed, and loaded
- Quality check results
- Error details
- Batch ID or run ID

## 11. Documentation

Every production pipeline should document:

- Business purpose
- Source owners
- Target tables
- Refresh schedule
- Data quality checks
- Backfill instructions
- Known limitations

## 12. Recommended Folder Structure

```text
pipeline-name/
  README.md
  .env.example
  requirements.txt
  src/
    extract.py
    transform.py
    load.py
    main.py
  sql/
    create_tables.sql
    transformations.sql
    quality_checks.sql
  tests/
  data/
    sample/
    raw/
```
