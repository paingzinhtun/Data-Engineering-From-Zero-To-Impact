# Retail Analytics Warehouse

## 1. What It Is

Retail Analytics Warehouse is a portfolio project for building a practical warehouse for a retail stationery business.

The project turns raw sales, customer, product, inventory, and supplier data into trusted analytics tables and BI-ready data marts.

## 2. Why It Matters

Retail businesses need reliable answers to operational questions:

- Which products sell best?
- Which categories generate the most gross profit?
- Which products are close to stockout?
- Which customers buy repeatedly?
- Which sales channel performs better?
- Which inventory decisions need attention?

This project shows how warehouse modeling connects raw business data to decisions.

## 3. When to Use It

Use this project after learning:

- SQL basics
- Relational modeling
- Dimensional modeling
- ETL and ELT concepts
- Data validation
- Basic Python or warehouse loading patterns

It can be implemented locally with PostgreSQL or adapted to BigQuery, Snowflake, or Redshift.

## 4. Real Business Example

A stationery shop sells products through a physical POS system and an ecommerce store.

Source data includes:

- CSV exports from POS sales
- API data from ecommerce orders
- Product catalog files
- Customer records
- Inventory snapshots
- Supplier delivery files

The business wants a warehouse that supports daily dashboards and inventory decisions.

## 5. Technical Example

Architecture:

```text
CSV/API/POS data
  -> raw tables
  -> staging tables
  -> dimension/fact tables
  -> data marts
  -> BI dashboard
```

Recommended layers:

```text
raw
  raw_pos_sales
  raw_ecommerce_orders
  raw_products
  raw_customers
  raw_inventory_snapshots

staging
  stg_sales
  stg_products
  stg_customers
  stg_inventory_snapshots

core
  dim_date
  dim_product
  dim_customer
  fact_sales
  fact_inventory_snapshot

marts
  mart_daily_sales
  mart_product_performance
  mart_inventory_reorder
  mart_customer_purchase_summary
```

Expected metrics:

- Revenue
- Gross profit
- Gross margin percentage
- Units sold
- Transaction count
- Average order value
- Revenue by category
- Revenue by channel
- Low-stock product count
- Reorder quantity
- Customer total spend
- Customer purchase frequency

Business questions:

- What was daily revenue for the last 30 days?
- Which product categories produce the most gross profit?
- Which products are below reorder level?
- Which products sell well but have low inventory?
- Which customers have the highest total spend?
- How do online and store sales compare?
- What is the gross margin by product category?
- Which products have not sold recently?

## 6. Production Considerations

- Preserve raw source data for debugging and backfills.
- Define table grain for every staging, fact, and mart table.
- Validate row counts between source, staging, and facts.
- Use consistent metric definitions.
- Add checks for missing product and customer keys.
- Monitor mart freshness.
- Document dashboard assumptions.
- Protect customer data with appropriate access controls.

## 7. Common Mistakes

- Building dashboards directly from raw files.
- Skipping staging tables.
- Not defining fact grain.
- Mixing POS and ecommerce data without standardizing fields.
- Calculating revenue differently in different marts.
- Ignoring inventory snapshot grain.
- Not checking for duplicate sales.
- Treating this as only a SQL exercise instead of a business system.

## 8. Practice Task

Build the project in phases:

1. Create raw tables.
2. Load sample CSV or API data.
3. Create staging tables with cleaned column names and types.
4. Build `dim_date`, `dim_product`, and `dim_customer`.
5. Build `fact_sales` and `fact_inventory_snapshot`.
6. Build the marts.
7. Write data quality checks.
8. Create a dashboard or query pack for business users.
9. Write a portfolio case study explaining architecture, grain, metrics, and tradeoffs.

## 9. Related Project

- `04-data-modeling/retail-data-model-example/`: Star schema foundation.
- `05-etl-elt-pipelines/`: Pipeline patterns for loading and transforming warehouse data.
- `09-dbt-and-analytics-engineering/`: Transformation and documentation workflow for warehouse models.
- `17-projects/`: This project can become a full portfolio lab.
