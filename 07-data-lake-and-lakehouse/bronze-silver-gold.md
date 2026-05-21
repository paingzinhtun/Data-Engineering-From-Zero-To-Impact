# Bronze Silver Gold

## 1. What It Is

Bronze, Silver, and Gold are common names for layered data architecture in lakes and lakehouses.

- **Bronze:** Raw or source-shaped data.
- **Silver:** Cleaned, standardized, validated data.
- **Gold:** Business-ready data for analytics, dashboards, data products, or machine learning.

The names are simple, but the principle is important: data should improve in quality and usability as it moves through layers.

## 2. Why It Matters

Layering helps teams avoid mixing raw, cleaned, and business-ready data. It creates a clear path from source data to trusted outputs.

This matters because:

- Raw data is useful for replay and audit.
- Cleaned data is useful for reusable transformations.
- Gold data is useful for business decisions.
- Data quality checks can be applied at each layer.
- Ownership and access rules can differ by layer.

## 3. When to Use It

Use Bronze/Silver/Gold when:

- You have multiple source systems.
- Raw data should be preserved.
- Data needs several cleaning and modeling steps.
- Multiple teams use the same lake or lakehouse.
- You need analytics and ML-ready datasets.
- Data quality improves in stages.

It may be overkill for a small one-file project or a simple report.

## 4. Real Business Example

A retail stationery business collects POS sales, ecommerce orders, inventory files, and website logs.

Bronze stores the raw files exactly as received.

Silver standardizes fields such as product IDs, customer IDs, dates, quantities, and prices.

Gold creates business-ready datasets such as daily sales, product performance, inventory reorder recommendations, and customer purchase summaries.

## 5. Technical Example

Architecture:

```text
raw CSV/API/log data
  -> bronze raw layer
  -> silver cleaned layer
  -> gold business-ready layer
  -> warehouse/dashboard/ML
```

Example folder layout:

```text
lakehouse/
  bronze/
    pos_sales/ingest_date=2026-01-15/
    ecommerce_orders/ingest_date=2026-01-15/
  silver/
    sales/
    products/
    customers/
    inventory_snapshots/
  gold/
    daily_sales/
    product_performance/
    inventory_reorder/
```

Example transformation logic:

```sql
CREATE TABLE silver.sales AS
SELECT
    CAST(sale_id AS TEXT) AS sale_id,
    CAST(sale_date AS DATE) AS sale_date,
    product_id,
    customer_id,
    CAST(quantity AS INTEGER) AS quantity,
    CAST(unit_price AS NUMERIC(12, 2)) AS unit_price
FROM bronze.pos_sales
WHERE sale_id IS NOT NULL;
```

## 6. Production Considerations

- Define what each layer means for your organization.
- Keep Bronze immutable where possible.
- Apply schema and type checks in Silver.
- Apply business definitions in Gold.
- Document lineage from Bronze to Gold.
- Monitor freshness at each layer.
- Restrict sensitive raw data when needed.
- Avoid bypassing layers for important reporting.

## 7. Common Mistakes

- Treating Bronze/Silver/Gold as folder names only.
- Rewriting raw data without preserving the original.
- Putting business logic in Bronze.
- Publishing Silver tables as if they are business-ready.
- Creating Gold tables without metric definitions.
- Not documenting quality expectations by layer.
- Building layers for a tiny project where they add no value.

## 8. Practice Task

Take a retail sales dataset and design Bronze, Silver, and Gold layers.

Define:

1. What Bronze stores.
2. What Silver cleans and standardizes.
3. What Gold publishes.
4. Validation checks at each layer.
5. Who should access each layer.
6. Which layer supports dashboards.
7. Which layer supports machine learning.

## 9. Related Project

- `07-data-lake-and-lakehouse/lakehouse-project/`: Uses Bronze/Silver/Gold architecture.
- `05-etl-elt-pipelines/pipeline-design-patterns.md`: Layered pipeline patterns support this architecture.
- `06-data-warehousing/data-marts.md`: Gold tables often resemble warehouse data marts.
