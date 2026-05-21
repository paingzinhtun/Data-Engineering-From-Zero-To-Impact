# Slow Moving Products

## 1. Business Problem

Slow-moving products occupy shelf space, tie up cash, and may become obsolete or damaged. Many retailers only notice the problem during manual stock reviews.

The problem is identifying products with high stock but low sales early enough to act.

## 2. Why It Matters

Slow-moving inventory reduces cash flow and limits the ability to buy faster-selling products.

It matters especially for SMEs because capital tied up in inventory can restrict growth and daily operations.

## 3. Data Needed

- Product catalog
- Current inventory
- Sales history
- Product costs
- Purchase dates
- Supplier data
- Category data
- Markdown or discount history
- Returns and damages
- Seasonality indicators

## 4. Key Metrics

- Quantity on hand
- Inventory value
- Units sold in last 30, 60, 90 days
- Days since last sale
- Sell-through rate
- Inventory turnover
- Gross margin
- Stock age
- Slow-moving flag
- Overstock value

## 5. Data Pipeline Design

```text
inventory snapshots + sales history + product costs
  -> clean product and inventory models
  -> sales velocity calculations
  -> product aging logic
  -> mart_slow_moving_products
  -> action dashboard
```

The pipeline should compare current stock with recent sales velocity and product age.

## 6. Example Questions

- Which products have high stock but low sales?
- Which products have not sold in 60 days?
- How much cash is tied up in slow-moving products?
- Which categories have the most overstock?
- Which products should be discounted?
- Which suppliers are associated with slow-moving stock?

## 7. Dashboard Ideas

- Slow-moving product list
- Overstock value by category
- Days since last sale
- Inventory turnover by product
- Recommended markdown candidates
- Stock age distribution
- High-value slow movers
- Category-level overstock trend

## 8. Data Quality Risks

- Inventory quantities are stale
- Sales returns not handled
- Product costs missing
- Product variants not grouped correctly
- Old products renamed or recoded
- Seasonal products incorrectly marked slow
- Damaged stock counted as sellable
- Manual stock adjustments missing

## 9. AI or Automation Extension

AI can recommend actions such as discount, bundle, transfer, return to supplier, or stop reordering.

Automation can generate weekly slow-moving inventory reports for purchasing and store managers.

## 10. Business Impact

Slow-moving product analytics improves cash flow, frees storage space, reduces waste, and helps retailers make better buying and markdown decisions.
