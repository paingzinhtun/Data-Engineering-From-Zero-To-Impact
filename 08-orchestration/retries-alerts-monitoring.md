# Retries Alerts Monitoring

## 1. What It Is

Retries, alerts, and monitoring are operational controls that help pipelines recover from temporary failures and notify people when attention is needed.

- **Retries:** Automatically rerun failed tasks.
- **Alerts:** Notify owners when a pipeline fails or behaves unexpectedly.
- **Monitoring:** Track pipeline health, freshness, row counts, duration, and quality signals.

## 2. Why It Matters

Data pipelines fail for many reasons: APIs timeout, files arrive late, databases restart, schemas change, or validation checks fail.

Retries and monitoring help distinguish temporary issues from real data problems. Alerts make sure failures are visible before business users make decisions with stale or incorrect data.

## 3. When to Use It

Use retries when:

- Failures may be temporary.
- APIs or databases occasionally timeout.
- Source systems are briefly unavailable.

Use alerts when:

- A pipeline misses a business deadline.
- A critical validation fails.
- Data freshness is late.
- Row counts are unexpectedly low or high.

Use monitoring for every recurring production pipeline.

## 4. Real Business Example

A daily retail inventory pipeline calls a supplier API. The API sometimes returns a temporary server error.

A retry may fix the issue after a few minutes.

But if the pipeline still fails after retries, an alert should notify the data owner. If inventory data is stale, the purchasing team should know before placing orders.

## 5. Technical Example

Airflow retry settings:

```python
@task(retries=2, retry_delay=timedelta(minutes=5))
def extract_sales():
    ...
```

Monitoring checks:

```text
freshness: mart_daily_sales updated today
volume: sales row count between expected minimum and maximum
duration: pipeline completed within 30 minutes
quality: no negative revenue values
```

Alert message example:

```text
Pipeline failed: retail_daily_pipeline
Task failed: validate_sales
Run date: 2026-01-15
Reason: missing required column product_id
Action: check source POS export
```

## 6. Production Considerations

- Retry only tasks that are safe to rerun.
- Do not retry data quality failures blindly.
- Set alert severity based on business impact.
- Include useful context in alert messages.
- Monitor freshness, row counts, and duration.
- Track repeated flaky failures.
- Define ownership and escalation.
- Avoid alert fatigue from noisy non-actionable alerts.

## 7. Common Mistakes

- Retrying non-idempotent loads and creating duplicates.
- Retrying validation failures that require human action.
- Sending alerts without enough context.
- Alerting too often for low-risk issues.
- Not alerting for stale business-critical data.
- Monitoring only task success, not data quality.
- Ignoring slow increases in runtime.

## 8. Practice Task

Create an operational plan for a retail daily sales pipeline.

Define:

1. Which tasks should retry.
2. Which failures should not retry.
3. Retry count and delay.
4. Alert recipients.
5. Alert message content.
6. Freshness checks.
7. Row count checks.
8. Quality checks.

## 9. Related Project

- `08-orchestration/airflow-project/`: DAG skeleton includes retry settings.
- `12-data-quality-testing-observability/`: Data quality and monitoring are expanded there.
- `14-production-engineering/`: Alerting and incident response are production practices.
