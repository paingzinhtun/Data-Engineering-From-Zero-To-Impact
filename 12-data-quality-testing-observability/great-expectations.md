# Great Expectations

## 1. What It Is

Great Expectations is an open-source data quality framework for defining, running, and documenting expectations about data.

An expectation is a rule such as a column should not be null, values should be in a known set, or row counts should be within a range.

## 2. Why It Matters

Great Expectations helps teams make data validation explicit and reusable. It can produce validation results and documentation that explain whether datasets meet expectations.

It matters because it supports:

- Data quality checks.
- Validation suites.
- Documentation of assumptions.
- Pipeline integration.
- Reusable rules across datasets.
- Better communication between technical and business teams.

## 3. When to Use It

Use Great Expectations when:

- You need structured validation outside or alongside dbt.
- Pipelines process files, pandas DataFrames, Spark DataFrames, or database tables.
- Validation results should be documented.
- Data quality rules need to be reused.
- You want a dedicated framework for expectations.

For very small projects, plain SQL or Python checks may be enough.

## 4. Real Business Example

A retail business receives supplier inventory files every day.

Great Expectations can validate that:

- `product_id` is not null.
- `quantity_on_hand` is not negative.
- `snapshot_date` is recent.
- `supplier_id` is in an accepted list.
- Row count is within an expected range.

If validation fails, the pipeline can stop before bad inventory reaches reorder recommendations.

## 5. Technical Example

Conceptual expectations:

```python
validator.expect_column_values_to_not_be_null("product_id")
validator.expect_column_values_to_be_between(
    "quantity_on_hand",
    min_value=0,
)
validator.expect_column_values_to_be_in_set(
    "sales_channel",
    ["store", "online"],
)
validator.expect_table_row_count_to_be_between(
    min_value=100,
    max_value=100000,
)
```

These examples show the kind of rules Great Expectations can express. Exact project setup depends on the execution environment.

## 6. Production Considerations

- Keep expectation suites focused and meaningful.
- Decide which failures block pipelines.
- Store validation results.
- Review expectations when schemas change.
- Avoid excessive checks that slow pipelines.
- Assign ownership for critical suites.
- Integrate validation into orchestration.
- Document how to respond to failures.

## 7. Common Mistakes

- Adding expectations without business purpose.
- Treating warnings and failures the same.
- Not running validations automatically.
- Not storing validation results.
- Allowing expectations to become outdated.
- Creating noisy checks that teams ignore.
- Using a framework before understanding the quality rules.

## 8. Practice Task

Design a Great Expectations suite for retail sales.

Include expectations for:

1. Non-null sale IDs.
2. Unique sale line IDs.
3. Accepted sales channels.
4. Positive quantities.
5. Non-negative revenue.
6. Row count range.
7. Fresh sale dates.
8. Expected schema columns.

Explain which failures should stop the pipeline.

## 9. Related Project

- `03-python-for-data-engineering/testing-python-pipelines.md`: Python checks can grow into validation frameworks.
- `05-etl-elt-pipelines/data-validation.md`: Validation should be integrated into pipelines.
- `12-data-quality-testing-observability/data-quality-concepts.md`: Quality concepts guide which expectations to write.
