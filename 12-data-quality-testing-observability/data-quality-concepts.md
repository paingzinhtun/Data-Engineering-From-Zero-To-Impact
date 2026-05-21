# Data Quality Concepts

## 1. What It Is

Data quality describes whether data is fit for its intended use. Good data is not just present; it is accurate, complete, timely, consistent, valid, unique, and understandable.

In Data Engineering, quality is built through checks, tests, monitoring, documentation, and clear ownership.

## 2. Why It Matters

Business users make decisions from data. If the data is wrong, late, duplicated, or misunderstood, the business may make bad decisions with confidence.

Data quality matters for:

- Sales reporting.
- Inventory reorder decisions.
- Customer analytics.
- Finance reconciliation.
- Supplier performance tracking.
- AI and machine learning inputs.
- Operational alerts.

Trust is one of the most important outputs of Data Engineering.

## 3. When to Use It

Use data quality checks:

- During file ingestion.
- After API extraction.
- Before loading into target tables.
- After transformations.
- Before publishing marts.
- During backfills.
- After schema changes.
- Before training or using AI systems.

Important data should be checked at multiple points, not only at the end.

## 4. Real Business Example

A retail stationery shop uses a dashboard to decide which products to reorder.

If inventory quantities are negative, stale, or missing products, the team may reorder the wrong items or miss stockouts.

Quality checks can detect:

- Missing product IDs.
- Duplicate inventory records.
- Negative quantities.
- Stale inventory snapshots.
- Product IDs that do not exist in the product table.
- Unexpected row count drops.

## 5. Technical Example

Common quality dimensions:

```text
Completeness: required fields are not null
Uniqueness: primary keys do not duplicate
Validity: values follow expected rules
Consistency: relationships and definitions agree
Timeliness: data is fresh enough
Accuracy: data reflects reality
```

Example SQL checks:

```sql
-- Null check
SELECT COUNT(*) AS missing_product_ids
FROM fact_sales
WHERE product_id IS NULL;

-- Duplicate check
SELECT sale_line_id, COUNT(*) AS row_count
FROM fact_sales
GROUP BY sale_line_id
HAVING COUNT(*) > 1;

-- Freshness check
SELECT MAX(sale_date) AS latest_sale_date
FROM fact_sales;
```

## 6. Production Considerations

- Define quality checks based on business risk.
- Decide which failures block the pipeline.
- Track quality results over time.
- Assign owners for critical datasets.
- Monitor freshness and volume.
- Store rejected records when useful.
- Document known limitations.
- Review quality checks when business rules change.

## 7. Common Mistakes

- Checking only that a pipeline ran.
- Ignoring silent data problems.
- Treating all checks as equally important.
- Not documenting why a check exists.
- Not alerting when critical data is stale.
- Adding checks that fail often but nobody acts on.
- Measuring quality without ownership.
- Assuming source systems always produce valid data.

## 8. Practice Task

Choose a retail sales table and define checks for:

1. Null `sale_id`.
2. Duplicate `sale_line_id`.
3. Negative `quantity`.
4. Negative `revenue`.
5. Invalid `sales_channel`.
6. Missing product relationship.
7. Unexpected row count drop.
8. Stale latest sale date.

Classify each check as warning or failure.

## 9. Related Project

- `12-data-quality-testing-observability/quality-check-templates/`: Starter dbt and SQL checks.
- `05-etl-elt-pipelines/data-validation.md`: Validation is part of pipeline quality.
- `17-projects/`: Every portfolio project should include quality checks.
