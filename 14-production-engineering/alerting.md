# Alerting

## 1. What It Is

Alerting is notifying the right person or system when something needs attention.

In Data Engineering, alerts may be triggered by failed jobs, stale data, failed quality checks, unexpected row counts, schema changes, or cost spikes.

## 2. Why It Matters

Business users may depend on data before anyone manually checks it. Alerts help teams detect and respond to problems before bad or stale data causes decisions.

Good alerting:

- Reduces time to detect failures.
- Communicates business impact.
- Routes issues to owners.
- Supports incident response.
- Prevents silent data failures.

## 3. When to Use It

Use alerts when:

- A critical pipeline fails.
- A dashboard dataset is stale.
- A data quality check fails.
- Row counts change unexpectedly.
- A schema changes unexpectedly.
- Costs exceed thresholds.
- A streaming consumer falls behind.

Do not alert on every minor warning. Alerts should be actionable.

## 4. Real Business Example

A retail inventory reorder mart is stale. The purchasing team may place orders using yesterday's stock levels.

An alert should say:

- Which dataset is stale.
- Latest available date.
- Expected date.
- Business impact.
- Owner.
- Suggested next step.

## 5. Technical Example

Alert message template:

```text
Severity: high
Pipeline: retail_daily_pipeline
Dataset: mart_inventory_reorder
Issue: freshness check failed
Expected: data through 2026-01-15
Actual: data through 2026-01-14
Impact: reorder recommendations may be stale
Owner: data_engineering
Next step: inspect Airflow task validate_sales
```

Alert categories:

```text
job failure
freshness failure
quality failure
schema change
volume anomaly
cost anomaly
security event
```

## 6. Production Considerations

- Define severity levels.
- Route alerts to owners.
- Include business impact.
- Include run ID, dataset, and failing check.
- Avoid alert fatigue.
- Review noisy alerts.
- Link alerts to runbooks.
- Track incident resolution.
- Alert on data health, not only job status.

## 7. Common Mistakes

- Sending alerts with no owner.
- Alerting without impact or next steps.
- Alerting on non-actionable warnings.
- Missing alerts for stale business-critical data.
- Not alerting on data quality failures.
- Ignoring alert fatigue.
- Sending secrets or sensitive data in alerts.
- Not reviewing repeated incidents.

## 8. Practice Task

Design alerts for a retail data platform.

Include:

1. Pipeline failure alert.
2. Freshness alert.
3. Row count anomaly alert.
4. Data quality failure alert.
5. Cost threshold alert.
6. Severity levels.
7. Alert recipients.
8. Runbook links or next steps.

## 9. Related Project

- `08-orchestration/retries-alerts-monitoring.md`: Airflow-style alerting concepts.
- `12-data-quality-testing-observability/monitoring-and-alerting.md`: Data monitoring and alert design.
- `14-production-engineering/production-checklist.md`: Alerting is part of production readiness.
