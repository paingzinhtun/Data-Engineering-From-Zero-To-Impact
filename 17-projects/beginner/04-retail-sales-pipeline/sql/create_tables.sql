CREATE SCHEMA IF NOT EXISTS raw;
CREATE SCHEMA IF NOT EXISTS analytics;

DROP TABLE IF EXISTS analytics.mart_inventory_reorder;
DROP TABLE IF EXISTS analytics.mart_product_performance;
DROP TABLE IF EXISTS analytics.mart_daily_sales;
DROP TABLE IF EXISTS analytics.fact_sales;
DROP TABLE IF EXISTS analytics.dim_customer;
DROP TABLE IF EXISTS analytics.dim_product;
