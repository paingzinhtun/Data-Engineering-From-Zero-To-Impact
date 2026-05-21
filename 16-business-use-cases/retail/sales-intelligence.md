# Sales Intelligence

## 1. Business Problem

Retail businesses often know that sales are up or down, but they do not always know why. Sales data may be split across POS systems, ecommerce platforms, spreadsheets, and manual reports.

The problem is turning transaction data into useful intelligence about products, categories, channels, customers, stores, and time periods.

## 2. Why It Matters

Sales intelligence helps businesses make better decisions about pricing, inventory, staffing, promotions, purchasing, and growth.

Without trusted sales intelligence, owners may rely on intuition, delayed reports, or incomplete spreadsheets.

## 3. Data Needed

- POS sales transactions
- Ecommerce orders
- Product catalog
- Product categories
- Customer records
- Store or channel data
- Returns and refunds
- Discounts and promotions
- Payment status
- Calendar data

## 4. Key Metrics

- Revenue
- Units sold
- Gross profit
- Gross margin percentage
- Average order value
- Transaction count
- Revenue by product
- Revenue by category
- Revenue by channel
- Return rate
- Discount rate

## 5. Data Pipeline Design

```text
POS/ecommerce sales
  -> raw sales tables
  -> staging sales model
  -> product and customer joins
  -> fact_sales
  -> mart_daily_sales
  -> mart_product_performance
  -> dashboard
```

The pipeline should validate sale IDs, product IDs, quantities, prices, sales dates, and channel values before publishing metrics.

## 6. Example Questions

- What was revenue yesterday, last week, and last month?
- Which products generated the most gross profit?
- Which category is growing fastest?
- Are online sales increasing compared with store sales?
- Did discounts improve units sold or reduce margin?
- Which products have high returns?

## 7. Dashboard Ideas

- Daily revenue trend
- Sales by category
- Top and bottom products
- Gross margin by product
- Channel comparison
- Discount impact
- Return rate by category
- Sales heatmap by day of week

## 8. Data Quality Risks

- Duplicate sales records
- Missing product IDs
- Incorrect refund handling
- Cancelled orders counted as revenue
- Inconsistent channel names
- Tax and discount confusion
- Late ecommerce order updates
- Product category changes not tracked

## 9. AI or Automation Extension

An AI assistant can summarize sales changes and answer questions such as:

- Why did sales drop this week?
- Which products are driving margin?
- Which categories should receive promotion focus?

Automation can send daily sales summaries and anomaly alerts when revenue drops unexpectedly.

## 10. Business Impact

Sales intelligence helps businesses protect margin, choose better promotions, improve buying decisions, and understand what is actually driving revenue.
