# Data Quality Template

Use this template to design practical data quality checks for any data engineering project.

## 1. Quality Goals

Define what quality means for this project.

Examples:

- Sales reports should not include duplicate sale lines.
- Inventory quantities should never be negative.
- Dashboards should be refreshed before 8:00 AM.
- Product references in sales should exist in the product table.

## 2. Quality Dimensions

| Dimension | Question |
| --- | --- |
| Completeness | Is required data present? |
| Uniqueness | Are keys duplicated? |
| Validity | Do values follow expected rules? |
| Consistency | Do related tables agree? |
| Freshness | Is the data recent enough? |
| Accuracy | Does the data match trusted sources? |
| Integrity | Are relationships valid? |

## 3. Source Checks

- Required file exists.
- Required API response is available.
- Required columns exist.
- Source row count is greater than zero.
- Source freshness is within expectation.
- File format is readable.

## 4. Schema Checks

- Expected columns exist.
- Unexpected critical schema changes are detected.
- Data types are valid.
- Date fields parse correctly.
- Numeric fields parse correctly.

## 5. Record Checks

- Primary key is not null.
- Primary key is unique.
- Required business fields are not null.
- Quantity is greater than zero.
- Revenue is not negative.
- Status values are accepted.
- Email or phone fields follow expected format where needed.

## 6. Relationship Checks

- Sales product IDs exist in products.
- Sales customer IDs exist in customers.
- Inventory product IDs exist in products.
- Fact table keys resolve to dimensions.

## 7. Reconciliation Checks

- Raw row counts reconcile to staging row counts after expected filters.
- Fact totals reconcile to mart totals.
- Dashboard totals match mart totals.
- Monthly revenue matches finance export where applicable.

## 8. Freshness Checks

Track last source arrival time, last successful load time, last transformation time, and last dashboard refresh time.

Example rule:

> `mart_daily_sales` must be refreshed by 8:00 AM every business day.

## 9. Severity Levels

| Severity | Meaning | Action |
| --- | --- | --- |
| Critical | Data cannot be trusted | Fail pipeline and alert |
| Warning | Data may be usable with caution | Log and notify owner |
| Info | Useful monitoring signal | Record in quality report |

## 10. Quality Check Register

| Check Name | Table | Rule | Severity | Owner |
| --- | --- | --- | --- | --- |
| `sales_unique_line_id` | `fact_sales` | `sale_line_id` is unique | Critical | Data engineering |
| `inventory_not_negative` | `fact_inventory_snapshot` | `quantity_on_hand >= 0` | Critical | Operations |
| `daily_sales_freshness` | `mart_daily_sales` | Refreshed by 8:00 AM | Warning | Analytics |

## 11. Example SQL Checks

```sql
-- Duplicate sale line IDs
SELECT sale_line_id
FROM fact_sales
GROUP BY sale_line_id
HAVING COUNT(*) > 1;

-- Negative inventory
SELECT product_id, quantity_on_hand
FROM fact_inventory_snapshot
WHERE quantity_on_hand < 0;

-- Missing product references
SELECT sale_line_id, product_id
FROM fact_sales
WHERE product_id NOT IN (
    SELECT product_id
    FROM dim_product
);
```

## 12. Production Notes

- Quality checks should run before publishing data.
- Critical failures should stop downstream reporting.
- Failed records should be stored for review when possible.
- Alerts should include table, check name, severity, and example failed rows.
- Quality results should be visible, not hidden in logs only.
