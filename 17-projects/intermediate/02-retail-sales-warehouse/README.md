# Project 02: Retail Sales Warehouse

## Business Problem

A stationery retailer has data spread across point-of-sale exports, product spreadsheets, customer files, and inventory reports. Each department calculates sales, margin, and stock performance differently. The business needs one trusted warehouse where sales, product, customer, and inventory metrics are consistently defined.

## Goal

Design and build a retail analytics warehouse that moves source data through raw, staging, dimensional, fact, and mart layers.

The project should demonstrate warehouse modeling, SQL transformations, business metric definitions, and BI-ready outputs.

## Architecture

```text
CSV, POS, inventory, and customer data
  -> raw tables
  -> staging tables
  -> dimension tables
  -> fact tables
  -> marts
  -> dashboard or SQL reports
```

Recommended skeleton:

```text
02-retail-sales-warehouse/
  README.md
  docs/
    business-metrics.md
    data-dictionary.md
  sql/
    raw/
    staging/
    marts/
    quality/
  data/
    sample/
```

## Tools

- PostgreSQL for the warehouse
- SQL for modeling and transformations
- Python or database import tools for loading source files
- dbdiagram.io, Mermaid, or Markdown for model documentation
- Optional BI tool such as Metabase, Power BI, or Looker Studio

## Data Sources

Suggested source files:

- `sales.csv`: sale transactions and line items
- `products.csv`: product attributes, category, brand, unit cost
- `customers.csv`: customer profile and segment
- `inventory.csv`: daily or weekly stock snapshots
- `stores.csv`: store or branch details

Core source entities:

- Sales transactions
- Product catalog
- Customers
- Inventory snapshots
- Store locations

## Pipeline Steps

1. Load source files into raw tables without changing business meaning.
2. Standardize names, dates, IDs, and numeric fields in staging tables.
3. Create dimensions for date, product, customer, and store.
4. Create facts for sales and inventory snapshots.
5. Create marts for daily sales, product performance, customer summary, and reorder analysis.
6. Apply data quality checks at each layer.
7. Document table grain, metric definitions, and known assumptions.

## Data Model

Suggested schemas:

- `raw`: source-aligned tables
- `staging`: cleaned source tables
- `warehouse`: dimensions and facts
- `mart`: business-ready reporting tables

Suggested tables:

- `warehouse.dim_date`
- `warehouse.dim_product`
- `warehouse.dim_customer`
- `warehouse.dim_store`
- `warehouse.fact_sales`
- `warehouse.fact_inventory_snapshot`
- `mart.mart_daily_sales`
- `mart.mart_product_performance`
- `mart.mart_customer_value`
- `mart.mart_inventory_reorder`

Grain examples:

- `fact_sales`: one row per sale line item
- `fact_inventory_snapshot`: one row per product per store per snapshot date
- `mart_daily_sales`: one row per date
- `mart_product_performance`: one row per product for a reporting period

## Data Quality Checks

Minimum checks:

- Primary keys are unique in dimensions.
- Fact records have valid dimension references.
- Sales quantity is greater than zero.
- Unit price and cost are not negative.
- Net sales equals gross sales minus discounts.
- Inventory quantity is not negative.
- Required dates are not null.
- Row counts reconcile between staging and fact layers.

Business checks:

- Gross margin percentage is within a reasonable range.
- Products marked inactive do not dominate recent sales unless expected.
- Reorder recommendations only apply to active products.

## Expected Output

The project should produce a warehouse that answers:

- What are daily sales, units sold, gross profit, and margin?
- Which product categories generate the highest profit?
- Which products are low stock and should be reordered?
- Which customers generate the most repeat revenue?
- Which stores or channels are underperforming?

Expected deliverables:

- Warehouse schema SQL
- Transformation SQL
- Data dictionary
- Business metric definitions
- Quality check SQL
- Example dashboard layout or screenshots when implemented

## Production Improvements

Future improvements:

- Add dbt for model management, tests, and documentation.
- Add orchestration with Airflow.
- Add snapshots for slowly changing product and customer attributes.
- Add incremental fact loading.
- Add warehouse cost and query performance optimization.
- Add semantic layer definitions for shared metrics.
- Add BI dashboard deployment instructions.

## Skills Learned

- Dimensional modeling
- Star schema design
- Fact and dimension grain definition
- Retail KPI design
- SQL transformation design
- Data quality checks for warehouse layers
- Analytics-ready documentation

## Related Concepts

- [Dimensional Modeling](../../../04-data-modeling/dimensional-modeling.md)
- [Facts And Dimensions](../../../04-data-modeling/facts-and-dimensions.md)
- [Warehouse Concepts](../../../06-data-warehousing/warehouse-concepts.md)
- [Data Marts](../../../06-data-warehousing/data-marts.md)
