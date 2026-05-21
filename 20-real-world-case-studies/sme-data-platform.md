# SME Data Platform

## 1. Business Context

A small or mid-sized business wants better reporting across sales, customers, inventory, finance, and operations. The company has useful data, but it is scattered across spreadsheets, accounting exports, ecommerce tools, and manual reports.

The business needs a practical data platform that is affordable, maintainable, and focused on decisions.

## 2. Problem

Current problems:

- Reports are assembled manually.
- KPI definitions are inconsistent.
- Business users do not trust monthly numbers.
- Data lives in multiple spreadsheets.
- There is no clear owner for each dataset.
- Automation feels too expensive or complex.

## 3. Data Sources

Common sources:

- Sales exports
- Accounting files
- Customer lists
- Product or service catalog
- Inventory files
- Supplier files
- Ecommerce orders
- Marketing campaign exports

Priority domains:

- Revenue
- Costs
- Customers
- Products or services
- Inventory or operations
- Cashflow

## 4. Architecture

```text
Spreadsheets, SaaS exports, accounting files, APIs
  -> simple ingestion process
  -> PostgreSQL or DuckDB
  -> cleaned staging tables
  -> KPI marts
  -> dashboards and scheduled reports
```

Recommended architecture:

- Start with local files and PostgreSQL or DuckDB.
- Use Python for repeatable ingestion.
- Use SQL for transformations.
- Add dashboards only after metrics are defined.
- Move to cloud only when collaboration, scale, or availability requires it.

## 5. Data Model

Suggested schemas:

- `raw`
- `staging`
- `mart`
- `audit`

Suggested marts:

- `mart_monthly_revenue`
- `mart_profitability`
- `mart_customer_summary`
- `mart_product_performance`
- `mart_inventory_position`
- `mart_cashflow_summary`

Core metrics:

- Revenue
- Gross profit
- Expenses
- Net profit estimate
- Average order value
- Repeat customer rate
- Inventory value
- Stockout risk

## 6. Pipeline Design

1. Collect source files in a standard folder.
2. Validate file names, columns, and row counts.
3. Load raw data.
4. Clean dates, IDs, names, and numeric fields.
5. Build KPI marts.
6. Reconcile key totals to source reports.
7. Publish dashboards or spreadsheet exports.
8. Log run time, row counts, and failed checks.

## 7. Data Quality Strategy

SME-focused checks:

- Required files exist.
- Required columns exist.
- Duplicate invoices or orders are flagged.
- Revenue and cost fields are reasonable.
- Dates are valid.
- Product and customer IDs are consistent.
- Monthly totals reconcile to accounting or sales exports.
- Reports show last refresh time.

Quality principle:

> Start with the few checks that protect the most important business decisions.

## 8. Key Metrics

- Monthly revenue
- Monthly gross profit
- Expense by category
- Net profit estimate
- Top customers
- Top products or services
- Repeat customer rate
- Inventory value
- Slow-moving stock
- Cashflow summary

## 9. Dashboard or Output

Recommended outputs:

- Owner KPI dashboard
- Monthly management report
- Revenue and profit report
- Customer summary
- Product or service performance report
- Inventory attention list

Example questions:

- What changed this month?
- Which products or services are most profitable?
- Which customers drive the most revenue?
- Are expenses growing faster than revenue?
- Which operational issues need attention?

## 10. AI/Automation Extension

Useful extensions:

- Weekly KPI summary email.
- AI-generated management report draft.
- Natural language questions over KPI marts.
- Late file reminders.
- Anomaly explanations for revenue or expense changes.

Guardrail:

- AI should use approved KPI marts and cite sources. It should not access sensitive finance or customer data without permission.

## 11. Business Impact

Expected impact:

- Reduces manual reporting time.
- Gives owners consistent KPIs.
- Improves visibility into profit and operations.
- Supports better customer and product decisions.
- Creates a foundation for future automation.

## 12. Implementation Plan

Phase 1:

- Identify 3 to 5 core business questions.
- Create source folder and data dictionary.

Phase 2:

- Build raw and staging tables.
- Add quality checks.

Phase 3:

- Build KPI marts and dashboards.

Phase 4:

- Add scheduled runs and management report automation.

Phase 5:

- Add AI summaries or natural language access.

## 13. Risks and Tradeoffs

Risks:

- Source spreadsheets may be manually edited.
- Business definitions may be unclear.
- Owners may expect automation before data is clean.
- Sensitive finance and customer data require access control.

Tradeoffs:

- Simple batch pipelines are better than complex platforms for most SMEs.
- Cloud services may help collaboration but add cost and administration.
- AI is useful only after trusted metrics and data quality exist.

## 14. Related Projects

- `17-projects/capstone/sme-data-platform/`
- `18-templates/readme-template.md`
- `18-templates/project-checklist-template.md`
- `16-business-use-cases/sme-operations/`
