# Spark Optimization

## 1. What It Is

Spark optimization is the practice of improving Spark job performance, reliability, and cost without changing the correctness of results.

Optimization includes file layout, partition strategy, join strategy, shuffle reduction, caching decisions, cluster sizing, and query plan review.

## 2. Why It Matters

Spark jobs can become slow or expensive when data grows. Poorly designed jobs may spend most of their time shuffling data, reading too many files, spilling to disk, or running with bad partition sizes.

Optimization matters because it helps:

- Reduce runtime.
- Lower compute cost.
- Prevent memory failures.
- Improve reliability.
- Meet batch processing windows.
- Make large projects maintainable.

## 3. When to Use It

Optimize Spark when:

- A job is too slow.
- A job fails due to memory or shuffle issues.
- Costs are high.
- Outputs create many tiny files.
- Joins are expensive.
- The same dataset is reused multiple times.

Do not optimize blindly before measuring. First confirm the job is correct and identify the bottleneck.

## 4. Real Business Example

A large retail sales job runs every night. It reads one year of sales data, joins product and customer data, calculates product performance, and writes daily outputs.

The job starts taking four hours and misses the dashboard refresh deadline.

Optimization may include:

- Reading only needed date partitions.
- Using Parquet instead of CSV.
- Reducing shuffle-heavy joins.
- Broadcasting small dimension tables.
- Repartitioning output by date.
- Avoiding tiny output files.

## 5. Technical Example

Read only needed columns:

```python
sales = spark.read.parquet("data/silver/sales/").select(
    "sale_date",
    "product_id",
    "customer_id",
    "quantity",
    "unit_price",
)
```

Filter early:

```python
recent_sales = sales.filter(F.col("sale_date") >= F.lit("2026-01-01"))
```

Broadcast a small dimension:

```python
from pyspark.sql.functions import broadcast


sales_with_products = recent_sales.join(
    broadcast(products),
    on="product_id",
    how="left",
)
```

Write partitioned Parquet:

```python
daily_sales.write.mode("overwrite").partitionBy("sale_date").parquet(
    "data/gold/daily_product_sales/"
)
```

## 6. Production Considerations

- Measure before changing.
- Use Spark UI to inspect stages, tasks, shuffles, and skew.
- Prefer Parquet over CSV for repeated analytics jobs.
- Avoid many tiny files.
- Use partition pruning by filtering on partition columns.
- Broadcast only genuinely small tables.
- Cache only data reused multiple times.
- Control output file sizes.
- Document optimization decisions.

## 7. Common Mistakes

- Caching every DataFrame.
- Broadcasting large tables.
- Repartitioning too often.
- Ignoring data skew.
- Reading all columns when only a few are needed.
- Writing thousands of tiny files.
- Using Spark for small datasets.
- Optimizing without checking correctness first.

## 8. Practice Task

Review a Spark job design for daily product sales.

Answer:

1. What input format is used?
2. Are files too small or too large?
3. Which filters can be applied early?
4. Which joins are large?
5. Which tables could be broadcast?
6. Which transformations cause shuffles?
7. Should anything be cached?
8. How should output files be partitioned?

## 9. Related Project

- `10-big-data-processing/pyspark-project/`: Optimization decisions apply to the large retail batch project.
- `10-big-data-processing/partitioning-shuffling-caching.md`: Covers core Spark performance concepts.
- `07-data-lake-and-lakehouse/parquet-and-columnar-storage.md`: File format and layout affect Spark performance.
