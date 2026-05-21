# PySpark DataFrames

## 1. What It Is

A PySpark DataFrame is a distributed table-like data structure. It looks similar to a pandas DataFrame, but operations are planned by Spark and executed across distributed workers.

PySpark DataFrames are used for reading, transforming, joining, aggregating, and writing large datasets.

## 2. Why It Matters

DataFrames are the main API many Data Engineers use in Spark. They provide a structured way to express transformations while Spark handles distributed execution.

They matter because they support:

- Schema-aware processing.
- SQL-like transformations.
- Distributed joins and aggregations.
- Columnar file formats such as Parquet.
- Optimization by Spark's query engine.

## 3. When to Use It

Use PySpark DataFrames when:

- Working with large tabular or semi-structured data.
- Reading from Parquet, CSV, JSON, or tables.
- Applying column transformations.
- Joining large datasets.
- Aggregating metrics by date, product, customer, or category.
- Writing partitioned outputs.

Use pandas instead when the data is small and local processing is simpler.

## 4. Real Business Example

A retail business wants to process a month of sales files with millions of rows.

PySpark DataFrames can:

- Read all sales files.
- Cast fields to proper types.
- Filter invalid rows.
- Join sales to products.
- Calculate revenue and gross profit.
- Aggregate category performance.
- Write Gold datasets for BI.

## 5. Technical Example

Read and transform sales:

```python
from pyspark.sql import functions as F


sales = spark.read.option("header", True).csv("data/bronze/sales/")

clean_sales = (
    sales
    .select(
        F.col("sale_id"),
        F.to_date("sale_date").alias("sale_date"),
        F.col("product_id"),
        F.col("customer_id"),
        F.col("quantity").cast("int").alias("quantity"),
        F.col("unit_price").cast("double").alias("unit_price"),
    )
    .filter(F.col("quantity") > 0)
    .withColumn("revenue", F.col("quantity") * F.col("unit_price"))
)
```

Join and aggregate:

```python
products = spark.read.parquet("data/silver/products/")

sales_with_products = clean_sales.join(products, on="product_id", how="left")

category_performance = (
    sales_with_products
    .groupBy("sale_date", "category")
    .agg(
        F.sum("quantity").alias("units_sold"),
        F.sum("revenue").alias("revenue"),
    )
)
```

Write Parquet:

```python
category_performance.write.mode("overwrite").partitionBy("sale_date").parquet(
    "data/gold/category_performance/"
)
```

## 6. Production Considerations

- Define schemas instead of relying on inference for important jobs.
- Validate required columns.
- Cast data types explicitly.
- Avoid collecting large data to the driver.
- Use joins carefully and inspect row counts.
- Write Parquet for analytics outputs.
- Partition outputs by useful columns.
- Keep transformations readable and testable.

## 7. Common Mistakes

- Treating PySpark exactly like pandas.
- Using `.toPandas()` on large data.
- Letting Spark infer schemas from messy CSV files.
- Joining without checking duplicate keys.
- Forgetting that transformations are lazy until an action runs.
- Writing outputs without controlling file counts.
- Using Python UDFs when built-in functions are available.

## 8. Practice Task

Create a PySpark DataFrame plan for large retail sales data.

Include:

1. Read raw sales.
2. Apply an explicit schema.
3. Filter invalid quantities.
4. Calculate revenue.
5. Join products.
6. Aggregate by category and day.
7. Write output as Parquet.
8. List row count checks before and after joins.

## 9. Related Project

- `10-big-data-processing/pyspark-project/`: Uses DataFrames for retail batch outputs.
- `10-big-data-processing/partitioning-shuffling-caching.md`: DataFrame operations can trigger shuffles.
- `03-python-for-data-engineering/pandas-for-pipelines.md`: Compare pandas and PySpark use cases.
