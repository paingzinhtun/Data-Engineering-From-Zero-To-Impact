# What Is dbt

## 1. What It Is

dbt, short for data build tool, is a tool for transforming data inside a data warehouse using SQL and software engineering practices.

dbt does not usually extract data from source systems. It focuses on the transformation layer: turning raw or staged warehouse data into tested, documented, analytics-ready models.

## 2. Why It Matters

Many teams build warehouse transformations as scattered SQL scripts. dbt helps organize those transformations into models with dependencies, tests, documentation, and lineage.

dbt matters because it helps Data Engineers and analytics engineers:

- Write modular SQL.
- Build staging, intermediate, and mart layers.
- Test important assumptions.
- Generate documentation.
- Review changes through Git.
- Understand lineage from source to dashboard.
- Make business metrics more consistent.

## 3. When to Use It

Use dbt when:

- Data is already loaded into a warehouse.
- Transformations are mostly SQL-based.
- Teams need repeatable analytics models.
- Business metrics need consistency.
- Models should be tested and documented.
- Changes should be reviewed in Git.

Do not use dbt as a replacement for ingestion tools, orchestration, or source system integration.

## 4. Real Business Example

A retail stationery shop loads raw POS sales and ecommerce orders into a warehouse.

dbt can transform that raw data into:

- Clean sales staging models
- Product and customer dimensions
- Sales fact tables
- Daily sales marts
- Inventory reorder marts

The final models feed dashboards for revenue, gross profit, stockouts, and product performance.

## 5. Technical Example

Example dbt flow:

```text
raw_sales
  -> stg_sales
  -> int_sales_enriched
  -> fact_sales
  -> mart_daily_sales
```

Example model SQL:

```sql
SELECT
    sale_id,
    sale_date,
    product_id,
    customer_id,
    quantity,
    unit_price,
    quantity * unit_price AS revenue
FROM {{ ref('stg_sales') }}
WHERE sale_status = 'completed'
```

`ref()` tells dbt that this model depends on another model.

## 6. Production Considerations

- Keep model layers clear.
- Use Git for review and history.
- Add tests for primary keys, relationships, and accepted values.
- Document business-critical models.
- Avoid putting all logic in one model.
- Use environments carefully.
- Coordinate dbt runs with ingestion schedules.
- Monitor model freshness and failures.

## 7. Common Mistakes

- Using dbt before understanding SQL and modeling.
- Building marts directly from raw tables without staging.
- Skipping tests.
- Treating dbt docs as optional.
- Creating unclear model names.
- Repeating metric logic in multiple marts.
- Confusing dbt transformations with data extraction.

## 8. Practice Task

Design a dbt flow for retail sales.

Include:

1. Raw source tables.
2. Staging models.
3. Intermediate models.
4. Fact and dimension models.
5. Marts.
6. Tests.
7. Documentation.

Explain what each layer is responsible for.

## 9. Related Project

- `09-dbt-and-analytics-engineering/dbt-retail-project/`: Retail dbt project brief.
- `06-data-warehousing/`: dbt often builds warehouse models and marts.
- `04-data-modeling/`: dbt models should follow clear grain and metric definitions.
