# Data Observability

## 1. What It Is

Data observability is the ability to understand the health of data systems by monitoring data, pipelines, metadata, lineage, freshness, volume, schema, and quality signals.

It goes beyond checking whether a job ran. It asks whether the data is complete, fresh, expected, and trustworthy.

## 2. Why It Matters

Modern data systems have many moving parts. A dashboard can be wrong because of a failed job, delayed source, schema change, broken join, duplicate load, or unexpected business event.

Data observability helps teams:

- Detect incidents faster.
- Understand downstream impact.
- Track freshness and volume.
- Monitor schema changes.
- Trace lineage.
- Investigate quality failures.
- Communicate impact to users.

## 3. When to Use It

Use data observability when:

- Many users depend on data products.
- Pipelines are scheduled and business-critical.
- Multiple upstream sources feed downstream marts.
- Data incidents are costly.
- Teams need lineage and impact analysis.
- Data quality must be monitored continuously.

For small beginner projects, start with simple logs and SQL checks. Add observability practices as complexity grows.

## 4. Real Business Example

A retail dashboard shows that revenue dropped 80 percent overnight.

Data observability helps investigate:

- Did the POS source file arrive?
- Did row count drop?
- Did the schema change?
- Did the sales pipeline fail?
- Did a join to products remove records?
- Which dashboards and users are affected?
- Is this a real business event or a data incident?

## 5. Technical Example

Observability signals:

```text
freshness: latest data timestamp
volume: row counts and file sizes
schema: columns and data types
quality: failed checks
lineage: upstream and downstream dependencies
runtime: pipeline duration and status
distribution: value ranges and anomalies
```

Example schema change check:

```sql
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'fact_sales'
ORDER BY ordinal_position;
```

Example lineage question:

```text
If stg_sales fails, which models and dashboards are affected?
```

## 6. Production Considerations

- Monitor freshness, volume, schema, and quality together.
- Track lineage for critical datasets.
- Define data owners.
- Set severity levels.
- Keep historical observability metrics.
- Connect alerts to runbooks.
- Review incidents and add prevention checks.
- Avoid collecting signals nobody uses.

## 7. Common Mistakes

- Treating observability as only pipeline status.
- Not tracking schema changes.
- Not understanding downstream impact.
- Alerting without context.
- Ignoring slow data drift.
- Monitoring everything with no ownership.
- Not learning from incidents.
- Buying tools before defining quality expectations.

## 8. Practice Task

Create an observability plan for a retail warehouse.

Include:

1. Critical datasets.
2. Freshness checks.
3. Volume checks.
4. Schema change checks.
5. Quality checks.
6. Lineage documentation.
7. Owners.
8. Alert severity levels.
9. Runbook actions.

## 9. Related Project

- `12-data-quality-testing-observability/monitoring-and-alerting.md`: Alerts are part of observability.
- `06-data-warehousing/warehouse-project/`: Warehouse marts should be observable.
- `20-real-world-case-studies/`: Case studies can include data incident analysis.
