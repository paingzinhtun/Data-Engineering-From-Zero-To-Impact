/*
  Project: CSV to PostgreSQL Product Catalog
  Script: 04_validation_queries.sql

  Purpose:
  Validate that data/products.csv was loaded correctly into the products table.

  Run this script after loading the CSV data.
*/

/*
  1. Total row count
  Business reason:
  Confirms that the expected number of product records was loaded.
*/
SELECT
    COUNT(*) AS total_products_loaded
FROM products;

/*
  2. Preview first 10 rows
  Business reason:
  Helps beginners visually confirm that product names, prices, stock values,
  suppliers, and active status loaded into the correct columns.
*/
SELECT
    product_id,
    product_name,
    category,
    brand,
    cost_price,
    selling_price,
    stock_quantity,
    reorder_level,
    supplier_name,
    is_active,
    loaded_at
FROM products
ORDER BY product_id
LIMIT 10;

/*
  3. Check missing product names
  Business reason:
  Every product needs a name so staff can identify it.
  Expected result: 0 rows
*/
SELECT
    product_id,
    product_name AS missing_product_name
FROM products
WHERE product_name IS NULL
   OR TRIM(product_name) = '';

/*
  4. Check missing categories
  Business reason:
  Categories are needed for inventory and sales reporting by product group.
  Expected result: 0 rows
*/
SELECT
    product_id,
    product_name,
    category AS missing_category
FROM products
WHERE category IS NULL
   OR TRIM(category) = '';

/*
  5. Check negative cost_price or selling_price
  Business reason:
  Product prices cannot be negative in a real business.
  Expected result: 0 rows
*/
SELECT
    product_id,
    product_name,
    cost_price,
    selling_price
FROM products
WHERE cost_price < 0
   OR selling_price < 0;

/*
  6. Check selling_price lower than cost_price
  Business reason:
  Selling below cost may create a loss, so these products need review.
  Expected result: 0 rows
*/
SELECT
    product_id,
    product_name,
    cost_price,
    selling_price,
    selling_price - cost_price AS profit_per_unit
FROM products
WHERE selling_price < cost_price;

/*
  7. Check negative stock_quantity or reorder_level
  Business reason:
  Stock and reorder levels cannot be negative in normal inventory tracking.
  Expected result: 0 rows
*/
SELECT
    product_id,
    product_name,
    stock_quantity,
    reorder_level
FROM products
WHERE stock_quantity < 0
   OR reorder_level < 0;

/*
  8. Check duplicate product_id
  Business reason:
  product_id is the unique identifier for each product.
  Duplicate IDs can cause incorrect updates and reporting.
  The primary key also protects the table from duplicate product_id values.
  Expected result: 0 rows
*/
SELECT
    product_id,
    COUNT(*) AS duplicate_count
FROM products
GROUP BY product_id
HAVING COUNT(*) > 1;

/*
  9. Check duplicate product_name and brand combination
  Business reason:
  The same product name from the same brand may indicate duplicate catalog records.
  Expected result: 0 rows
*/
SELECT
    product_name,
    brand,
    COUNT(*) AS duplicate_count
FROM products
GROUP BY product_name, brand
HAVING COUNT(*) > 1;

/*
  10. Check products that need restocking
  Business reason:
  Products where stock_quantity is less than or equal to reorder_level
  should be reviewed for purchase orders.

  Non-zero rows are useful business insight, not necessarily an error.
*/
SELECT
    product_id,
    product_name,
    category,
    supplier_name,
    stock_quantity,
    reorder_level,
    reorder_level - stock_quantity AS units_below_reorder_level
FROM products
WHERE stock_quantity <= reorder_level
  AND is_active = TRUE
ORDER BY units_below_reorder_level DESC, product_id;

/*
  11. Check inactive products
  Business reason:
  Inactive products may be discontinued, old stock, or items no longer sold.
  These are not errors, but they should be visible for catalog management.
*/
SELECT
    product_id,
    product_name,
    category,
    brand,
    stock_quantity,
    is_active
FROM products
WHERE is_active = FALSE
ORDER BY product_id;

/*
  12. Check loaded_at values
  Business reason:
  loaded_at shows when each row was inserted into PostgreSQL.
  Missing loaded_at values would make it harder to audit data loading.
  Expected result: 0 rows
*/
SELECT
    product_id,
    product_name,
    loaded_at
FROM products
WHERE loaded_at IS NULL;

/*
  12b. Summary of loaded_at values
  Business reason:
  Shows the earliest and latest load timestamps for the current table data.
*/
SELECT
    MIN(loaded_at) AS earliest_loaded_at,
    MAX(loaded_at) AS latest_loaded_at,
    COUNT(*) AS rows_with_loaded_at
FROM products
WHERE loaded_at IS NOT NULL;
