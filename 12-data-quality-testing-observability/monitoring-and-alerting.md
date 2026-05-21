# Monitoring And Alerting

## 1. What It Is

Monitoring is the practice of tracking pipeline and data health over time. Alerting is notifying the right people when something requires attention.

Monitoring should cover both system behavior and data behavior.

## 2. Why It Matters

A pipeline can fail silently or produce incorrect data while still appearing successful. Monitoring and alerting help teams detect problems before users make decisions with bad or stale data.

They matter for:

- Freshness.
- Row counts.
- Runtime duration.
- Failed jobs.
- Schema changes.
- Quality check failures.
- Volume anomalies.
- Business metric anomalies.

## 3. When to Use It

Use monitoring and alerting for:

- Scheduled pipelines.
- Business-critical dashboards.
- Warehouse marts.
- Real-time streams.
- Data quality checks.
- External source dependencies.
- AI-ready datasets.

Not every warning needs an alert. Alert when action is required.

## 4. Real Business Example

A retail owner reviews `mart_daily_sales` every morning.

Monitoring should detect:

- The mart was not refreshed today.
- Row count dropped by 90 percent.
- Revenue is zero on a normal business day.
- A source schema changed.
- A critical dbt test failed.

An alert should include what failed, when it failed, likely impact, and what to check next.

## 5. Technical Example

Freshness check:

```sql
SELECT
    MAX(sales_date) AS latest_sales_date
FROM mart_daily_sales;
```

Row count monitor:

```sql
SELECT
    sales_date,
    COUNT(*) AS row_count
FROM fact_sales
GROUP BY sales_date
ORDER BY sales_date DESC;
```

Alert message:

```text
Dataset: mart_daily_sales
Issue: freshness failure
Latest date: 2026-01-14
Expected: 2026-01-15
Impact: daily sales dashboard may be stale
Owner: data_engineering
Next step: check retail_daily_pipeline run
```

## 6. Production Considerations

- Define freshness expectations.
- Define row count thresholds.
- Track pipeline duration.
- Alert only actionable failures.
- Include context in alerts.
- Route alerts to owners.
- Track repeated failures.
- Review noisy alerts.
- Keep runbooks for common incidents.

## 7. Common Mistakes

- Monitoring only infrastructure and not data.
- Alerting on every minor warning.
- Sending alerts without ownership.
- Not including impact in alert messages.
- Ignoring row count anomalies.
- Not tracking freshness.
- Failing silently when quality checks fail.
- Letting alert fatigue make teams ignore incidents.

## 8. Practice Task

Design monitoring for a retail daily sales mart.

Include:

1. Freshness rule.
2. Row count rule.
3. Revenue sanity rule.
4. Schema change rule.
5. Runtime duration rule.
6. Alert recipients.
7. Alert message format.
8. Runbook link or next steps.

## 9. Related Project

- `08-orchestration/retries-alerts-monitoring.md`: Pipeline alerts and retries.
- `12-data-quality-testing-observability/data-observability.md`: Broader observability concepts.
- `14-production-engineering/`: Monitoring connects to incident response.
