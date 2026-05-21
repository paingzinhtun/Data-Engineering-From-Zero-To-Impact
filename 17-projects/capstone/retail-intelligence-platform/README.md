# Retail Intelligence Platform

## 1. Business Problem

Small and mid-sized retailers often operate with fragmented data. Sales live in POS exports, inventory is tracked in spreadsheets, ecommerce orders come from a platform API, and customer information may sit in a CRM or loyalty system. Managers need to answer practical questions every day, but the data is inconsistent, delayed, and difficult to trust.

Common problems:

- Sales reports do not match between finance, operations, and store managers.
- Product performance is reviewed too late to act.
- Inventory decisions are made without reliable sales velocity.
- Customer behavior is not connected to product or channel performance.
- Promotions are evaluated manually after the opportunity to adjust has passed.

This capstone builds a unified retail intelligence platform that gives decision makers trusted sales, inventory, customer, and product insights.

## 2. Target Users

Primary users:

- Store owner or general manager
- Operations manager
- Inventory or purchasing manager
- Sales manager
- Finance analyst
- Marketing or customer retention analyst

Secondary users:

- Data analyst
- Data engineer
- BI developer
- External consultant supporting the business

## 3. System Goal

Build an end-to-end analytics platform for retail decision-making.

The system should ingest retail data, transform it into trusted models, apply data quality checks, and produce business-ready dashboards and marts.

Core goals:

- Create one trusted source of retail metrics.
- Support sales, product, inventory, customer, and channel analysis.
- Make data quality visible.
- Reduce manual spreadsheet reporting.
- Provide a foundation for forecasting, recommendations, and AI-assisted analysis.

## 4. Architecture

```text
POS CSV exports, ecommerce API, inventory files, customer data
  -> ingestion layer
  -> raw database tables
  -> staging models
  -> dimensional warehouse
  -> business marts
  -> dashboards, reports, and AI-ready APIs
```

Recommended implementation path:

- Phase 1: PostgreSQL warehouse with Python ingestion
- Phase 2: dbt transformations and tests
- Phase 3: Airflow orchestration
- Phase 4: BI dashboard and metric documentation
- Phase 5: AI-ready data API or assistant

The architecture should stay practical. Start with PostgreSQL and local files before moving to cloud services.

## 5. Data Sources

Required sources:

- Sales transactions
- Sales line items
- Product catalog
- Customer list or loyalty records
- Inventory snapshots
- Store or channel information

Optional sources:

- Ecommerce orders
- Promotion calendar
- Supplier files
- Product cost history
- Returns and refunds
- Foot traffic or web analytics

Important fields:

- `sale_id`
- `sale_line_id`
- `sale_date`
- `store_id`
- `channel`
- `customer_id`
- `product_id`
- `quantity`
- `unit_price`
- `discount_amount`
- `unit_cost`
- `quantity_on_hand`
- `reorder_level`

## 6. Data Model

Recommended schemas:

- `raw`: source-aligned data
- `staging`: cleaned and standardized data
- `warehouse`: dimensions and facts
- `mart`: business-ready outputs
- `audit`: pipeline and quality metadata

Core warehouse tables:

- `dim_date`
- `dim_product`
- `dim_customer`
- `dim_store`
- `dim_channel`
- `fact_sales`
- `fact_inventory_snapshot`
- `fact_returns`
- `fact_promotions`

Core marts:

- `mart_daily_sales`
- `mart_product_performance`
- `mart_inventory_reorder`
- `mart_customer_value`
- `mart_channel_performance`
- `mart_promotion_effectiveness`

Grain examples:

- `fact_sales`: one row per sale line item
- `fact_inventory_snapshot`: one row per product per store per snapshot date
- `mart_daily_sales`: one row per date, store, and channel
- `mart_product_performance`: one row per product per reporting period

## 7. Pipelines

Suggested pipelines:

- Sales ingestion pipeline
- Product catalog ingestion pipeline
- Customer ingestion pipeline
- Inventory snapshot pipeline
- Warehouse transformation pipeline
- Data quality pipeline
- Dashboard refresh pipeline

Pipeline stages:

1. Extract source data from CSV, API, or database.
2. Store raw data with load metadata.
3. Validate schema, freshness, duplicates, and required fields.
4. Clean and standardize data in staging.
5. Build facts, dimensions, and marts.
6. Run reconciliation checks.
7. Publish dashboard-ready tables.
8. Log pipeline run status and row counts.

## 8. Data Quality Strategy

Quality checks should exist at multiple layers.

Source checks:

- Required files or API responses exist.
- Source row count is greater than zero.
- Required columns are present.
- Source freshness meets expectations.

Staging checks:

- IDs are standardized.
- Dates parse correctly.
- Numeric fields are valid.
- Duplicate business keys are handled.

Warehouse checks:

- Primary keys are unique.
- Fact records have valid dimension references.
- Sales quantity is greater than zero.
- Net sales equals gross sales minus discounts.
- Gross profit equals net sales minus cost amount.

Mart checks:

- Aggregates reconcile to facts.
- Dashboards are refreshed from current marts.
- Metric definitions match documentation.

## 9. Dashboards or Outputs

Recommended dashboards:

- Executive sales overview
- Product performance dashboard
- Inventory reorder dashboard
- Customer value dashboard
- Channel performance dashboard
- Promotion effectiveness dashboard

Example metrics:

- Gross sales
- Net sales
- Units sold
- Average order value
- Gross profit
- Gross margin percentage
- Stockout risk
- Inventory value
- Repeat customer rate
- Sales by channel

Example business questions:

- Which products generate the most profit?
- Which products need reorder?
- Which categories are growing or declining?
- Which customers buy repeatedly?
- Which channels perform best?
- Which promotions improved margin, not only revenue?

## 10. AI/Automation Features

Useful AI and automation extensions:

- Natural language metric lookup
- Reorder recommendation explanations
- Sales anomaly summaries
- Automated weekly business performance narrative
- AI assistant that answers approved questions from marts
- Product performance alerts
- Promotion impact summaries

AI guardrails:

- Use only approved marts and metric definitions.
- Cite tables or documents used for answers.
- Block access to raw sensitive data.
- Log AI queries and responses.
- Add tests for known business questions.

## 11. Production Requirements

Minimum production requirements:

- Environment-based configuration
- Secrets stored outside code
- Idempotent loads
- Incremental processing
- Retry logic for temporary failures
- Pipeline logging
- Data quality failure handling
- Backfill process
- Documentation for setup and operations
- Clear ownership for data models and dashboards

Operational requirements:

- Alert when critical pipelines fail.
- Record row counts and load timestamps.
- Track dashboard freshness.
- Keep runbooks for common failures.
- Version SQL transformations and pipeline code.

## 12. Security and Governance

Security requirements:

- Restrict raw data access.
- Mask customer PII in marts where not needed.
- Use least-privilege database roles.
- Separate development and production environments.
- Avoid hardcoded credentials.
- Audit access to sensitive tables.

Governance requirements:

- Document metric definitions.
- Assign table owners.
- Maintain a data dictionary.
- Track lineage from source to dashboard.
- Classify sensitive fields.
- Review schema changes before production release.

## 13. Cost and Scalability

Start low-cost:

- Local PostgreSQL
- CSV sample data
- Python scripts
- SQL transformations

Scale when justified:

- Move files to object storage.
- Add managed warehouse.
- Add orchestration.
- Add dbt and CI/CD.
- Add cloud monitoring.

Cost controls:

- Build only useful marts.
- Avoid unnecessary full refreshes.
- Use incremental loads.
- Archive old raw files.
- Monitor dashboard query patterns.

Scalability considerations:

- Partition large fact tables by date.
- Index common join and filter columns.
- Separate raw and mart workloads.
- Use columnar formats or cloud warehouse when data grows.

## 14. Skills Demonstrated

This capstone demonstrates:

- Business problem framing
- Source data analysis
- Data modeling
- SQL transformations
- Python ingestion
- Data quality design
- Metric definition
- Warehouse architecture
- Dashboard planning
- Production engineering
- Security and governance thinking
- Portfolio communication

## 15. Portfolio Presentation Guide

A strong portfolio presentation should include:

- A one-page business case
- Architecture diagram
- Source-to-mart data flow
- Data model diagram
- Screenshots or sample dashboard outputs
- Data quality strategy
- Key SQL or pipeline code snippets
- Clear tradeoffs and assumptions
- Business impact explanation

Suggested project story:

"I built a retail intelligence platform for a small stationery retailer that consolidates sales, product, customer, and inventory data into trusted analytics marts. The platform reduces manual reporting, improves reorder decisions, and provides a foundation for AI-assisted business analysis."

## 16. Future Improvements

Possible improvements:

- Add demand forecasting.
- Add customer segmentation.
- Add supplier performance analytics.
- Add promotion uplift modeling.
- Add real-time sales events.
- Add cloud warehouse deployment.
- Add semantic layer metrics.
- Add AI assistant with governed data access.

## Related Concepts

- [Retail Sales Intelligence Use Case](../../../16-business-use-cases/retail/sales-intelligence.md)
- [Data Warehousing](../../../06-data-warehousing/warehouse-concepts.md)
- [Data Quality Concepts](../../../12-data-quality-testing-observability/data-quality-concepts.md)
- [Portfolio Guide](../../../19-interview-and-career/portfolio-guide.md)
