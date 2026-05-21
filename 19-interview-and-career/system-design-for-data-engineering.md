# System Design For Data Engineering

Data engineering system design interviews test whether you can turn a business problem into a reliable data system. The goal is not to name as many tools as possible. The goal is to make reasonable tradeoffs.

## 1. System Design Answer Structure

Use this structure:

1. Clarify the business problem.
2. Identify users and outputs.
3. Define data sources and volume.
4. Choose batch, streaming, or hybrid.
5. Design storage layers.
6. Design transformations and data model.
7. Add data quality checks.
8. Add orchestration, monitoring, and alerting.
9. Discuss security and governance.
10. Discuss scalability, cost, and tradeoffs.

## 2. Questions To Ask First

- Who uses the output?
- How fresh does the data need to be?
- What data sources are involved?
- What is the data volume?
- Are there sensitive fields?
- What happens if the pipeline fails?
- Is historical reprocessing needed?
- What are the most important metrics?

## 3. Common System Design Topics

Batch pipeline:

- Source extraction
- Raw storage
- Transformations
- Data marts
- Scheduling
- Backfills

Streaming pipeline:

- Events
- Topics
- Partitions
- Consumer groups
- Event time
- Late data
- Checkpoints

Warehouse design:

- Facts and dimensions
- Star schema
- Data marts
- Partitioning
- Query performance
- Metric governance

Lakehouse design:

- Bronze, Silver, Gold
- Object storage
- Parquet
- Table formats
- Catalog
- File compaction

Production design:

- Logging
- Monitoring
- Alerts
- Retries
- Idempotency
- Incident response

## 4. Example: Daily Retail Sales Platform

Problem:

> Store managers need daily sales and inventory reports by 8:00 AM.

Design:

```text
POS CSV exports
  -> Python ingestion
  -> raw PostgreSQL tables
  -> staging transformations
  -> fact_sales and dim_product
  -> mart_daily_sales and mart_inventory_reorder
  -> dashboard
```

Quality checks:

- Source file exists.
- Sales row count is greater than zero.
- Sale line IDs are unique.
- Product IDs exist in product dimension.
- Quantity is positive.
- Dashboard mart freshness is before 8:00 AM.

Tradeoff:

- Batch is enough because users need morning reports, not second-by-second updates.

## 5. Example: Real-Time Sales Alerts

Problem:

> Operations wants alerts when sales drop unusually during business hours.

Design:

```text
POS events
  -> Kafka topic
  -> stream processor
  -> rolling sales aggregates
  -> alert service and real-time dashboard
```

Quality checks:

- Event schema is valid.
- Event ID is unique.
- Consumer lag is monitored.
- Late events are handled with watermarks.
- Dead-letter events are tracked.

Tradeoff:

- Streaming is useful for live operational action, but overkill for next-day reports.

## 6. Example: AI Business Assistant

Problem:

> Business users want to ask questions in natural language using trusted company data.

Design:

```text
Warehouse marts and business documents
  -> semantic layer
  -> document chunking and vector search
  -> governed data API
  -> AI assistant
  -> cited answers
```

Quality and governance:

- AI uses approved marts only.
- Documents include metadata and access levels.
- Answers cite sources.
- Queries and responses are logged.
- Sensitive fields are masked.

Tradeoff:

- Build reliable marts and metric definitions before adding AI.

## 7. Scalability Discussion Points

Discuss:

- Data volume
- Partitioning
- File sizes
- Indexes
- Query patterns
- Incremental loading
- Compute scaling
- Storage format
- Retention

Good answer:

> I would start with PostgreSQL for this volume. If the data grows beyond what single-node queries can handle, I would move large historical files to object storage and use a warehouse or Spark for heavier transformations.

## 8. Reliability Discussion Points

Discuss:

- Idempotency
- Retries
- Backfills
- Checkpoints
- Data quality gates
- Alerts
- Run logs
- Ownership

Good answer:

> The pipeline should fail before publishing marts if critical checks fail. It should log row counts, source files, execution date, and failed check examples so the owner can debug quickly.

## 9. Cost Discussion Points

Discuss:

- Whether advanced architecture is justified
- Batch versus streaming cost
- Warehouse query cost
- Compute runtime
- Storage retention
- Dashboard query patterns

Good answer:

> I would not use Kafka unless the business needs real-time decisions. For daily reporting, scheduled batch is simpler and cheaper.

## 10. Security Discussion Points

Discuss:

- Least privilege
- Secret management
- PII masking
- Encryption
- Access audit
- Environment separation
- Approved views

Good answer:

> Analysts should query curated marts, not raw tables with sensitive fields. Credentials should be stored in a secret manager or environment variables, never in code.
