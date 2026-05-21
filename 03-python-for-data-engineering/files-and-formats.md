# Files And Formats

## 1. What It Is

Files and formats are how data is stored and exchanged between systems. Common formats in Data Engineering include CSV, JSON, Parquet, Excel, and plain text logs.

Python can read and write these formats using built-in modules and libraries such as `pathlib`, `csv`, `json`, and `pandas`.

## 2. Why It Matters for Data Engineering

Many pipelines start with files. A supplier may send CSV files, an ecommerce API may return JSON, a data lake may store Parquet, and a finance team may export Excel files.

Data Engineers need to understand how to:

- Locate files safely.
- Read files with the correct format.
- Validate schemas.
- Handle missing or malformed values.
- Write outputs consistently.
- Preserve raw data for debugging.

## 3. Core Concepts

- **File path:** The location of a file.
- **Relative path:** A path relative to the current working directory.
- **Absolute path:** A full path from the root of the filesystem.
- **Encoding:** How text is represented, such as UTF-8.
- **Delimiter:** The character separating fields in a text file.
- **Schema:** The expected columns and data types.
- **Raw data:** Data saved as received from the source.
- **Processed data:** Data cleaned or transformed for use.
- **Idempotent output:** Output that can be recreated safely.

## 4. Real-World Example

A small distributor receives supplier inventory files every morning. Some suppliers send CSV, some send Excel, and one sends JSON through an API.

A Python pipeline reads each source, standardizes fields such as `sku`, `product_name`, `available_quantity`, and `supplier_id`, then writes a clean dataset for inventory planning.

Without careful file handling, the business may reorder too late, overstock slow-moving items, or report incorrect inventory.

## 5. Python Example

```python
from pathlib import Path

import pandas as pd


input_path = Path("data/raw/sales.csv")
output_path = Path("data/processed/sales_clean.csv")

if not input_path.exists():
    raise FileNotFoundError(f"Missing input file: {input_path}")

sales = pd.read_csv(input_path)

required_columns = {"order_id", "customer_id", "order_total"}
missing_columns = required_columns - set(sales.columns)
if missing_columns:
    raise ValueError(f"Missing columns: {sorted(missing_columns)}")

sales = sales.drop_duplicates(subset=["order_id"])

output_path.parent.mkdir(parents=True, exist_ok=True)
sales.to_csv(output_path, index=False)
```

## 6. Production Considerations

- Keep raw files separate from processed files.
- Validate required columns before transformation.
- Decide how to handle duplicates, nulls, and invalid types.
- Avoid overwriting raw source data.
- Use consistent naming conventions.
- Log file paths and row counts.
- Be careful with spreadsheet files that may contain hidden formatting issues.
- Use Parquet or database tables for larger analytics workloads.

## 7. Common Mistakes

- Assuming the current working directory is always the project root.
- Reading a file without checking that it exists.
- Ignoring encoding problems.
- Treating all values as strings.
- Overwriting raw data with cleaned data.
- Forgetting to create output folders before writing.
- Processing files without validating columns.
- Using CSV for large analytical datasets where Parquet would be better.

## 8. Practice Task

Create a small `sales.csv` file with columns:

- `order_id`
- `customer_id`
- `order_date`
- `product_id`
- `quantity`
- `unit_price`

Write a Python script that:

1. Reads the file.
2. Validates required columns.
3. Adds a `revenue` column.
4. Drops duplicate `order_id` rows.
5. Writes the cleaned file to a processed folder.
6. Logs input and output row counts.

## 9. Related Project

- `01-fundamentals/json-csv-parquet.md`: Learn when to use CSV, JSON, and Parquet.
- `03-python-for-data-engineering/examples/read_csv.py`: Practical CSV reading example.
- `17-projects/`: File-based retail and inventory projects should apply these patterns.
