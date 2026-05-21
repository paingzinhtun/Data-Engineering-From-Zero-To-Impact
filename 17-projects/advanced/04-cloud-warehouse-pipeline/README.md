# Project 04: Cloud Warehouse Pipeline

## Business Problem

A growing SME has outgrown local spreadsheets and a single PostgreSQL reporting database. Reporting is slow, historical data is growing, and business users want governed dashboards across sales, finance, inventory, ecommerce, and operations.

The business needs a cloud warehouse pipeline that is scalable, secure, cost-aware, and reliable without requiring the team to manage database infrastructure.

## System Goal

Design a cloud-native data warehouse pipeline that ingests operational data, transforms it into trusted marts, applies data quality checks, and serves dashboards for decision makers.

## Architecture

```text
Operational databases, CSV exports, APIs, SaaS tools
  -> cloud storage landing zone
  -> ingestion jobs
  -> cloud warehouse raw tables
  -> staging and marts
  -> BI dashboards and governed metrics
```

The project can be implemented with one cloud provider:

- AWS: S3, Glue or Lambda, Redshift, IAM, CloudWatch
- GCP: Cloud Storage, Cloud Functions or Dataflow, BigQuery, IAM, Cloud Monitoring
- Azure: ADLS, Data Factory or Functions, Synapse, Entra ID, Azure Monitor

## Tools

Recommended tool families:

- Object storage for landing files
- Managed warehouse for analytics
- Serverless or managed ingestion service
- SQL transformation layer
- dbt for transformations and tests
- BI tool for dashboards
- Cloud monitoring and alerting
- IAM for access control

## Data Sources

Suggested sources:

- POS database exports
- Ecommerce order API
- Inventory CSV files
- Accounting revenue files
- Customer CRM exports
- Marketing campaign data

Source patterns:

- Batch file arrivals
- API pulls
- Database change exports
- Manually uploaded operational files

## Pipeline Design

1. Land all source files in cloud object storage.
2. Organize landing paths by source and date.
3. Trigger ingestion jobs on schedule or file arrival.
4. Load source data into raw warehouse tables.
5. Apply staging transformations for types, names, and deduplication.
6. Build fact and dimension tables.
7. Build business marts for sales, inventory, finance, and customer analytics.
8. Run quality checks and freshness checks.
9. Publish dashboards and metric documentation.
10. Monitor failures, cost, and query performance.

## Data Model

Suggested schemas:

- `raw`
- `staging`
- `warehouse`
- `mart`
- `audit`

Suggested tables:

- `warehouse.dim_date`
- `warehouse.dim_product`
- `warehouse.dim_customer`
- `warehouse.dim_store`
- `warehouse.fact_sales`
- `warehouse.fact_inventory_snapshot`
- `warehouse.fact_payments`
- `mart.daily_sales`
- `mart.inventory_reorder`
- `mart.customer_value`
- `mart.finance_revenue`
- `audit.pipeline_runs`

## Quality Checks

Minimum checks:

- Source files loaded for expected dates.
- Raw row counts match source metadata.
- Required columns exist.
- Primary keys are unique where expected.
- Fact-to-dimension relationships are valid.
- Freshness meets the reporting SLA.
- Revenue and quantity fields are reasonable.
- Dashboard marts reconcile to warehouse facts.

Operational checks:

- Ingestion jobs finish within schedule.
- Failed loads are logged and alerted.
- Backfills do not duplicate records.
- Cost anomalies are detected.

## Scalability Considerations

This architecture is useful when:

- Many users query the same business data.
- Data volume or query load exceeds local databases.
- The team wants managed infrastructure.
- BI dashboards need reliable performance.
- Governance and access control matter.

Design considerations:

- Partition large fact tables by date.
- Cluster or sort by common filter columns.
- Separate raw, warehouse, and mart schemas.
- Use incremental models for large datasets.
- Monitor long-running and expensive queries.
- Use materialized views or aggregate marts for common reports.

## Cost Considerations

Main cost drivers:

- Storage
- Compute or query scans
- Data ingestion jobs
- BI query patterns
- Cross-region transfer
- Always-on warehouse clusters where applicable

Cost controls:

- Use partition pruning.
- Avoid `SELECT *` dashboards.
- Schedule workloads instead of running constantly where possible.
- Set warehouse auto-suspend or serverless budgets.
- Build narrow marts for frequent dashboards.
- Monitor cost by project, dataset, user, or workload.

## Security Considerations

Security requirements:

- Use least-privilege IAM.
- Separate admin, engineer, analyst, and BI roles.
- Encrypt storage and warehouse data.
- Mask or restrict PII.
- Use private networking where required.
- Rotate credentials and avoid static keys.
- Audit access to sensitive datasets.
- Separate development and production environments.

## Expected Output

Expected deliverables:

- Cloud warehouse architecture plan
- Ingestion and transformation design
- Raw, warehouse, and mart table model
- Data quality check plan
- Cost control plan
- IAM and security plan
- Dashboard-ready marts

Business questions answered:

- What is company-wide daily revenue?
- Which channels or stores are growing fastest?
- Which products need reorder?
- Which customers are most valuable?
- Are dashboards fresh and trustworthy?
- What is the monthly warehouse cost?

## Future Improvements

- Add dbt CI/CD.
- Add data contracts with source teams.
- Add source freshness alerting.
- Add automated backfill workflows.
- Add semantic layer metrics.
- Add row-level security by region or department.
- Add FinOps dashboards for warehouse cost.

## Useful When

Use this architecture when the business needs governed analytics, scalable BI, many users, and managed infrastructure.

## Overkill When

This is overkill for a single analyst, small CSV files, or a few simple reports. A local PostgreSQL warehouse or lightweight DuckDB workflow may be cheaper and faster to maintain.

## Related Concepts

- [Cloud Fundamentals](../../../13-cloud-data-engineering/cloud-fundamentals.md)
- [Warehouse Concepts](../../../06-data-warehousing/warehouse-concepts.md)
- [IAM And Security](../../../13-cloud-data-engineering/iam-and-security.md)
- [Cost Optimization](../../../13-cloud-data-engineering/cost-optimization.md)
