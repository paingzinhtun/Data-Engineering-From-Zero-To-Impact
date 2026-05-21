# 08 - Orchestration

## What This Section Covers

This section covers workflow scheduling, task dependencies, retries, backfills, monitoring, parameters, environments, and the operational behavior of data pipelines.

## Why It Matters In Data Engineering

A script that works once is not the same as a pipeline that runs reliably every day. Orchestration helps Data Engineers manage complexity, timing, dependencies, and recovery when something fails.

## What You Should Be Able To Do

After studying this section, you should be able to:

- Break a pipeline into clear tasks.
- Define dependencies between tasks.
- Schedule batch workflows.
- Configure retries and failure handling.
- Plan backfills and reruns.
- Explain pipeline status to technical and business users.

## Related Projects In This Repo

- `17-projects/`: Scheduled batch pipeline projects.
- `05-etl-elt-pipelines/`: Pipeline design patterns that orchestration tools execute.

## Start Here

Recommended order:

1. [orchestration-concepts.md](orchestration-concepts.md)
2. [airflow-basics.md](airflow-basics.md)
3. [airflow-dags.md](airflow-dags.md)
4. [scheduling-and-backfills.md](scheduling-and-backfills.md)
5. [retries-alerts-monitoring.md](retries-alerts-monitoring.md)
6. [airflow-project/](airflow-project/)

Project: [Airflow Scheduled Pipeline](../17-projects/intermediate/05-airflow-scheduled-pipeline/)

## Navigation

Previous: [07 - Data Lake And Lakehouse](../07-data-lake-and-lakehouse/)  
Next: [09 - dbt And Analytics Engineering](../09-dbt-and-analytics-engineering/)
