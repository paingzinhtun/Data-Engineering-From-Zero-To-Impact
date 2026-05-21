# Metric Definitions

## 1. What It Is

Metric definitions describe exactly how business metrics are calculated and interpreted.

A metric is not just a column or formula. It is a shared business definition.

Examples:

- Revenue
- Gross profit
- Gross margin
- Units sold
- Average order value
- Stockout rate
- Repeat customer rate

## 2. Why It Matters

If teams define metrics differently, reports will disagree and trust will fall.

Metric definitions help Data Engineers:

- Build consistent reporting tables.
- Reduce dashboard disputes.
- Validate calculations.
- Align business and technical teams.
- Support reliable decision-making.
- Document assumptions such as refunds, discounts, taxes, and cancelled orders.

Metrics are part of the data contract between the data team and the business.

## 3. Core Concepts

- **Metric name:** Clear business-friendly name.
- **Business definition:** Plain-English meaning.
- **Formula:** Exact calculation.
- **Grain:** Level at which the metric is calculated.
- **Filters:** Included and excluded records.
- **Dimensions:** Ways the metric can be grouped.
- **Owner:** Person or team responsible for the definition.
- **Refresh cadence:** How often the metric updates.
- **Known limitations:** Cases where the metric may be incomplete or misleading.

## 4. Real Business Example

A stationery shop asks for monthly revenue.

Different teams may calculate it differently:

- Sales team includes all orders placed.
- Finance team excludes cancelled orders.
- Operations team cares only about shipped orders.
- Marketing team includes discount before tax.

Without a definition, all teams may be correct in their own context but still disagree.

A clear definition might say:

Revenue is the sum of `quantity_sold * unit_price` for completed sales, excluding cancelled transactions, before tax, after line-level discounts.

## 5. Simple Data Model Example

Metric definition table:

```text
metric_name: Gross Profit
business_definition: Profit after subtracting product cost from sales revenue.
formula: SUM(quantity_sold * (unit_price - unit_cost))
grain: Can be calculated by sale line, then aggregated by date, product, category, or customer segment.
filters: Include completed sales only. Exclude cancelled and test transactions.
owner: Finance and Operations
refresh_cadence: Daily
```

SQL example:

```sql
SELECT
    d.full_date,
    SUM(f.quantity_sold * f.unit_price) AS revenue,
    SUM(f.quantity_sold * f.unit_cost) AS cost,
    SUM(f.quantity_sold * (f.unit_price - f.unit_cost)) AS gross_profit
FROM fact_sales AS f
JOIN dim_date AS d
    ON f.date_key = d.date_key
GROUP BY d.full_date;
```

## 6. Production Considerations

- Define metrics before building dashboards.
- Store metric logic in shared models when possible.
- Document filters and exclusions.
- Validate metrics against known business reports.
- Assign ownership for important metrics.
- Version metric definitions when they change.
- Communicate changes to users.
- Avoid defining the same metric differently in multiple places.

## 7. Common Mistakes

- Naming a metric without defining it.
- Ignoring refunds, discounts, taxes, and cancellations.
- Mixing order date, payment date, and shipment date.
- Calculating ratios before aggregation when aggregation should come first.
- Building dashboards directly from raw tables.
- Changing metric logic without documenting it.
- Assuming business users share the same definition.

## 8. Practice Task

Write definitions for these stationery shop metrics:

1. Revenue
2. Gross profit
3. Gross margin percentage
4. Units sold
5. Low-stock product count
6. Average order value

For each metric, define:

- Formula
- Grain
- Filters
- Dimensions
- Owner
- Known limitations

## 9. Related Project

- `04-data-modeling/retail-data-model-example/`: Includes marts that calculate daily sales, product performance, and reorder metrics.
- `09-dbt-and-analytics-engineering/`: Metric definitions become tested and documented analytics models.
- `16-business-use-cases/`: Business use cases should define metrics before implementation.
