# Supplier Performance

## 1. Business Problem

Retail businesses depend on suppliers for stock availability, cost control, and product quality. Supplier issues are often tracked manually across purchase orders, emails, invoices, and delivery notes.

The problem is measuring supplier reliability and identifying which suppliers create operational risk.

## 2. Why It Matters

Poor supplier performance causes stockouts, delayed customer orders, excess safety stock, quality issues, and margin pressure.

Supplier analytics helps businesses negotiate, plan purchasing, and reduce operational surprises.

## 3. Data Needed

- Supplier master data
- Purchase orders
- Expected delivery dates
- Goods received records
- Invoice data
- Product catalog
- Defect or return records
- Lead time history
- Cost changes
- Stockout events

## 4. Key Metrics

- On-time delivery rate
- Average lead time
- Lead time variability
- Fill rate
- Defect rate
- Cost variance
- Late delivery count
- Purchase order cycle time
- Supplier stockout impact
- Return or damage rate

## 5. Data Pipeline Design

```text
purchase orders + receiving + supplier + product data
  -> raw procurement tables
  -> staging purchase order and receiving models
  -> supplier delivery fact
  -> supplier performance mart
  -> supplier scorecard dashboard
```

The pipeline should standardize supplier IDs and match purchase orders to received goods.

## 6. Example Questions

- Which suppliers deliver late most often?
- Which suppliers have the longest lead times?
- Which suppliers frequently deliver partial orders?
- Which products are affected by supplier delays?
- Are supplier costs increasing?
- Which suppliers create the most stockout risk?

## 7. Dashboard Ideas

- Supplier scorecard
- On-time delivery trend
- Lead time by supplier
- Fill rate by supplier
- Defect rate by product and supplier
- Cost change trend
- Late purchase order list
- Supplier risk ranking

## 8. Data Quality Risks

- Purchase orders missing supplier IDs
- Delivery dates entered inconsistently
- Partial deliveries not captured
- Goods received not matched to purchase orders
- Supplier names duplicated
- Cost changes not tracked historically
- Defects recorded outside the system
- Manual email updates not captured

## 9. AI or Automation Extension

AI can summarize supplier risks and explain which suppliers are affecting stock availability.

Automation can alert purchasing teams when a supplier's lead time increases or when a purchase order is overdue.

## 10. Business Impact

Supplier performance analytics improves purchasing decisions, reduces stockout risk, supports better negotiation, and helps protect customer availability.
