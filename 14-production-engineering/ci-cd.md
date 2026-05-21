# CI CD

## 1. What It Is

CI/CD means Continuous Integration and Continuous Delivery or Deployment.

Continuous Integration runs automated checks when code changes. Continuous Delivery prepares changes for release. Continuous Deployment automatically releases changes when checks pass.

In Data Engineering, CI/CD can test Python code, SQL models, dbt projects, documentation, and configuration before changes reach production.

## 2. Why It Matters

Data pipelines can break because of small code, SQL, schema, or configuration changes. CI/CD reduces the risk by running checks consistently.

It helps teams:

- Catch errors before production.
- Enforce code quality.
- Run tests automatically.
- Review changes safely.
- Deploy repeatably.
- Build confidence in pipeline changes.

## 3. When to Use It

Use CI/CD when:

- A project is maintained in Git.
- Multiple people contribute.
- Pipelines support business reporting.
- dbt models or Python transformations need tests.
- Deployments should be repeatable.

For early learning projects, start with simple checks and expand over time.

## 4. Real Business Example

A data engineer changes `fact_sales` logic to handle refunds. Before merging, CI runs:

- SQL formatting checks.
- dbt model tests.
- Python unit tests.
- Documentation checks.

If revenue tests fail, the change is blocked before it breaks the retail dashboard.

## 5. Technical Example

Simple CI workflow:

```text
pull request opened
  -> install dependencies
  -> run linting
  -> run unit tests
  -> run dbt compile
  -> run dbt tests
  -> approve and merge
```

Example commands:

```bash
python -m pytest
dbt compile
dbt test
```

## 6. Production Considerations

- Keep CI fast enough for regular use.
- Run critical tests before merge.
- Use separate credentials for CI.
- Never expose secrets in logs.
- Test deployment steps before relying on them.
- Require review for production changes.
- Include rollback strategy.
- Track failed checks and fix flaky tests.

## 7. Common Mistakes

- Skipping tests because pipelines are "just SQL".
- Running checks locally only.
- Putting production secrets in CI variables without controls.
- Ignoring flaky tests.
- Making CI so slow that developers avoid it.
- Deploying automatically without enough validation.
- Not testing data quality rules.

## 8. Practice Task

Design CI for a retail analytics project.

Include:

1. Python tests.
2. SQL or dbt checks.
3. Documentation checks.
4. Secret handling.
5. Pull request rules.
6. Deployment trigger.
7. Failure behavior.
8. Required approvals.

## 9. Related Project

- `03-python-for-data-engineering/testing-python-pipelines.md`: Unit testing foundation.
- `09-dbt-and-analytics-engineering/dbt-tests.md`: dbt tests can run in CI.
- `14-production-engineering/production-checklist.md`: CI/CD is one part of production readiness.
