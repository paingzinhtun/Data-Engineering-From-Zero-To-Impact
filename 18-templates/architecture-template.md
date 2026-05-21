# Architecture Template

Use this template to document the design of a data engineering project.

## 1. Architecture Summary

Explain the system in a short paragraph.

Example:

> This architecture ingests daily retail sales files, loads raw data into PostgreSQL, transforms it into fact and mart tables, runs quality checks, and serves dashboard-ready metrics.

## 2. Source Layer

Describe where data comes from.

Include:

- Source system names
- Source owners
- File formats or API response formats
- Refresh frequency
- Expected arrival time
- Known source limitations

Example sources:

- POS CSV export
- Ecommerce orders API
- Inventory spreadsheet
- Customer CRM export

## 3. Ingestion Layer

Describe how data enters the platform.

Include:

- Extraction method
- Batch or streaming pattern
- Authentication
- Pagination or file discovery
- Retry behavior
- Raw data preservation

Example:

```text
Python extractor reads daily CSV files from data/sample and loads them into raw PostgreSQL tables.
```

## 4. Storage Layer

Describe where data is stored.

Include:

- Raw storage
- Cleaned storage
- Analytics storage
- File formats
- Database schemas
- Partitioning or indexing strategy

Example:

- `raw`: source-aligned tables
- `staging`: cleaned tables
- `mart`: business-ready reporting tables

## 5. Transformation Layer

Describe how raw data becomes useful data.

Include:

- Cleaning rules
- Joins
- Business metric calculations
- Dimensional modeling
- Incremental or full-refresh logic
- SQL or Python transformation location

Example transformations:

- Standardize dates and IDs
- Join sales to products
- Calculate gross sales and gross profit
- Aggregate daily sales

## 6. Serving Layer

Describe how users consume the data.

Include:

- Dashboards
- SQL marts
- API endpoints
- Reports
- AI assistant access
- Export files

Example outputs:

- `mart_daily_sales`
- `mart_product_performance`
- `mart_inventory_reorder`

## 7. Monitoring Layer

Describe how the system is observed.

Include:

- Pipeline logs
- Run status
- Row counts
- Freshness
- Error alerts
- Dashboard refresh status
- Cost monitoring where relevant

## 8. Data Quality Layer

Describe where quality checks happen.

Include:

- Source checks
- Schema checks
- Null checks
- Duplicate checks
- Relationship checks
- Metric reconciliation
- Freshness checks
- Failure handling

Example:

> Critical quality failures stop the pipeline before marts are published.

## 9. Security Layer

Describe how data and credentials are protected.

Include:

- Environment variables
- Secret management
- Database roles
- Access control
- PII masking
- Encryption
- Audit logging

## 10. Architecture Diagram

Add a text or Mermaid diagram.

```text
Source files
  -> Python ingestion
  -> raw tables
  -> staging transformations
  -> fact and dimension tables
  -> business marts
  -> dashboard
```

## 11. Tradeoffs

Explain why this design was chosen.

Include:

- Why this is appropriate for the project size
- What was intentionally kept simple
- What would need to change for production scale
- What would be overkill right now
