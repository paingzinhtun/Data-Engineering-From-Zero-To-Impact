# Demand Forecasting

## 1. Business Problem

Retail businesses need to estimate future demand so they can buy enough stock, plan promotions, schedule staff, and manage cash flow.

The problem is forecasting future sales using historical sales, inventory, seasonality, promotions, and business context.

## 2. Why It Matters

Poor demand forecasting causes stockouts, overstock, missed revenue, and inefficient purchasing.

Better forecasting helps businesses plan inventory, reduce waste, and prepare for seasonal demand.

## 3. Data Needed

- Historical sales
- Product catalog
- Inventory history
- Promotion calendar
- Price history
- Returns and refunds
- Supplier lead times
- Holidays and events
- Weather or local event data if relevant
- Stockout history

## 4. Key Metrics

- Forecasted units
- Actual units sold
- Forecast error
- Mean absolute percentage error
- Stockout rate
- Inventory coverage
- Sales velocity
- Promotion uplift
- Seasonal index
- Reorder quantity

## 5. Data Pipeline Design

```text
sales + inventory + promotions + calendar
  -> clean historical fact tables
  -> feature engineering pipeline
  -> forecasting dataset
  -> forecast model or rules
  -> demand forecast output
  -> reorder and planning dashboard
```

The pipeline should prevent data leakage and preserve historical point-in-time accuracy.

## 6. Example Questions

- How many units will we likely sell next week?
- Which products need extra stock before a promotion?
- Which categories have seasonal demand?
- How accurate were last month's forecasts?
- Which products are hardest to forecast?
- What inventory level should we maintain?

## 7. Dashboard Ideas

- Forecast vs actual sales
- Forecast error by product
- Demand forecast by category
- Stockout risk forecast
- Seasonal demand trend
- Promotion uplift estimate
- Reorder planning view
- High-uncertainty product list

## 8. Data Quality Risks

- Stockouts mistaken for low demand
- Promotions not flagged
- Product replacements not linked
- Returns not handled
- Missing historical sales
- Inconsistent product IDs
- Future data leakage
- Seasonality ignored

## 9. AI or Automation Extension

Machine learning can forecast product demand, while an AI assistant can explain forecast drivers and highlight risks.

Automation can create reorder suggestions based on forecasted demand and supplier lead time.

## 10. Business Impact

Demand forecasting improves stock planning, reduces cash tied in excess inventory, lowers stockout risk, and supports better purchasing and promotion decisions.
