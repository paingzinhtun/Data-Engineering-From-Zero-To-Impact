# Redshift

## 1. What It Is

Amazon Redshift is AWS's cloud data warehouse service. It is used for SQL analytics, reporting, and large-scale data warehousing on AWS.

Redshift is commonly used with data stored in Amazon S3, AWS Glue, orchestration tools, and BI dashboards.

## 2. Why It Matters

Redshift represents a common AWS warehouse architecture. Data Engineers working in AWS environments may use it to build analytics warehouses, load data from S3, create dimensional models, and support business dashboards.

It matters because learners should understand how warehouse design principles apply across platforms, not just one vendor.

## 3. When to Use It

Use Redshift when:

- Your organization is on AWS.
- You need a managed warehouse for SQL analytics.
- Data is already stored in S3.
- BI tools need access to modeled tables.
- You need warehouse integration with other AWS services.

Use simpler local tools while learning basics. Move to Redshift when practicing AWS-style warehouse workflows.

## 4. Real Business Example

A stationery retailer stores daily sales CSV files in S3. A pipeline loads those files into Redshift raw tables.

SQL transformations create:

- Staging sales and product tables
- Product and customer dimensions
- Sales and inventory facts
- Daily sales and inventory reorder marts

BI dashboards connect to the marts for business reporting.

## 5. Technical Example

Conceptual schema layout:

```sql
CREATE SCHEMA raw;
CREATE SCHEMA staging;
CREATE SCHEMA core;
CREATE SCHEMA marts;
```

Example copy pattern from S3:

```sql
COPY raw.sales
FROM 's3://example-retail-bucket/sales/'
IAM_ROLE 'arn:aws:iam::123456789012:role/RedshiftLoadRole'
CSV
IGNOREHEADER 1;
```

Example mart query:

```sql
SELECT
    sales_date,
    revenue,
    gross_profit
FROM marts.mart_daily_sales
WHERE sales_date >= DATE '2026-01-01'
ORDER BY sales_date;
```

## 6. Production Considerations

- Use appropriate load patterns from S3.
- Separate raw, staging, core, and marts schemas.
- Manage IAM roles carefully.
- Choose distribution and sort strategies based on workload.
- Monitor query performance and warehouse cost.
- Vacuum and analyze where appropriate for the Redshift setup.
- Avoid giving BI users access to raw sensitive tables.
- Document table grain and refresh schedules.

## 7. Common Mistakes

- Loading directly into final reporting tables.
- Not managing permissions between S3 and Redshift carefully.
- Ignoring distribution and sort strategy on large tables.
- Running BI dashboards on raw tables.
- Not monitoring load failures.
- Forgetting that AWS service integration adds operational responsibility.
- Overusing platform-specific tuning before fixing data model issues.

## 8. Practice Task

Design a Redshift warehouse for retail analytics.

Define:

1. S3 raw file layout.
2. Redshift schemas.
3. Raw tables.
4. Staging tables.
5. Fact and dimension tables.
6. Mart tables.
7. IAM and access considerations.
8. Performance considerations for large sales data.

## 9. Related Project

- `06-data-warehousing/warehouse-project/`: Can be implemented in Redshift.
- `13-cloud-data-engineering/`: Redshift fits into AWS data engineering workflows.
- `05-etl-elt-pipelines/`: Loading from S3 to Redshift is an ELT pipeline pattern.
