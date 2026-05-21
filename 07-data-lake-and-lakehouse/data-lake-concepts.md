# Data Lake Concepts

## 1. What It Is

A data lake is a storage architecture for keeping large amounts of raw and processed data in files, usually on object storage such as cloud storage.

Unlike a traditional warehouse, a data lake can store many types of data:

- CSV files
- JSON API responses
- Parquet files
- Logs
- Images
- Documents
- Event data
- Semi-structured and unstructured data

The data lake is a storage foundation. It still needs organization, metadata, quality checks, and governance to be useful.

## 2. Why It Matters

Modern businesses generate data from many systems and formats. Not all of that data fits neatly into relational warehouse tables immediately.

Data lakes help Data Engineers:

- Preserve raw data.
- Store high-volume files cost-effectively.
- Support batch and big data processing.
- Keep historical source data for replay.
- Prepare data for analytics, machine learning, and AI.
- Separate raw storage from business-ready outputs.

Without management, a data lake can become a data swamp: a place full of files that nobody trusts or understands.

## 3. When to Use It

Use a data lake when:

- You need to store large volumes of raw data.
- Data arrives in multiple formats.
- You need audit or replay capability.
- You process logs, events, documents, or semi-structured data.
- Machine learning or AI workflows need access to raw and processed data.
- Warehouse storage is too restrictive or expensive for raw files.

Avoid starting with a complex data lake when a small database or warehouse is enough.

## 4. Real Business Example

A growing ecommerce stationery business collects:

- Order CSV exports
- Product catalog API responses
- Website clickstream logs
- Customer support tickets
- Inventory snapshots
- Supplier files

The company stores raw files in a data lake so they can be reprocessed later. Cleaned and curated datasets are then used for dashboards, inventory planning, and customer analytics.

## 5. Technical Example

Example lake layout:

```text
data-lake/
  raw/
    pos_sales/
      ingest_date=2026-01-15/
    ecommerce_orders/
      ingest_date=2026-01-15/
    website_logs/
      ingest_date=2026-01-15/
  processed/
    sales/
    customers/
    inventory/
  curated/
    daily_sales/
    product_performance/
```

Example principles:

```text
raw: source-shaped, minimally changed
processed: cleaned and standardized
curated: business-ready and documented
```

## 6. Production Considerations

- Define naming conventions for folders and files.
- Preserve raw data separately from processed data.
- Track metadata such as source, ingest time, schema, and owner.
- Use efficient file formats for analytics.
- Partition large datasets by useful columns such as date.
- Apply access controls to sensitive data.
- Monitor storage cost.
- Prevent uncontrolled copies and unclear versions.

## 7. Common Mistakes

- Treating object storage as automatically organized.
- Dumping files without metadata.
- Mixing raw and cleaned files in the same location.
- Not documenting source systems.
- Using CSV for large analytical datasets without reason.
- Creating many versions with unclear meaning.
- Ignoring data retention and privacy requirements.
- Calling a folder structure a platform before adding quality and governance.

## 8. Practice Task

Design a data lake folder structure for a stationery ecommerce business.

Include:

1. Three raw source folders.
2. Two cleaned datasets.
3. Two curated business datasets.
4. Partitioning strategy.
5. Metadata fields to track.
6. Access control concerns.
7. Retention considerations.

## 9. Related Project

- `07-data-lake-and-lakehouse/lakehouse-project/`: Bronze/Silver/Gold project brief.
- `01-fundamentals/json-csv-parquet.md`: File formats matter in lake design.
- `10-big-data-processing/`: Large lake datasets often require distributed processing.
