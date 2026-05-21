# Storage Compute Networking

## 1. What It Is

Storage, compute, and networking are the basic infrastructure categories behind cloud data systems.

- **Storage** keeps data such as files, tables, logs, and backups.
- **Compute** runs processing jobs, APIs, transformations, and queries.
- **Networking** controls how systems connect to each other securely.

Every cloud data architecture uses these three concepts.

## 2. Why It Matters

Data Engineers often debug problems that are not caused by code. A pipeline may fail because storage permissions are wrong, compute resources are too small, or network access is blocked.

Understanding storage, compute, and networking helps you:

- Design clearer architectures.
- Choose the right service for the job.
- Debug access and connectivity issues.
- Avoid unnecessary cost.
- Separate public and private access.
- Explain data platform tradeoffs.

## 3. When to Use It

Think about storage, compute, and networking whenever:

- Moving a pipeline to cloud.
- Loading files into a warehouse.
- Connecting to a managed database.
- Running serverless jobs.
- Processing data in a private network.
- Debugging timeouts or permission errors.
- Estimating cost.

## 4. Real Business Example

A retail pipeline reads daily POS files and loads a warehouse.

Storage:

- Raw files are stored in object storage.

Compute:

- A scheduled job reads, validates, and transforms files.

Networking:

- The job connects privately to a managed database or warehouse.

If the compute job cannot reach the database, the problem may be network rules rather than Python code.

## 5. Technical Example

Generic architecture:

```text
object storage
  -> serverless compute job
  -> managed database or warehouse
  -> dashboard
```

Key concepts:

```text
object storage: scalable file storage for raw and processed data
compute: machines or serverless services that run code
managed database: provider-operated database service
warehouse: analytics-focused storage and query engine
network: routes, firewalls, subnets, private endpoints, DNS
```

Serverless example:

```text
file lands in object storage
  -> event triggers serverless function
  -> function validates metadata
  -> job writes record to warehouse
```

## 6. Production Considerations

- Keep raw and processed storage separated.
- Choose compute based on workload size and runtime.
- Use serverless for event-driven or lightweight jobs when appropriate.
- Use private networking for sensitive systems.
- Restrict public access.
- Monitor compute failures and runtime.
- Track storage growth.
- Document network dependencies.

## 7. Common Mistakes

- Assuming storage access means database access.
- Forgetting network rules or firewall allowlists.
- Using always-on compute for occasional jobs.
- Using serverless for jobs that exceed timeout limits.
- Leaving object storage publicly accessible.
- Not separating environments.
- Ignoring storage lifecycle costs.
- Debugging only code while ignoring infrastructure.

## 8. Practice Task

Design storage, compute, and networking for a cloud sales pipeline.

Define:

1. Raw storage location.
2. Processed storage location.
3. Compute service.
4. Database or warehouse target.
5. Network access requirements.
6. Public access restrictions.
7. Monitoring needs.
8. Cost risks.

## 9. Related Project

- `13-cloud-data-engineering/cloud-fundamentals.md`: Overview of cloud platform components.
- `05-etl-elt-pipelines/`: ETL jobs depend on storage, compute, and connectivity.
- `07-data-lake-and-lakehouse/`: Data lakes are built on object storage.
