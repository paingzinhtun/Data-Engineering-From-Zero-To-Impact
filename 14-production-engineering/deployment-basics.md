# Deployment Basics

## 1. What It Is

Deployment is the process of moving code, configuration, and supporting assets from a development environment into an environment where they can run reliably.

For Data Engineering, deployment may include pipeline scripts, dbt projects, Airflow DAGs, Docker images, SQL migrations, configuration files, and monitoring settings.

## 2. Why It Matters

A pipeline that works on one laptop is not production-ready. Production systems must run predictably, be repeatable, and be understandable by other people.

Deployment matters because it helps teams:

- Run pipelines outside a local machine.
- Control changes.
- Reduce manual setup.
- Recover from failures.
- Separate development and production.
- Create repeatable releases.

## 3. When to Use It

Use deployment practices when:

- A pipeline runs on a schedule.
- Business users depend on the output.
- More than one person maintains the project.
- Code runs in cloud, containers, orchestration tools, or servers.
- Changes need review before production.

For a short local exercise, manual execution may be acceptable. For business-critical data, deployment must be intentional.

## 4. Real Business Example

A retail daily sales pipeline starts as a local Python script. Once the operations team depends on the daily dashboard, the script should be deployed to a controlled environment.

The deployment might include:

- A Docker image with dependencies.
- Environment variables for paths and database connections.
- A scheduled Airflow DAG.
- Logs and alerts.
- A rollback plan.
- Documentation for reruns and backfills.

## 5. Technical Example

Simple deployment flow:

```text
developer branch
  -> code review
  -> automated tests
  -> build artifact
  -> deploy to staging
  -> validate
  -> deploy to production
```

Data pipeline deployment assets:

```text
src/
dags/
models/
requirements.txt
Dockerfile
docker-compose.yml
.env.example
README.md
```

## 6. Production Considerations

- Deploy from version control.
- Separate development, staging, and production settings.
- Use repeatable dependency installation.
- Avoid manual changes directly in production.
- Store secrets securely.
- Validate deployment after release.
- Keep rollback or recovery steps documented.
- Monitor the first run after deployment.

## 7. Common Mistakes

- Copying files manually into production.
- Running production jobs from a laptop.
- Hardcoding paths and credentials.
- Deploying without tests.
- Not documenting dependencies.
- Not having a rollback plan.
- Mixing development and production databases.
- Ignoring logs after deployment.

## 8. Practice Task

Take one pipeline project and define a deployment plan.

Include:

1. Runtime environment.
2. Required dependencies.
3. Configuration values.
4. Secret values.
5. Deployment steps.
6. Validation steps.
7. Rollback plan.
8. Monitoring after deployment.

## 9. Related Project

- `05-etl-elt-pipelines/templates/python-etl-template.py`: Starter pipeline code to prepare for deployment.
- `08-orchestration/airflow-project/`: Airflow DAGs need deployment practices.
- `13-cloud-data-engineering/`: Cloud deployment requires secure configuration and monitoring.
