# Partitioning Shuffling Caching

## 1. What It Is

Partitioning, shuffling, and caching are core Spark concepts.

**Partitions** are chunks of data processed in parallel.

**Shuffling** is the movement of data across workers, often caused by joins, aggregations, and repartitioning.

**Caching** stores reused data in memory or disk so Spark does not recompute it repeatedly.

## 2. Why It Matters

These concepts explain many Spark performance problems.

Good partitioning helps parallelism. Excessive shuffling slows jobs and increases cost. Useful caching can speed repeated operations, while unnecessary caching can waste memory.

Understanding these concepts helps Data Engineers build Spark jobs that are reliable and efficient.

## 3. When to Use It

Think about partitions when:

- Reading or writing large files.
- Processing data by date.
- Output file sizes are too small or too large.
- Tasks are uneven or slow.

Think about shuffling when:

- Running joins.
- Running `groupBy`.
- Running `distinct`.
- Repartitioning data.
- Sorting large datasets.

Use caching when:

- The same DataFrame is reused multiple times.
- Recomputing the DataFrame is expensive.
- There is enough memory to cache it safely.

## 4. Real Business Example

A retail Spark job reads sales data and creates three outputs:

- Daily product sales
- Customer summary
- Category performance

All three outputs use the same cleaned sales DataFrame.

Caching the cleaned sales DataFrame may help because it is reused. But caching a huge joined dataset that is used once may waste memory.

Aggregating by product and customer causes shuffles because Spark must group related rows together across workers.

## 5. Technical Example

Partitioned write:

```python
sales.write.mode("overwrite").partitionBy("sale_date").parquet(
    "data/silver/sales/"
)
```

Aggregation that causes shuffle:

```python
daily_product_sales = sales.groupBy("sale_date", "product_id").agg(
    F.sum("quantity").alias("units_sold"),
    F.sum("revenue").alias("revenue"),
)
```

Join that may cause shuffle:

```python
sales_with_products = sales.join(products, on="product_id", how="left")
```

Caching reused data:

```python
clean_sales = clean_sales.cache()
clean_sales.count()

daily_product_sales = build_daily_product_sales(clean_sales)
customer_summary = build_customer_summary(clean_sales)
category_performance = build_category_performance(clean_sales)
```

Unpersist when done:

```python
clean_sales.unpersist()
```

## 6. Production Considerations

- Choose partition columns based on query and load patterns.
- Avoid partitioning by high-cardinality columns such as customer ID.
- Watch for shuffles in joins and aggregations.
- Use broadcast joins for small dimension tables when appropriate.
- Cache only reused DataFrames.
- Unpersist cached DataFrames when finished.
- Monitor file sizes and task skew.
- Avoid too many tiny output files.

## 7. Common Mistakes

- Partitioning by columns with too many unique values.
- Assuming more partitions are always better.
- Ignoring shuffle size.
- Caching data used only once.
- Forgetting to unpersist cached data.
- Repartitioning repeatedly without reason.
- Joining large skewed datasets without mitigation.
- Writing small files that slow future reads.

## 8. Practice Task

For a large sales processing job, identify:

1. Input partitions.
2. Output partition column.
3. Transformations that cause shuffles.
4. Small tables that could be broadcast.
5. DataFrames reused multiple times.
6. Whether caching is justified.
7. File size risks.
8. How Parquet affects performance.

## 9. Related Project

- `10-big-data-processing/pyspark-project/`: Project outputs require partition, shuffle, cache, join, and file-size decisions.
- `10-big-data-processing/spark-optimization.md`: Optimization builds on these concepts.
- `07-data-lake-and-lakehouse/bronze-silver-gold.md`: Layered lakehouse outputs often depend on partitioned files.
