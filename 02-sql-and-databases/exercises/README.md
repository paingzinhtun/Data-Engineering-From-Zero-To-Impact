# SQL Exercises

This folder is for SQL practice exercises connected to the `02-sql-and-databases` learning section.

## How To Use These Exercises

Start with the PostgreSQL practice database in `../postgresql-practice/`.

Recommended order:

1. Read the schema.
2. Load the seed data.
3. Run the beginner queries.
4. Modify each query.
5. Try the exercises below without looking at the examples.
6. Compare your answers with `../postgresql-practice/practice_queries.sql`.

## Beginner Exercises

1. List all products with their category and sale price.
2. Find all customers in Yangon.
3. Count the total number of sales.
4. Calculate total units sold.
5. Find products where inventory is below the reorder level.
6. Calculate daily sales revenue.

## Intermediate Exercises

1. Calculate revenue by product.
2. Calculate revenue by category.
3. Find the top three products by revenue.
4. Create a customer purchase summary.
5. Calculate gross profit by product.
6. Find products with low stock and recent sales.
7. Compare revenue from `store` and `online` channels.

## Advanced Exercises

1. Rank products by revenue within each category.
2. Calculate a three-day moving average of daily revenue.
3. Use `LAG` to find each customer's previous purchase date.
4. Calculate each category's percentage of total revenue.
5. Identify each customer's first purchase.
6. Create a query that classifies inventory as `out_of_stock`, `low_stock`, or `healthy`.
7. Write a data quality query that should return zero rows if foreign key relationships are valid.

## Reflection Questions

After completing the exercises, answer:

1. Which queries changed row counts after joins?
2. Which business metric needed the clearest definition?
3. Which query would become slow if the sales table had millions of rows?
4. Which columns might need indexes in a larger database?
5. Which results would be useful for a retail manager?

## Related Files

- `../sql-basics.md`
- `../advanced-sql.md`
- `../joins-and-window-functions.md`
- `../indexes-and-query-optimization.md`
- `../transactions-and-acid.md`
- `../postgresql-practice/practice_queries.sql`
