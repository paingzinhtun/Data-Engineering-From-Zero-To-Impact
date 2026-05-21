# SQL Basics

## 1. What It Is

SQL, or Structured Query Language, is the standard language used to work with relational databases. It lets you create tables, insert data, query records, filter results, join related tables, aggregate values, and update stored data.

For Data Engineering, SQL is not only an analytics skill. It is also a validation, transformation, modeling, debugging, and production support skill.

## 2. Why It Matters

Most business data eventually becomes structured tables: customers, products, orders, payments, inventory, suppliers, shipments, subscriptions, and support tickets.

SQL helps Data Engineers:

- Inspect raw and modeled data.
- Validate pipeline outputs.
- Build reporting tables.
- Investigate data quality issues.
- Create transformations in warehouses.
- Answer business questions quickly.
- Communicate clearly with analysts and stakeholders.

Strong SQL is one of the highest-value skills for any Data Engineer.

## 3. Core Concepts

- **Database:** A system that stores and manages data.
- **Table:** A structured collection of rows and columns.
- **Column:** A named field such as `customer_id` or `sale_date`.
- **Row:** One record in a table.
- **Primary key:** A column or group of columns that uniquely identifies a row.
- **Foreign key:** A column that references a related row in another table.
- **SELECT:** Reads data from tables.
- **WHERE:** Filters rows.
- **GROUP BY:** Aggregates rows into groups.
- **ORDER BY:** Sorts query results.
- **JOIN:** Combines related tables.
- **NULL:** A missing or unknown value.

## 4. Real Business Example

A small retail company wants to know daily revenue and which products are selling.

The raw data includes:

- Customer records
- Product catalog
- Sales transactions
- Current inventory

SQL can answer questions such as:

- How much revenue did we make yesterday?
- Which product category had the most sales?
- Which products are low in stock?
- Which customers have purchased the most?
- Are there sales records with missing product IDs?

These questions are simple, but they are the foundation of business reporting.

## 5. SQL Examples

Select all products:

```sql
SELECT *
FROM products;
```

Select specific columns:

```sql
SELECT product_id, product_name, category, sale_price
FROM products;
```

Filter rows:

```sql
SELECT product_id, product_name, quantity_on_hand
FROM inventory
WHERE quantity_on_hand < reorder_level;
```

Aggregate sales:

```sql
SELECT
    sale_date,
    SUM(quantity * unit_price) AS daily_revenue
FROM sales
GROUP BY sale_date
ORDER BY sale_date;
```

Join sales to products:

```sql
SELECT
    s.sale_id,
    s.sale_date,
    p.product_name,
    p.category,
    s.quantity,
    s.unit_price
FROM sales AS s
JOIN products AS p
    ON s.product_id = p.product_id;
```

Check for missing customer references:

```sql
SELECT s.*
FROM sales AS s
LEFT JOIN customers AS c
    ON s.customer_id = c.customer_id
WHERE c.customer_id IS NULL;
```

## 6. Production Considerations

- Use clear table and column names.
- Understand the grain of each table before querying.
- Validate row counts after loading data.
- Be careful with `NULL` values in filters and calculations.
- Avoid `SELECT *` in production transformations.
- Document metric definitions such as revenue, gross profit, and active customer.
- Check joins for accidental duplication.
- Use transactions for multi-step changes when needed.

## 7. Common Mistakes

- Filtering after aggregation when `HAVING` is needed.
- Joining on names instead of stable IDs.
- Forgetting that `NULL` does not behave like an empty string or zero.
- Using `SELECT *` without understanding the table.
- Counting rows after a join without checking for duplicates.
- Calculating revenue without considering refunds, discounts, taxes, or returns.
- Assuming every table has one row per business entity.

## 8. Practice Tasks

Using the PostgreSQL practice database in `postgresql-practice/`:

1. List all customers.
2. List products by category.
3. Find products below reorder level.
4. Calculate total revenue by day.
5. Count how many sales each customer made.
6. Find the most recent sale date.
7. Check whether any sale has a missing customer or product.

## 9. Related Project

- `02-sql-and-databases/postgresql-practice/`: Practice SQL using a small retail database.
- `17-projects/`: Retail sales and inventory projects should use these query patterns.
