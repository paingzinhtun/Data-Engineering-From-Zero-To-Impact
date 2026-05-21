# Validation Checks

## 1. What It Is

Validation checks are specific rules that data must satisfy. They can run on files, tables, models, pipeline outputs, or business metrics.

Examples include null checks, duplicate checks, row count checks, freshness checks, accepted values, referential integrity checks, negative quantity checks, revenue sanity checks, and schema change checks.

## 2. Why It Matters

Validation checks catch problems before bad data reaches reports, dashboards, ML models, or business operations.

They help Data Engineers:

- Stop invalid data early.
- Detect source changes.
- Prevent duplicate reporting.
- Protect important metrics.
- Find broken relationships.
- Build trust in analytics.

## 3. When to Use It

Use validation checks:

- Before processing raw files.
- After loading raw tables.
- After building staging tables.
- After building facts and dimensions.
- Before publishing marts.
- During incident investigation.
- After backfills.

Validation should match the risk and purpose of the dataset.

## 4. Real Business Example

A retail sales pipeline loads daily POS data.

Validation checks should catch:

- A missing `sale_id`.
- Duplicate sale lines.
- A sales channel outside `store` or `online`.
- A product ID not found in `dim_product`.
- Negative quantities.
- Revenue much higher than normal.
- A file with far fewer rows than expected.
- A new unexpected column from the POS system.

## 5. Technical Example

Null check:

```sql
SELECT COUNT(*) AS failed_rows
FROM stg_sales
WHERE sale_id IS NULL;
```

Duplicate check:

```sql
SELECT sale_line_id, COUNT(*) AS row_count
FROM fact_sales
GROUP BY sale_line_id
HAVING COUNT(*) > 1;
```

Accepted values:

```sql
SELECT DISTINCT sales_channel
FROM fact_sales
WHERE sales_channel NOT IN ('store', 'online');
```

Referential integrity:

```sql
SELECT f.product_key
FROM fact_sales AS f
LEFT JOIN dim_product AS p
    ON f.product_key = p.product_key
WHERE p.product_key IS NULL;
```

Revenue sanity:

```sql
SELECT *
FROM fact_sales
WHERE revenue < 0
   OR revenue > 100000;
```

## 6. Production Considerations

- Separate critical failures from warnings.
- Run cheap checks early.
- Run business-critical checks before publishing.
- Record check results.
- Alert owners for failures.
- Keep thresholds realistic.
- Review thresholds as the business grows.
- Document what action to take when a check fails.

## 7. Common Mistakes

- Writing checks but not running them automatically.
- Alerting on checks nobody owns.
- Using thresholds that never change.
- Failing pipelines for harmless warnings.
- Letting bad data pass because a check is too expensive.
- Ignoring schema changes.
- Checking only row-level rules and not aggregate metrics.

## 8. Practice Task

Create validation checks for an inventory table.

Include:

1. Product ID is not null.
2. Product ID is unique for the snapshot date.
3. Quantity on hand is not negative.
4. Reorder level is not negative.
5. Snapshot date is current.
6. Product exists in product dimension.
7. Row count is within expected range.
8. Schema matches expected columns.

## 9. Related Project

- `12-data-quality-testing-observability/quality-check-templates/sql-quality-checks.sql`: SQL examples.
- `09-dbt-and-analytics-engineering/dbt-tests.md`: dbt tests can implement many validation checks.
- `06-data-warehousing/warehouse-project/`: Warehouse marts need validation.
