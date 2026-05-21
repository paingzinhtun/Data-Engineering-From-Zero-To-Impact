CREATE SCHEMA IF NOT EXISTS analytics;

DROP TABLE IF EXISTS analytics.dim_product;
CREATE TABLE analytics.dim_product AS
SELECT
    product_id,
    product_name,
    category,
    unit_cost,
    unit_price
FROM raw.products;

DROP TABLE IF EXISTS analytics.dim_customer;
CREATE TABLE analytics.dim_customer AS
SELECT
    customer_id,
    customer_name,
    customer_segment,
    city
FROM raw.customers;

DROP TABLE IF EXISTS analytics.fact_sales;
CREATE TABLE analytics.fact_sales AS
SELECT
    s.sale_id,
    s.sale_line_id,
    s.sale_date,
    s.customer_id,
    c.customer_name,
    c.customer_segment,
    c.city,
    s.product_id,
    p.product_name,
    p.category,
    s.quantity,
    s.unit_price,
    s.discount_amount,
    s.gross_sales,
    s.net_sales,
    s.cost_amount,
    s.gross_profit
FROM raw.sales AS s
LEFT JOIN analytics.dim_product AS p
    ON s.product_id = p.product_id
LEFT JOIN analytics.dim_customer AS c
    ON s.customer_id = c.customer_id;

CREATE INDEX IF NOT EXISTS idx_fact_sales_sale_date
    ON analytics.fact_sales (sale_date);

CREATE INDEX IF NOT EXISTS idx_fact_sales_product_id
    ON analytics.fact_sales (product_id);

CREATE INDEX IF NOT EXISTS idx_fact_sales_customer_id
    ON analytics.fact_sales (customer_id);

DROP TABLE IF EXISTS analytics.mart_daily_sales;
CREATE TABLE analytics.mart_daily_sales AS
SELECT
    sale_date,
    COUNT(DISTINCT sale_id) AS transaction_count,
    SUM(quantity) AS units_sold,
    SUM(gross_sales) AS gross_sales,
    SUM(net_sales) AS net_sales,
    SUM(cost_amount) AS cost_amount,
    SUM(gross_profit) AS gross_profit
FROM analytics.fact_sales
GROUP BY sale_date
ORDER BY sale_date;

DROP TABLE IF EXISTS analytics.mart_product_performance;
CREATE TABLE analytics.mart_product_performance AS
SELECT
    product_id,
    product_name,
    category,
    SUM(quantity) AS units_sold,
    SUM(gross_sales) AS gross_sales,
    SUM(net_sales) AS net_sales,
    SUM(cost_amount) AS cost_amount,
    SUM(gross_profit) AS gross_profit
FROM analytics.fact_sales
GROUP BY product_id, product_name, category
ORDER BY gross_profit DESC;

DROP TABLE IF EXISTS analytics.mart_inventory_reorder;
CREATE TABLE analytics.mart_inventory_reorder AS
SELECT
    i.snapshot_date,
    i.product_id,
    p.product_name,
    p.category,
    i.quantity_on_hand,
    i.reorder_level,
    CASE
        WHEN i.quantity_on_hand = 0 THEN 'out_of_stock'
        WHEN i.quantity_on_hand < i.reorder_level THEN 'reorder_needed'
        ELSE 'healthy'
    END AS inventory_status
FROM raw.inventory AS i
LEFT JOIN raw.products AS p
    ON i.product_id = p.product_id
ORDER BY inventory_status, i.quantity_on_hand;
