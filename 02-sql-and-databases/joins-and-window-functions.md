# Joins And Window Functions

## 1. What It Is

Joins combine related tables. Window functions calculate values across related rows while keeping each row visible.

Joins answer questions that require multiple tables. Window functions answer questions that require comparison, ranking, running totals, moving averages, or previous-row logic.

Together, they are essential for serious SQL work.

## 2. Why It Matters

Business data is usually split across multiple tables. A sale may reference a customer and product. A product may belong to a category. Inventory may be tracked separately from sales.

Joins help connect these tables. Window functions help analyze patterns across the connected data.

Data Engineers use them to:

- Build analytics tables.
- Validate relationships.
- Rank products and customers.
- Calculate moving averages.
- Detect duplicates.
- Compare current and previous values.
- Prepare warehouse models.

## 3. Core Concepts

- **INNER JOIN:** Returns matching rows from both tables.
- **LEFT JOIN:** Keeps all rows from the left table and matching rows from the right table.
- **RIGHT JOIN:** Keeps all rows from the right table and matching rows from the left table.
- **FULL OUTER JOIN:** Keeps rows from both tables, matched where possible.
- **CROSS JOIN:** Combines every row from one table with every row from another.
- **Join key:** The column used to match tables.
- **Window function:** A calculation over a defined group of rows.
- **PARTITION BY:** Divides rows into groups for a window function.
- **ORDER BY:** Defines row order inside a window.
- **Frame:** Defines which rows around the current row are included in a calculation.

## 4. Real Business Example

A retail manager wants to see product performance.

The `sales` table has product IDs and quantities sold. The `products` table has product names, categories, sale prices, and costs. The `inventory` table has stock levels.

By joining the tables, the business can see revenue, gross profit, and inventory risk in one report.

By using window functions, the business can rank products by revenue within each category and calculate a moving average of daily sales.

## 5. SQL Examples

Join sales to products:

```sql
SELECT
    s.sale_id,
    s.sale_date,
    p.product_name,
    p.category,
    s.quantity,
    s.unit_price
FROM sales AS s
JOIN products AS p
    ON s.product_id = p.product_id;
```

Find sales with missing product records:

```sql
SELECT s.*
FROM sales AS s
LEFT JOIN products AS p
    ON s.product_id = p.product_id
WHERE p.product_id IS NULL;
```

Rank products by revenue:

```sql
WITH product_revenue AS (
    SELECT
        p.category,
        p.product_name,
        SUM(s.quantity * s.unit_price) AS revenue
    FROM sales AS s
    JOIN products AS p
        ON s.product_id = p.product_id
    GROUP BY p.category, p.product_name
)
SELECT
    category,
    product_name,
    revenue,
    RANK() OVER (
        PARTITION BY category
        ORDER BY revenue DESC
    ) AS category_rank
FROM product_revenue
ORDER BY category, category_rank;
```

Calculate a moving average:

```sql
WITH daily_sales AS (
    SELECT
        sale_date,
        SUM(quantity * unit_price) AS revenue
    FROM sales
    GROUP BY sale_date
)
SELECT
    sale_date,
    revenue,
    AVG(revenue) OVER (
        ORDER BY sale_date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS three_day_moving_average
FROM daily_sales
ORDER BY sale_date;
```

Compare each customer sale to their previous sale:

```sql
SELECT
    customer_id,
    sale_date,
    sale_id,
    LAG(sale_date) OVER (
        PARTITION BY customer_id
        ORDER BY sale_date
    ) AS previous_sale_date
FROM sales
ORDER BY customer_id, sale_date;
```

## 6. Production Considerations

- Always understand the grain of each table before joining.
- Check whether join keys are unique where expected.
- Validate row counts before and after joins.
- Use left joins for relationship quality checks.
- Avoid joining on names, descriptions, or free-text fields.
- Be explicit about tie handling with `RANK`, `DENSE_RANK`, or `ROW_NUMBER`.
- Define moving average windows clearly.
- Document whether rankings are global or partitioned.

## 7. Common Mistakes

- Creating duplicate rows by joining to a table with multiple matches.
- Using an inner join when unmatched records should be preserved.
- Forgetting `PARTITION BY` in a window function.
- Ranking before aggregating to the correct grain.
- Assuming `ROW_NUMBER`, `RANK`, and `DENSE_RANK` behave the same.
- Calculating moving averages on missing dates without a date spine.
- Joining on columns with different meanings.

## 8. Practice Tasks

Using the practice database:

1. Join sales to customers and products.
2. Find sales records with missing customer or product references.
3. Calculate revenue by product.
4. Rank products by revenue within category.
5. Calculate a moving average of daily sales.
6. Find each customer's first and most recent purchase.
7. Use `LAG` to compare each sale date to the customer's previous sale.

## 9. Related Project

- `02-sql-and-databases/postgresql-practice/`: Includes product ranking and moving average queries.
- `04-data-modeling/`: Correct joins depend on well-designed relationships and grain.
- `06-data-warehousing/`: Facts and dimensions rely on joins and window logic.
