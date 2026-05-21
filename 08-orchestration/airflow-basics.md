# Airflow Basics

## 1. What It Is

Apache Airflow is an open-source workflow orchestration tool. It lets Data Engineers define pipelines as code, schedule them, monitor runs, retry failures, and manage task dependencies.

In Airflow, workflows are called DAGs, which stands for directed acyclic graphs.

## 2. Why It Matters

Airflow is widely used in Data Engineering because many pipelines are recurring workflows with dependencies and operational requirements.

Airflow helps teams:

- Define pipelines in Python.
- Schedule daily, hourly, or custom workflows.
- View task status in a UI.
- Retry failed tasks.
- Run historical backfills.
- Track execution history.
- Coordinate work across systems.

## 3. When to Use It

Use Airflow when:

- Pipelines have multiple dependent tasks.
- Jobs must run on a schedule.
- You need visibility into failures.
- Backfills are required.
- Teams want pipelines defined as code.
- Different systems need to be coordinated.

Airflow may be too much for a single small script, but it is useful once workflows become repeated and business-critical.

## 4. Real Business Example

A stationery retailer needs a daily pipeline that loads POS sales, online orders, and inventory snapshots.

Airflow can schedule the pipeline every morning, run extraction before transformation, retry temporary database failures, and show which task failed if the dashboard is not refreshed.

## 5. Technical Example

Basic Airflow concepts:

```text
DAG: workflow definition
Task: one unit of work
Operator: template for a task type
Schedule: when the DAG runs
Dependency: task order
Run: one execution of a DAG
Retry: automatic rerun after failure
```

Simple task dependency:

```python
extract_sales >> validate_sales >> load_raw_sales
```

This means `validate_sales` runs after `extract_sales`, and `load_raw_sales` runs after `validate_sales`.

## 6. Production Considerations

- Keep DAG files readable.
- Make tasks small enough to debug.
- Do not put heavy processing directly in DAG parsing code.
- Use connections or secrets for credentials.
- Set owners, retries, and alert behavior.
- Use clear task IDs.
- Log useful operational details.
- Test pipeline logic outside Airflow where possible.

## 7. Common Mistakes

- Writing all pipeline logic inside the DAG file.
- Creating one huge task.
- Forgetting retries or failure alerts.
- Hardcoding credentials.
- Depending on local files that do not exist in the Airflow environment.
- Confusing DAG parse time with task runtime.
- Using Airflow before understanding the pipeline itself.

## 8. Practice Task

Write a simple Airflow DAG design for daily inventory processing.

Define:

1. DAG name.
2. Schedule.
3. Tasks.
4. Dependencies.
5. Retry settings.
6. Expected output.
7. Failure behavior.

Do this as a design first, then implement the DAG skeleton.

## 9. Related Project

- `08-orchestration/airflow-project/dags/retail_daily_pipeline.py`: Beginner-friendly DAG skeleton.
- `05-etl-elt-pipelines/templates/python-etl-template.py`: Pipeline code that Airflow can orchestrate.
- `14-production-engineering/`: Airflow workflows need operational standards.
