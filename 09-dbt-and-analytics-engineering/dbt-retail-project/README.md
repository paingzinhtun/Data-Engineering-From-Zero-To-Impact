# dbt Retail Project

## 1. What It Is

This project defines a dbt transformation project for retail analytics.

The goal is to transform raw retail warehouse tables into tested, documented, business-ready models for dashboards and decision-making.

## 2. Why It Matters

Retail businesses need consistent metrics for sales, inventory, products, customers, and operations.

A dbt project helps turn warehouse data into reliable models with:

- Modular SQL
- Clear dependencies
- Tests
- Documentation
- Lineage
- Reviewable code

## 3. When to Use It

Use this project after raw data has already been loaded into a warehouse.

It fits when:

- Raw sales, product, customer, and inventory tables exist.
- Transformations are mostly SQL-based.
- Dashboards need trusted marts.
- The team wants tests and docs.
- The project should be version-controlled.

It is not the ingestion layer. Use ETL or ELT pipelines to load raw tables first.

## 4. Real Business Example

A stationery shop loads raw POS sales, ecommerce orders, product catalog files, customer records, and inventory snapshots into a warehouse.

dbt transforms this raw data into:

- Clean staging models
- Enriched sales models
- Product and customer dimensions
- Sales facts
- Daily sales marts
- Inventory reorder marts

Business users can then analyze revenue, gross profit, product performance, stock risk, and customer behavior.

## 5. Technical Example

Project flow:

```text
Raw retail data
  -> staging models
  -> intermediate models
  -> marts
  -> tests
  -> docs
```

Example model lineage:

```text
raw.sales
  -> stg_sales
  -> int_sales_enriched
  -> fact_sales
  -> mart_daily_sales
```

Example model names:

```text
stg_sales
stg_products
int_sales_enriched
dim_product
dim_customer
fact_sales
mart_daily_sales
mart_inventory_reorder
```

Suggested structure:

```text
dbt_retail_project/
  models/
    staging/
      stg_sales.sql
      stg_products.sql
      stg_customers.sql
      stg_inventory_snapshots.sql
      sources.yml
    intermediate/
      int_sales_enriched.sql
    marts/
      core/
        dim_product.sql
        dim_customer.sql
        fact_sales.sql
      reporting/
        mart_daily_sales.sql
        mart_inventory_reorder.sql
  seeds/
    product_category_mapping.csv
  tests/
  macros/
```

Expected tests:

- `stg_sales.sale_id` is not null.
- `stg_products.product_id` is not null and unique.
- `fact_sales.sale_line_id` is unique.
- `fact_sales.product_key` relates to `dim_product.product_key`.
- `fact_sales.customer_key` relates to `dim_customer.customer_key`.
- `mart_daily_sales.sales_date` is not null and unique.
- Revenue is non-negative.
- Quantity sold is greater than zero.

Expected documentation:

- Model purpose
- Model grain
- Column descriptions
- Metric definitions
- Source freshness expectations
- Known limitations

## 6. Production Considerations

- Keep raw ingestion separate from dbt transformations.
- Define sources for raw tables.
- Keep staging models simple and source-aligned.
- Put reusable joins and calculations in intermediate models.
- Build marts for business users.
- Test critical keys and relationships.
- Document mart grain and metrics.
- Run dbt after ingestion completes.
- Use Git and code review.

## 7. Common Mistakes

- Loading source data with dbt when another ingestion tool is needed.
- Building marts directly from raw tables.
- Skipping intermediate models when logic is reused.
- Not testing keys and relationships.
- Not documenting model grain.
- Repeating metric logic in multiple marts.
- Ignoring source freshness.
- Creating too many models without clear purpose.

## 8. Practice Task

Build the dbt retail project in phases:

1. Define raw sources.
2. Build `stg_sales` and `stg_products`.
3. Add `stg_customers` and `stg_inventory_snapshots`.
4. Build `int_sales_enriched`.
5. Build `dim_product` and `dim_customer`.
6. Build `fact_sales`.
7. Build `mart_daily_sales`.
8. Build `mart_inventory_reorder`.
9. Add tests.
10. Add docs.
11. Generate and inspect lineage.

## 9. Related Project

- `06-data-warehousing/warehouse-project/`: Warehouse project that dbt can implement.
- `04-data-modeling/retail-data-model-example/`: Star schema design reference.
- `12-data-quality-testing-observability/`: dbt tests are one layer of data quality.
- `17-projects/`: This can become a portfolio-grade analytics engineering project.
