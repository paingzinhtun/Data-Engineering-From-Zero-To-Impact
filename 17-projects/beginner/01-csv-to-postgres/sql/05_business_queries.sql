/*
  Project: CSV to PostgreSQL Product Catalog
  Script: 05_business_queries.sql

  Purpose:
  Answer simple but useful business questions from the stationery shop
  product catalog.

  Run this script after loading and validating the products table.
*/

/*
  1. How many active products does the shop sell?

  Business reason:
  Shows how many products are currently available for sale.
*/
SELECT
    COUNT(*) AS active_product_count
FROM products
WHERE is_active = TRUE;

/*
  2. Which products need restocking?

  Business reason:
  Helps the shop owner decide which products to reorder before they run out.
*/
SELECT
    product_id,
    product_name,
    category,
    supplier_name,
    stock_quantity,
    reorder_level
FROM products
WHERE stock_quantity <= reorder_level
  AND is_active = TRUE
ORDER BY stock_quantity ASC, product_id;

/*
  3. Which products have the highest profit per unit?

  Business reason:
  Shows which products earn the most money for each unit sold.
*/
SELECT
    product_id,
    product_name,
    category,
    cost_price,
    selling_price,
    selling_price - cost_price AS profit_per_unit
FROM products
WHERE is_active = TRUE
ORDER BY profit_per_unit DESC, product_id
LIMIT 10;

/*
  4. Which products have the highest profit margin percentage?

  Business reason:
  Shows which products have the best percentage return compared to cost.
*/
SELECT
    product_id,
    product_name,
    category,
    cost_price,
    selling_price,
    ROUND(((selling_price - cost_price) / cost_price) * 100, 2) AS profit_margin_percentage
FROM products
WHERE is_active = TRUE
  AND cost_price > 0
ORDER BY profit_margin_percentage DESC, product_id
LIMIT 10;

/*
  5. What is the total inventory cost value?

  Business reason:
  Shows how much money the shop has invested in current stock.
*/
SELECT
    SUM(cost_price * stock_quantity) AS total_inventory_cost_value
FROM products
WHERE is_active = TRUE;

/*
  6. What is the total potential sales value?

  Business reason:
  Shows the total revenue the shop could earn if all active stock is sold.
*/
SELECT
    SUM(selling_price * stock_quantity) AS total_potential_sales_value
FROM products
WHERE is_active = TRUE;

/*
  7. What is the inventory value by category?

  Business reason:
  Shows which product categories hold the most stock investment.
*/
SELECT
    category,
    COUNT(*) AS product_count,
    SUM(stock_quantity) AS total_units_in_stock,
    SUM(cost_price * stock_quantity) AS inventory_cost_value,
    SUM(selling_price * stock_quantity) AS potential_sales_value
FROM products
WHERE is_active = TRUE
GROUP BY category
ORDER BY inventory_cost_value DESC;

/*
  8. Which supplier provides the highest inventory value?

  Business reason:
  Shows which suppliers are most important based on the value of stock they provide.
*/
SELECT
    supplier_name,
    COUNT(*) AS product_count,
    SUM(stock_quantity) AS total_units_in_stock,
    SUM(cost_price * stock_quantity) AS inventory_cost_value
FROM products
WHERE is_active = TRUE
GROUP BY supplier_name
ORDER BY inventory_cost_value DESC;

/*
  9. Which category has the most products?

  Business reason:
  Shows which product categories are largest in the shop catalog.
*/
SELECT
    category,
    COUNT(*) AS product_count
FROM products
WHERE is_active = TRUE
GROUP BY category
ORDER BY product_count DESC, category;

/*
  10. Which products have low stock but high profit margin?

  Business reason:
  These products may deserve priority restocking because they are running low
  and have strong profit potential.
*/
SELECT
    product_id,
    product_name,
    category,
    supplier_name,
    stock_quantity,
    reorder_level,
    cost_price,
    selling_price,
    ROUND(((selling_price - cost_price) / cost_price) * 100, 2) AS profit_margin_percentage
FROM products
WHERE is_active = TRUE
  AND stock_quantity <= reorder_level
  AND cost_price > 0
  AND ((selling_price - cost_price) / cost_price) * 100 >= 40
ORDER BY profit_margin_percentage DESC, stock_quantity ASC;

/*
  How these queries help a business owner:

  These queries turn the product catalog into useful business information.
  The owner can see which products are active, which items need restocking,
  which products are most profitable, how much money is invested in inventory,
  and which suppliers or categories are most important.

  This helps the shop make better decisions about purchasing, pricing,
  stock planning, and supplier management.
*/
