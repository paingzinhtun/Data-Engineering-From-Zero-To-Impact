# Architecture

```text
product CSV
  -> local validation
  -> PostgreSQL raw_products table
  -> SQL validation queries
```

## Components

- Source: CSV product catalog
- Processing: Python or SQL copy command
- Storage: PostgreSQL
- Validation: SQL row count, null checks, duplicate checks

## Target Table

`raw_products`

Expected columns:

- `product_id`
- `product_name`
- `category`
- `unit_cost`
- `unit_price`
