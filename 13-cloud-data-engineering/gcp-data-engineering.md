# GCP Data Engineering

## 1. What It Is

GCP data engineering means building data systems using Google Cloud Platform. GCP provides services for object storage, compute, managed databases, data warehousing, streaming, security, monitoring, and orchestration.

The goal is to understand how GCP services map to common data platform needs.

## 2. Why It Matters

GCP is widely used for analytics-focused data platforms, especially with BigQuery. Data Engineers should understand how to combine storage, processing, warehousing, IAM, networking, and monitoring in a practical architecture.

GCP can support:

- Raw data storage
- Batch and streaming processing
- Managed databases
- Cloud data warehousing
- Serverless analytics
- IAM and service accounts
- Monitoring and cost management

## 3. When to Use It

Use GCP data services when:

- The organization uses Google Cloud.
- BigQuery is the analytics warehouse.
- Data integrates with Google Cloud services.
- Serverless analytics is useful.
- Teams need managed processing and monitoring.

Avoid using cloud services before understanding the data model, pipeline behavior, security needs, and cost profile.

## 4. Real Business Example

A retail ecommerce company wants daily analytics across online orders, customer records, inventory snapshots, and marketing events.

A high-level GCP architecture might use:

- Cloud Storage for raw files
- Cloud Run, Cloud Functions, or Dataflow for processing
- Cloud SQL for managed relational data
- BigQuery for analytics warehousing
- Pub/Sub for event ingestion
- IAM service accounts for access control
- Cloud Logging and Cloud Monitoring for observability
- Billing budgets for cost control

## 5. Technical Example

High-level service mapping:

```text
object storage: Cloud Storage
compute: Compute Engine, Cloud Run, Cloud Functions, Dataflow
managed database: Cloud SQL, AlloyDB
warehouse: BigQuery
streaming/messaging: Pub/Sub
IAM/security: IAM, service accounts, Secret Manager, Cloud KMS
monitoring: Cloud Logging, Cloud Monitoring
```

Example architecture:

```text
ecommerce API data
  -> Cloud Storage raw bucket
  -> Dataflow or Cloud Run processing
  -> BigQuery staging and mart tables
  -> BI dashboard
```

## 6. Production Considerations

- Use service accounts with least privilege.
- Separate raw, staging, and mart datasets.
- Monitor BigQuery query cost and scanned bytes.
- Use partitioning and clustering on large BigQuery tables.
- Keep secrets in Secret Manager.
- Use Cloud Logging and Monitoring for jobs.
- Define network access intentionally.
- Use budgets and alerts.

## 7. Common Mistakes

- Querying large BigQuery tables without filters.
- Giving broad IAM permissions to service accounts.
- Storing secrets in code.
- Mixing raw and business-ready data in one dataset.
- Ignoring cloud billing until costs spike.
- Using serverless compute without understanding timeouts and limits.
- Not monitoring failed jobs.

## 8. Practice Task

Design a GCP retail analytics pipeline.

Define:

1. Cloud Storage layout.
2. Compute service for ingestion.
3. BigQuery dataset structure.
4. IAM service accounts.
5. Secret management.
6. Monitoring and logging.
7. Cost controls.
8. Data quality checks.

## 9. Related Project

- `06-data-warehousing/bigquery.md`: BigQuery warehouse overview.
- `07-data-lake-and-lakehouse/`: Cloud Storage can support lakehouse-style layers.
- `17-projects/`: Cloud extensions can deploy portfolio projects to GCP.
