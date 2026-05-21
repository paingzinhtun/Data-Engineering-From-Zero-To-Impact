# Large Retail Batch Processing Project

## 1. What It Is

This project defines a large batch processing workflow for retail sales data using PySpark.

Input:

- Large sales files

Outputs:

- Daily product sales
- Customer summary
- Category performance

The goal is to practice Spark concepts in a realistic Data Engineering scenario.

## 2. Why It Matters

Retail businesses can generate large sales datasets across stores, ecommerce channels, and historical periods.

This project teaches how to process high-volume data using distributed computing while still focusing on business outputs, data quality, and production tradeoffs.

## 3. When to Use It

Use Spark for this project when:

- Sales files are too large for pandas.
- Processing many files locally is slow.
- Data is stored in a data lake.
- Outputs need to be written as partitioned Parquet.
- Joins and aggregations involve millions of rows.

Spark is overkill when:

- The dataset is small enough for pandas.
- A warehouse SQL query can produce the result simply.
- There is no operational need for distributed processing.
- The project is only a beginner file-reading exercise.

## 4. Real Business Example

A stationery retailer has daily sales files from many stores and an online shop.

The business wants:

- Daily product sales for operations.
- Customer summary for retention analysis.
- Category performance for merchandising decisions.

Large historical files make local processing slow, so PySpark is used to process files in parallel and write business-ready outputs.

## 5. Technical Example

Architecture:

```text
large sales files
  -> PySpark read
  -> schema validation
  -> cleaning and type casting
  -> product/customer joins
  -> aggregations
  -> Parquet outputs
```

Expected input columns:

```text
sale_id
sale_date
store_id
channel
product_id
customer_id
quantity
unit_price
```

Expected outputs:

```text
gold/daily_product_sales/
  grain: one row per sale_date and product_id
  metrics: units_sold, revenue

gold/customer_summary/
  grain: one row per customer_id
  metrics: total_orders, total_units, total_revenue, first_purchase_date, last_purchase_date

gold/category_performance/
  grain: one row per sale_date and product_category
  metrics: units_sold, revenue, gross_profit
```

Suggested file format:

```text
Input: CSV or Parquet
Silver output: Parquet
Gold output: partitioned Parquet
```

## 6. Production Considerations

- Prefer Parquet over CSV for repeated processing.
- Use explicit schemas.
- Validate required columns before transformation.
- Avoid collecting large data to the driver.
- Monitor joins and shuffles.
- Broadcast small dimensions when appropriate.
- Avoid too many tiny files.
- Partition Gold outputs by date when useful.
- Log input and output row counts.
- Keep Spark configuration documented.

## 7. Common Mistakes

- Using Spark without enough data to justify it.
- Reading all columns when only a subset is needed.
- Letting Spark infer messy CSV schemas.
- Joining products or customers without checking duplicate keys.
- Writing too many small files.
- Caching everything.
- Ignoring shuffle-heavy aggregations.
- Not validating output metrics.

## 8. Practice Task

Build the project in phases:

1. Read large sales files.
2. Define an explicit schema.
3. Validate required columns.
4. Cast dates and numeric fields.
5. Calculate revenue.
6. Join product data to add category and cost.
7. Create daily product sales.
8. Create customer summary.
9. Create category performance.
10. Write outputs as Parquet.
11. Document partitions, shuffles, joins, caching, and file-size decisions.

## 9. Related Project

- `10-big-data-processing/spark-basics.md`: Spark overview and basic job pattern.
- `10-big-data-processing/pyspark-dataframes.md`: DataFrame transformations used in this project.
- `10-big-data-processing/partitioning-shuffling-caching.md`: Key performance concepts for the project.
- `07-data-lake-and-lakehouse/parquet-and-columnar-storage.md`: Parquet output design.
