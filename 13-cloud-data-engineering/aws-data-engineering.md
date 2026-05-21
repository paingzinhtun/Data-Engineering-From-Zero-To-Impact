# AWS Data Engineering

## 1. What It Is

AWS data engineering means building data systems using Amazon Web Services. AWS provides services for storage, compute, databases, warehouses, streaming, security, monitoring, and orchestration.

This section explains AWS at a high level. The goal is to understand service categories and architecture choices, not memorize every product.

## 2. Why It Matters

Many companies run data platforms on AWS. Data Engineers should understand how common AWS services map to general data engineering needs.

AWS can support:

- Raw file storage
- Batch processing
- Managed databases
- Data warehousing
- Streaming pipelines
- Serverless jobs
- IAM-based security
- Monitoring and cost tracking

## 3. When to Use It

Use AWS data services when:

- The organization is already on AWS.
- Data is stored in or near S3.
- You need managed infrastructure.
- You need scalable batch or warehouse workloads.
- You need integration with AWS security and networking.

Avoid choosing AWS services just because they are available. Start with the data problem and choose the simplest service set that solves it.

## 4. Real Business Example

A retail stationery company wants to automate daily sales reporting.

A high-level AWS architecture might use:

- Amazon S3 for raw sales and inventory files
- AWS Lambda or AWS Glue for ingestion and transformation
- Amazon RDS for managed PostgreSQL
- Amazon Redshift for analytics warehousing
- AWS IAM for access control
- Amazon CloudWatch for logs and alerts
- AWS Cost Explorer and budgets for cost monitoring

## 5. Technical Example

High-level service mapping:

```text
object storage: Amazon S3
compute: EC2, ECS, Lambda, Glue
managed database: Amazon RDS, Amazon Aurora
warehouse: Amazon Redshift
streaming: Amazon MSK, Kinesis
serverless query: Athena
IAM/security: IAM, KMS, Secrets Manager
monitoring: CloudWatch
```

Example architecture:

```text
POS CSV files
  -> S3 raw bucket
  -> Glue or Lambda processing
  -> Redshift fact and mart tables
  -> BI dashboard
```

## 6. Production Considerations

- Use IAM roles instead of long-lived access keys where possible.
- Separate raw, processed, and curated storage paths.
- Encrypt sensitive data.
- Keep secrets in a managed secrets service.
- Configure network access intentionally.
- Monitor CloudWatch logs and metrics.
- Track S3 storage, compute, and warehouse costs.
- Use lifecycle policies for old files when appropriate.

## 7. Common Mistakes

- Making S3 buckets public accidentally.
- Hardcoding AWS keys in code.
- Giving overly broad IAM permissions.
- Loading directly from raw files into final reporting tables.
- Ignoring Redshift or compute costs.
- Not monitoring failed Glue or Lambda jobs.
- Choosing many services when a simple RDS or Redshift setup would work.

## 8. Practice Task

Design an AWS retail analytics pipeline.

Define:

1. S3 bucket layout.
2. Compute service for ingestion.
3. Warehouse or database target.
4. IAM roles.
5. Secret storage.
6. Monitoring setup.
7. Cost controls.
8. Data quality checks.

## 9. Related Project

- `06-data-warehousing/redshift.md`: Redshift warehouse overview.
- `05-etl-elt-pipelines/`: AWS services can run ETL and ELT pipelines.
- `17-projects/`: Cloud extensions can deploy portfolio projects to AWS.
