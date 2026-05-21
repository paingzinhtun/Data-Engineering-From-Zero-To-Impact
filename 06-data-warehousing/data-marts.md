# Data Marts

## 1. What It Is

A data mart is a business-ready dataset designed for a specific team, process, or reporting purpose.

Data marts are usually built from warehouse facts and dimensions. They make data easier to consume by presenting trusted metrics at a useful grain.

## 2. Why It Matters

Raw and staging tables are not ideal for business users. Data marts provide clean, documented, and purpose-built tables for dashboards and analysis.

Data marts help:

- Reduce repeated query logic.
- Improve dashboard performance.
- Standardize metrics.
- Make data easier for analysts to use.
- Separate business-facing outputs from technical layers.
- Support team-specific needs without duplicating raw logic.

## 3. When to Use It

Use data marts when:

- A dashboard repeatedly needs the same metrics.
- Business users need simple tables.
- Complex joins should be hidden behind a stable model.
- A team needs a curated dataset for a process.
- Metrics need consistency across reports.

Avoid creating a mart for every one-off question. Marts should serve recurring business needs.

## 4. Real Business Example

A retail stationery shop creates three marts:

- `mart_daily_sales`: daily revenue, gross profit, units sold, transaction count
- `mart_product_performance`: product revenue, units sold, margin, ranking
- `mart_inventory_reorder`: current stock, reorder status, reorder quantity

The owner uses daily sales. The purchasing team uses inventory reorder. The category manager uses product performance.

## 5. Technical Example

Daily sales mart:

```sql
CREATE TABLE mart_daily_sales AS
SELECT
    d.full_date AS sales_date,
    SUM(f.quantity_sold) AS units_sold,
    SUM(f.revenue) AS revenue,
    SUM(f.gross_profit) AS gross_profit,
    COUNT(DISTINCT f.sales_transaction_id) AS transaction_count
FROM fact_sales AS f
JOIN dim_date AS d
    ON f.date_key = d.date_key
GROUP BY d.full_date;
```

Product performance mart:

```sql
CREATE TABLE mart_product_performance AS
SELECT
    p.product_id,
    p.product_name,
    p.product_category,
    SUM(f.quantity_sold) AS units_sold,
    SUM(f.revenue) AS revenue,
    SUM(f.gross_profit) AS gross_profit
FROM fact_sales AS f
JOIN dim_product AS p
    ON f.product_key = p.product_key
GROUP BY p.product_id, p.product_name, p.product_category;
```

## 6. Production Considerations

- Define mart grain clearly.
- Document metric formulas.
- Refresh marts on a reliable schedule.
- Test row uniqueness and expected relationships.
- Monitor freshness.
- Use consistent naming conventions.
- Avoid duplicating business logic across many marts.
- Assign owners for business-critical marts.

## 7. Common Mistakes

- Building marts directly from raw data without staging.
- Creating marts with unclear grain.
- Repeating the same metric with different logic.
- Not documenting who uses the mart.
- Treating temporary analysis tables as production marts.
- Not validating mart totals against facts.
- Allowing marts to become stale.

## 8. Practice Task

Design three data marts for a stationery shop:

1. Daily sales mart.
2. Product performance mart.
3. Inventory reorder mart.

For each mart, define:

- Grain
- Source facts and dimensions
- Metrics
- Intended users
- Refresh schedule
- Data quality checks

## 9. Related Project

- `06-data-warehousing/warehouse-project/`: Includes expected data marts.
- `04-data-modeling/metric-definitions.md`: Marts should use documented metric definitions.
- `12-data-quality-testing-observability/`: Business-facing marts need quality checks and freshness monitoring.
