# Setup

## Prerequisites

- PostgreSQL installed locally or running in Docker
- Python installed if using a Python loader
- Basic command-line knowledge

## Steps

1. Create a database named `retail_learning`.
2. Create a table for products.
3. Place the source CSV in a `data/` folder.
4. Load the CSV into PostgreSQL.
5. Run validation queries.

## Validation Queries

```sql
SELECT COUNT(*) FROM raw_products;

SELECT product_id, COUNT(*)
FROM raw_products
GROUP BY product_id
HAVING COUNT(*) > 1;

SELECT *
FROM raw_products
WHERE product_id IS NULL
   OR product_name IS NULL;
```
