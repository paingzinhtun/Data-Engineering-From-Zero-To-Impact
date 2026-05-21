# Data Model

## Raw Tables

### `raw.sales`

Grain: one row per sale line.

Important columns:

- `sale_id`
- `sale_line_id`
- `sale_date`
- `product_id`
- `customer_id`
- `quantity`
- `unit_price`
- `discount_amount`
- `gross_sales`
- `net_sales`
- `cost_amount`
- `gross_profit`

### `raw.products`

Grain: one row per product.

### `raw.customers`

Grain: one row per customer.

### `raw.inventory`

Grain: one row per product inventory snapshot.

## Analytics Tables

### `analytics.dim_product`

Grain: one row per product.

Purpose: stores product attributes used for sales analysis and reorder reporting.

### `analytics.dim_customer`

Grain: one row per customer.

Purpose: stores customer attributes used for customer and segment analysis.

### `analytics.fact_sales`

Grain: one row per sale line with product and customer context.

### `analytics.mart_daily_sales`

Grain: one row per sales date.

### `analytics.mart_product_performance`

Grain: one row per product.

### `analytics.mart_inventory_reorder`

Grain: one row per product inventory record.

## Modeling Notes

- Raw tables preserve cleaned source-level records.
- Dimension tables provide descriptive product and customer context.
- The fact table stores measurable sales events.
- Mart tables answer common business questions with fewer joins.
- This is intentionally small, but it follows the same raw-to-dim/fact-to-mart pattern used in larger warehouses.
