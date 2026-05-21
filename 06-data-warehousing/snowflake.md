# Snowflake

## 1. What It Is

Snowflake is a managed cloud data platform used for data warehousing, analytics, data sharing, and data applications.

It separates storage and compute, allowing teams to scale processing resources independently from stored data.

## 2. Why It Matters

Snowflake is widely used in professional data teams. It introduces important warehouse concepts such as virtual warehouses, databases, schemas, roles, stages, and cost-aware compute management.

For Data Engineers, Snowflake is useful for:

- Centralized analytics data.
- ELT transformations.
- Data sharing.
- Role-based access control.
- Scalable SQL workloads.
- BI and analytics marts.

## 3. When to Use It

Use Snowflake when:

- Your organization chooses Snowflake as its cloud data platform.
- You need scalable SQL analytics.
- Multiple teams need controlled access to shared data.
- You want separated compute resources for different workloads.
- You need strong warehouse governance patterns.

For learning fundamentals, use Snowflake after understanding SQL, modeling, and warehouse layers.

## 4. Real Business Example

A regional stationery retailer has online sales, store POS data, supplier files, and customer loyalty data.

Snowflake could organize this as:

- `RAW` schema for loaded source data
- `STAGING` schema for cleaned source models
- `CORE` schema for facts and dimensions
- `MARTS` schema for business-facing tables

Different virtual warehouses can support loading jobs, transformation jobs, and BI dashboards.

## 5. Technical Example

Conceptual schema layout:

```sql
CREATE DATABASE RETAIL_ANALYTICS;

CREATE SCHEMA RETAIL_ANALYTICS.RAW;
CREATE SCHEMA RETAIL_ANALYTICS.STAGING;
CREATE SCHEMA RETAIL_ANALYTICS.CORE;
CREATE SCHEMA RETAIL_ANALYTICS.MARTS;
```

Example mart query:

```sql
SELECT
    sales_date,
    revenue,
    gross_profit
FROM RETAIL_ANALYTICS.MARTS.MART_DAILY_SALES
WHERE sales_date >= DATE '2026-01-01'
ORDER BY sales_date;
```

Conceptual workload separation:

```text
LOAD_WH        ingestion jobs
TRANSFORM_WH   warehouse transformations
BI_WH          dashboard queries
```

## 6. Production Considerations

- Use clear database and schema naming.
- Separate raw, staging, core, and mart layers.
- Manage roles and grants carefully.
- Size compute resources according to workload.
- Monitor warehouse runtime and cost.
- Suspend compute when not needed.
- Document ownership and freshness expectations.
- Use automated transformations and tests for critical models.

## 7. Common Mistakes

- Leaving compute running unnecessarily.
- Giving broad privileges instead of role-based access.
- Mixing raw and business-facing tables in one schema.
- Not separating workloads.
- Building dashboards on raw tables.
- Ignoring cost monitoring.
- Treating Snowflake-specific features as a replacement for data modeling.

## 8. Practice Task

Design a Snowflake structure for a retail warehouse.

Include:

1. Database name.
2. Schemas for raw, staging, core, and marts.
3. Virtual warehouse names by workload.
4. Role-based access plan.
5. Three mart tables.
6. Cost controls.
7. Monitoring needs.

## 9. Related Project

- `06-data-warehousing/warehouse-project/`: Can be implemented in Snowflake.
- `04-data-modeling/`: Facts, dimensions, and marts still matter on Snowflake.
- `14-production-engineering/`: Warehouse cost, access, and operations are production concerns.
