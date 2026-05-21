# Tools

Tools change. Concepts remain. Learn the problem each tool solves.

This list is not a ranking. It is a map of common tool categories in modern data engineering.

## Programming

Common tools:

- Python
- SQL
- Bash or shell scripting
- Java or Scala for some big data and streaming systems

Problems solved:

- Data extraction
- File processing
- API integration
- Transformation logic
- Automation
- Testing

What to learn first:

- Python functions, files, logging, exceptions, and environment variables
- SQL joins, aggregations, windows, and query plans

## Databases

Common tools:

- PostgreSQL
- MySQL
- SQLite
- DuckDB

Problems solved:

- Structured storage
- Transactions
- Relational modeling
- Operational reporting
- Local analytics

What to learn first:

- PostgreSQL for realistic relational practice
- DuckDB for local analytical workflows

## Warehouses

Common tools:

- BigQuery
- Snowflake
- Amazon Redshift
- Azure Synapse

Problems solved:

- Scalable analytics
- BI workloads
- Large historical queries
- Managed compute and storage
- Shared reporting platforms

Concepts to learn:

- Partitioning
- Clustering or sorting
- Query cost
- Data marts
- Access control

## Data Lakes

Common tools:

- S3
- Google Cloud Storage
- Azure Data Lake Storage
- MinIO
- Delta Lake
- Apache Iceberg
- Apache Hudi

Problems solved:

- Raw file storage
- Large historical data
- Semi-structured data
- Lakehouse tables
- Data science and ML storage

Concepts to learn:

- Bronze/Silver/Gold
- Object storage
- File layout
- Table formats
- Catalogs

## File Formats

Common formats:

- CSV
- JSON
- Parquet
- Avro
- ORC

Problems solved:

- Data exchange
- Row-based records
- Columnar analytics
- Schema evolution
- Efficient storage

What to learn first:

- CSV for basic ingestion
- JSON for APIs
- Parquet for analytics and big data

## Orchestration

Common tools:

- Apache Airflow
- Dagster
- Prefect
- Cloud-native schedulers

Problems solved:

- Scheduling
- Task dependencies
- Retries
- Backfills
- Operational visibility

Concepts to learn:

- DAGs
- Idempotency
- Retry strategy
- Backfills
- Alerts

## Transformation

Common tools:

- SQL
- dbt
- pandas
- PySpark
- Stored procedures in some environments

Problems solved:

- Cleaning
- Standardization
- Joins
- Metric calculations
- Marts
- Documentation and tests

What to learn first:

- SQL transformations
- dbt once warehouse modeling becomes important

## Big Data

Common tools:

- Apache Spark
- PySpark
- Databricks
- Hadoop ecosystem in legacy environments

Problems solved:

- Distributed batch processing
- Large joins and aggregations
- Large file processing
- ML feature processing

Concepts to learn:

- Partitions
- Shuffling
- Caching
- Broadcast joins
- File sizes
- Parquet

## Streaming

Common tools:

- Apache Kafka
- Redpanda
- Kafka Streams
- Flink
- Spark Structured Streaming

Problems solved:

- Event ingestion
- Real-time processing
- Event replay
- Operational alerts
- Event-driven architecture

Concepts to learn:

- Producers
- Consumers
- Topics
- Partitions
- Offsets
- Consumer groups
- Event time
- Late data
- Checkpoints

## Data Quality

Common tools:

- dbt tests
- Great Expectations
- Soda
- SQL checks
- Custom Python checks

Problems solved:

- Null detection
- Duplicate detection
- Schema validation
- Freshness checks
- Referential integrity
- Business rule validation

What to learn first:

- SQL checks and dbt tests before adopting heavier frameworks

## BI

Common tools:

- Power BI
- Tableau
- Looker
- Looker Studio
- Metabase
- Apache Superset

Problems solved:

- Dashboards
- Business reporting
- KPI monitoring
- Self-service analytics

Concepts to learn:

- Dashboard-ready marts
- Metric definitions
- Refresh schedules
- Row-level security

## AI-Ready Data

Common tools:

- pgvector
- Qdrant
- Weaviate
- Milvus
- Pinecone
- FastAPI
- Semantic layers
- Feature stores

Problems solved:

- Vector search
- RAG retrieval
- Governed data APIs
- Feature reuse
- AI assistant data access

Concepts to learn:

- Embeddings
- Chunking
- Metadata
- Retrieval quality
- Access control
- Evaluation

## Tool Selection Rule

Choose the simplest tool that solves the business problem with acceptable reliability, cost, and maintainability.

Do not use Spark for small CSV files. Do not use Kafka for daily reports. Do not use AI before the underlying data is trustworthy.
