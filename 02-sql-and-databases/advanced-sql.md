# Advanced SQL

## 1. What It Is

Advanced SQL is the set of SQL techniques used to solve more complex data problems. It includes common table expressions, subqueries, conditional logic, set operations, date functions, window functions, advanced aggregation, and careful query structure.

Advanced SQL is not about making queries look complicated. It is about writing queries that are correct, readable, maintainable, and useful for real business analysis.

## 2. Why It Matters

Data Engineers use advanced SQL to build warehouse models, validate pipelines, debug business metrics, and prepare analytics datasets.

Advanced SQL helps you:

- Break complex transformations into readable steps.
- Compare current and previous periods.
- Rank products, customers, and stores.
- Calculate rolling metrics.
- Detect duplicates and anomalies.
- Create reusable business logic.
- Validate outputs from ETL and ELT pipelines.

## 3. Core Concepts

- **Common table expression:** A named temporary result inside a query.
- **Subquery:** A query nested inside another query.
- **CASE expression:** Conditional logic in SQL.
- **Set operation:** Combining query results with `UNION`, `UNION ALL`, `INTERSECT`, or `EXCEPT`.
- **Window function:** A calculation across related rows without collapsing them.
- **Date function:** Logic for grouping, filtering, or comparing dates.
- **CTE pipeline:** A query written as a sequence of named steps.
- **Deduplication:** Selecting one trusted record from duplicate candidates.

## 4. Real Business Example

A retailer wants a weekly performance report that shows:

- Revenue by category
- Gross profit by product
- Ranking of top products
- Seven-day moving average of daily sales
- Customers with repeat purchases
- Products that sell well but are low in stock

Basic SQL can answer parts of this. Advanced SQL makes it possible to combine multiple steps, calculate rankings, and produce cleaner reporting tables.

## 5. SQL Examples

Use a common table expression:

```sql
WITH sales_with_profit AS (
    SELECT
        s.sale_id,
        s.sale_date,
        p.product_name,
        p.category,
        s.quantity,
        s.unit_price,
        p.cost_price,
        (s.quantity * s.unit_price) AS revenue,
        (s.quantity * (s.unit_price - p.cost_price)) AS gross_profit
    FROM sales AS s
    JOIN products AS p
        ON s.product_id = p.product_id
)
SELECT
    category,
    SUM(revenue) AS revenue,
    SUM(gross_profit) AS gross_profit
FROM sales_with_profit
GROUP BY category
ORDER BY revenue DESC;
```

Use `CASE` for business logic:

```sql
SELECT
    product_id,
    quantity_on_hand,
    reorder_level,
    CASE
        WHEN quantity_on_hand = 0 THEN 'out_of_stock'
        WHEN quantity_on_hand < reorder_level THEN 'low_stock'
        ELSE 'healthy'
    END AS stock_status
FROM inventory;
```

Use date grouping:

```sql
SELECT
    DATE_TRUNC('week', sale_date)::date AS week_start,
    SUM(quantity * unit_price) AS weekly_revenue
FROM sales
GROUP BY week_start
ORDER BY week_start;
```

Use `UNION ALL` to combine similar result sets:

```sql
SELECT 'online' AS channel, SUM(quantity * unit_price) AS revenue
FROM sales
WHERE channel = 'online'
UNION ALL
SELECT 'store' AS channel, SUM(quantity * unit_price) AS revenue
FROM sales
WHERE channel = 'store';
```

## 6. Production Considerations

- Prefer readable CTEs over deeply nested queries.
- Name calculated fields clearly.
- Keep business logic consistent across models.
- Be careful with date boundaries and time zones.
- Use `UNION ALL` unless you intentionally need duplicate removal.
- Validate intermediate CTE row counts when debugging.
- Document assumptions behind classifications and calculations.
- Avoid hiding complex business rules inside undocumented queries.

## 7. Common Mistakes

- Writing one large query that nobody can review.
- Using `UNION` when `UNION ALL` is intended.
- Forgetting that `CASE` conditions are evaluated in order.
- Creating inconsistent metric logic in different queries.
- Grouping by the wrong date field.
- Ignoring refunds, returns, cancelled orders, or test records.
- Treating advanced SQL as a substitute for clear data modeling.

## 8. Practice Tasks

Using the practice database:

1. Create a CTE that calculates revenue and gross profit per sale.
2. Summarize gross profit by category.
3. Classify inventory as `out_of_stock`, `low_stock`, or `healthy`.
4. Calculate weekly revenue.
5. Find repeat customers.
6. Find products with high sales and low stock.
7. Compare online and store revenue.

## 9. Related Project

- `02-sql-and-databases/postgresql-practice/`: Use the practice queries as a starting point.
- `06-data-warehousing/`: Advanced SQL is used heavily in warehouse transformations.
- `09-dbt-and-analytics-engineering/`: CTE-based SQL is common in analytics engineering.
