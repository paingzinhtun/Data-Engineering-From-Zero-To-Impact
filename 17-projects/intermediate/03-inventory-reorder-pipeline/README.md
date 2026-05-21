# Project 03: Inventory Reorder Pipeline

## Business Problem

A small retail or stationery business often runs out of popular products while keeping too much cash tied up in slow-moving stock. Reorder decisions are made manually from spreadsheets, which leads to missed sales, overstock, and inconsistent purchasing.

The business needs a data pipeline that recommends which products should be reordered based on stock levels, sales velocity, supplier lead time, and reorder rules.

## Goal

Build an inventory reorder pipeline that combines inventory snapshots, sales history, product data, and supplier information to produce practical reorder recommendations.

The project should focus on business impact, not only technical loading. Learners should understand how a data pipeline can support purchasing decisions.

## Architecture

```text
Sales history, inventory snapshots, product catalog, supplier file
  -> raw tables
  -> cleaned staging tables
  -> sales velocity calculations
  -> reorder logic
  -> reorder recommendation mart
  -> buyer report or dashboard
```

Recommended skeleton:

```text
03-inventory-reorder-pipeline/
  README.md
  docs/
    reorder-rules.md
    metric-definitions.md
  src/
    calculate_reorder.py
  sql/
    transformations.sql
    quality_checks.sql
  data/
    sample/
```

## Tools

- Python for source loading and optional calculations
- pandas for beginner-friendly transformation
- PostgreSQL for persistent tables
- SQL for analytics transformations
- Optional BI tool for reorder dashboard
- pytest for logic tests

## Data Sources

Suggested source files:

- `sales.csv`: sale line items by date and product
- `inventory.csv`: product stock by date and store
- `products.csv`: product category, cost, price, active status
- `suppliers.csv`: supplier name, lead time, minimum order quantity
- `purchase_orders.csv`: open purchase orders and expected arrival dates

Important fields:

- `product_id`
- `quantity_on_hand`
- `reorder_level`
- `daily_units_sold`
- `lead_time_days`
- `minimum_order_quantity`
- `open_purchase_quantity`
- `unit_cost`

## Pipeline Steps

1. Load sales, inventory, product, supplier, and purchase order data.
2. Clean product IDs, dates, quantities, and cost fields.
3. Calculate recent sales velocity, such as average daily units sold over 7, 14, and 30 days.
4. Estimate days of stock remaining.
5. Adjust available stock using open purchase orders.
6. Apply reorder rules by product and supplier.
7. Create a recommendation table with reorder status, suggested quantity, urgency, and reason.
8. Run quality checks.
9. Produce a report for business users.

## Data Model

Suggested tables:

- `raw.sales`
- `raw.inventory`
- `raw.products`
- `raw.suppliers`
- `raw.purchase_orders`
- `analytics.product_sales_velocity`
- `analytics.inventory_position`
- `analytics.reorder_recommendations`

Suggested grain:

- `product_sales_velocity`: one row per product per calculation date
- `inventory_position`: one row per product per store per snapshot date
- `reorder_recommendations`: one row per product per store per calculation date

Core calculated fields:

- `avg_daily_units_sold_7d`
- `avg_daily_units_sold_30d`
- `days_of_stock_remaining`
- `reorder_point`
- `suggested_reorder_quantity`
- `reorder_priority`
- `reorder_reason`

## Data Quality Checks

Minimum checks:

- Product IDs are present and consistent across files.
- Inventory quantity is not negative.
- Sales quantity is greater than zero.
- Supplier lead time is not negative.
- Minimum order quantity is greater than zero.
- Active products have a supplier assigned.
- Reorder recommendations do not include inactive products unless explicitly allowed.

Business checks:

- Products with zero stock and recent sales should be high priority.
- Products with high stock and low sales should not be recommended for reorder.
- Open purchase orders should reduce reorder urgency.

## Expected Output

The final output should include:

- Reorder recommendation table
- Buyer-friendly reorder report
- Product-level inventory status
- Sales velocity summary
- SQL or dashboard examples

Example business questions answered:

- Which products should I reorder today?
- Which products are likely to run out before the next supplier delivery?
- Which products have high stock but low sales?
- How much cash is tied up in slow-moving stock?
- Which suppliers have the longest replenishment risk?

## Production Improvements

Future improvements:

- Add automatic email or Slack alerts for urgent reorders.
- Add supplier delivery reliability.
- Add seasonality and promotion-aware demand estimates.
- Add safety stock rules by category.
- Add approval workflow before purchase order creation.
- Add forecast-based reorder logic.
- Add integration with accounting or inventory software.

## Skills Learned

- Translating business rules into data logic
- Inventory analytics
- Sales velocity calculations
- Reorder point design
- Data quality checks for operational decisions
- Building data products with measurable business impact

## Related Concepts

- [Inventory Reorder Use Case](../../../16-business-use-cases/retail/inventory-reorder.md)
- [Metric Definitions](../../../04-data-modeling/metric-definitions.md)
- [Data Validation](../../../05-etl-elt-pipelines/data-validation.md)
- [Production Checklist](../../../14-production-engineering/production-checklist.md)
