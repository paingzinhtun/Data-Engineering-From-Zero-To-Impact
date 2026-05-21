# dbt Tests

## 1. What It Is

dbt tests are checks that validate assumptions about models and columns.

Common built-in tests include:

- `not_null`
- `unique`
- `relationships`
- `accepted_values`

Custom tests can check business-specific rules.

## 2. Why It Matters

Warehouse transformations can run successfully and still produce incorrect data. dbt tests help catch broken assumptions before bad data reaches dashboards.

Tests matter because they protect:

- Primary keys
- Foreign key relationships
- Metric inputs
- Accepted categories
- Required fields
- Business-critical marts

## 3. When to Use It

Use dbt tests when:

- A column must never be null.
- A model should have one row per key.
- A foreign key should match a dimension.
- A status field must contain expected values.
- A business rule should always hold.
- A mart feeds an important dashboard.

Every important model should have at least basic tests.

## 4. Real Business Example

A retail dashboard shows daily revenue. If `sale_id` duplicates appear in `fact_sales`, revenue may be overstated.

dbt tests can check:

- `sale_id` is unique.
- `sale_id` is not null.
- `product_id` exists in `dim_product`.
- `quantity_sold` is positive.
- `sales_channel` is `store` or `online`.

## 5. Technical Example

YAML tests:

```yaml
version: 2

models:
  - name: fact_sales
    description: One row per sales transaction line.
    columns:
      - name: sale_line_id
        tests:
          - not_null
          - unique
      - name: product_key
        tests:
          - not_null
          - relationships:
              to: ref('dim_product')
              field: product_key
      - name: sales_channel
        tests:
          - accepted_values:
              values: ['store', 'online']
```

Custom SQL test idea:

```sql
SELECT *
FROM {{ ref('fact_sales') }}
WHERE quantity_sold <= 0
```

If the query returns rows, the test fails.

## 6. Production Considerations

- Test keys and relationships on core models.
- Add business-rule tests for critical facts and marts.
- Decide which tests block deployment or production runs.
- Keep tests meaningful and maintainable.
- Avoid noisy tests that fail without action.
- Run tests in CI where possible.
- Monitor recurring failures.
- Document why custom tests exist.

## 7. Common Mistakes

- Adding no tests to important models.
- Testing only staging models and not marts.
- Writing tests that are too vague.
- Ignoring test failures.
- Using accepted values without updating them when business rules change.
- Adding many slow custom tests without considering runtime.
- Treating tests as a replacement for source data quality ownership.

## 8. Practice Task

Define dbt tests for these models:

1. `stg_sales`
2. `stg_products`
3. `dim_product`
4. `fact_sales`
5. `mart_daily_sales`

Include tests for:

- Not-null keys
- Unique keys
- Relationships
- Accepted values
- Positive quantities
- Non-negative revenue

## 9. Related Project

- `09-dbt-and-analytics-engineering/dbt-retail-project/`: Includes test expectations.
- `12-data-quality-testing-observability/`: Expands testing into broader data quality practices.
- `05-etl-elt-pipelines/data-validation.md`: Validation and dbt tests work together.
