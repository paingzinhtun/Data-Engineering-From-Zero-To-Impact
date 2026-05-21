# BigQuery

## 1. What It Is

BigQuery is Google Cloud's managed data warehouse. It is designed for analytics over large datasets using SQL and serverless infrastructure.

In practice, teams use BigQuery to store raw, staged, modeled, and mart tables for reporting, analytics, machine learning preparation, and data products.

## 2. Why It Matters

BigQuery is widely used in modern cloud data platforms because it reduces infrastructure management. Data Engineers can focus more on data modeling, SQL, pipelines, quality, governance, and cost control.

It matters for learners because it demonstrates cloud warehouse concepts such as:

- Datasets and tables
- Columnar storage
- SQL analytics
- Partitioning and clustering
- Access control
- Query cost awareness
- Integration with cloud storage and BI tools

## 3. When to Use It

Use BigQuery when:

- Your organization uses Google Cloud.
- You need a managed analytics warehouse.
- Data workloads are SQL-heavy.
- Teams want serverless warehouse operations.
- Data needs to integrate with Google Cloud services.
- Query cost can be managed through good design.

For local learning, PostgreSQL is often enough. BigQuery becomes more relevant when practicing cloud warehouse workflows.

## 4. Real Business Example

A retail ecommerce business stores order exports in cloud storage and loads them into BigQuery.

The warehouse contains:

- Raw ecommerce orders
- Raw POS sales
- Staged product and customer tables
- Sales fact table
- Inventory snapshot fact table
- Daily sales and product performance marts

Business users connect BI dashboards to the marts.

## 5. Technical Example

Layer naming example:

```text
retail_raw.raw_orders
retail_staging.stg_orders
retail_marts.mart_daily_sales
```

Partitioned table concept:

```sql
CREATE TABLE retail_marts.fact_sales (
    sale_date DATE,
    product_id STRING,
    customer_id STRING,
    quantity_sold INT64,
    revenue NUMERIC
)
PARTITION BY sale_date;
```

Query with partition filter:

```sql
SELECT
    sale_date,
    SUM(revenue) AS revenue
FROM retail_marts.fact_sales
WHERE sale_date >= DATE '2026-01-01'
GROUP BY sale_date;
```

## 6. Production Considerations

- Use partition filters on large date-based tables.
- Cluster large tables based on common filters and joins.
- Control access at dataset and table levels.
- Monitor query cost and scanned bytes.
- Separate raw, staging, and mart datasets.
- Avoid dashboards querying raw tables directly.
- Use scheduled queries or orchestration for transformations.
- Document table owners, grain, and freshness expectations.

## 7. Common Mistakes

- Querying large tables without date filters.
- Building many dashboards directly on raw tables.
- Not monitoring cost.
- Giving broad access to sensitive datasets.
- Creating unclear dataset naming conventions.
- Using BigQuery before understanding SQL and modeling fundamentals.
- Treating serverless as costless.

## 8. Practice Task

Design a BigQuery layout for a retail analytics warehouse.

Define:

1. Datasets for raw, staging, dimensions, facts, and marts.
2. Partition strategy for `fact_sales`.
3. Clustering candidates.
4. Access rules for raw and mart layers.
5. Three queries that should use partition filters.
6. Cost risks and controls.

## 9. Related Project

- `06-data-warehousing/warehouse-project/`: Can be implemented in BigQuery.
- `13-cloud-data-engineering/`: BigQuery is part of cloud data engineering workflows.
- `09-dbt-and-analytics-engineering/`: dbt is commonly used with cloud warehouses including BigQuery.
