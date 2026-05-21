# Warehouse Concepts

## 1. What It Is

A data warehouse is a system designed to store, organize, and serve data for analytics, reporting, and decision-making.

Unlike operational databases, which support day-to-day transactions, warehouses are optimized for reading, aggregating, joining, and analyzing large amounts of historical data.

## 2. Why It Matters

Businesses need trusted reporting across many systems. A warehouse gives teams a central place to combine sales, inventory, customers, finance, marketing, and operations data.

Warehouses help Data Engineers:

- Separate analytics workloads from operational systems.
- Preserve historical data.
- Build reusable reporting layers.
- Create consistent metrics.
- Support BI dashboards.
- Prepare data for analytics and AI use cases.

## 3. When to Use It

Use a data warehouse when:

- Reports need data from multiple systems.
- Analysts repeatedly join the same datasets.
- Dashboards need consistent metrics.
- Historical reporting matters.
- Operational systems should not be overloaded by analytics queries.
- The business needs governed, documented, analytics-ready data.

For a very small project, a PostgreSQL database may be enough. As usage, data volume, and business needs grow, a warehouse becomes more useful.

## 4. Real Business Example

A retail stationery shop uses:

- POS data for in-store sales
- Ecommerce API data for online orders
- CSV supplier files for inventory
- CRM data for customer segments

The owner wants one dashboard showing revenue, gross profit, stockouts, customer repeat purchases, and product performance.

A warehouse combines these sources into raw, staging, dimension, fact, and mart layers so business users can trust the dashboard.

## 5. Technical Example

Common warehouse layers:

```text
raw
  Source-shaped data loaded with minimal changes.

staging
  Cleaned, renamed, typed, and lightly standardized data.

intermediate
  Reusable transformation logic and joins.

marts
  Business-ready tables for analytics and dashboards.
```

Example warehouse flow:

```text
raw_pos_sales
raw_ecommerce_orders
raw_inventory_csv
    -> stg_sales
    -> stg_products
    -> stg_inventory
    -> dim_product
    -> dim_customer
    -> fact_sales
    -> fact_inventory_snapshot
    -> mart_daily_sales
```

## 6. Production Considerations

- Define clear layer naming conventions.
- Preserve raw data when useful for audit and reprocessing.
- Document table grain.
- Test primary keys, foreign keys, and important business rules.
- Manage access by sensitivity and business need.
- Monitor freshness and row counts.
- Track costs for storage and compute.
- Avoid letting marts become undocumented one-off tables.

## 7. Common Mistakes

- Treating a warehouse as a dumping ground.
- Building dashboards directly on raw tables.
- Not defining table grain.
- Recreating the same metric logic in many reports.
- Ignoring data quality checks.
- Giving broad access to sensitive data.
- Not managing warehouse costs.
- Overengineering before the business needs it.

## 8. Practice Task

Design a warehouse layout for a retail business.

Include:

1. Three raw source tables.
2. Three staging tables.
3. Two dimensions.
4. Two fact tables.
5. Two marts.
6. Five metrics.
7. Three data quality checks.

Explain which business users would use each mart.

## 9. Related Project

- `06-data-warehousing/warehouse-project/`: Retail Analytics Warehouse project brief.
- `04-data-modeling/`: Warehouse design depends on facts, dimensions, grain, and metrics.
- `09-dbt-and-analytics-engineering/`: dbt-style workflows are often used to build warehouse layers.
