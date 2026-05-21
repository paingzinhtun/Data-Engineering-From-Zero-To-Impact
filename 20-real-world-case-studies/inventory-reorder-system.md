# Inventory Reorder System

## 1. Business Context

A stationery shop manages hundreds of products, including notebooks, pens, markers, paper, art supplies, and office accessories. The owner often discovers stockouts only after customers ask for missing products. At the same time, slow-moving items take up shelf space and cash.

The business needs a practical reorder system that recommends what to buy and why.

## 2. Problem

Current inventory problems:

- Reorder decisions are manual.
- Popular products run out before supplier orders arrive.
- Slow-moving products are reordered unnecessarily.
- Open purchase orders are not considered.
- Supplier lead times are not part of the decision.

The business needs data-driven reorder recommendations that are explainable and easy for a buyer to review.

## 3. Data Sources

Required sources:

- Sales history
- Inventory snapshots
- Product catalog
- Supplier list

Recommended sources:

- Purchase orders
- Supplier lead times
- Product cost and price
- Promotions
- Stock adjustments

Key fields:

- `product_id`
- `store_id`
- `sale_date`
- `quantity_sold`
- `quantity_on_hand`
- `reorder_level`
- `supplier_id`
- `lead_time_days`
- `minimum_order_quantity`
- `open_purchase_quantity`

## 4. Architecture

```text
Sales, inventory, products, suppliers, purchase orders
  -> raw tables
  -> staging tables
  -> sales velocity model
  -> inventory position model
  -> reorder recommendation mart
  -> buyer dashboard and alerts
```

Recommended implementation:

- PostgreSQL for analytics tables
- Python or SQL for reorder logic
- Scheduled batch refresh
- Dashboard or exported buyer report

## 5. Data Model

Core tables:

- `dim_product`
- `dim_supplier`
- `dim_store`
- `fact_sales`
- `fact_inventory_snapshot`
- `fact_purchase_order`

Marts:

- `mart_sales_velocity`
- `mart_inventory_position`
- `mart_reorder_recommendation`
- `mart_slow_moving_products`

Grain:

- `mart_reorder_recommendation`: one row per product per store per recommendation date
- `mart_sales_velocity`: one row per product per store per calculation date

## 6. Pipeline Design

1. Load sales, inventory, product, supplier, and purchase order data.
2. Validate product and supplier references.
3. Calculate average daily units sold over 7, 14, and 30 days.
4. Calculate available stock including open purchase orders.
5. Estimate days of stock remaining.
6. Apply reorder rules and minimum order quantities.
7. Assign priority and recommendation reason.
8. Publish buyer-ready output.

## 7. Data Quality Strategy

Critical checks:

- Inventory quantity is not negative.
- Sales quantity is greater than zero.
- Active products have supplier records.
- Supplier lead time is available for reorderable products.
- Product IDs match across sales, inventory, and supplier files.
- Open purchase orders are not double-counted.

Business checks:

- Products with high stock and low sales should not be recommended.
- Products with zero stock and recent sales should be high priority.
- Recommendations should include a reason.

## 8. Key Metrics

- Average daily units sold
- Quantity on hand
- Open purchase quantity
- Days of stock remaining
- Reorder point
- Suggested reorder quantity
- Stockout risk
- Inventory value
- Slow-moving stock value
- Supplier lead time

## 9. Dashboard or Output

Recommended outputs:

- Reorder recommendation table
- Buyer action list
- Stockout risk dashboard
- Slow-moving products report
- Supplier replenishment risk report

Example questions:

- What should I reorder today?
- Which products may stock out this week?
- Which products have high stock but low sales?
- Which supplier delays create risk?
- How much cash is tied up in slow-moving stock?

## 10. AI/Automation Extension

Useful extensions:

- Generate daily reorder email.
- Explain each reorder recommendation in plain English.
- Draft purchase order suggestions for buyer approval.
- Summarize slow-moving stock by category.
- Alert when high-margin items are near stockout.

Guardrail:

- AI should recommend and explain, not automatically place purchase orders without approval.

## 11. Business Impact

Expected impact:

- Reduces stockout risk.
- Improves purchasing decisions.
- Reduces excess stock.
- Protects cash flow.
- Helps buyers focus on urgent products.
- Makes reorder decisions more consistent.

## 12. Implementation Plan

Phase 1:

- Build product, sales, and inventory tables.
- Create simple low-stock report.

Phase 2:

- Add sales velocity and days of stock remaining.

Phase 3:

- Add supplier lead time and open purchase orders.

Phase 4:

- Add dashboard, alerts, and AI explanations.

## 13. Risks and Tradeoffs

Risks:

- Sales history may not predict seasonal demand.
- Supplier lead times may be inaccurate.
- Inventory snapshots may be late or manually adjusted.
- Promotions can distort sales velocity.

Tradeoffs:

- Simple reorder rules are transparent but less accurate than forecasting.
- Forecasting can improve recommendations but adds complexity and explainability challenges.
- Daily batch refresh is usually enough for SMEs; real-time inventory is only needed for high-volume operations.

## 14. Related Projects

- `16-business-use-cases/retail/inventory-reorder.md`
- `17-projects/intermediate/03-inventory-reorder-pipeline/`
- `17-projects/capstone/inventory-optimization-system/`
- `15-ai-ready-data-engineering/ai-data-project/`
