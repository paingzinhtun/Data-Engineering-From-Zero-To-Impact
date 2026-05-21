# AI Business Data Assistant

## 1. What It Is

AI Business Data Assistant is a project for building a governed assistant that answers business questions using trusted retail data.

The assistant should use structured data from a business database through a semantic layer and data API. It should provide business answers grounded in approved metrics and datasets.

## 2. Why It Matters

Business users often need answers faster than a data team can manually create every report.

An AI assistant can help answer operational questions, but only if the data layer is reliable, secure, and well-defined.

This project shows that AI value depends on Data Engineering foundations:

- Clean warehouse tables.
- Data quality checks.
- Metric definitions.
- Access control.
- Semantic layer.
- Query governance.
- Monitoring.

## 3. When to Use It

Use this project when:

- The business has trusted sales, inventory, product, and customer data.
- Metrics are defined.
- AI should answer structured business questions.
- Users need natural-language access to analytics.
- Access can be controlled and logged.

Do not build this assistant directly on raw tables, messy spreadsheets, or unrestricted production databases.

## 4. Real Business Example

A retail stationery manager asks:

- Which products should I reorder?
- Why did sales drop?
- Which products have high stock but low sales?

The assistant should answer using approved datasets such as:

- `mart_daily_sales`
- `mart_product_performance`
- `mart_inventory_reorder`
- `mart_customer_purchase_summary`

It should explain the metric and source, not invent unsupported reasons.

## 5. Technical Example

Architecture:

```text
business database
  -> semantic layer
  -> data API
  -> AI assistant
  -> business answers
```

Example semantic layer concepts:

```text
metric: revenue
definition: SUM(quantity_sold * unit_price)
source: fact_sales or mart_daily_sales

metric: low_stock_flag
definition: quantity_on_hand < reorder_level
source: mart_inventory_reorder

metric: slow_moving_product
definition: high stock and low sales over the last 30 days
source: mart_product_performance + mart_inventory_reorder
```

Example API endpoints:

```text
GET /metrics/daily-sales?start_date=2026-01-01&end_date=2026-01-31
GET /inventory/reorder-recommendations
GET /products/slow-moving
GET /products/category-performance
```

Example assistant behavior:

```text
question: Which products should I reorder?
route: inventory_reorder endpoint
answer: products where quantity_on_hand is below reorder_level
source: mart_inventory_reorder
```

## 6. Production Considerations

- Use read-only access.
- Expose approved APIs instead of raw database access.
- Define metrics in a semantic layer.
- Apply user-level access control.
- Log questions, API calls, and generated answers.
- Include source dataset references.
- Monitor stale data.
- Prevent destructive actions.
- Add evaluation questions and expected answers.
- Document known limitations.

## 7. Common Mistakes

- Letting the assistant query raw tables directly.
- Giving unrestricted database credentials.
- Not defining business metrics.
- Exposing customer personal data.
- Not checking data freshness.
- Letting the assistant answer without source references.
- Using vector search for structured metric questions that need SQL.
- Not evaluating answer quality.

## 8. Practice Task

Build the project in phases:

1. Define business questions.
2. Identify approved marts.
3. Define semantic metrics.
4. Create read-only SQL queries or API endpoints.
5. Add access controls.
6. Add freshness checks.
7. Connect the AI assistant to the data API.
8. Add source references to answers.
9. Create evaluation questions and expected answers.
10. Document limitations and safe-use rules.

## 9. Related Project

- `04-data-modeling/metric-definitions.md`: Metrics must be defined before AI answers them.
- `06-data-warehousing/warehouse-project/`: Provides the business-ready marts.
- `12-data-quality-testing-observability/`: Assistant reliability depends on quality and freshness.
- `15-ai-ready-data-engineering/ai-agent-data-access.md`: Safe data access design for AI agents.
