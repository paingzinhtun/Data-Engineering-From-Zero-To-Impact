# Project 01: API To PostgreSQL ETL

## Business Problem

A small retail business uses an external sales or ecommerce platform to manage orders. The platform has useful operational data, but the data is only available through an API. Managers currently export reports manually, which creates delays, inconsistent files, and reporting errors.

The business needs a repeatable ETL pipeline that extracts API data, validates it, and loads it into PostgreSQL for analysis.

## Goal

Build an API-to-PostgreSQL ETL pipeline that extracts paginated order data, stores raw API responses, transforms them into relational tables, and makes the data ready for sales reporting.

The project should teach learners how to work with real API concerns such as authentication, pagination, rate limits, retries, schema drift, and incremental loading.

## Architecture

```text
External API
  -> Python extractor
  -> raw JSON archive
  -> PostgreSQL raw tables
  -> PostgreSQL staging tables
  -> analytics tables
  -> SQL reports or dashboard
```

Recommended skeleton:

```text
01-api-to-postgres-etl/
  README.md
  .env.example
  requirements.txt
  src/
    extract.py
    transform.py
    load.py
    main.py
  sql/
    create_tables.sql
    transformations.sql
    quality_checks.sql
  data/
    raw/
  tests/
```

## Tools

- Python for extraction, transformation, and loading
- `requests` for API calls
- `pandas` for lightweight transformation
- SQLAlchemy for PostgreSQL loading
- PostgreSQL for storage and analytics
- `python-dotenv` for local configuration
- pytest for transformation tests

## Data Sources

Use a public test API, a mock API, or a small local JSON fixture that behaves like an API response.

Suggested source entities:

- Orders
- Order line items
- Customers
- Products
- Payment status
- Fulfillment status

Important API fields:

- `order_id`
- `order_created_at`
- `customer_id`
- `product_id`
- `quantity`
- `unit_price`
- `discount_amount`
- `tax_amount`
- `payment_status`
- `fulfillment_status`

## Pipeline Steps

1. Load API configuration from environment variables.
2. Request data from the API with a timeout.
3. Handle pagination until all records are extracted.
4. Respect rate limits and retry temporary failures.
5. Save raw API responses for traceability.
6. Normalize nested JSON into tabular records.
7. Validate required fields and data types.
8. Load raw and cleaned tables into PostgreSQL.
9. Run SQL transformations for reporting tables.
10. Run quality checks and log pipeline results.

## Data Model

Suggested PostgreSQL schemas:

- `raw`: raw API payloads and normalized raw records
- `staging`: cleaned source-aligned tables
- `analytics`: business-ready tables

Suggested tables:

- `raw.api_orders`
- `raw.api_order_items`
- `staging.stg_orders`
- `staging.stg_order_items`
- `analytics.fact_orders`
- `analytics.mart_daily_sales`
- `analytics.mart_fulfillment_status`

Suggested grain:

- `fact_orders`: one row per order line item
- `mart_daily_sales`: one row per sales date
- `mart_fulfillment_status`: one row per date and fulfillment status

## Data Quality Checks

Minimum checks:

- `order_id` and `product_id` are not null.
- Order line item IDs are unique.
- Quantity is greater than zero.
- Revenue fields are not negative.
- `payment_status` is in an accepted list.
- API extraction date is present.
- Row counts are within expected ranges.
- Incremental loads do not duplicate existing orders.

Useful business checks:

- Paid orders should have positive revenue.
- Cancelled orders should not be counted as completed sales.
- Fulfilled orders should have a fulfillment timestamp.

## Expected Output

The finished project should produce:

- A reproducible API extraction job
- Raw API response files for debugging
- PostgreSQL raw and analytics tables
- A daily sales mart
- A fulfillment status mart
- SQL quality check results
- A short project write-up explaining assumptions and limitations

Example business questions answered:

- What was daily revenue?
- Which products sold the most?
- How many orders are still unfulfilled?
- Which customers have the highest order value?
- Did the latest API run miss or duplicate records?

## Production Improvements

Future improvements:

- Add Airflow scheduling.
- Add incremental extraction using `updated_at` watermarks.
- Store raw JSON in object storage.
- Add structured logging and alerting.
- Add dead-letter handling for malformed records.
- Add API contract tests.
- Add dashboard views for sales and fulfillment.
- Add secrets management instead of local `.env` files.

## Skills Learned

- API extraction patterns
- Pagination and rate limit handling
- JSON normalization
- PostgreSQL loading
- Incremental ETL thinking
- Data quality validation
- Production logging and error handling
- Building a portfolio-ready data pipeline specification

## Related Concepts

- [API Basics](../../../01-fundamentals/api-basics.md)
- [Working With APIs](../../../03-python-for-data-engineering/working-with-apis.md)
- [Incremental Loading](../../../05-etl-elt-pipelines/incremental-loading.md)
- [Data Quality Concepts](../../../12-data-quality-testing-observability/data-quality-concepts.md)
