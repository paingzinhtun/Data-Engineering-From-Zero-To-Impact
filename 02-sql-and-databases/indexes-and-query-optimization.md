# Indexes And Query Optimization

## 1. What It Is

Indexes are database structures that help queries find rows faster. Query optimization is the process of improving query performance while keeping results correct.

An index is similar to an index in a book. Instead of scanning every page, the database can use the index to find relevant rows more efficiently.

## 2. Why It Matters

Slow queries can delay dashboards, pipelines, reports, and business decisions. As tables grow, queries that worked on small samples may become too slow for production.

Data Engineers need optimization basics to:

- Debug slow transformations.
- Keep dashboards responsive.
- Reduce warehouse costs.
- Design better tables.
- Support reliable scheduled jobs.
- Understand database execution plans.

Optimization should be driven by evidence, not guessing.

## 3. Core Concepts

- **Index:** A structure that speeds up lookups for selected columns.
- **Sequential scan:** Reading many or all rows in a table.
- **Index scan:** Using an index to find relevant rows.
- **Execution plan:** The database's plan for running a query.
- **Cardinality:** The number of distinct values in a column.
- **Selectivity:** How much a filter reduces rows.
- **Composite index:** An index on multiple columns.
- **Query predicate:** A filter condition in `WHERE` or join logic.
- **Statistics:** Metadata the database uses to estimate query cost.

## 4. Real Business Example

A dashboard shows low-stock products and top-selling products. At first, it runs quickly. After one year, the `sales` table has millions of rows and the dashboard becomes slow.

The Data Engineer investigates:

- Are queries filtering by `sale_date`?
- Are joins using indexed keys?
- Is the query aggregating more rows than needed?
- Are dashboard queries hitting raw transaction tables instead of summary tables?
- Would an index, materialized table, or warehouse model help?

The solution may include indexes, better filters, pre-aggregated tables, or improved data modeling.

## 5. SQL Examples

Create an index on a foreign key:

```sql
CREATE INDEX idx_sales_customer_id
ON sales (customer_id);
```

Create an index on a date used for filtering:

```sql
CREATE INDEX idx_sales_sale_date
ON sales (sale_date);
```

Create a composite index:

```sql
CREATE INDEX idx_sales_product_date
ON sales (product_id, sale_date);
```

Inspect a query plan:

```sql
EXPLAIN
SELECT
    sale_date,
    SUM(quantity * unit_price) AS revenue
FROM sales
WHERE sale_date >= DATE '2026-01-01'
GROUP BY sale_date;
```

Inspect a query plan with runtime details:

```sql
EXPLAIN ANALYZE
SELECT
    p.category,
    SUM(s.quantity * s.unit_price) AS revenue
FROM sales AS s
JOIN products AS p
    ON s.product_id = p.product_id
GROUP BY p.category;
```

Filter before aggregating:

```sql
SELECT
    sale_date,
    SUM(quantity * unit_price) AS revenue
FROM sales
WHERE sale_date >= CURRENT_DATE - INTERVAL '30 days'
GROUP BY sale_date;
```

## 6. Production Considerations

- Do not add indexes blindly. Indexes improve reads but add cost to writes.
- Index columns used often in joins and filters.
- Low-cardinality columns may not benefit much from simple indexes.
- Use `EXPLAIN` and `EXPLAIN ANALYZE` to inspect performance.
- Keep table statistics updated.
- Prefer summary tables for repeated heavy dashboard queries.
- Avoid functions on indexed columns in filters when possible.
- Optimize the data model before over-tuning individual queries.

## 7. Common Mistakes

- Adding indexes without measuring performance.
- Indexing every column.
- Assuming indexes always make queries faster.
- Filtering with expressions that prevent efficient index use.
- Optimizing a query before checking whether the result is correct.
- Forgetting that indexes take storage space.
- Running expensive queries directly on production systems without care.
- Ignoring row counts and join duplication.

## 8. Practice Tasks

Using the practice database:

1. Run `EXPLAIN` on a daily sales query.
2. Create an index on `sales.sale_date`.
3. Run `EXPLAIN` again and compare the plan.
4. Create indexes on `sales.customer_id` and `sales.product_id`.
5. Test a customer purchase summary query.
6. Write down whether each index is useful for the small dataset and why results may differ on large data.

## 9. Related Project

- `02-sql-and-databases/postgresql-practice/`: Add indexes and inspect query plans.
- `06-data-warehousing/`: Summary models often solve performance problems better than raw-table queries.
- `14-production-engineering/`: Query performance affects reliability, cost, and operations.
