# Dimensional Modeling

## 1. What It Is

Dimensional modeling is a data modeling approach designed for analytics and reporting. It organizes data into fact tables and dimension tables.

Fact tables store measurable business events. Dimension tables store descriptive context used to filter, group, and explain those events.

## 2. Why It Matters

Dimensional models make data easier for analysts, BI tools, and business users to understand.

They help Data Engineers:

- Build reporting-friendly datasets.
- Define clear table grain.
- Improve metric consistency.
- Reduce repeated business logic.
- Support dashboards and self-service analytics.
- Separate measurable events from descriptive attributes.

Dimensional modeling is one of the most practical skills for analytics-focused Data Engineering.

## 3. Core Concepts

- **Fact table:** A table of measurable events or snapshots.
- **Dimension table:** A table of descriptive attributes.
- **Measure:** A numeric value such as quantity, revenue, or cost.
- **Grain:** What one row in a fact table represents.
- **Star schema:** A model with one fact table connected to multiple dimensions.
- **Surrogate key:** A warehouse-generated key used to identify dimension rows.
- **Natural key:** A source-system key, such as product code or customer ID.
- **Conformed dimension:** A shared dimension used across multiple facts.

## 4. Real Business Example

A stationery shop wants dashboards for sales and inventory.

Useful dimensions:

- Date
- Product
- Customer

Useful facts:

- Sales transactions
- Inventory snapshots

With this model, the shop can answer:

- Revenue by day
- Revenue by product category
- Gross profit by customer segment
- Inventory on hand by product
- Products below reorder level

## 5. Simple Data Model Example

```text
dim_date
- date_key
- full_date
- month
- year

dim_product
- product_key
- product_id
- product_name
- category

dim_customer
- customer_key
- customer_id
- customer_segment

fact_sales
- sales_key
- date_key
- product_key
- customer_key
- quantity_sold
- revenue
- gross_profit
```

Grain:

- `fact_sales`: one row per product sold per sales transaction line

The dimensions describe the sale. The fact stores the measurable event.

## 6. Production Considerations

- Define fact table grain before choosing columns.
- Use dimensions for descriptive fields.
- Store measures in facts.
- Use surrogate keys when tracking history.
- Validate that fact rows connect to dimensions.
- Document metric definitions.
- Avoid mixing multiple grains in one fact table.
- Build marts from facts and dimensions, not directly from raw files.

## 7. Common Mistakes

- Not defining grain.
- Putting descriptive attributes directly into facts without reason.
- Mixing order-level and order-line-level measures.
- Creating dimensions with duplicate business keys.
- Calculating metrics differently in every dashboard.
- Treating a star schema as only a diagram instead of a business contract.

## 8. Practice Task

Design a star schema for a stationery shop.

Include:

1. A sales fact table.
2. An inventory snapshot fact table.
3. Product, customer, and date dimensions.
4. Grain definitions for each fact.
5. Three metrics the model should support.

## 9. Related Project

- `04-data-modeling/retail-data-model-example/`: Full retail star schema example.
- `04-data-modeling/facts-and-dimensions.md`: Deeper explanation of facts and dimensions.
- `06-data-warehousing/`: Dimensional models are central to warehouse design.
