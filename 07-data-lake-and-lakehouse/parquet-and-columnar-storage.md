# Parquet And Columnar Storage

## 1. What It Is

Parquet is a columnar file format commonly used in data lakes, lakehouses, and big data systems.

Columnar storage means data is stored by column rather than by row. This is useful for analytics because queries often read only a few columns from many rows.

## 2. Why It Matters

File format affects storage cost, query speed, compression, and compatibility.

Parquet matters because it:

- Stores data efficiently.
- Compresses well.
- Supports schema information.
- Works well with analytics engines.
- Reduces scanned data when queries read selected columns.
- Is better than CSV for many large analytical datasets.

## 3. When to Use It

Use Parquet when:

- Data is used for analytics.
- Files are large.
- Queries read selected columns.
- Data is stored in a lake or lakehouse.
- You need efficient compression.
- You use engines such as Spark, DuckDB, Trino, or cloud warehouses that support Parquet.

Use CSV when data is small, simple, and needs to be human-readable or spreadsheet-friendly.

Use JSON when preserving nested API responses or event payloads.

## 4. Real Business Example

A stationery ecommerce business stores years of order history.

Raw API responses may be stored as JSON in Bronze for audit. Cleaned order line data may be stored as Parquet in Silver because analysts often query columns such as order date, product ID, quantity, and price.

Gold product performance datasets may also be stored as Parquet for efficient dashboard and ML use.

## 5. Technical Example

Convert CSV to Parquet with pandas:

```python
from pathlib import Path

import pandas as pd


input_path = Path("data/bronze/sales.csv")
output_path = Path("data/silver/sales.parquet")

sales = pd.read_csv(input_path)
output_path.parent.mkdir(parents=True, exist_ok=True)
sales.to_parquet(output_path, index=False)
```

Query only needed columns conceptually:

```sql
SELECT
    sale_date,
    product_id,
    quantity
FROM silver_sales
WHERE sale_date >= DATE '2026-01-01';
```

With columnar storage, the engine can avoid reading unnecessary columns when supported.

## 6. Production Considerations

- Use Parquet for large cleaned and curated analytical datasets.
- Keep file sizes reasonable for the processing engine.
- Partition large datasets by common filters such as date.
- Track schema changes carefully.
- Avoid too many tiny files.
- Validate row counts after conversion.
- Preserve raw source files separately when needed.
- Document compression, partitioning, and schema assumptions.

## 7. Common Mistakes

- Using CSV for very large analytics workloads.
- Creating many tiny Parquet files.
- Assuming Parquet automatically solves bad modeling.
- Ignoring schema evolution.
- Over-partitioning by high-cardinality columns.
- Not preserving raw files before conversion.
- Choosing Parquet when human review in spreadsheets is the main need.

## 8. Practice Task

Create a small retail sales CSV.

Then:

1. Read it with pandas.
2. Validate required columns.
3. Convert it to Parquet.
4. Compare file sizes.
5. Read the Parquet file back.
6. Explain when you would keep CSV, JSON, and Parquet versions.

## 9. Related Project

- `01-fundamentals/json-csv-parquet.md`: Basic comparison of common data formats.
- `07-data-lake-and-lakehouse/lakehouse-project/`: Silver and Gold layers often use Parquet.
- `10-big-data-processing/`: Distributed engines commonly process Parquet efficiently.
