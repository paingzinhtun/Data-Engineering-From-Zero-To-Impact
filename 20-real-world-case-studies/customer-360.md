# Customer 360

## 1. Business Context

A retail or ecommerce business has customer data across sales, loyalty, marketing, support, and website systems. Teams want to understand customer value, repeat behavior, preferences, and retention risk, but the data is fragmented.

A Customer 360 system creates a unified, analytics-ready view of customers.

## 2. Problem

Current customer analytics problems:

- Customer records are duplicated across systems.
- Sales, support, and marketing activity are not connected.
- Customer value is calculated inconsistently.
- Teams cannot identify repeat customers or at-risk customers easily.
- Personalized campaigns are based on incomplete data.

## 3. Data Sources

Required sources:

- Customer master list
- Sales transactions
- Ecommerce orders
- Loyalty records

Optional sources:

- Email campaign interactions
- Website events
- Customer support tickets
- Returns and refunds
- Survey responses

Key fields:

- `customer_id`
- `email_hash`
- `phone_hash`
- `first_purchase_date`
- `last_purchase_date`
- `order_count`
- `net_sales`
- `gross_profit`
- `loyalty_status`
- `support_ticket_count`

## 4. Architecture

```text
Sales, ecommerce, CRM, loyalty, support, marketing
  -> ingestion pipelines
  -> raw customer activity tables
  -> identity resolution and staging
  -> customer dimension and activity facts
  -> customer 360 mart
  -> dashboards, segments, and activation lists
```

Recommended approach:

- Start with deterministic matching using known customer IDs or hashed email.
- Add more complex matching only when the business needs it.

## 5. Data Model

Core dimensions:

- `dim_customer`
- `dim_date`
- `dim_channel`

Facts:

- `fact_sales`
- `fact_customer_interaction`
- `fact_support_ticket`
- `fact_marketing_event`

Marts:

- `mart_customer_360`
- `mart_customer_value`
- `mart_customer_retention`
- `mart_customer_segments`

Grain:

- `mart_customer_360`: one row per customer
- `fact_customer_interaction`: one row per customer interaction event

## 6. Pipeline Design

1. Ingest customer, sales, loyalty, and interaction data.
2. Standardize IDs, emails, phone numbers, dates, and channel values.
3. Deduplicate customer records.
4. Connect customer activity across systems.
5. Calculate customer metrics.
6. Assign customer segments.
7. Publish customer 360 mart and segment outputs.
8. Run privacy and quality checks.

## 7. Data Quality Strategy

Critical checks:

- Customer IDs are not null in customer master.
- Duplicate customer records are identified.
- Sales customer references resolve where expected.
- Email and phone fields are masked or hashed when needed.
- Customer metrics reconcile to sales facts.

Business checks:

- Last purchase date is not before first purchase date.
- Order count matches sales history.
- Customer lifetime value is not negative unless returns exceed purchases.

## 8. Key Metrics

- Total customers
- New customers
- Repeat customer rate
- First purchase date
- Last purchase date
- Order count
- Average order value
- Customer lifetime value estimate
- Gross profit by customer
- Days since last purchase
- Segment membership

## 9. Dashboard or Output

Recommended outputs:

- Customer 360 table
- Customer value dashboard
- Retention dashboard
- Segment export for marketing
- At-risk customer list

Example questions:

- Who are our most valuable customers?
- Which customers have not purchased recently?
- Which segments buy high-margin products?
- Which customers generate many support issues?
- Which customers should receive a retention offer?

## 10. AI/Automation Extension

Useful extensions:

- Generate customer segment summaries.
- Create personalized campaign suggestions.
- Explain why a customer is marked at risk.
- Build an AI assistant for customer performance questions.
- Draft outreach lists based on approved segments.

Governance note:

- Customer data is sensitive. AI access must respect privacy, consent, and role-based permissions.

## 11. Business Impact

Expected impact:

- Improves customer retention decisions.
- Helps marketing target better segments.
- Gives sales and support teams a shared customer view.
- Reduces duplicate customer records.
- Connects customer value to product and channel strategy.

## 12. Implementation Plan

Phase 1:

- Build customer master, sales history, and customer value mart.

Phase 2:

- Add loyalty, support, and marketing events.

Phase 3:

- Add segmentation and retention outputs.

Phase 4:

- Add AI summaries and campaign recommendations.

## 13. Risks and Tradeoffs

Risks:

- Identity matching can be wrong.
- Privacy requirements may restrict use.
- Marketing data may be incomplete.
- Returns and refunds can distort value metrics.

Tradeoffs:

- Deterministic matching is safer but may miss matches.
- Probabilistic matching improves coverage but creates false-match risk.
- Start with transparent segmentation before using advanced ML.

## 14. Related Projects

- `16-business-use-cases/customer-analytics/`
- `17-projects/capstone/retail-intelligence-platform/`
- `17-projects/capstone/sme-data-platform/`
- `15-ai-ready-data-engineering/`
