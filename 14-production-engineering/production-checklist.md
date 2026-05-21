# Production Checklist

## 1. What It Is

A production checklist is a structured review used before treating a data pipeline, warehouse model, or data product as production-ready.

It helps confirm that the system is reliable, secure, documented, testable, maintainable, and useful.

## 2. Why It Matters

Production data systems affect business decisions. A checklist reduces the chance of missed basics such as secrets, logging, tests, retries, monitoring, and documentation.

## 3. When to Use It

Use this checklist before:

- Scheduling a pipeline.
- Publishing a data mart.
- Connecting a dashboard to a table.
- Deploying an Airflow DAG.
- Sharing a portfolio project as professional evidence.
- Moving from local development to cloud or production.

## 4. Real Business Example

A retail daily sales pipeline is ready to support a morning dashboard.

Before production, the team reviews code quality, configuration, secrets, logging, data quality, idempotency, retries, backfills, monitoring, alerting, performance, cost, security, and documentation.

If any critical item is missing, the pipeline should not be considered reliable yet.

## 5. Technical Example

## Code Quality

- [ ] Code is readable and organized.
- [ ] Functions have clear responsibilities.
- [ ] SQL models have clear grain.
- [ ] Unused code and temporary files are removed.
- [ ] Naming is consistent.

## Configuration

- [ ] Environment-specific values are not hardcoded.
- [ ] Required environment variables are documented.
- [ ] `.env.example` exists if useful.
- [ ] Development and production settings are separated.
- [ ] Missing configuration fails clearly.

## Secrets

- [ ] No secrets are committed to Git.
- [ ] Secrets are stored in a secret manager or secure runtime configuration.
- [ ] Secret access follows least privilege.
- [ ] Logs do not expose credentials.
- [ ] Rotation or revocation process is known.

## Logging

- [ ] Pipeline start and finish are logged.
- [ ] Task names and run IDs are logged.
- [ ] Source and target row counts are logged.
- [ ] Errors include useful context.
- [ ] Sensitive data is not logged.

## Testing

- [ ] Unit tests exist for important Python transformation logic.
- [ ] SQL or dbt tests exist for key models.
- [ ] Tests run before deployment.
- [ ] Test data is safe and understandable.
- [ ] Known edge cases are tested.

## Data Quality

- [ ] Null checks exist for required fields.
- [ ] Duplicate checks exist for keys.
- [ ] Accepted values are tested.
- [ ] Referential integrity is checked.
- [ ] Freshness and row count checks exist.
- [ ] Revenue and quantity sanity checks exist.

## Idempotency

- [ ] Pipeline can be safely rerun.
- [ ] Unique keys or upsert logic prevent duplicates.
- [ ] Delete-and-reload logic is scoped correctly.
- [ ] Pipeline state updates only after success.
- [ ] Rerun behavior is documented.

## Retries

- [ ] Retryable failures are identified.
- [ ] Non-retryable failures are not blindly retried.
- [ ] Retry count and delay are configured.
- [ ] Retried tasks are idempotent.
- [ ] Repeated failures are visible.

## Backfills

- [ ] Backfill process is documented.
- [ ] Batch date logic is clear.
- [ ] Backfills use safe rerun logic.
- [ ] Historical metric changes are communicated.
- [ ] Backfill validation checks are defined.

## Monitoring

- [ ] Pipeline status is monitored.
- [ ] Freshness is monitored.
- [ ] Row counts are monitored.
- [ ] Runtime duration is monitored.
- [ ] Schema changes are monitored where needed.

## Alerting

- [ ] Alerts are actionable.
- [ ] Alert owners are defined.
- [ ] Severity levels are defined.
- [ ] Alerts include business impact.
- [ ] Runbook or next steps are linked.

## Performance

- [ ] Large queries are reviewed.
- [ ] Indexes, partitions, or clustering are considered where appropriate.
- [ ] File sizes are reasonable.
- [ ] Joins are validated for row explosion.
- [ ] Runtime meets business deadlines.

## Cost

- [ ] Cloud budgets or cost alerts exist.
- [ ] Unused compute is stopped or suspended.
- [ ] Dashboard queries avoid scanning unnecessary raw data.
- [ ] Storage retention is defined.
- [ ] Cost owners are known.

## Security

- [ ] Least-privilege access is applied.
- [ ] Sensitive data is identified.
- [ ] Raw sensitive data access is restricted.
- [ ] Encryption is used where appropriate.
- [ ] Audit logs are available where needed.

## Documentation

- [ ] README explains setup and usage.
- [ ] Inputs and outputs are documented.
- [ ] Table grain is documented.
- [ ] Metric definitions are documented.
- [ ] Known limitations are documented.
- [ ] Operational runbook exists for common failures.

## 6. Production Considerations

- Treat the checklist as a review tool, not paperwork.
- Apply stricter standards to business-critical systems.
- Revisit the checklist after incidents.
- Keep checklist items tied to real risks.
- Assign owners for unresolved items.

## 7. Common Mistakes

- Marking a pipeline production-ready because it ran once.
- Skipping documentation.
- Ignoring reruns and backfills.
- Not defining owners.
- Treating warnings as acceptable without business approval.
- Forgetting cost and security.
- Not revisiting readiness after changes.

## 8. Practice Task

Use this checklist on one project in the repository.

Record:

1. Items complete.
2. Items missing.
3. Risks created by missing items.
4. Priority fixes.
5. Owner for each fix.
6. Evidence that the fix was completed.

## 9. Related Project

- `17-projects/`: Apply this checklist before calling a project portfolio-ready.
- `05-etl-elt-pipelines/templates/pipeline-checklist.md`: Pipeline-specific checklist.
- `12-data-quality-testing-observability/`: Quality and monitoring practices.
