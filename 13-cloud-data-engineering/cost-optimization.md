# Cost Optimization

## 1. What It Is

Cost optimization is the practice of designing and operating cloud systems so they deliver business value without unnecessary spending.

Cloud services are flexible, but flexibility can create surprise bills if compute, storage, queries, and data transfer are not managed.

## 2. Why It Matters

Data Engineering workloads can become expensive because they process large files, run scheduled jobs, query warehouses, store historical data, and move data between systems.

Cost optimization helps teams:

- Avoid waste.
- Keep projects sustainable.
- Choose appropriate services.
- Reduce unnecessary compute.
- Manage warehouse query cost.
- Control storage growth.
- Explain tradeoffs to the business.

## 3. When to Use It

Use cost optimization from the beginning of cloud work.

It is especially important when:

- Running scheduled jobs.
- Processing large datasets.
- Querying cloud warehouses.
- Storing raw history.
- Running Spark clusters.
- Using serverless services at scale.
- Supporting dashboards with frequent refreshes.

## 4. Real Business Example

A retail dashboard refreshes every five minutes, scanning years of sales data each time.

The business only needs hourly updates and the dashboard usually shows the last 30 days.

Cost optimization might include:

- Creating a daily sales mart.
- Partitioning by date.
- Filtering dashboard queries.
- Reducing refresh frequency.
- Archiving old raw files.
- Monitoring query spend.

## 5. Technical Example

Cost drivers:

```text
storage: amount of data retained
compute: runtime and size of jobs
warehouse queries: bytes scanned or compute time
network transfer: data moved between regions or services
logging: high-volume logs retained too long
```

Simple cost-aware query pattern:

```sql
SELECT
    sales_date,
    revenue
FROM mart_daily_sales
WHERE sales_date >= CURRENT_DATE - INTERVAL '30 days';
```

Better than repeatedly querying raw sales history for every dashboard tile.

## 6. Production Considerations

- Set budgets and alerts.
- Tag or label resources by project.
- Stop or suspend unused compute.
- Use lifecycle policies for old files.
- Prefer efficient formats such as Parquet for analytics.
- Partition large tables.
- Build marts for repeated dashboard queries.
- Monitor warehouse query patterns.
- Review costs regularly with owners.

## 7. Common Mistakes

- Leaving clusters or warehouses running.
- Querying raw large tables for dashboards.
- Not setting budgets.
- Keeping every raw file forever without retention policy.
- Creating many duplicate datasets.
- Using oversized compute for small jobs.
- Ignoring serverless costs because there are no servers to manage.
- Not tracking costs by project or environment.

## 8. Practice Task

Review a cloud retail analytics architecture.

Identify:

1. Storage cost risks.
2. Compute cost risks.
3. Warehouse query cost risks.
4. Dashboard refresh cost risks.
5. Data retention policy.
6. Budget alerts.
7. Resource tags or labels.
8. Three changes that reduce cost without reducing business value.

## 9. Related Project

- `06-data-warehousing/partitioning-and-clustering.md`: Physical design affects query cost.
- `10-big-data-processing/spark-optimization.md`: Spark optimization affects compute cost.
- `14-production-engineering/`: Production operations include cost management.
