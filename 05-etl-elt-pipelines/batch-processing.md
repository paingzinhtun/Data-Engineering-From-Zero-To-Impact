# Batch Processing

## 1. What It Is

Batch processing is the practice of processing data in groups at scheduled or repeated intervals. Instead of handling each event immediately, a batch pipeline processes data for a time period or file set.

Examples:

- Daily sales file
- Hourly inventory export
- Weekly customer report
- Monthly finance reconciliation

## 2. Why It Matters

Many business processes do not require real-time data. Batch processing is simpler, easier to reason about, and often cheaper than streaming.

Data Engineers use batch processing to:

- Ingest daily files.
- Update dashboards.
- Refresh warehouse tables.
- Recalculate metrics.
- Process API extracts.
- Run validation checks.
- Create reports for business teams.

Batch pipelines are the foundation of many production data platforms.

## 3. When to Use It

Use batch processing when:

- Data arrives on a schedule.
- Business users need daily or hourly updates.
- Source systems provide exports rather than events.
- Simplicity is more important than low latency.
- Data volume can be processed within the available time window.
- The process needs clear reruns and backfills.

Avoid batch-only design when the business truly needs immediate response, such as fraud alerts, real-time inventory reservation, or live operational monitoring.

## 4. Real Business Example

A stationery shop receives a daily CSV export from its point-of-sale system at 11 PM.

A batch pipeline runs at midnight:

1. Checks that the file arrived.
2. Reads the sales file.
3. Validates required columns.
4. Loads raw records.
5. Updates sales and product performance tables.
6. Sends a summary to the operations dashboard.

The manager sees yesterday's sales and low-stock products every morning.

## 5. Technical Example

Simple batch pipeline steps:

```text
1. extract_daily_sales
2. validate_schema
3. load_raw_sales
4. transform_sales_mart
5. run_quality_checks
6. publish_report
```

Python-style control flow:

```python
def run_daily_batch() -> None:
    raw_sales = extract("data/raw/sales_2026_01_15.csv")
    validate(raw_sales)
    clean_sales = transform(raw_sales)
    load(clean_sales, table_name="fact_sales")
    run_quality_checks()
```

SQL batch summary:

```sql
INSERT INTO mart_daily_sales (sales_date, revenue, units_sold)
SELECT
    sale_date,
    SUM(quantity * unit_price) AS revenue,
    SUM(quantity) AS units_sold
FROM fact_sales
WHERE sale_date = DATE '2026-01-15'
GROUP BY sale_date;
```

## 6. Production Considerations

- Define the expected schedule.
- Check whether source data arrived.
- Log start time, end time, and row counts.
- Make batches rerunnable.
- Store batch identifiers or processing dates.
- Handle late-arriving data.
- Plan backfills.
- Alert when a batch fails or produces suspicious results.
- Avoid partial outputs when a batch fails halfway.

## 7. Common Mistakes

- Assuming source files always arrive on time.
- Reprocessing the same file and creating duplicates.
- Not recording which batch was processed.
- Not validating row counts.
- Overwriting outputs without backup or audit.
- Running long jobs without monitoring.
- Building daily logic that cannot handle backfills.

## 8. Practice Task

Design a daily batch pipeline for a stationery shop.

Include:

1. Source file name pattern.
2. Expected arrival time.
3. Required schema.
4. Validation checks.
5. Target tables.
6. Row count logging.
7. Failure behavior.
8. Backfill strategy.

## 9. Related Project

- `08-orchestration/`: Batch jobs are commonly scheduled by orchestration tools.
- `12-data-quality-testing-observability/`: Batch outputs need quality checks and monitoring.
- `17-projects/`: Retail sales and inventory pipelines should start as batch projects.
