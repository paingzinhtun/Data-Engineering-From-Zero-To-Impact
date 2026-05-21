# Project 04: dbt Retail Transformations

## Business Problem

A retail business has raw sales, product, customer, and inventory data in a warehouse, but the SQL transformations are scattered across notebooks, scripts, and BI tools. Metric definitions are inconsistent, tests are missing, and nobody has a reliable lineage view.

The business needs a dbt project that turns raw retail data into documented, tested, reusable analytics models.

## Goal

Build a dbt project for retail analytics with staging models, intermediate models, marts, tests, documentation, and clear metric definitions.

The project should show that the learner understands analytics engineering practices, not only SQL syntax.

## Architecture

```text
Warehouse raw tables
  -> dbt sources
  -> staging models
  -> intermediate models
  -> dimensions and facts
  -> marts
  -> dbt tests and docs
  -> BI dashboard
```

Recommended skeleton:

```text
04-dbt-retail-transformations/
  README.md
  dbt_project.yml
  models/
    sources.yml
    staging/
    intermediate/
    marts/
  seeds/
  tests/
  macros/
```

## Tools

- dbt Core or dbt Cloud
- PostgreSQL, BigQuery, Snowflake, or DuckDB as the warehouse
- SQL for transformations
- YAML for tests and documentation
- Optional BI tool for dashboarding

## Data Sources

Expected source tables:

- `raw.sales`
- `raw.products`
- `raw.customers`
- `raw.inventory`

Optional seeds:

- Product category mapping
- Store mapping
- Accepted customer segments
- Calendar or holiday data

## Pipeline Steps

1. Define dbt sources for raw retail tables.
2. Build staging models that clean names, types, dates, and IDs.
3. Build intermediate models for enriched sales and inventory calculations.
4. Build dimension and fact models.
5. Build marts for daily sales, product performance, inventory reorder, and customer value.
6. Add generic tests for uniqueness, not null, accepted values, and relationships.
7. Add singular tests for business rules.
8. Generate dbt documentation and lineage graph.
9. Document metric definitions and model grain.

## Data Model

Suggested dbt models:

- `stg_sales`
- `stg_products`
- `stg_customers`
- `stg_inventory`
- `int_sales_enriched`
- `int_inventory_position`
- `dim_product`
- `dim_customer`
- `fact_sales`
- `fact_inventory_snapshot`
- `mart_daily_sales`
- `mart_product_performance`
- `mart_inventory_reorder`
- `mart_customer_value`

Model grain:

- `stg_sales`: one row per raw sale line
- `int_sales_enriched`: one row per sale line with product and customer context
- `fact_sales`: one row per sale line with standardized metrics
- `mart_daily_sales`: one row per sale date
- `mart_inventory_reorder`: one row per product per inventory snapshot

## Data Quality Checks

Generic dbt tests:

- `not_null` on primary keys and required dates
- `unique` on dimension keys and sale line IDs
- `relationships` from facts to dimensions
- `accepted_values` for customer segment, channel, and inventory status

Singular business tests:

- Quantity must be greater than zero.
- Net sales must not exceed gross sales.
- Gross profit should equal net sales minus cost amount.
- Active products should have product names and categories.
- Reorder recommendations should not include products with healthy stock.

## Expected Output

The finished project should produce:

- A dbt project structure
- Clean staging models
- Reusable intermediate models
- Dimensional models and marts
- dbt tests
- dbt documentation
- A lineage graph
- A business-ready analytics layer

Example business questions answered:

- What was daily revenue and margin?
- Which products generate the most profit?
- Which products need reorder?
- Which customer segments are most valuable?
- Which source tables feed each metric?

## Production Improvements

Future improvements:

- Add CI checks for `dbt build`.
- Add slim CI for changed models only.
- Add incremental materializations for large fact tables.
- Add snapshots for slowly changing products and customers.
- Add exposures for BI dashboards.
- Add model ownership and alert routing.
- Add semantic layer metrics.

## Skills Learned

- dbt project structure
- Source freshness and source documentation
- Staging, intermediate, and mart model design
- dbt testing
- dbt docs and lineage
- Analytics engineering workflows
- Metric governance

## Related Concepts

- [What Is dbt](../../../09-dbt-and-analytics-engineering/what-is-dbt.md)
- [dbt Models](../../../09-dbt-and-analytics-engineering/dbt-models.md)
- [dbt Tests](../../../09-dbt-and-analytics-engineering/dbt-tests.md)
- [Metric Definitions](../../../04-data-modeling/metric-definitions.md)
