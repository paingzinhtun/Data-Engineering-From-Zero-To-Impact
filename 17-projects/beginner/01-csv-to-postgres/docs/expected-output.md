# Expected Output

## Purpose

This document shows what correct project output should look like after running the SQL scripts.

Your timestamps may be different, but the row counts and business results should be similar if you are using the provided `data/products.csv` file.

## 1. Total Row Count

### SQL Query

```sql
SELECT
    COUNT(*) AS total_products_loaded
FROM products;
```

### Example Expected Result

| total_products_loaded |
| ---: |
| 120 |

### Business Meaning

This confirms that all 120 product records from the CSV file were loaded into PostgreSQL.

## 2. Sample Rows From Products Table

### SQL Query

```sql
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
```

### Example Expected Result

| product_id | product_name | category | brand | cost_price | selling_price | stock_quantity | reorder_level | supplier_name | is_active | loaded_at |
| ---: | --- | --- | --- | ---: | ---: | ---: | ---: | --- | --- | --- |
| 1 | Blue Ballpoint Pen | Writing | Pilot | 350.00 | 500.00 | 120 | 30 | Yangon Stationery Supply | true | your load timestamp |
| 2 | Black Ballpoint Pen | Writing | Pilot | 350.00 | 500.00 | 95 | 30 | Yangon Stationery Supply | true | your load timestamp |
| 3 | Red Ballpoint Pen | Writing | Pilot | 350.00 | 500.00 | 40 | 25 | Yangon Stationery Supply | true | your load timestamp |
| 4 | Black Gel Pen | Writing | Zebra | 700.00 | 1000.00 | 45 | 25 | Mandalay Office Mart | true | your load timestamp |
| 5 | Blue Gel Pen | Writing | Zebra | 700.00 | 1000.00 | 24 | 25 | Mandalay Office Mart | true | your load timestamp |

### Business Meaning

This preview confirms that the product data loaded into the correct columns. The `loaded_at` column should also have a timestamp showing when the data was inserted.

## 3. Data Quality Checks That Should Return 0 Rows

### SQL Query

```sql
SELECT
    product_id,
    product_name AS missing_product_name
FROM products
WHERE product_name IS NULL
   OR TRIM(product_name) = '';
```

```sql
SELECT
    product_id,
    product_name,
    cost_price,
    selling_price
FROM products
WHERE cost_price < 0
   OR selling_price < 0;
```

```sql
SELECT
    product_id,
    product_name,
    cost_price,
    selling_price,
    selling_price - cost_price AS profit_per_unit
FROM products
WHERE selling_price < cost_price;
```

```sql
SELECT
    product_id,
    COUNT(*) AS duplicate_count
FROM products
GROUP BY product_id
HAVING COUNT(*) > 1;
```

### Example Expected Result

```text
0 rows
```

### Business Meaning

For these checks, no output is a good result. It means the loaded data does not have missing product names, negative prices, selling prices below cost, or duplicate product IDs.

## 4. Products That Need Restocking

### SQL Query

```sql
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
```

### Example Expected Result

| product_id | product_name | category | supplier_name | stock_quantity | reorder_level |
| ---: | --- | --- | --- | ---: | ---: |
| 109 | Notebook Premium | Paper | Yangon Stationery Supply | 3 | 5 |
| 60 | Date Stamp | Office Tools | Yangon Office Depot | 4 | 6 |
| 106 | File Tray Triple | Office Tools | Mandalay Office Mart | 4 | 6 |
| 114 | Brush Pen Color Set | Writing | Yangon Art Center | 4 | 5 |
| 40 | Brown Kraft Paper Roll | Paper | Mandalay Paper House | 5 | 8 |

### Business Meaning

These products are at or below their reorder level. This is not a data error. It is useful inventory insight that helps the shop owner decide what to buy next.

## 5. Product Profit Margin Result

### SQL Query

```sql
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
```

### Example Expected Result

| product_id | product_name | category | cost_price | selling_price | profit_margin_percentage |
| ---: | --- | --- | ---: | ---: | ---: |
| 85 | Ruler 6 Inch | Accessories | 400.00 | 800.00 | 100.00 |
| 98 | School Bag Tag | Accessories | 500.00 | 1000.00 | 100.00 |
| 89 | Lanyard Plain | Accessories | 800.00 | 1500.00 | 87.50 |
| 44 | Paper Clips Box | Office Tools | 500.00 | 900.00 | 80.00 |
| 90 | ID Card Sleeve | Accessories | 500.00 | 900.00 | 80.00 |

### Business Meaning

This shows which products have the highest percentage profit compared to their cost. High-margin products can be important for pricing and restocking decisions.

## 6. Inventory Value By Category

### SQL Query

```sql
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
```

### Example Expected Result

| category | product_count | total_units_in_stock | inventory_cost_value | potential_sales_value |
| --- | ---: | ---: | ---: | ---: |
| Paper | 26 | 630 | 1505000.00 | 2131700.00 |
| Office Tools | 26 | 370 | 925700.00 | 1398500.00 |
| Accessories | 23 | 552 | 785900.00 | 1247900.00 |
| Writing | 23 | 660 | 701050.00 | 1055100.00 |
| Art Supplies | 20 | 237 | 683500.00 | 1052800.00 |

### Business Meaning

This shows where the shop's money is invested by category. In this dataset, `Paper` has the highest inventory cost value, so it may need close stock and supplier management.

## 7. Supplier Inventory Value

### SQL Query

```sql
SELECT
    supplier_name,
    COUNT(*) AS product_count,
    SUM(stock_quantity) AS total_units_in_stock,
    SUM(cost_price * stock_quantity) AS inventory_cost_value
FROM products
WHERE is_active = TRUE
GROUP BY supplier_name
ORDER BY inventory_cost_value DESC;
```

### Example Expected Result

| supplier_name | product_count | total_units_in_stock | inventory_cost_value |
| --- | ---: | ---: | ---: |
| Yangon Paper World | 8 | 191 | 872900.00 |
| Mandalay Office Mart | 22 | 365 | 848600.00 |
| Yangon Office Depot | 25 | 360 | 732000.00 |
| Yangon School Supplies | 18 | 644 | 667900.00 |
| Yangon Stationery Supply | 17 | 561 | 574450.00 |

### Business Meaning

This shows which suppliers provide the highest value of inventory. A business owner can use this information to manage supplier relationships, negotiate better prices, and monitor dependency on key suppliers.
