# Spark Basics

## 1. What It Is

Apache Spark is a distributed data processing engine used for large-scale batch and streaming workloads.

PySpark is the Python interface to Spark. It lets Data Engineers write Spark jobs using Python while Spark handles distributed execution across workers.

## 2. Why It Matters

Spark is widely used for big data processing because it can read large datasets, transform them in parallel, join data, aggregate metrics, and write outputs to data lakes or warehouses.

Spark matters when data volume or processing time exceeds what simpler tools can handle.

## 3. When to Use It

Spark is useful when:

- Files are large or numerous.
- Data is stored in a lake.
- Transformations need distributed execution.
- Jobs process millions or billions of rows.
- You need to write partitioned Parquet outputs.
- Multiple large datasets must be joined or aggregated.

Spark is overkill when:

- The data fits easily in pandas.
- A warehouse SQL query is simpler and faster.
- The job is only a small script.
- Cluster startup time is longer than the processing work.
- The team does not need distributed execution.

## 4. Real Business Example

A retailer receives large sales files from many stores. Each file contains transaction lines with product, customer, date, quantity, and price.

Spark can read all files, clean invalid rows, calculate revenue, aggregate daily product sales, and write the result as Parquet for dashboards and downstream analytics.

## 5. Technical Example

Basic PySpark structure:

```python
from pyspark.sql import SparkSession
from pyspark.sql import functions as F


spark = SparkSession.builder.appName("retail-sales").getOrCreate()

sales = spark.read.parquet("data/silver/sales/")

daily_sales = (
    sales
    .groupBy("sale_date", "product_id")
    .agg(
        F.sum("quantity").alias("units_sold"),
        F.sum(F.col("quantity") * F.col("unit_price")).alias("revenue"),
    )
)

daily_sales.write.mode("overwrite").parquet("data/gold/daily_product_sales/")
```

This example reads Parquet, groups data, calculates metrics, and writes Parquet output.

## 6. Production Considerations

- Prefer Parquet for large analytics data.
- Avoid unnecessary shuffles.
- Check partition counts.
- Use clear input and output paths.
- Avoid collecting large data to the driver.
- Monitor Spark UI metrics when tuning.
- Use appropriate cluster size.
- Write outputs in manageable file sizes.

## 7. Common Mistakes

- Calling `.collect()` on large datasets.
- Reading many tiny files.
- Writing too many tiny output files.
- Using Python loops instead of DataFrame transformations.
- Caching everything.
- Joining large tables without understanding shuffle.
- Using Spark when SQL or pandas is enough.

## 8. Practice Task

Design a Spark job for large sales files.

Define:

1. Input path.
2. Input format.
3. Required columns.
4. Transformations.
5. Aggregations.
6. Output format.
7. Partitioning strategy.
8. Why Spark is or is not justified.

## 9. Related Project

- `10-big-data-processing/pyspark-project/`: Defines a large retail Spark batch project.
- `10-big-data-processing/pyspark-dataframes.md`: Covers DataFrame operations.
- `07-data-lake-and-lakehouse/parquet-and-columnar-storage.md`: Parquet is a common Spark format.
