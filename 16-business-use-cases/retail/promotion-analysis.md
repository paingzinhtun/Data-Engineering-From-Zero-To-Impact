# Promotion Analysis

## 1. Business Problem

Retail promotions often increase sales volume but may reduce margin. Many businesses cannot clearly tell whether a promotion was profitable or only moved sales from one period to another.

The problem is measuring the real impact of discounts, campaigns, bundles, and seasonal offers.

## 2. Why It Matters

Promotions affect revenue, margin, inventory, customer behavior, and supplier planning.

Promotion analysis helps businesses decide which offers to repeat, stop, improve, or target more carefully.

## 3. Data Needed

- Sales transactions
- Promotion calendar
- Discount codes
- Product catalog
- Product costs
- Inventory levels
- Customer segments
- Marketing campaign data
- Returns and refunds
- Baseline historical sales

## 4. Key Metrics

- Promotion revenue
- Units sold during promotion
- Gross profit
- Gross margin percentage
- Discount amount
- Incremental sales estimate
- Average order value
- Return rate
- Stockout during promotion
- Customer acquisition or repeat purchase rate

## 5. Data Pipeline Design

```text
sales + promotions + product costs + inventory
  -> raw campaign and sales tables
  -> promotion mapping model
  -> sales enriched with promotion flags
  -> promotion performance mart
  -> promotion dashboard
```

The pipeline should separate promoted sales, non-promoted sales, discount amounts, costs, and returns.

## 6. Example Questions

- Did the promotion increase revenue?
- Did the promotion improve or reduce gross profit?
- Which products sold more during the promotion?
- Did the promotion cause stockouts?
- Which customer segments responded?
- Did sales drop after the promotion ended?

## 7. Dashboard Ideas

- Promotion revenue and gross profit
- Units sold before, during, and after promotion
- Margin impact by product
- Promotion performance by customer segment
- Stockout risk during promotion
- Discount rate trend
- Return rate after promotion
- Campaign comparison table

## 8. Data Quality Risks

- Promotion codes missing from sales
- Discounts not stored at line level
- Costs not available for margin calculation
- Returns not linked to original sale
- Promotion dates entered incorrectly
- Multiple promotions overlap
- Baseline period not comparable
- Stockouts distort demand measurement

## 9. AI or Automation Extension

AI can summarize promotion performance and suggest which products or segments responded best.

Automation can alert teams when a promotion is reducing margin too much or causing stockout risk.

## 10. Business Impact

Promotion analysis helps businesses protect margin, improve campaign planning, reduce over-discounting, and focus marketing effort on offers that create real value.
