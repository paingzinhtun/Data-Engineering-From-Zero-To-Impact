# Facts And Dimensions

## 1. What It Is

Facts and dimensions are the main building blocks of dimensional models.

Facts capture measurable business events or snapshots. Dimensions provide descriptive context for those facts.

Example:

- A sale is a fact.
- The customer, product, date, and channel are dimensions.

## 2. Why It Matters

Separating facts and dimensions makes analytics clearer.

It helps Data Engineers:

- Define metrics consistently.
- Avoid mixing descriptions and measurements.
- Build reusable dimensions.
- Support flexible filtering and grouping.
- Explain business events precisely.
- Create reporting tables that BI tools can use.

## 3. Core Concepts

- **Transaction fact:** Records business events, such as sales.
- **Snapshot fact:** Records the state of something at a point in time, such as inventory on hand.
- **Accumulating fact:** Tracks a process through milestones, such as an order from placed to shipped.
- **Dimension attribute:** Descriptive field such as product category or customer segment.
- **Measure:** Numeric value stored or derived from a fact.
- **Additive measure:** Can be summed across dimensions, such as revenue.
- **Semi-additive measure:** Can be summed across some dimensions but not all, such as inventory balance.
- **Non-additive measure:** Cannot be meaningfully summed, such as a ratio.

## 4. Real Business Example

A stationery shop wants to monitor sales and stock.

`fact_sales` records each product sold. Measures include:

- Quantity sold
- Revenue
- Cost amount
- Gross profit

`fact_inventory_snapshot` records stock levels each day. Measures include:

- Quantity on hand
- Reorder level

Dimensions include:

- Product
- Customer
- Date

This design allows the business to analyze sales performance and inventory risk using the same product and date dimensions.

## 5. Simple Data Model Example

```text
dim_product
- product_key
- product_name
- category
- brand

dim_customer
- customer_key
- customer_segment
- city

fact_sales
- sales_key
- date_key
- product_key
- customer_key
- quantity_sold
- revenue
- gross_profit

fact_inventory_snapshot
- snapshot_date_key
- product_key
- quantity_on_hand
- reorder_level
```

Grain:

- `fact_sales`: one row per product sold per transaction line
- `fact_inventory_snapshot`: one row per product per snapshot date

## 6. Production Considerations

- Define fact grain before building the table.
- Keep facts numeric and event-focused.
- Keep dimensions descriptive and reusable.
- Understand which measures are additive.
- Be careful summing snapshot balances across dates.
- Use conformed dimensions when multiple facts share context.
- Validate that fact rows have matching dimension keys.
- Document how measures are calculated.

## 7. Common Mistakes

- Summing inventory across many dates as if it were sales.
- Mixing multiple grains in one fact table.
- Putting calculated ratios in facts without documenting logic.
- Creating separate product dimensions for every mart.
- Treating dimensions as static when business attributes can change.
- Confusing transaction dates, shipping dates, and snapshot dates.

## 8. Practice Task

For a stationery shop, classify these as facts, dimensions, or measures:

1. Product category
2. Customer segment
3. Sale date
4. Quantity sold
5. Revenue
6. Inventory on hand
7. Reorder level
8. City
9. Gross profit

Then define the grain for a sales fact and an inventory snapshot fact.

## 9. Related Project

- `04-data-modeling/dimensional-modeling.md`: Introduces dimensional modeling structure.
- `04-data-modeling/retail-data-model-example/`: Implements facts and dimensions in SQL.
- `09-dbt-and-analytics-engineering/`: Facts and dimensions often become dbt models.
