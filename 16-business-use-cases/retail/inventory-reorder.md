# Inventory Reorder

## 1. Business Problem

Retail businesses need enough stock to meet demand without overbuying. Many SMEs manage inventory with spreadsheets, delayed POS reports, or manual counts.

The problem is identifying which products need reorder action before stockouts happen.

## 2. Why It Matters

Stockouts lose sales and damage customer trust. Overstock ties up cash and storage space.

Good reorder intelligence helps businesses balance availability, cash flow, supplier lead times, and product demand.

## 3. Data Needed

- Current inventory
- Sales history
- Product catalog
- Reorder levels
- Supplier lead times
- Purchase orders
- Goods received records
- Returns and damaged goods
- Store or warehouse locations
- Seasonal calendar

## 4. Key Metrics

- Quantity on hand
- Reorder level
- Reorder quantity
- Days of stock remaining
- Stockout count
- Sell-through rate
- Average daily sales
- Supplier lead time
- Inventory turnover
- Inventory value

## 5. Data Pipeline Design

```text
inventory snapshots + sales history + supplier data
  -> raw inventory and sales tables
  -> cleaned product and stock models
  -> inventory snapshot fact
  -> sales velocity calculation
  -> mart_inventory_reorder
  -> reorder dashboard or alert
```

The pipeline should refresh inventory regularly and compare stock levels to sales velocity and reorder thresholds.

## 6. Example Questions

- Which products should I reorder today?
- Which products are below reorder level?
- Which products may stock out before the next supplier delivery?
- Which high-margin items are at risk of stockout?
- Which products have too much stock?
- Which suppliers cause reorder delays?

## 7. Dashboard Ideas

- Reorder recommendation list
- Low-stock products by category
- Days of stock remaining
- Stockout risk by supplier
- Inventory value by category
- Overstocked products
- Fast-selling low-stock products
- Purchase order status

## 8. Data Quality Risks

- Inventory counts are stale
- Negative stock values
- Product IDs do not match sales data
- Supplier lead times are missing
- Purchase orders are not updated
- Returns are not reflected in stock
- Multiple inventory systems disagree
- Manual adjustments are undocumented

## 9. AI or Automation Extension

An AI assistant can answer:

- Which products should I reorder?
- Which products are at risk of stockout?
- Why is inventory value increasing?

Automation can generate reorder alerts or draft purchase order recommendations for review.

## 10. Business Impact

Inventory reorder analytics reduces lost sales, improves cash flow, lowers overstock, and helps operations teams act before inventory problems become customer problems.
