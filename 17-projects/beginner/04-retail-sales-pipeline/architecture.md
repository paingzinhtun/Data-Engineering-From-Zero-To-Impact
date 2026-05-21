# Architecture

```text
CSV files
  -> Python extract
  -> Python transform and validation
  -> PostgreSQL raw tables
  -> SQL transformations
  -> analytics tables
  -> SQL quality checks
```

## Source Files

- `sales.csv`
- `products.csv`
- `customers.csv`
- `inventory.csv`

## PostgreSQL Layers

- `raw`: cleaned source-shaped tables loaded by Python
- `analytics`: transformed tables created by SQL

## Analytics Outputs

- `analytics.fact_sales`
- `analytics.mart_daily_sales`
- `analytics.mart_product_performance`
- `analytics.mart_inventory_reorder`
