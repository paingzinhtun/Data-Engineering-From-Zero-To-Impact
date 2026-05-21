# Data Validation

## 1. What It Is

Data validation is the process of checking whether data meets expected rules before or after processing.

Validation can check files, schemas, data types, ranges, uniqueness, relationships, volumes, freshness, and business rules.

## 2. Why It Matters

A pipeline that runs successfully can still produce wrong data. Validation helps catch problems before they reach dashboards, reports, AI systems, or business decisions.

Data validation matters because it protects:

- Revenue reporting.
- Inventory decisions.
- Customer analytics.
- Supplier performance tracking.
- Finance reconciliation.
- AI-ready datasets.

Trustworthy data systems validate important assumptions.

## 3. When to Use It

Use validation:

- Before reading a file.
- After extracting from an API.
- Before loading into a database.
- After transformation.
- Before publishing a mart.
- During backfills.
- When source schemas change.
- When business-critical metrics are updated.

Validation should happen at multiple points in a pipeline.

## 4. Real Business Example

A stationery shop receives an inventory file from a warehouse system.

Validation checks might include:

- File exists.
- Required columns are present.
- Product IDs are not missing.
- Quantity on hand is not negative.
- Product IDs exist in the product catalog.
- Row count is within expected range.
- File date matches the expected processing date.

If validation fails, the pipeline should stop or quarantine the bad data.

## 5. Technical Example

Python validation:

```python
required_columns = {"product_id", "quantity_on_hand", "reorder_level"}
missing_columns = required_columns - set(inventory.columns)

if missing_columns:
    raise ValueError(f"Missing required columns: {sorted(missing_columns)}")

if (inventory["quantity_on_hand"] < 0).any():
    raise ValueError("Inventory contains negative quantity_on_hand values")
```

SQL validation:

```sql
SELECT product_id
FROM inventory
WHERE quantity_on_hand < 0;
```

Relationship validation:

```sql
SELECT s.product_id
FROM staging_sales AS s
LEFT JOIN products AS p
    ON s.product_id = p.product_id
WHERE p.product_id IS NULL;
```

## 6. Production Considerations

- Classify checks as warnings or failures.
- Stop pipelines for critical validation failures.
- Log validation results.
- Store rejected records when useful.
- Validate both row-level and aggregate-level rules.
- Compare record counts between source, staging, and target.
- Monitor schema drift.
- Document validation rules and owners.

## 7. Common Mistakes

- Validating only after bad data has reached users.
- Checking schema but not business rules.
- Logging validation errors without failing the pipeline.
- Not storing rejected records.
- Treating all validation failures as equally severe.
- Ignoring row count changes.
- Not validating joins.
- Assuming source systems always enforce valid data.

## 8. Practice Task

Create validation rules for a retail sales file.

Include checks for:

1. File exists.
2. Required columns exist.
3. `sale_id` is unique.
4. `product_id` is not null.
5. `quantity` is greater than zero.
6. `unit_price` is not negative.
7. `sale_date` is not in the future.
8. Product IDs exist in the product table.

Decide which failures should stop the pipeline.

## 9. Related Project

- `12-data-quality-testing-observability/`: Expands validation into broader testing and monitoring.
- `03-python-for-data-engineering/testing-python-pipelines.md`: Python tests support validation logic.
- `17-projects/`: Every project should include validation checks.
