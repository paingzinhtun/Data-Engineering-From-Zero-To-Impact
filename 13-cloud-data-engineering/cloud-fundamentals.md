# Cloud Fundamentals

## 1. What It Is

Cloud computing means using managed infrastructure and services from a cloud provider instead of running everything on your own laptop or servers.

For Data Engineering, cloud platforms commonly provide:

- Object storage
- Compute services
- Managed databases
- Data warehouses
- Serverless jobs
- Networking
- IAM and security
- Monitoring and logging
- Cost management tools

Cloud is not magic. It is still infrastructure, but much of the setup, scaling, and maintenance is handled by the provider.

## 2. Why It Matters

Most professional data systems run in cloud or managed environments. Data Engineers need to understand how data moves through cloud storage, compute, databases, warehouses, and orchestration services.

Cloud fundamentals matter because they help you:

- Move beyond local-only projects.
- Store raw and processed data reliably.
- Run scheduled jobs.
- Secure sensitive data.
- Scale workloads when needed.
- Monitor pipelines.
- Control costs.

## 3. When to Use It

Use cloud services when:

- Data must be shared across teams.
- Pipelines need to run on a schedule outside your laptop.
- Storage needs to scale.
- Managed databases or warehouses are useful.
- Security, access control, and monitoring matter.
- The business needs reliable production workflows.

Avoid cloud complexity when:

- You are learning fundamentals locally.
- A small local database is enough.
- You cannot monitor or control cost.
- You do not understand the architecture you are deploying.

## 4. Real Business Example

A retail stationery business starts with spreadsheet reports on one laptop. As the business grows, multiple teams need sales, inventory, and customer data.

A cloud data setup might use:

- Object storage for raw CSV and API files
- Serverless compute for ingestion jobs
- A managed database for operational reporting
- A cloud warehouse for analytics
- IAM roles to control access
- Monitoring alerts for failed pipelines
- Cost budgets to avoid surprises

## 5. Technical Example

Generic cloud data flow:

```text
source systems
  -> object storage raw zone
  -> compute job
  -> managed database or warehouse
  -> data marts
  -> BI dashboard
```

Core service categories:

```text
object storage: stores files
compute: runs jobs
managed database: stores structured operational data
warehouse: supports analytics queries
IAM: controls who and what can access resources
networking: controls connectivity
monitoring: tracks health, logs, and alerts
cost tools: track spend and budgets
```

## 6. Production Considerations

- Use separate environments for development and production.
- Store secrets securely.
- Apply least-privilege IAM.
- Encrypt sensitive data where appropriate.
- Monitor job failures and data freshness.
- Track cost by project or workload.
- Use infrastructure documentation.
- Design for recovery and reruns.

## 7. Common Mistakes

- Treating cloud services as automatically secure.
- Giving broad permissions to every user or job.
- Forgetting cost monitoring.
- Building complex cloud architecture before understanding the data problem.
- Leaving compute resources running unnecessarily.
- Hardcoding credentials.
- Ignoring networking and access restrictions.
- Skipping logging and alerting.

## 8. Practice Task

Design a simple cloud architecture for a retail sales pipeline.

Include:

1. Object storage location for raw files.
2. Compute service for processing.
3. Database or warehouse target.
4. IAM roles.
5. Networking requirements.
6. Monitoring and alerts.
7. Cost controls.
8. Recovery or rerun plan.

## 9. Related Project

- `06-data-warehousing/warehouse-project/`: Can be deployed to a cloud warehouse.
- `07-data-lake-and-lakehouse/lakehouse-project/`: Uses cloud-style object storage concepts.
- `14-production-engineering/`: Cloud systems require production operations.
