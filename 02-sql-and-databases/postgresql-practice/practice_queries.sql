-- Beginner queries

-- 1. View all customers.
SELECT *
FROM customers
ORDER BY customer_id;

-- 2. View all active products.
SELECT
    product_id,
    product_name,
    category,
    sale_price
FROM products
WHERE is_active = TRUE
ORDER BY category, product_name;

-- 3. Daily sales revenue.
SELECT
    sale_date,
    SUM(quantity * unit_price) AS daily_revenue
FROM sales
GROUP BY sale_date
ORDER BY sale_date;

-- 4. Low-stock products.
SELECT
    p.product_id,
    p.product_name,
    p.category,
    i.quantity_on_hand,
    i.reorder_level
FROM inventory AS i
JOIN products AS p
    ON i.product_id = p.product_id
WHERE i.quantity_on_hand < i.reorder_level
ORDER BY i.quantity_on_hand ASC;

-- Intermediate queries

-- 5. Top products by revenue.
SELECT
    p.product_id,
    p.product_name,
    p.category,
    SUM(s.quantity) AS units_sold,
    SUM(s.quantity * s.unit_price) AS revenue
FROM sales AS s
JOIN products AS p
    ON s.product_id = p.product_id
GROUP BY p.product_id, p.product_name, p.category
ORDER BY revenue DESC;

-- 6. Revenue by category.
SELECT
    p.category,
    SUM(s.quantity * s.unit_price) AS revenue
FROM sales AS s
JOIN products AS p
    ON s.product_id = p.product_id
GROUP BY p.category
ORDER BY revenue DESC;

-- 7. Customer purchase summary.
SELECT
    c.customer_id,
    c.customer_name,
    c.customer_segment,
    COUNT(s.sale_id) AS number_of_sales,
    SUM(s.quantity) AS units_purchased,
    SUM(s.quantity * s.unit_price) AS total_spent,
    MIN(s.sale_date) AS first_purchase_date,
    MAX(s.sale_date) AS most_recent_purchase_date
FROM customers AS c
LEFT JOIN sales AS s
    ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.customer_name, c.customer_segment
ORDER BY total_spent DESC NULLS LAST;

-- 8. Gross profit by product.
SELECT
    p.product_id,
    p.product_name,
    p.category,
    SUM(s.quantity * s.unit_price) AS revenue,
    SUM(s.quantity * p.cost_price) AS cost,
    SUM(s.quantity * (s.unit_price - p.cost_price)) AS gross_profit
FROM sales AS s
JOIN products AS p
    ON s.product_id = p.product_id
GROUP BY p.product_id, p.product_name, p.category
ORDER BY gross_profit DESC;

-- 9. Products with both low stock and sales activity.
SELECT
    p.product_name,
    p.category,
    i.quantity_on_hand,
    i.reorder_level,
    SUM(s.quantity) AS units_sold
FROM products AS p
JOIN inventory AS i
    ON p.product_id = i.product_id
LEFT JOIN sales AS s
    ON p.product_id = s.product_id
GROUP BY p.product_name, p.category, i.quantity_on_hand, i.reorder_level
HAVING i.quantity_on_hand < i.reorder_level
ORDER BY units_sold DESC NULLS LAST;

-- Advanced queries

-- 10. Three-day moving average of daily revenue.
WITH daily_sales AS (
    SELECT
        sale_date,
        SUM(quantity * unit_price) AS daily_revenue
    FROM sales
    GROUP BY sale_date
)
SELECT
    sale_date,
    daily_revenue,
    ROUND(
        AVG(daily_revenue) OVER (
            ORDER BY sale_date
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ),
        2
    ) AS three_day_moving_average
FROM daily_sales
ORDER BY sale_date;

-- 11. Product ranking with window functions.
WITH product_revenue AS (
    SELECT
        p.category,
        p.product_id,
        p.product_name,
        SUM(s.quantity * s.unit_price) AS revenue
    FROM sales AS s
    JOIN products AS p
        ON s.product_id = p.product_id
    GROUP BY p.category, p.product_id, p.product_name
)
SELECT
    category,
    product_id,
    product_name,
    revenue,
    RANK() OVER (
        PARTITION BY category
        ORDER BY revenue DESC
    ) AS category_revenue_rank,
    ROW_NUMBER() OVER (
        ORDER BY revenue DESC
    ) AS overall_revenue_position
FROM product_revenue
ORDER BY category, category_revenue_rank;

-- 12. Customer purchase sequence.
SELECT
    c.customer_name,
    s.sale_id,
    s.sale_date,
    p.product_name,
    s.quantity,
    s.quantity * s.unit_price AS revenue,
    ROW_NUMBER() OVER (
        PARTITION BY s.customer_id
        ORDER BY s.sale_date, s.sale_id
    ) AS customer_purchase_number,
    LAG(s.sale_date) OVER (
        PARTITION BY s.customer_id
        ORDER BY s.sale_date, s.sale_id
    ) AS previous_purchase_date
FROM sales AS s
JOIN customers AS c
    ON s.customer_id = c.customer_id
JOIN products AS p
    ON s.product_id = p.product_id
ORDER BY c.customer_name, s.sale_date, s.sale_id;

-- 13. Category share of total revenue.
WITH category_revenue AS (
    SELECT
        p.category,
        SUM(s.quantity * s.unit_price) AS revenue
    FROM sales AS s
    JOIN products AS p
        ON s.product_id = p.product_id
    GROUP BY p.category
)
SELECT
    category,
    revenue,
    ROUND(
        revenue / SUM(revenue) OVER () * 100,
        2
    ) AS percentage_of_total_revenue
FROM category_revenue
ORDER BY revenue DESC;

-- 14. Data quality check: sales with invalid customer or product references.
-- Foreign keys should prevent these rows, so this query should return zero rows.
SELECT
    s.sale_id,
    s.customer_id,
    s.product_id
FROM sales AS s
LEFT JOIN customers AS c
    ON s.customer_id = c.customer_id
LEFT JOIN products AS p
    ON s.product_id = p.product_id
WHERE c.customer_id IS NULL
   OR p.product_id IS NULL;
