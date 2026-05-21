# Retail Sales Intelligence

## 1. Business Context

A small retail chain sells stationery, office supplies, and school products through two branches and an online channel. Managers receive sales exports from the POS system and ecommerce platform, but reporting is manual and inconsistent.

The business wants a trusted view of sales performance by day, product, category, branch, channel, and customer segment.

## 2. Problem

Current reporting issues:

- Sales reports are built manually in spreadsheets.
- Product performance is reviewed too late.
- Revenue and profit are not separated clearly.
- Discounts are not consistently included in net sales.
- Managers cannot easily compare branches or channels.

The business needs a repeatable sales intelligence system that turns source data into actionable sales and margin insights.

## 3. Data Sources

Required sources:

- POS sales transactions
- Ecommerce orders
- Product catalog
- Customer list
- Store or channel reference data

Optional sources:

- Promotion calendar
- Returns and refunds
- Product cost history
- Sales targets

Key fields:

- `sale_id`
- `sale_line_id`
- `sale_date`
- `store_id`
- `channel`
- `customer_id`
- `product_id`
- `quantity`
- `unit_price`
- `discount_amount`
- `unit_cost`

## 4. Architecture

```text
POS CSV and ecommerce API
  -> ingestion pipeline
  -> raw sales and product tables
  -> staging transformations
  -> fact_sales and dimensions
  -> sales marts
  -> dashboard and management reports
```

Recommended starting architecture:

- Python for ingestion
- PostgreSQL for storage
- SQL or dbt for transformations
- Dashboard tool for reporting
- Data quality checks before publishing marts

## 5. Data Model

Core dimensions:

- `dim_date`
- `dim_product`
- `dim_customer`
- `dim_store`
- `dim_channel`

Core facts:

- `fact_sales`
- `fact_returns`

Business marts:

- `mart_daily_sales`
- `mart_product_performance`
- `mart_category_performance`
- `mart_store_channel_sales`

Grain:

- `fact_sales`: one row per sale line item
- `mart_daily_sales`: one row per date, store, and channel
- `mart_product_performance`: one row per product per reporting period

## 6. Pipeline Design

1. Extract POS and ecommerce sales data.
2. Load raw source records with ingestion metadata.
3. Clean dates, IDs, prices, discounts, and quantities.
4. Join sales to product, customer, store, and channel dimensions.
5. Calculate gross sales, net sales, cost amount, gross profit, and margin.
6. Build daily, product, category, and store/channel marts.
7. Run quality checks.
8. Publish dashboard-ready tables.

## 7. Data Quality Strategy

Critical checks:

- Sale line IDs are unique.
- Required IDs are not null.
- Quantity is greater than zero.
- Unit price and cost are not negative.
- Net sales equals gross sales minus discount.
- Gross profit equals net sales minus cost amount.
- Product and customer references are valid.
- Sales marts reconcile to `fact_sales`.

Operational checks:

- Latest sales data is loaded before the reporting deadline.
- Source row counts are logged.
- Failed records are stored for review.

## 8. Key Metrics

- Gross sales
- Net sales
- Units sold
- Discount amount
- Cost amount
- Gross profit
- Gross margin percentage
- Average order value
- Transactions
- Sales by category
- Sales by channel

## 9. Dashboard or Output

Recommended dashboard pages:

- Executive sales overview
- Product and category performance
- Store and channel comparison
- Discount and margin analysis
- Customer segment sales

Example business questions:

- Which products generate the most profit?
- Which branches are growing?
- Which categories have declining margin?
- Are discounts increasing sales or reducing profit?
- Which channel performs best by product category?

## 10. AI/Automation Extension

Useful extensions:

- Weekly sales performance summary
- Automated alert when sales drop below target
- Product-level anomaly explanation
- Natural language question answering over approved sales marts
- Promotion impact narrative

Example AI prompt:

> Explain why gross profit dropped last week using sales, category, discount, and channel data.

## 11. Business Impact

Expected impact:

- Reduces manual sales reporting effort.
- Improves trust in sales and profit metrics.
- Helps managers identify profitable products.
- Supports better promotion decisions.
- Gives leadership a consistent view of branch and channel performance.

## 12. Implementation Plan

Phase 1:

- Load sales, products, customers, and stores.
- Build `fact_sales` and `mart_daily_sales`.

Phase 2:

- Add category, channel, and margin analysis.
- Add quality checks and documentation.

Phase 3:

- Add dashboard, alerts, and promotion analysis.

Phase 4:

- Add AI-generated sales summaries and anomaly explanations.

## 13. Risks and Tradeoffs

Risks:

- Product costs may be missing or outdated.
- Ecommerce and POS systems may define discounts differently.
- Returns may be excluded from early versions.
- Manual source files may arrive late.

Tradeoffs:

- Batch reporting is simpler and enough for daily decisions.
- Real-time streaming is only justified if managers need live operations alerts.
- A small PostgreSQL warehouse is enough until data volume or BI concurrency grows.

## 14. Related Projects

- `17-projects/beginner/04-retail-sales-pipeline/`
- `17-projects/intermediate/02-retail-sales-warehouse/`
- `17-projects/intermediate/04-dbt-retail-transformations/`
- `17-projects/capstone/retail-intelligence-platform/`
