# SME Data Platform

## 1. Business Problem

Many small and mid-sized enterprises want better data but cannot justify complex enterprise platforms. Their data is usually spread across accounting exports, sales spreadsheets, inventory files, CRM lists, ecommerce platforms, and operational tools.

The business needs a practical, low-cost data platform that improves reporting and decision-making without introducing unnecessary complexity.

This capstone focuses on building a maintainable data platform for real SME constraints: limited budget, small team, simple sources, and high need for business impact.

## 2. Target Users

Primary users:

- Business owner
- Operations manager
- Finance manager
- Sales manager
- Inventory manager

Secondary users:

- Data analyst
- Freelance data consultant
- Part-time data engineer
- Department leads

## 3. System Goal

Build a small business data platform that centralizes operational data, defines trusted metrics, automates recurring reports, and provides a path to future growth.

Core goals:

- Replace manual spreadsheet consolidation.
- Create reliable business metrics.
- Keep infrastructure simple and affordable.
- Make reporting repeatable.
- Support future automation and AI use cases.

## 4. Architecture

```text
Spreadsheets, SaaS exports, accounting files, ecommerce API
  -> file landing area
  -> Python ingestion
  -> PostgreSQL or DuckDB warehouse
  -> SQL marts
  -> dashboards and scheduled reports
```

Recommended architecture options:

- Local-first: CSV files, DuckDB, SQL, static reports
- Small production: PostgreSQL, Python, scheduled jobs, Metabase
- Cloud-light: object storage, serverless ingestion, managed warehouse

Start with the simplest architecture that solves the business problem.

## 5. Data Sources

Common SME sources:

- Sales CSV files
- Accounting exports
- Product or service catalog
- Inventory spreadsheet
- Customer list
- Supplier list
- Ecommerce orders
- Marketing campaign data
- Support tickets
- Manual operational logs

Priority source domains:

- Revenue
- Customers
- Products or services
- Inventory or operations
- Costs
- Payments

## 6. Data Model

Recommended schemas:

- `raw`
- `staging`
- `mart`
- `audit`

Suggested tables:

- `raw.sales`
- `raw.expenses`
- `raw.customers`
- `raw.products`
- `raw.inventory`
- `staging.stg_sales`
- `staging.stg_expenses`
- `mart.monthly_profitability`
- `mart.customer_summary`
- `mart.product_performance`
- `mart.cashflow_summary`
- `mart.inventory_position`
- `audit.pipeline_runs`

Core metrics:

- Revenue
- Gross profit
- Operating expense
- Net profit estimate
- Average order value
- Repeat customer rate
- Inventory value
- Stockout risk
- Customer lifetime value estimate

## 7. Pipelines

Recommended pipelines:

- Sales ingestion
- Expense ingestion
- Customer ingestion
- Product or service catalog ingestion
- Inventory ingestion
- Monthly finance summary
- KPI mart refresh
- Report export or dashboard refresh

Pipeline stages:

1. Collect files or API responses.
2. Validate source schema.
3. Load raw data.
4. Clean and standardize staging tables.
5. Build business marts.
6. Run quality checks.
7. Publish dashboards or reports.
8. Log run metadata.

## 8. Data Quality Strategy

SME-friendly quality checks:

- Required files exist.
- Required columns are present.
- Duplicate invoices or order IDs are flagged.
- Revenue and cost values are not negative unless expected.
- Dates are valid.
- Customer IDs are consistent.
- Product IDs are consistent.
- Monthly totals reconcile to source reports.
- Dashboard freshness is visible.

Practical approach:

- Start with a small number of high-value checks.
- Make failures understandable to non-technical users.
- Keep a rejected records table.
- Document manual corrections.

## 9. Dashboards or Outputs

Recommended dashboards:

- Executive KPI dashboard
- Monthly revenue and profit dashboard
- Customer performance dashboard
- Product or service performance dashboard
- Inventory and operations dashboard
- Cashflow summary

Useful outputs:

- Daily or weekly management report
- Monthly finance summary
- Slow-moving inventory list
- Top customer list
- Sales by channel report
- Expense category report

Example business questions:

- What were sales and profit this month?
- Which customers are most valuable?
- Which products or services drive margin?
- Which expenses are increasing?
- Which inventory items need attention?
- Are reports based on complete data?

## 10. AI/Automation Features

Useful automation:

- Scheduled weekly KPI email
- Late file alerts
- Automatic anomaly notes
- Customer follow-up list
- Inventory reorder reminders

AI features:

- Ask questions against approved marts.
- Generate plain-English KPI summaries.
- Explain changes in revenue or margin.
- Create draft management reports.
- Search policy or process documents.

Guardrails:

- Keep AI access limited to approved marts.
- Do not expose payroll, personal, or sensitive finance data without permission.
- Require source references for AI-generated explanations.

## 11. Production Requirements

Minimum requirements:

- Simple setup documentation
- Environment-based configuration
- Repeatable load process
- Data quality checks
- Clear folder structure
- Backup process
- Error logging
- Dashboard refresh schedule

Operational requirements:

- Non-technical users know where to place source files.
- Pipeline failures explain what action is needed.
- Reports show last refresh time.
- Changes to business metrics are documented.
- There is a recovery process for bad source files.

## 12. Security and Governance

Security requirements:

- Restrict access to finance and customer data.
- Store credentials outside code.
- Back up the database.
- Avoid emailing sensitive raw data.
- Use role-based access for dashboards.

Governance requirements:

- Define each KPI.
- Assign a business owner for each source file.
- Maintain a data dictionary.
- Document source refresh frequency.
- Track manual adjustments.
- Keep historical metric definitions when they change.

## 13. Cost and Scalability

Cost-first design:

- Use open-source tools where possible.
- Avoid cloud services until they solve a real problem.
- Prefer scheduled batch jobs over always-running infrastructure.
- Keep dashboards focused on key decisions.

Scaling path:

- DuckDB to PostgreSQL
- Local files to object storage
- Manual runs to scheduled orchestration
- SQL scripts to dbt
- Local dashboards to managed BI
- Basic reporting to AI-assisted analytics

Cost controls:

- Review unused dashboards.
- Archive old raw files.
- Avoid overbuilding pipelines for low-value sources.
- Automate only recurring reports with clear business value.

## 14. Skills Demonstrated

This capstone demonstrates:

- Practical architecture judgment
- SME business understanding
- Data ingestion
- SQL modeling
- KPI design
- Data quality
- Documentation
- Dashboard planning
- Cost-aware engineering
- Stakeholder communication

## 15. Portfolio Presentation Guide

Present this capstone as a realistic consulting-style project.

Include:

- SME problem statement
- Before and after reporting workflow
- Architecture diagram
- Data model
- KPI dictionary
- Example dashboards
- Quality checks
- Cost and scalability decisions
- Business impact summary

Suggested project story:

"I designed a low-cost SME data platform that consolidates sales, finance, customer, and inventory data into trusted KPI marts, replacing manual spreadsheet reporting with repeatable analytics."

## 16. Future Improvements

Possible improvements:

- Add accounting system API integration.
- Add ecommerce connector.
- Add dbt transformations.
- Add dashboard access control.
- Add automated weekly PDF or email reports.
- Add AI business summary generation.
- Add anomaly detection.
- Add cloud backup and disaster recovery.

## Related Concepts

- [SME Operations](../../../16-business-use-cases/sme-operations/)
- [Cloud Fundamentals](../../../13-cloud-data-engineering/cloud-fundamentals.md)
- [Production Checklist](../../../14-production-engineering/production-checklist.md)
- [SME Data Platform Case Study](../../../20-real-world-case-studies/sme-data-platform.md)
