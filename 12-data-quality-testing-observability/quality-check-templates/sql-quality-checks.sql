-- Null checks
SELECT COUNT(*) AS missing_sale_line_ids
FROM fact_sales
WHERE sale_line_id IS NULL;

SELECT COUNT(*) AS missing_product_keys
FROM fact_sales
WHERE product_key IS NULL;

-- Duplicate checks
SELECT
    sale_line_id,
    COUNT(*) AS row_count
FROM fact_sales
GROUP BY sale_line_id
HAVING COUNT(*) > 1;

-- Row count checks
SELECT
    sales_date,
    COUNT(*) AS row_count
FROM mart_daily_sales
GROUP BY sales_date
ORDER BY sales_date DESC;

-- Freshness checks
SELECT
    MAX(sales_date) AS latest_sales_date,
    CURRENT_DATE - MAX(sales_date) AS days_since_latest_sales
FROM mart_daily_sales;

-- Accepted values
SELECT DISTINCT sales_channel
FROM fact_sales
WHERE sales_channel NOT IN ('store', 'online');

-- Referential integrity: sales product keys must exist in dim_product
SELECT
    f.sale_line_id,
    f.product_key
FROM fact_sales AS f
LEFT JOIN dim_product AS p
    ON f.product_key = p.product_key
WHERE p.product_key IS NULL;

-- Referential integrity: sales customer keys must exist in dim_customer
SELECT
    f.sale_line_id,
    f.customer_key
FROM fact_sales AS f
LEFT JOIN dim_customer AS c
    ON f.customer_key = c.customer_key
WHERE c.customer_key IS NULL;

-- Negative quantity checks
SELECT *
FROM fact_sales
WHERE quantity_sold <= 0;

-- Revenue sanity checks
SELECT *
FROM fact_sales
WHERE revenue < 0
   OR revenue > 100000;

-- Gross profit sanity checks
SELECT *
FROM fact_sales
WHERE gross_profit < -10000
   OR gross_profit > 100000;

-- Inventory quantity checks
SELECT *
FROM fact_inventory_snapshot
WHERE quantity_on_hand < 0
   OR reorder_level < 0;

-- Schema change check: review current columns and data types
SELECT
    table_name,
    column_name,
    data_type,
    ordinal_position
FROM information_schema.columns
WHERE table_name IN (
    'stg_sales',
    'dim_product',
    'dim_customer',
    'fact_sales',
    'fact_inventory_snapshot',
    'mart_daily_sales'
)
ORDER BY table_name, ordinal_position;

-- Expected schema check example for fact_sales
WITH expected_columns AS (
    SELECT *
    FROM (
        VALUES
            ('sale_line_id'),
            ('sales_date'),
            ('product_key'),
            ('customer_key'),
            ('sales_channel'),
            ('quantity_sold'),
            ('revenue'),
            ('gross_profit')
    ) AS columns(column_name)
),
actual_columns AS (
    SELECT column_name
    FROM information_schema.columns
    WHERE table_name = 'fact_sales'
)
SELECT e.column_name AS missing_expected_column
FROM expected_columns AS e
LEFT JOIN actual_columns AS a
    ON e.column_name = a.column_name
WHERE a.column_name IS NULL;
