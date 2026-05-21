# dbt Project Template

Use this template when creating a dbt project for analytics engineering, warehouse transformations, or governed business marts.

## 1. Project Purpose

Describe the business purpose of the dbt project.

Example:

> Transform raw retail sales, product, customer, and inventory data into tested, documented marts for dashboards and operational reporting.

## 2. Recommended Structure

```text
dbt-project/
  dbt_project.yml
  models/
    sources.yml
    staging/
    intermediate/
    marts/
  seeds/
  snapshots/
  tests/
  macros/
```

## 3. Model Layers

| Layer | Purpose | Example |
| --- | --- | --- |
| Sources | Declare raw tables | `raw.sales` |
| Staging | Clean one source at a time | `stg_sales` |
| Intermediate | Reusable business logic | `int_sales_enriched` |
| Marts | Business-facing outputs | `mart_daily_sales` |

## 4. Naming Conventions

- `stg_`: staging model
- `int_`: intermediate model
- `dim_`: dimension table
- `fact_`: fact table
- `mart_`: dashboard or business mart

## 5. Sources

```yaml
version: 2

sources:
  - name: raw
    tables:
      - name: sales
        loaded_at_field: loaded_at
        freshness:
          warn_after: {count: 24, period: hour}
          error_after: {count: 48, period: hour}
```

## 6. Tests

Minimum tests:

- `not_null`
- `unique`
- `relationships`
- `accepted_values`

```yaml
version: 2

models:
  - name: fact_sales
    columns:
      - name: sale_line_id
        tests:
          - not_null
          - unique
      - name: product_id
        tests:
          - relationships:
              to: ref('dim_product')
              field: product_id
```

## 7. Documentation

Document model purpose, model grain, key columns, metric definitions, source assumptions, and business owner.

```yaml
models:
  - name: mart_daily_sales
    description: Daily retail sales metrics used by operations and finance.
```

## 8. Materialization Guidance

| Model Type | Suggested Materialization |
| --- | --- |
| Small staging model | View |
| Large staging model | Table or incremental |
| Intermediate model | View or ephemeral |
| Fact table | Table or incremental |
| Business mart | Table |

## 9. Production Checklist

- `dbt build` succeeds.
- Sources have freshness checks.
- Important models have descriptions.
- Primary keys have tests.
- Facts have relationship tests.
- Business metrics are documented.
- Large models use incremental logic when needed.
- CI runs before deployment.

## 10. Common Mistakes

- Putting all logic directly in marts.
- Skipping staging models.
- Not documenting model grain.
- Testing only final outputs.
- Using inconsistent metric definitions.
- Creating too many models without clear business purpose.
