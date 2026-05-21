# Retail Data Model Example

This example shows a simple dimensional model for a small retail stationery shop.

The shop sells notebooks, pens, paper, folders, calculators, and office supplies through store and online channels. The business wants trusted reporting for sales, product performance, and inventory reorder planning.

## Model Overview

The model includes:

- `dim_date`
- `dim_product`
- `dim_customer`
- `fact_sales`
- `fact_inventory_snapshot`
- `mart_daily_sales`
- `mart_product_performance`
- `mart_inventory_reorder`

## Grain Definitions

Grain is the most important modeling decision. It defines what one row means.

### `dim_date`

One row per calendar date.

Used to group and filter facts by day, week, month, quarter, and year.

### `dim_product`

One row per product version.

In this starter model, product attributes are current-state attributes. It can be extended later for slowly changing dimensions.

### `dim_customer`

One row per customer version.

In this starter model, customer segment and city are current-state attributes. It can be extended later for SCD Type 2 behavior.

### `fact_sales`

One row per product sold per sales transaction line.

Example: if one receipt includes a notebook and a pen, that receipt creates two `fact_sales` rows.

Measures:

- `quantity_sold`
- `unit_price`
- `unit_cost`
- `revenue`
- `cost_amount`
- `gross_profit`

### `fact_inventory_snapshot`

One row per product per snapshot date.

Example: if inventory is captured daily for 20 products, each day creates 20 inventory snapshot rows.

Measures:

- `quantity_on_hand`
- `reorder_level`
- `reorder_quantity`

Inventory is semi-additive. It can be summed across products, but summing inventory across dates usually does not make business sense.

### `mart_daily_sales`

One row per sales date.

Used for daily revenue, gross profit, units sold, and transaction count reporting.

### `mart_product_performance`

One row per product.

Used to compare revenue, units sold, gross profit, and most recent sale date.

### `mart_inventory_reorder`

One row per product for the latest inventory snapshot.

Used to identify products below reorder level and estimate reorder quantity.

## How To Use

Run the SQL file in PostgreSQL:

```bash
psql -d retail_modeling -f retail_star_schema.sql
```

The SQL creates tables and views. It does not load sample data yet.

## Learning Goals

After studying this example, you should be able to:

- Explain fact and dimension table grain.
- Understand why sales and inventory need different fact tables.
- Identify additive and semi-additive measures.
- Explain how marts simplify reporting.
- Extend the model for more realistic retail use cases.

## Extension Ideas

- Add sample seed data.
- Add `dim_store` for store locations.
- Add `dim_supplier` for supplier analysis.
- Add discounts, refunds, and cancelled sales.
- Add SCD Type 2 tracking for product category changes.
- Add a date spine population script.
- Add tests for key relationships and non-negative measures.

## Related Sections

- `../dimensional-modeling.md`
- `../facts-and-dimensions.md`
- `../slowly-changing-dimensions.md`
- `../metric-definitions.md`
- `../../06-data-warehousing/`
- `../../17-projects/`
