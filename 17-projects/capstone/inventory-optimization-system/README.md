# Inventory Optimization System

## 1. Business Problem

Retailers and SMEs often lose money in two opposite ways: they run out of fast-moving products and overstock slow-moving products. Both problems hurt cash flow. Stockouts cause lost sales and frustrated customers, while overstock ties up money and storage space.

Many small businesses manage reorder decisions manually using spreadsheets, intuition, or supplier suggestions. These methods rarely combine sales velocity, current stock, open purchase orders, supplier lead time, and margin impact.

This capstone builds a data system that helps the business decide what to reorder, when to reorder, and which products require attention.

## 2. Target Users

Primary users:

- Inventory manager
- Purchasing manager
- Store owner
- Operations manager

Secondary users:

- Finance manager
- Store manager
- Supplier relationship manager
- Data analyst

## 3. System Goal

Build an inventory optimization system that combines sales, inventory, product, and supplier data to produce reorder recommendations and inventory risk insights.

Core goals:

- Identify products that need reorder.
- Detect slow-moving stock.
- Estimate days of stock remaining.
- Prioritize reorder actions by urgency and business value.
- Reduce stockouts and overstock.
- Make inventory decisions explainable.

## 4. Architecture

```text
Sales history, inventory snapshots, products, suppliers, purchase orders
  -> ingestion pipelines
  -> raw and staging tables
  -> inventory analytics models
  -> reorder recommendation engine
  -> dashboards, alerts, and buyer reports
```

Recommended phases:

- Phase 1: SQL-based reorder mart
- Phase 2: Python pipeline for sales velocity and reorder logic
- Phase 3: Scheduled daily refresh
- Phase 4: Dashboard and alerting
- Phase 5: Forecasting or optimization model

## 5. Data Sources

Required sources:

- Sales transactions
- Product catalog
- Inventory snapshots
- Supplier list

Recommended sources:

- Purchase orders
- Supplier lead times
- Product categories
- Product cost and selling price
- Promotions or seasonal calendar
- Stock adjustment records

Important fields:

- `product_id`
- `store_id`
- `sale_date`
- `quantity_sold`
- `quantity_on_hand`
- `reorder_level`
- `unit_cost`
- `unit_price`
- `supplier_id`
- `lead_time_days`
- `minimum_order_quantity`
- `open_purchase_quantity`

## 6. Data Model

Recommended tables:

- `dim_product`
- `dim_supplier`
- `dim_store`
- `fact_sales`
- `fact_inventory_snapshot`
- `fact_purchase_order`
- `mart_sales_velocity`
- `mart_inventory_position`
- `mart_reorder_recommendation`
- `mart_slow_moving_products`

Key grains:

- `fact_sales`: one row per sale line item
- `fact_inventory_snapshot`: one row per product per store per snapshot date
- `fact_purchase_order`: one row per purchase order line
- `mart_reorder_recommendation`: one row per product per store per recommendation date

Core metrics:

- Average daily units sold
- Days of stock remaining
- Reorder point
- Suggested reorder quantity
- Stockout risk level
- Inventory value
- Gross margin contribution
- Sell-through rate
- Slow-moving stock value

## 7. Pipelines

Suggested pipelines:

- Daily sales ingestion
- Inventory snapshot ingestion
- Product and supplier refresh
- Purchase order ingestion
- Sales velocity calculation
- Inventory position calculation
- Reorder recommendation generation
- Slow-moving stock detection
- Dashboard refresh and alerting

Pipeline logic:

1. Load latest sales and inventory data.
2. Validate product and supplier references.
3. Calculate rolling sales velocity over 7, 14, and 30 days.
4. Estimate days of stock remaining.
5. Adjust available stock with open purchase orders.
6. Apply reorder rules.
7. Assign priority level and explanation.
8. Publish recommendations.
9. Alert on urgent stockout risk.

## 8. Data Quality Strategy

Critical checks:

- Product IDs are valid across sales, inventory, and suppliers.
- Inventory quantity is not negative.
- Sales quantity is greater than zero.
- Supplier lead time is not null for active products.
- Reorder recommendations do not include inactive products.
- Open purchase orders are not double-counted.
- Latest inventory snapshot exists for each active product.

Business checks:

- High-stock, low-sales products should not be recommended for reorder.
- Out-of-stock products with recent sales should be high priority.
- Products without sales history should use conservative default rules.
- Suggested order quantity should respect minimum order quantity.

## 9. Dashboards or Outputs

Recommended outputs:

- Reorder recommendation dashboard
- Stockout risk report
- Slow-moving inventory report
- Supplier lead time dashboard
- Inventory value summary
- Buyer action list

Recommended columns for buyer report:

- Product
- Store
- Current stock
- Reorder level
- Average daily units sold
- Days of stock remaining
- Open purchase quantity
- Suggested reorder quantity
- Priority
- Explanation

Example business questions:

- Which products should be reordered today?
- Which products are likely to stock out this week?
- Which products have too much stock?
- Which suppliers create the highest replenishment risk?
- How much cash is tied up in slow-moving inventory?

## 10. AI/Automation Features

Useful automation:

- Daily reorder email to purchasing manager
- Alerts for stockout risk
- Automatic draft purchase order generation
- Supplier delay warnings
- Slow-moving stock recommendations

AI features:

- Explain why a product was recommended for reorder.
- Summarize inventory risk by category.
- Answer questions such as "What should I buy this week?"
- Generate supplier negotiation notes.
- Identify unusual changes in demand.

Guardrails:

- AI should not place purchase orders without approval.
- Recommendations must cite data fields and logic.
- High-cost reorder actions should require human review.

## 11. Production Requirements

Minimum requirements:

- Daily scheduled refresh
- Idempotent inventory snapshot loading
- Retry logic for source failures
- Reorder rule versioning
- Quality check failure alerts
- Run logs and row counts
- Manual override field for buyers
- Backfill support for historical sales velocity

Operational requirements:

- Document reorder logic.
- Record recommendation date and rule version.
- Store buyer decisions for feedback.
- Monitor missed source files.
- Keep dashboard freshness visible.

## 12. Security and Governance

Security requirements:

- Restrict supplier cost data.
- Limit purchase order access to authorized users.
- Protect customer-level sales data if included.
- Avoid storing credentials in code.

Governance requirements:

- Define inventory metrics clearly.
- Document reorder formulas.
- Track changes to reorder rules.
- Assign business owners for recommendations.
- Keep audit history of generated recommendations.

## 13. Cost and Scalability

Low-cost starting point:

- PostgreSQL
- Python
- CSV source files
- Scheduled local or cloud job

Scale when:

- There are many stores.
- Inventory snapshots are large.
- Recommendations need near real-time updates.
- Supplier and purchase order integrations increase complexity.

Cost controls:

- Calculate recommendations daily unless real-time is necessary.
- Store aggregated velocity metrics instead of repeatedly scanning all sales history.
- Archive old snapshots.
- Avoid overengineering with streaming unless stock changes must be immediate.

## 14. Skills Demonstrated

This capstone demonstrates:

- Inventory analytics
- Business rule modeling
- Python and SQL pipeline design
- Fact and mart design
- Data quality for operational decisions
- Reorder logic
- Dashboard planning
- Alerting design
- Cost-aware architecture
- Human-in-the-loop automation

## 15. Portfolio Presentation Guide

Show the project as a business decision system, not only a data pipeline.

Include:

- Problem statement with stockout and overstock examples
- Architecture diagram
- Reorder formula explanation
- Data model
- Sample recommendation table
- Dashboard screenshots or mockups
- Quality checks
- Example business impact

Suggested project story:

"I built an inventory optimization system that combines sales velocity, stock levels, supplier lead time, and open purchase orders to generate explainable reorder recommendations for a small retail business."

## 16. Future Improvements

Possible improvements:

- Add demand forecasting.
- Add safety stock by category.
- Add promotion-aware reorder logic.
- Add supplier reliability scoring.
- Add purchase order workflow integration.
- Add ABC inventory classification.
- Add seasonality adjustment.
- Add optimization for budget-constrained purchasing.

## Related Concepts

- [Inventory Reorder Use Case](../../../16-business-use-cases/retail/inventory-reorder.md)
- [Slow Moving Products](../../../16-business-use-cases/retail/slow-moving-products.md)
- [Demand Forecasting](../../../16-business-use-cases/retail/demand-forecasting.md)
- [Metric Definitions](../../../04-data-modeling/metric-definitions.md)
