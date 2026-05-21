# dbt Models

## 1. What It Is

A dbt model is usually a SQL file that defines a table or view in the warehouse.

Each model represents one transformation step. dbt builds models in dependency order using references such as `ref()` and `source()`.

## 2. Why It Matters

Models are the core of a dbt project. They turn raw warehouse data into clean, documented, and reusable analytics datasets.

Good model design helps teams:

- Break complex SQL into understandable layers.
- Reuse transformation logic.
- Define clear table grain.
- Build reliable marts.
- Review changes in Git.
- Debug lineage when metrics look wrong.

## 3. When to Use It

Use dbt models when:

- You need repeatable SQL transformations.
- Raw tables need cleaning and standardization.
- Facts and dimensions need to be built.
- Business-facing marts need reliable logic.
- Several reports depend on the same transformation.

Avoid creating a model for every tiny temporary analysis query.

## 4. Real Business Example

A retail warehouse has raw sales data from POS and ecommerce sources.

dbt models can create:

- `stg_sales`: cleaned sales records
- `stg_products`: standardized product catalog
- `int_sales_enriched`: sales joined to product and customer context
- `fact_sales`: measurable sales fact table
- `mart_daily_sales`: daily business summary

Each model has a clear purpose and depends on earlier models.

## 5. Technical Example

Staging model:

```sql
-- models/staging/stg_sales.sql
SELECT
    CAST(sale_id AS TEXT) AS sale_id,
    CAST(sale_date AS DATE) AS sale_date,
    product_id,
    customer_id,
    CAST(quantity AS INTEGER) AS quantity,
    CAST(unit_price AS NUMERIC) AS unit_price,
    sales_channel
FROM {{ source('raw', 'sales') }}
```

Intermediate model:

```sql
-- models/intermediate/int_sales_enriched.sql
SELECT
    s.sale_id,
    s.sale_date,
    s.product_id,
    p.product_category,
    s.customer_id,
    s.quantity,
    s.unit_price,
    s.quantity * s.unit_price AS revenue
FROM {{ ref('stg_sales') }} AS s
LEFT JOIN {{ ref('stg_products') }} AS p
    ON s.product_id = p.product_id
```

## 6. Production Considerations

- Use clear model naming conventions.
- Keep staging models close to source structure.
- Put reusable logic in intermediate models.
- Build marts for business users.
- Define model materializations intentionally.
- Test model keys and relationships.
- Document grain and important columns.
- Avoid circular dependencies.

## 7. Common Mistakes

- Creating one giant model with all logic.
- Using unclear names like `final_table`.
- Building marts directly from raw sources.
- Not documenting model grain.
- Repeating the same transformation in several models.
- Overusing intermediate models without purpose.
- Forgetting that model materialization affects performance and cost.

## 8. Practice Task

Create a model plan for retail sales.

Define:

1. Two staging models.
2. One intermediate model.
3. One fact model.
4. One mart model.
5. Grain of each model.
6. Tests for each model.

## 9. Related Project

- `09-dbt-and-analytics-engineering/dbt-retail-project/`: Includes example model names and layers.
- `04-data-modeling/facts-and-dimensions.md`: Model design should follow fact and dimension principles.
- `06-data-warehousing/data-marts.md`: dbt marts serve business-facing analytics.
