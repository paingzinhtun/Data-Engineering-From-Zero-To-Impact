# Soda

## 1. What It Is

Soda is a data quality tool used to define and run checks against datasets. Checks can validate nulls, duplicates, row counts, freshness, accepted values, and custom rules.

Soda checks are often written in a readable configuration style, making them approachable for data teams.

## 2. Why It Matters

Soda helps teams monitor data quality in databases, warehouses, and pipelines. It makes quality rules explicit and repeatable.

It matters because it can help detect:

- Missing values.
- Duplicate keys.
- Stale tables.
- Unexpected row counts.
- Invalid categories.
- Failed business rules.
- Metric anomalies.

## 3. When to Use It

Use Soda when:

- You want readable data quality checks.
- You need checks across warehouse tables.
- You want to monitor freshness and volume.
- Quality rules should run as part of pipelines.
- A dedicated quality tool is useful for the team.

For very small learning projects, SQL checks or dbt tests may be enough.

## 4. Real Business Example

A retail analytics warehouse has a `mart_daily_sales` table.

Soda checks could validate:

- `sales_date` is unique.
- `revenue` is not negative.
- `mart_daily_sales` is fresh.
- Row count is greater than zero.
- `sales_channel` only contains accepted values.

These checks help prevent dashboard users from seeing broken daily metrics.

## 5. Technical Example

Conceptual Soda checks:

```yaml
checks for fact_sales:
  - row_count > 0
  - missing_count(sale_line_id) = 0
  - duplicate_count(sale_line_id) = 0
  - invalid_count(sales_channel) = 0:
      valid values: ['store', 'online']
  - failed rows:
      fail query: |
        SELECT *
        FROM fact_sales
        WHERE quantity_sold <= 0
```

Freshness-style check concept:

```yaml
checks for mart_daily_sales:
  - freshness(sales_date) < 2d
```

Exact syntax and capabilities depend on the Soda version and connector.

## 6. Production Considerations

- Keep checks tied to business impact.
- Run checks after important transformations.
- Alert only when action is needed.
- Store check results.
- Review thresholds regularly.
- Separate warning and failure checks.
- Document ownership.
- Integrate checks with orchestration.

## 7. Common Mistakes

- Adding checks without owners.
- Making every anomaly a critical alert.
- Not version-controlling check definitions.
- Ignoring freshness.
- Not validating key relationships.
- Allowing check files to drift away from schema changes.
- Treating a tool as a substitute for data ownership.

## 8. Practice Task

Design Soda-style checks for `fact_inventory_snapshot`.

Include:

1. Row count greater than zero.
2. Product key not null.
3. No duplicate product and snapshot date combinations.
4. Quantity on hand is not negative.
5. Reorder level is not negative.
6. Snapshot date is fresh.
7. Product key exists in `dim_product`.

## 9. Related Project

- `12-data-quality-testing-observability/monitoring-and-alerting.md`: Quality checks should connect to monitoring and alerts.
- `06-data-warehousing/data-marts.md`: Business-facing marts benefit from quality tools.
- `08-orchestration/retries-alerts-monitoring.md`: Orchestrators can run Soda checks after transformations.
