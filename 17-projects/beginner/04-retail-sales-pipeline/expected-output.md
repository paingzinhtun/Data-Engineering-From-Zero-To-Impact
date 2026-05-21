# Expected Output

After running the pipeline, PostgreSQL should contain:

## Raw Tables

- `raw.sales`
- `raw.products`
- `raw.customers`
- `raw.inventory`

## Analytics Tables

- `analytics.dim_product`
- `analytics.dim_customer`
- `analytics.fact_sales`
- `analytics.mart_daily_sales`
- `analytics.mart_product_performance`
- `analytics.mart_inventory_reorder`

## Expected Business Results

You should be able to answer:

- What was daily revenue?
- Which products generated the most gross profit?
- Which categories produced the most sales?
- Which products are below reorder level?
- Which customers purchased most?

## Success Criteria

- Pipeline runs without hardcoded credentials.
- Sample CSV files are read successfully.
- Raw tables are loaded into PostgreSQL.
- Analytics tables are created.
- Quality checks run.
- Tests pass.

## Validation Queries To Try

```sql
SELECT *
FROM analytics.mart_daily_sales
ORDER BY sale_date;

SELECT *
FROM analytics.mart_product_performance
ORDER BY gross_profit DESC;

SELECT *
FROM analytics.mart_inventory_reorder
WHERE inventory_status <> 'healthy';
```
