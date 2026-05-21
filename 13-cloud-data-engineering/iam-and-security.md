# IAM And Security

## 1. What It Is

IAM means Identity and Access Management. It controls who or what can access cloud resources and what actions they can perform.

Cloud security also includes secrets management, encryption, network controls, audit logs, data classification, and least-privilege access.

## 2. Why It Matters

Data Engineering systems often handle sensitive business and customer data. Poor access control can expose private data, damage systems, or create compliance issues.

IAM and security matter because they protect:

- Customer records.
- Sales and finance data.
- API credentials.
- Warehouse tables.
- Raw source files.
- Production pipelines.
- Business trust.

## 3. When to Use It

Use IAM and security practices for every cloud data project, even small ones.

They are especially important when:

- Data includes customer or financial information.
- Pipelines write to production tables.
- Multiple users or services need access.
- Secrets are required.
- Data is shared across teams.
- Cloud resources are internet-accessible.

## 4. Real Business Example

A retail analytics warehouse contains customer purchase history.

The data engineering job needs permission to read raw files and write warehouse tables. Analysts need permission to read marts. Most users should not access raw customer email data.

Good IAM separates these responsibilities instead of giving everyone administrator access.

## 5. Technical Example

Least-privilege access:

```text
pipeline_service_account:
  can read raw sales files
  can write staging and mart tables
  cannot manage IAM users
  cannot delete unrelated storage buckets

analyst_role:
  can read business marts
  cannot read raw sensitive files
  cannot modify production tables
```

Secrets pattern:

```text
bad: database_password = "plaintext-password"
better: read password from managed secrets service or environment variable
```

Security layers:

```text
IAM permissions
network access
encryption
secrets management
audit logging
data masking or redaction
```

## 6. Production Considerations

- Apply least privilege.
- Use service accounts or managed identities for jobs.
- Store secrets in a secrets manager.
- Rotate credentials where appropriate.
- Enable audit logs.
- Encrypt sensitive data.
- Restrict public network access.
- Separate development and production access.
- Review permissions regularly.

## 7. Common Mistakes

- Giving administrator access to pipeline jobs.
- Sharing one credential across people and services.
- Hardcoding secrets in code.
- Storing customer data in public buckets.
- Not reviewing permissions after project changes.
- Giving analysts access to raw sensitive data by default.
- Ignoring audit logs.
- Treating security as something to add later.

## 8. Practice Task

Design IAM for a retail data platform.

Define:

1. Pipeline service account.
2. Analyst role.
3. Admin role.
4. Raw storage permissions.
5. Mart read permissions.
6. Secret access permissions.
7. Production write permissions.
8. Audit and review process.

## 9. Related Project

- `13-cloud-data-engineering/storage-compute-networking.md`: Security depends on infrastructure design.
- `14-production-engineering/`: Production systems require access control and operational review.
- `15-ai-ready-data-engineering/`: AI-ready datasets require privacy and governance.
