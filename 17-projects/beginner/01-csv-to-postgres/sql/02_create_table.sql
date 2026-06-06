/*
  Project: CSV to PostgreSQL Product Catalog
  Script: 02_create_table.sql

  Purpose:
  This script creates the products table for the stationery shop product catalog.

  Run this script after:
  1. Creating the stationery_shop database
  2. Connecting to the stationery_shop database
*/

CREATE TABLE products (
    -- Unique ID for each product in the catalog.
    product_id INTEGER PRIMARY KEY,

    -- Product name used by shop staff and customers.
    product_name VARCHAR(100) NOT NULL,

    -- Business category used for reporting and analysis.
    category VARCHAR(50) NOT NULL,

    -- Product brand or local brand name.
    brand VARCHAR(50),

    -- Amount the shop pays to buy the product.
    cost_price NUMERIC(10,2) NOT NULL,

    -- Amount the shop charges customers for the product.
    selling_price NUMERIC(10,2) NOT NULL,

    -- Current number of units available in stock.
    stock_quantity INTEGER NOT NULL,

    -- Minimum stock level before the shop should reorder.
    reorder_level INTEGER NOT NULL,

    -- Supplier that provides the product to the shop.
    supplier_name VARCHAR(100),

    -- Shows whether the product is currently sold by the shop.
    -- TRUE means the product is active. FALSE means it is inactive or discontinued.
    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    -- Timestamp showing when the row was loaded into PostgreSQL.
    -- This is filled automatically during insert or CSV load.
    loaded_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT chk_products_cost_price_non_negative
        CHECK (cost_price >= 0),

    CONSTRAINT chk_products_selling_price_non_negative
        CHECK (selling_price >= 0),

    CONSTRAINT chk_products_stock_quantity_non_negative
        CHECK (stock_quantity >= 0),

    CONSTRAINT chk_products_reorder_level_non_negative
        CHECK (reorder_level >= 0),

    CONSTRAINT chk_products_selling_price_at_least_cost_price
        CHECK (selling_price >= cost_price)
);
