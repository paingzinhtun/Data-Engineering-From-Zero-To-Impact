# JSON, CSV, And Parquet

## 1. What It Is

JSON, CSV, and Parquet are common data formats.

**CSV** is a plain-text table format where values are separated by commas.

**JSON** is a text format often used for nested data from APIs and applications.

**Parquet** is a columnar file format designed for efficient analytics and large-scale data processing.

Each format has strengths and weaknesses. Data Engineers need to know when to use each one.

## 2. Why It Matters for Data Engineering

File format affects storage size, speed, compatibility, schema handling, and data quality.

Choosing the wrong format can cause problems:

- CSV may lose type information.
- JSON may be flexible but harder to query at scale.
- Parquet is efficient but less readable by humans.

Data Engineers often ingest data in one format, store raw data safely, and transform it into another format for analytics.

## 3. When You Use It

Use CSV when:

- Sharing simple tabular data.
- Working with spreadsheets.
- Creating beginner-friendly examples.
- Exporting small business reports.

Use JSON when:

- Working with APIs.
- Handling nested records.
- Storing raw application events.
- Capturing flexible data structures.

Use Parquet when:

- Storing large analytics datasets.
- Working with data lakes or lakehouses.
- Querying only selected columns.
- Optimizing storage and processing performance.

## 4. Real-World Example

An online store exports daily order data.

The ecommerce API returns JSON because each order may include nested customer details, shipping address, line items, discounts, and payment information.

The operations team may export a CSV because they want to open it in Excel.

The Data Engineering team may convert cleaned order data into Parquet for efficient storage and analytics in a data lake or warehouse pipeline.

All three formats can appear in the same business workflow.

## 5. Basic Commands or Examples

CSV example:

```csv
order_id,customer_id,order_total,status
ORD-1001,C-501,89.50,paid
ORD-1002,C-502,42.00,refunded
```

JSON example:

```json
{
  "order_id": "ORD-1001",
  "customer": {
    "customer_id": "C-501",
    "email": "customer@example.com"
  },
  "items": [
    {
      "product_id": "P-100",
      "quantity": 2,
      "price": 19.99
    }
  ],
  "status": "paid"
}
```

Parquet is usually handled through tools rather than opened manually:

```python
import pandas as pd

orders = pd.read_csv("orders.csv")
orders.to_parquet("orders.parquet", index=False)
```

Comparison:

| Format | Best For | Strengths | Weaknesses |
| --- | --- | --- | --- |
| CSV | Simple tables and spreadsheet exchange | Human-readable, widely supported, easy to create | Weak schema support, poor for nested data, inefficient for large analytics |
| JSON | APIs, events, nested data | Flexible, common in web systems, supports nested structures | Can be verbose, harder to query, inconsistent schemas are common |
| Parquet | Analytics and large datasets | Efficient, compressed, columnar, good for big data tools | Not human-readable, requires compatible tools |

## 6. Common Mistakes

- Assuming CSV preserves data types.
- Opening large CSV files in spreadsheets and accidentally changing values.
- Flattening JSON without preserving important nested relationships.
- Using JSON for large analytics tables when Parquet would be more efficient.
- Using Parquet for simple beginner examples where CSV would be easier.
- Forgetting to document schema and field meanings.
- Treating empty strings, nulls, and missing fields as the same thing.

## 7. Practice Task

Create a small order dataset with:

- Order ID
- Customer ID
- Order date
- Product ID
- Quantity
- Price
- Status

Then:

1. Write it as CSV.
2. Write one order as JSON with nested customer and item information.
3. Explain how the data would change if stored as Parquet.
4. List which format you would use for raw API storage.
5. List which format you would use for spreadsheet sharing.
6. List which format you would use for analytics at scale.

## 8. Related Project

- `17-projects/`: Messy CSV cleaning, API JSON ingestion, and analytics storage projects.
- `07-data-lake-and-lakehouse/`: Parquet is commonly used in data lakes and lakehouse designs.
- `10-big-data-processing/`: Distributed processing tools often work efficiently with Parquet.
