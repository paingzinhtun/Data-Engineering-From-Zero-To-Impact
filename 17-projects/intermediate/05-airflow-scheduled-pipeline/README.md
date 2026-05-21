# Project 05: Airflow Scheduled Pipeline

## Business Problem

A retail operations team depends on daily sales, inventory, and reorder reports every morning. The existing pipeline is run manually, so reports are late when someone forgets to run a script or when a source file is delayed.

The business needs a scheduled workflow that runs automatically, validates data, retries temporary failures, and alerts the team when action is needed.

## Goal

Build an Airflow-scheduled retail data pipeline that orchestrates extraction, validation, loading, transformation, quality checks, and reporting tasks.

This project should teach orchestration thinking: dependencies, scheduling, retries, backfills, task ownership, and operational visibility.

## Architecture

```text
Daily source files or API data
  -> Airflow DAG
  -> extract task
  -> validation task
  -> raw load task
  -> transformation task
  -> quality check task
  -> reporting or notification task
```

Recommended skeleton:

```text
05-airflow-scheduled-pipeline/
  README.md
  dags/
    retail_daily_pipeline.py
  include/
    sql/
    scripts/
  docker-compose.yml
  .env.example
  tests/
```

## Tools

- Apache Airflow for orchestration
- Python for pipeline task logic
- PostgreSQL for warehouse storage
- SQL for transformations and checks
- Docker Compose for local Airflow and PostgreSQL
- Optional email, Slack, or Teams alerts

## Data Sources

Suggested sources:

- Daily POS sales CSV
- Product catalog CSV
- Customer CSV
- Inventory snapshot CSV
- Optional API endpoint for online orders

Expected arrival pattern:

- Sales file arrives daily after store close.
- Inventory file arrives daily or weekly.
- Product and customer files change less frequently.

## Pipeline Steps

1. Wait for required source files or API availability.
2. Extract source data.
3. Validate schema, row count, and required fields.
4. Load data into raw tables.
5. Run transformations for analytics tables.
6. Run data quality checks.
7. Publish report tables or dashboard-ready marts.
8. Send success or failure notification.
9. Record task logs and run metadata.

Suggested Airflow tasks:

- `extract_sales`
- `extract_inventory`
- `validate_sources`
- `load_raw_tables`
- `run_transformations`
- `run_quality_checks`
- `publish_daily_report`
- `notify_result`

## Data Model

Suggested tables:

- `raw.sales`
- `raw.products`
- `raw.customers`
- `raw.inventory`
- `analytics.fact_sales`
- `analytics.mart_daily_sales`
- `analytics.mart_product_performance`
- `analytics.mart_inventory_reorder`
- `ops.pipeline_run_log`

Operational metadata:

- DAG run ID
- Execution date
- Source file names
- Row counts
- Quality check status
- Load timestamp

## Data Quality Checks

Minimum checks:

- Source files exist before loading.
- Source schema matches expected columns.
- Sales row count is greater than zero.
- Sale line IDs are unique.
- Quantity is greater than zero.
- Product and customer references are valid.
- Inventory quantities are not negative.
- Latest data freshness meets the service level agreement.

Operational checks:

- Pipeline should fail before publishing if quality checks fail.
- Retries should apply to temporary extraction failures.
- Backfills should not duplicate already loaded records.
- Alerts should include enough context to debug the issue.

## Expected Output

The finished project should produce:

- A scheduled Airflow DAG
- Task-level logs
- Raw and analytics database tables
- Daily sales and inventory marts
- Quality check results
- Success and failure notifications
- Documentation showing how to run, monitor, and backfill the pipeline

Example business questions answered:

- Did today’s pipeline run successfully?
- Are daily sales tables ready before business hours?
- Did any data quality check fail?
- Which source file caused the issue?
- Can we rerun a past date safely?

## Production Improvements

Future improvements:

- Add file sensors or object storage sensors.
- Add task-level SLAs.
- Add Slack or email alert routing.
- Add backfill documentation and runbooks.
- Add Airflow pools and concurrency limits.
- Add task retries with exponential backoff.
- Add idempotent partition-based loading.
- Add deployment through CI/CD.

## Skills Learned

- Airflow DAG design
- Scheduling and dependency management
- Backfill and rerun strategy
- Operational data quality checks
- Alerting and monitoring patterns
- Idempotent pipeline design
- Production workflow documentation

## Related Concepts

- [Orchestration Concepts](../../../08-orchestration/orchestration-concepts.md)
- [Airflow DAGs](../../../08-orchestration/airflow-dags.md)
- [Scheduling And Backfills](../../../08-orchestration/scheduling-and-backfills.md)
- [Retries Alerts Monitoring](../../../08-orchestration/retries-alerts-monitoring.md)
