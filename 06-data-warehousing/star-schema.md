# Star Schema

## 1. What It Is

A star schema is a warehouse design pattern with a central fact table connected to surrounding dimension tables.

The fact table stores measurable events. Dimension tables store descriptive context used for filtering and grouping.

It is called a star schema because the diagram often looks like a star, with the fact table in the center.

## 2. Why It Matters

Star schemas make warehouse data easier to understand and query. They are especially useful for dashboards and recurring business analysis.

They help Data Engineers:

- Build clear analytics models.
- Reduce repeated joins to source tables.
- Support BI tools.
- Define metrics consistently.
- Improve query readability.
- Separate measures from descriptive attributes.

## 3. When to Use It

Use a star schema when:

- Business users need reporting and dashboard tables.
- Data represents measurable events such as sales, shipments, payments, or inventory snapshots.
- Analysts need to slice metrics by date, product, customer, channel, or location.
- The warehouse needs reusable dimensions and facts.

Avoid forcing a star schema when the data is exploratory, unstructured, or not yet understood.

## 4. Real Business Example

A stationery shop wants to analyze sales by product, customer segment, date, and channel.

The star schema might include:

- `fact_sales`
- `dim_date`
- `dim_product`
- `dim_customer`
- `dim_channel`

This lets users ask:

- What was revenue by month?
- Which product category had the highest gross profit?
- Which customer segment bought the most notebooks?
- How did online sales compare to store sales?

## 5. Technical Example

Simple star schema:

```text
dim_date       dim_product       dim_customer
    \              |                 /
           fact_sales
                  |
             dim_channel
```

Example fact:

```sql
CREATE TABLE fact_sales (
    sales_key BIGINT PRIMARY KEY,
    date_key INTEGER NOT NULL,
    product_key INTEGER NOT NULL,
    customer_key INTEGER NOT NULL,
    channel_key INTEGER NOT NULL,
    quantity_sold INTEGER NOT NULL,
    revenue NUMERIC(12, 2) NOT NULL,
    gross_profit NUMERIC(12, 2) NOT NULL
);
```

Example query:

```sql
SELECT
    d.month_name,
    p.product_category,
    SUM(f.revenue) AS revenue
FROM fact_sales AS f
JOIN dim_date AS d ON f.date_key = d.date_key
JOIN dim_product AS p ON f.product_key = p.product_key
GROUP BY d.month_name, p.product_category;
```

## 6. Production Considerations

- Define fact grain before building the table.
- Use surrogate keys where appropriate.
- Keep dimensions reusable across facts.
- Validate fact-to-dimension relationships.
- Document metric calculations.
- Avoid storing conflicting measures.
- Consider slowly changing dimensions when attributes change over time.
- Use marts to simplify common reporting needs.

## 7. Common Mistakes

- Not defining fact grain.
- Mixing multiple grains in one fact table.
- Putting every descriptive field in the fact table.
- Creating one-off dimensions that duplicate existing dimensions.
- Ignoring changes in product category or customer segment.
- Building a star schema without clear business questions.

## 8. Practice Task

Design a star schema for retail sales.

Include:

1. One sales fact table.
2. Date, product, customer, and channel dimensions.
3. Grain definition for the fact.
4. Five measures.
5. Five business questions the model can answer.

## 9. Related Project

- `04-data-modeling/retail-data-model-example/`: SQL example of a retail star schema.
- `06-data-warehousing/warehouse-project/`: Uses star schema design for a retail warehouse.
- `09-dbt-and-analytics-engineering/`: Star schema tables often become documented transformation models.
