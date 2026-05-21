# Airflow Project

This project shows how an Airflow DAG can represent a daily retail data pipeline.

The example DAG is intentionally simple and beginner-friendly. It is a skeleton, not a complete production pipeline.

## What The DAG Represents

The DAG models a daily workflow for a retail stationery shop.

Each day, the business needs sales data from a POS or ecommerce source to be validated, loaded, transformed, and checked before dashboards use it.

Task flow:

```text
extract_sales
  -> validate_sales
  -> load_raw_sales
  -> transform_sales
  -> run_quality_checks
```

## Task Purpose

### `extract_sales`

Gets raw sales data from a source system such as a CSV export, POS database, or ecommerce API.

### `validate_sales`

Checks whether the extracted data has the required fields, valid dates, positive quantities, and expected row counts.

### `load_raw_sales`

Loads validated source-shaped data into a raw table or raw storage layer.

### `transform_sales`

Creates cleaned and business-ready tables such as `fact_sales` or `mart_daily_sales`.

### `run_quality_checks`

Runs final checks before data is trusted by dashboards or downstream systems.

## Why This Matters

This DAG demonstrates the difference between a script and an orchestrated pipeline.

Airflow adds:

- Task order
- Schedule
- Retry behavior
- Run history
- Failure visibility
- Backfill capability

The business value is reliable daily reporting for sales, product performance, and operations.

## How To Use

Place `dags/retail_daily_pipeline.py` in an Airflow DAGs folder.

The task bodies are teaching stubs. Replace the stub bodies with real project code when implementing the pipeline.

Examples:

- Replace `extract_sales` with a CSV/API extraction function.
- Replace `validate_sales` with schema and row-level checks.
- Replace `load_raw_sales` with a database or lake load.
- Replace `transform_sales` with SQL or dbt transformations.
- Replace `run_quality_checks` with table-level tests.

## Production Notes

Before using this pattern in production:

- Move business logic into tested modules.
- Store credentials in Airflow connections or secrets.
- Make each task idempotent.
- Add meaningful logging.
- Add data quality checks.
- Define owners and alerts.
- Confirm the schedule matches source data arrival.
- Test backfills on a small date range.

## Related Sections

- `../orchestration-concepts.md`
- `../airflow-basics.md`
- `../airflow-dags.md`
- `../scheduling-and-backfills.md`
- `../retries-alerts-monitoring.md`
- `../../05-etl-elt-pipelines/`
