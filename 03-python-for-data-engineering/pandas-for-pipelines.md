# Pandas For Pipelines

## 1. What It Is

Pandas is a Python library for working with tabular data. It provides the `DataFrame`, a table-like structure used to read, clean, transform, aggregate, and write data.

For Data Engineering, pandas is useful for small to medium-sized batch processing, prototyping transformations, validating files, and preparing data before loading it into a database.

## 2. Why It Matters for Data Engineering

Pandas helps Data Engineers quickly process business files such as CSV exports, Excel reports, and JSON records.

It is useful for:

- Reading files.
- Renaming columns.
- Converting data types.
- Removing duplicates.
- Filtering invalid rows.
- Joining datasets.
- Calculating derived columns.
- Writing processed outputs.

Pandas is not the right tool for every scale, but it is excellent for learning and many practical workflows.

## 3. Core Concepts

- **DataFrame:** A table-like data structure.
- **Series:** A single column from a DataFrame.
- **Index:** Row labels used by pandas.
- **Column selection:** Choosing fields to inspect or transform.
- **Filtering:** Keeping rows that match conditions.
- **Aggregation:** Summarizing rows into metrics.
- **Merge:** Joining DataFrames.
- **Data type conversion:** Converting strings to dates, numbers, or booleans.
- **Vectorized operation:** Applying logic across columns efficiently.

## 4. Real-World Example

A retail operations team sends daily sales and product files. A pandas pipeline can:

1. Read sales and products CSV files.
2. Validate required columns.
3. Convert sale dates and numeric fields.
4. Join sales to products.
5. Calculate revenue and gross profit.
6. Aggregate revenue by category.
7. Write a clean output file for loading to PostgreSQL.

This is a common bridge between messy source files and structured database tables.

## 5. Python Example

```python
from pathlib import Path

import pandas as pd


sales_path = Path("data/raw/sales.csv")
products_path = Path("data/raw/products.csv")

sales = pd.read_csv(sales_path)
products = pd.read_csv(products_path)

sales["sale_date"] = pd.to_datetime(sales["sale_date"])
sales["quantity"] = sales["quantity"].astype(int)
sales["unit_price"] = sales["unit_price"].astype(float)

sales["revenue"] = sales["quantity"] * sales["unit_price"]

sales_with_products = sales.merge(
    products[["product_id", "product_name", "category", "cost_price"]],
    on="product_id",
    how="left",
)

sales_with_products["gross_profit"] = (
    sales_with_products["quantity"]
    * (sales_with_products["unit_price"] - sales_with_products["cost_price"])
)

category_summary = (
    sales_with_products.groupby("category", as_index=False)
    .agg(revenue=("revenue", "sum"), gross_profit=("gross_profit", "sum"))
    .sort_values("revenue", ascending=False)
)

print(category_summary)
```

## 6. Production Considerations

- Validate input columns before transformation.
- Convert data types explicitly.
- Check row counts before and after merges.
- Watch memory usage for large files.
- Avoid chained assignment confusion.
- Keep transformation logic in functions for testing.
- Log summary metrics.
- Use databases, Spark, or warehouse SQL when data becomes too large for pandas.

## 7. Common Mistakes

- Letting pandas infer important data types incorrectly.
- Not checking for duplicated join keys.
- Losing rows during merges without noticing.
- Using pandas for data too large for memory.
- Not handling null values before calculations.
- Mixing notebook exploration with production pipeline logic.
- Writing outputs without validating row counts.

## 8. Practice Task

Create two CSV files:

- `sales.csv`
- `products.csv`

Write a pandas script that:

1. Reads both files.
2. Validates required columns.
3. Converts dates and numeric fields.
4. Joins sales to products.
5. Calculates revenue and gross profit.
6. Summarizes revenue by category.
7. Logs row counts before and after the join.

## 9. Related Project

- `03-python-for-data-engineering/examples/read_csv.py`: Basic file reading pattern.
- `03-python-for-data-engineering/examples/load_to_postgres.py`: Load pandas results into PostgreSQL.
- `17-projects/`: Retail sales and inventory projects can use pandas for early pipeline versions.
