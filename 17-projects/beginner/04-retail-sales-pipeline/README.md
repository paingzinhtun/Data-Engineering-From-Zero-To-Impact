# Project 04: Retail Sales Pipeline

## Goal

Build a beginner-friendly but production-like retail sales pipeline for a small stationery shop.

The pipeline reads CSV files, cleans data, calculates sales metrics, loads raw tables into PostgreSQL, runs SQL transformations, and performs quality checks.

## Business Scenario

A stationery shop sells notebooks, pens, folders, and office supplies. Sales, products, customers, and inventory are stored as CSV exports. The business wants a repeatable pipeline that produces trusted analytics tables.

## What This Project Includes

- Sample retail CSV files
- Python ETL code
- PostgreSQL raw tables
- SQL analytics transformations
- SQL quality checks
- Docker Compose for PostgreSQL
- pytest tests
- `.env.example` configuration

## Metrics Calculated

- `gross_sales`
- `net_sales`
- `cost_amount`
- `gross_profit`

## Project Structure

```text
src/
sql/
data/sample/
data/raw/
tests/
```

## Related Sections

- `03-python-for-data-engineering/`
- `05-etl-elt-pipelines/`
- `12-data-quality-testing-observability/`
- `16-business-use-cases/retail/sales-intelligence.md`

## Related Concepts

- [Python Basics For Data Engineering](../../../03-python-for-data-engineering/python-basics-for-de.md)
- [ETL Vs ELT](../../../05-etl-elt-pipelines/etl-vs-elt.md)
- [Data Validation](../../../05-etl-elt-pipelines/data-validation.md)
- [Data Quality Concepts](../../../12-data-quality-testing-observability/data-quality-concepts.md)
