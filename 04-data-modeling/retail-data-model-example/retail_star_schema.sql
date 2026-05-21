DROP VIEW IF EXISTS mart_inventory_reorder;
DROP VIEW IF EXISTS mart_product_performance;
DROP VIEW IF EXISTS mart_daily_sales;
DROP TABLE IF EXISTS fact_inventory_snapshot;
DROP TABLE IF EXISTS fact_sales;
DROP TABLE IF EXISTS dim_customer;
DROP TABLE IF EXISTS dim_product;
DROP TABLE IF EXISTS dim_date;

CREATE TABLE dim_date (
    date_key INTEGER PRIMARY KEY,
    full_date DATE NOT NULL UNIQUE,
    day_of_week INTEGER NOT NULL CHECK (day_of_week BETWEEN 1 AND 7),
    day_name VARCHAR(20) NOT NULL,
    week_of_year INTEGER NOT NULL CHECK (week_of_year BETWEEN 1 AND 53),
    month_number INTEGER NOT NULL CHECK (month_number BETWEEN 1 AND 12),
    month_name VARCHAR(20) NOT NULL,
    quarter_number INTEGER NOT NULL CHECK (quarter_number BETWEEN 1 AND 4),
    year_number INTEGER NOT NULL,
    is_weekend BOOLEAN NOT NULL
);

CREATE TABLE dim_product (
    product_key INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_id VARCHAR(50) NOT NULL UNIQUE,
    product_name VARCHAR(150) NOT NULL,
    product_category VARCHAR(80) NOT NULL,
    product_subcategory VARCHAR(80),
    brand VARCHAR(80),
    unit_cost NUMERIC(12, 2) NOT NULL CHECK (unit_cost >= 0),
    standard_unit_price NUMERIC(12, 2) NOT NULL CHECK (standard_unit_price >= 0),
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE dim_customer (
    customer_key INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id VARCHAR(50) NOT NULL UNIQUE,
    customer_name VARCHAR(150) NOT NULL,
    customer_segment VARCHAR(60) NOT NULL,
    city VARCHAR(100),
    region VARCHAR(100),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Grain: one row per product sold per sales transaction line.
CREATE TABLE fact_sales (
    sales_key BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    sales_transaction_id VARCHAR(80) NOT NULL,
    sales_line_id VARCHAR(80) NOT NULL UNIQUE,
    date_key INTEGER NOT NULL REFERENCES dim_date (date_key),
    product_key INTEGER NOT NULL REFERENCES dim_product (product_key),
    customer_key INTEGER NOT NULL REFERENCES dim_customer (customer_key),
    sales_channel VARCHAR(30) NOT NULL CHECK (sales_channel IN ('store', 'online')),
    quantity_sold INTEGER NOT NULL CHECK (quantity_sold > 0),
    unit_price NUMERIC(12, 2) NOT NULL CHECK (unit_price >= 0),
    unit_cost NUMERIC(12, 2) NOT NULL CHECK (unit_cost >= 0),
    revenue NUMERIC(12, 2) GENERATED ALWAYS AS (quantity_sold * unit_price) STORED,
    cost_amount NUMERIC(12, 2) GENERATED ALWAYS AS (quantity_sold * unit_cost) STORED,
    gross_profit NUMERIC(12, 2) GENERATED ALWAYS AS (
        quantity_sold * (unit_price - unit_cost)
    ) STORED,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Grain: one row per product per inventory snapshot date.
CREATE TABLE fact_inventory_snapshot (
    inventory_snapshot_key BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    snapshot_date_key INTEGER NOT NULL REFERENCES dim_date (date_key),
    product_key INTEGER NOT NULL REFERENCES dim_product (product_key),
    quantity_on_hand INTEGER NOT NULL CHECK (quantity_on_hand >= 0),
    reorder_level INTEGER NOT NULL CHECK (reorder_level >= 0),
    reorder_quantity INTEGER NOT NULL DEFAULT 0 CHECK (reorder_quantity >= 0),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uq_inventory_snapshot_product_date UNIQUE (
        snapshot_date_key,
        product_key
    )
);

CREATE INDEX idx_fact_sales_date_key ON fact_sales (date_key);
CREATE INDEX idx_fact_sales_product_key ON fact_sales (product_key);
CREATE INDEX idx_fact_sales_customer_key ON fact_sales (customer_key);
CREATE INDEX idx_inventory_snapshot_date_key
    ON fact_inventory_snapshot (snapshot_date_key);
CREATE INDEX idx_inventory_snapshot_product_key
    ON fact_inventory_snapshot (product_key);

-- Grain: one row per sales date.
CREATE VIEW mart_daily_sales AS
SELECT
    d.full_date AS sales_date,
    d.year_number,
    d.month_number,
    d.month_name,
    COUNT(DISTINCT f.sales_transaction_id) AS transaction_count,
    SUM(f.quantity_sold) AS units_sold,
    SUM(f.revenue) AS revenue,
    SUM(f.cost_amount) AS cost_amount,
    SUM(f.gross_profit) AS gross_profit,
    CASE
        WHEN SUM(f.revenue) = 0 THEN NULL
        ELSE ROUND(SUM(f.gross_profit) / SUM(f.revenue) * 100, 2)
    END AS gross_margin_percentage
FROM fact_sales AS f
JOIN dim_date AS d
    ON f.date_key = d.date_key
GROUP BY
    d.full_date,
    d.year_number,
    d.month_number,
    d.month_name;

-- Grain: one row per product.
CREATE VIEW mart_product_performance AS
SELECT
    p.product_id,
    p.product_name,
    p.product_category,
    p.product_subcategory,
    p.brand,
    SUM(f.quantity_sold) AS units_sold,
    SUM(f.revenue) AS revenue,
    SUM(f.cost_amount) AS cost_amount,
    SUM(f.gross_profit) AS gross_profit,
    CASE
        WHEN SUM(f.revenue) = 0 THEN NULL
        ELSE ROUND(SUM(f.gross_profit) / SUM(f.revenue) * 100, 2)
    END AS gross_margin_percentage,
    MAX(d.full_date) AS most_recent_sale_date
FROM fact_sales AS f
JOIN dim_product AS p
    ON f.product_key = p.product_key
JOIN dim_date AS d
    ON f.date_key = d.date_key
GROUP BY
    p.product_id,
    p.product_name,
    p.product_category,
    p.product_subcategory,
    p.brand;

-- Grain: one row per product for the latest inventory snapshot.
CREATE VIEW mart_inventory_reorder AS
WITH latest_snapshot AS (
    SELECT MAX(snapshot_date_key) AS snapshot_date_key
    FROM fact_inventory_snapshot
),
current_inventory AS (
    SELECT
        i.snapshot_date_key,
        i.product_key,
        i.quantity_on_hand,
        i.reorder_level,
        i.reorder_quantity
    FROM fact_inventory_snapshot AS i
    JOIN latest_snapshot AS l
        ON i.snapshot_date_key = l.snapshot_date_key
)
SELECT
    d.full_date AS snapshot_date,
    p.product_id,
    p.product_name,
    p.product_category,
    p.product_subcategory,
    i.quantity_on_hand,
    i.reorder_level,
    i.reorder_quantity,
    CASE
        WHEN i.quantity_on_hand = 0 THEN 'out_of_stock'
        WHEN i.quantity_on_hand < i.reorder_level THEN 'reorder_needed'
        ELSE 'healthy'
    END AS inventory_status
FROM current_inventory AS i
JOIN dim_product AS p
    ON i.product_key = p.product_key
JOIN dim_date AS d
    ON i.snapshot_date_key = d.date_key;
