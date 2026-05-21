# PostgreSQL Practice

This folder contains a small retail database for practicing SQL in a Data Engineering context.

## What It Includes

- `schema.sql`: Creates the retail practice tables.
- `seed_data.sql`: Inserts sample customers, products, inventory, and sales.
- `practice_queries.sql`: Provides beginner, intermediate, and advanced practice queries.

## Database Scenario

The database represents a small retail business with:

- Customers who buy products
- Products grouped by category
- Sales transactions from store and online channels
- Inventory levels and reorder thresholds

The schema is intentionally small so learners can focus on query logic, relationships, metrics, and validation.

## How To Use

Create a PostgreSQL database, then run the files in order:

```bash
psql -d retail_practice -f schema.sql
psql -d retail_practice -f seed_data.sql
psql -d retail_practice -f practice_queries.sql
```

If you are using a different database name, replace `retail_practice` with your database.

## Learning Goals

After using this practice database, you should be able to:

- Query individual tables.
- Join customers, products, sales, and inventory.
- Calculate revenue and gross profit.
- Identify low-stock products.
- Summarize customer purchasing behavior.
- Use window functions for ranking and moving averages.
- Think about data quality checks in SQL.

## Suggested Workflow

1. Read `schema.sql` to understand the tables and relationships.
2. Run `seed_data.sql` to load sample data.
3. Open `practice_queries.sql`.
4. Run one query at a time.
5. Modify each query and observe how the result changes.
6. Write your own questions before looking for more examples.

## Related Sections

- `../sql-basics.md`
- `../advanced-sql.md`
- `../joins-and-window-functions.md`
- `../indexes-and-query-optimization.md`
- `../transactions-and-acid.md`
