# Airflow DAG Template

Use this template when designing a scheduled data workflow in Airflow.

## 1. DAG Purpose

Explain why the DAG exists.

Example:

> Run the daily retail sales pipeline after the POS export arrives, validate the data, load warehouse tables, and alert the team if quality checks fail.

## 2. DAG Metadata

| Field | Example |
| --- | --- |
| DAG ID | `retail_daily_sales_pipeline` |
| Owner | `data-engineering` |
| Schedule | `0 7 * * *` |
| Start date | `2026-01-01` |
| Catchup | `False` for most daily operational pipelines |
| Retries | `2` |
| Retry delay | `5 minutes` |

## 3. Task Design

Recommended task pattern:

```text
wait_for_source
  -> extract
  -> validate_source
  -> load_raw
  -> transform
  -> run_quality_checks
  -> publish_outputs
  -> notify_success
```

## 4. Task Responsibilities

| Task | Responsibility |
| --- | --- |
| `wait_for_source` | Confirm source data exists |
| `extract` | Pull or read source data |
| `validate_source` | Check schema and row counts |
| `load_raw` | Load unchanged source data |
| `transform` | Build warehouse or mart tables |
| `run_quality_checks` | Fail on bad data |
| `publish_outputs` | Refresh dashboard or report outputs |

## 5. Airflow Best Practices

- Keep business logic in Python modules or SQL files, not only inside the DAG file.
- Make tasks idempotent.
- Use Airflow connections or secrets backends for credentials.
- Use clear task names.
- Set retries only for failures that can recover.
- Avoid passing large data through XCom.
- Log useful row counts and paths.
- Design backfills before production use.

## 6. Data Quality Checks

- Source freshness
- Required columns
- Row count minimums
- Duplicate keys
- Null business keys
- Fact-to-dimension references
- Metric reconciliation

## 7. Alerting

Failure alerts should include DAG ID, task ID, execution date, error summary, source path or endpoint, a log link, and the owner or next action.

## 8. Backfill Notes

Before enabling catchup or manual backfills, define whether the pipeline is partitioned by date, whether reruns overwrite or merge data, how duplicates are avoided, and which downstream dashboards are affected.

## 9. Minimal DAG Skeleton

```python
from __future__ import annotations

from datetime import datetime, timedelta

from airflow.decorators import dag, task


default_args = {
    "owner": "data-engineering",
    "retries": 2,
    "retry_delay": timedelta(minutes=5),
}


@dag(
    dag_id="example_daily_pipeline",
    start_date=datetime(2026, 1, 1),
    schedule="0 7 * * *",
    catchup=False,
    default_args=default_args,
    tags=["template", "data-engineering"],
)
def example_daily_pipeline():
    @task
    def extract():
        return "extracted"

    @task
    def validate():
        return "validated"

    @task
    def load():
        return "loaded"

    @task
    def transform():
        return "transformed"

    @task
    def quality_checks():
        return "checks passed"

    extract() >> validate() >> load() >> transform() >> quality_checks()


example_daily_pipeline()
```
