# Airflow DAGs

## 1. What It Is

An Airflow DAG is a Python-defined workflow. DAG stands for directed acyclic graph.

Directed means tasks have a defined direction. Acyclic means the workflow cannot loop back on itself. Graph means the workflow is made of connected tasks.

## 2. Why It Matters

DAGs turn pipeline design into executable workflow code. A well-written DAG communicates what the pipeline does, when it runs, which tasks depend on each other, and how failures should behave.

Good DAG design helps Data Engineers:

- Debug failures faster.
- Keep workflows maintainable.
- Avoid hidden dependencies.
- Support backfills.
- Monitor task status.
- Communicate pipeline behavior clearly.

## 3. When to Use It

Use an Airflow DAG when:

- You have a workflow with ordered tasks.
- The workflow needs scheduling.
- Tasks should be retried independently.
- You need run history.
- Backfills may be needed.
- Business users depend on the output.

Do not put every tiny utility script into Airflow unless it belongs to a managed workflow.

## 4. Real Business Example

A daily sales DAG for a retail stationery shop might contain:

- `extract_sales`
- `validate_sales`
- `load_raw_sales`
- `transform_sales`
- `run_quality_checks`

If validation fails, later steps should not run. This prevents bad sales data from reaching dashboards.

## 5. Technical Example

Common DAG structure:

```python
from datetime import datetime

from airflow.decorators import dag, task


@dag(
    dag_id="retail_daily_pipeline",
    start_date=datetime(2026, 1, 1),
    schedule="@daily",
    catchup=False,
)
def retail_daily_pipeline():
    @task
    def extract_sales():
        return "sales extracted"

    @task
    def validate_sales(extract_result: str):
        return f"validated: {extract_result}"

    validate_sales(extract_sales())


retail_daily_pipeline()
```

TaskFlow style passes outputs between tasks using function calls, while the DAG still controls execution.

## 6. Production Considerations

- Keep DAG definitions deterministic.
- Avoid expensive work during DAG import.
- Use clear task names.
- Set `start_date` intentionally.
- Understand `catchup` behavior.
- Use retries for temporary failures.
- Store credentials in Airflow connections or secrets.
- Keep business logic in importable pipeline modules when projects grow.

## 7. Common Mistakes

- Setting a dynamic `start_date` such as current time.
- Putting database queries at DAG parse time.
- Creating circular dependencies.
- Using unclear task names.
- Setting `catchup=True` without planning historical runs.
- Not testing task logic separately.
- Treating DAG code as the only documentation.

## 8. Practice Task

Create a DAG skeleton for a daily inventory pipeline.

Include tasks:

1. `extract_inventory`
2. `validate_inventory`
3. `load_raw_inventory`
4. `transform_inventory`
5. `run_quality_checks`

Define dependencies and add comments explaining what each task should do.

## 9. Related Project

- `08-orchestration/airflow-project/`: Contains a retail daily pipeline DAG.
- `08-orchestration/scheduling-and-backfills.md`: DAG behavior depends heavily on schedule and catchup settings.
- `05-etl-elt-pipelines/idempotency.md`: Airflow tasks should be safe to retry.
