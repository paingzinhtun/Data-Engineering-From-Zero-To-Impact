# AI Business Analytics Assistant

## 1. Business Problem

Business users often need answers faster than analysts or engineers can provide them. They ask questions such as "Why did sales drop?", "Which products should I reorder?", or "Which customers are at risk?". Dashboards help, but they do not cover every question.

At the same time, giving AI direct access to raw databases is risky. It may use the wrong tables, expose sensitive data, generate incorrect SQL, or answer without understanding metric definitions.

This capstone builds a governed AI analytics assistant that answers business questions using approved metrics, trusted marts, documents, and controlled data access.

## 2. Target Users

Primary users:

- Business owner
- Operations manager
- Inventory manager
- Sales manager
- Finance analyst

Secondary users:

- Data analyst
- Data engineer
- BI developer
- Compliance or governance reviewer

## 3. System Goal

Build an AI assistant that can answer practical business questions from trusted data while respecting access control, metric definitions, and source traceability.

Core goals:

- Answer natural language business questions.
- Use approved marts and metrics.
- Retrieve relevant business documents.
- Cite sources or tables used.
- Avoid exposing sensitive data.
- Log AI interactions for review.

## 4. Architecture

```text
Warehouse marts, metric definitions, policies, business documents
  -> semantic layer
  -> document ingestion and chunking
  -> vector database
  -> governed data API
  -> AI assistant
  -> cited business answers
```

Core components:

- Analytics warehouse
- Semantic layer or metric registry
- Document ingestion pipeline
- Embedding and vector search
- Controlled SQL or metric API
- AI response layer
- Audit and evaluation tables

Recommended implementation phases:

- Phase 1: Define approved business questions and marts.
- Phase 2: Build a semantic metric lookup.
- Phase 3: Add document ingestion and retrieval.
- Phase 4: Add controlled SQL or API access.
- Phase 5: Add assistant interface and evaluation.

## 5. Data Sources

Structured sources:

- `mart_daily_sales`
- `mart_product_performance`
- `mart_inventory_reorder`
- `mart_customer_value`
- `mart_supplier_performance`

Metadata sources:

- Metric definitions
- Table descriptions
- Column descriptions
- Data freshness records
- Data owner records

Document sources:

- Business policies
- Supplier terms
- Product notes
- Dashboard documentation
- SOPs
- Meeting notes
- Data dictionary

## 6. Data Model

Suggested schemas:

- `mart`: trusted business outputs
- `semantic`: approved metrics and business definitions
- `ai`: document chunks, embeddings, retrieval logs
- `audit`: AI query and response logs

Suggested tables:

- `semantic.metrics`
- `semantic.business_terms`
- `semantic.approved_questions`
- `ai.document_sources`
- `ai.document_chunks`
- `ai.chunk_embeddings`
- `ai.retrieval_events`
- `audit.ai_query_log`
- `audit.generated_sql_log`
- `audit.answer_evaluation`

Important fields:

- `metric_name`
- `business_definition`
- `calculation_sql`
- `approved_table`
- `sensitivity_level`
- `document_source`
- `chunk_text`
- `metadata`
- `user_role`
- `query_text`
- `retrieved_sources`
- `answer_text`

## 7. Pipelines

Required pipelines:

- Metric definition ingestion
- Data mart freshness validation
- Document ingestion
- Document chunking
- Embedding generation
- Vector index refresh
- AI query logging
- Evaluation question runner

Question-answer flow:

1. User asks a business question.
2. System classifies the question type.
3. System checks user permissions.
4. System retrieves relevant metrics, tables, or document chunks.
5. System queries approved marts through an API or controlled SQL layer.
6. Assistant generates an answer with source references.
7. System logs the question, sources, SQL, and answer.
8. Evaluation checks can compare output against expected answers.

## 8. Data Quality Strategy

Structured data quality:

- Approved marts are fresh.
- Metric definitions exist for exposed metrics.
- Required marts pass quality checks.
- SQL outputs reconcile to dashboard metrics.

Document quality:

- Documents have source, owner, date, and access metadata.
- Chunks are not empty.
- Chunks are within expected size.
- Restricted documents are not indexed for unauthorized users.

AI quality:

- Answers cite sources.
- Generated SQL uses approved tables only.
- Sensitive columns are not exposed.
- Known questions produce expected answers.
- Low-confidence answers ask for clarification or escalate.

## 9. Dashboards or Outputs

Primary output:

- AI business analytics assistant interface

Supporting outputs:

- Approved metrics catalog
- Business glossary
- Source citation view
- AI query audit dashboard
- Data freshness dashboard
- Answer evaluation report

Example questions:

- Which products should I reorder?
- Why did sales drop last week?
- Which products have high stock but low sales?
- Which customer segment is most profitable?
- What supplier terms apply to office paper?
- Is today's sales dashboard fresh?

## 10. AI/Automation Features

Core features:

- Natural language business question answering
- Metric lookup
- Document retrieval
- Source-cited responses
- Role-aware data access
- Generated SQL review log

Advanced features:

- Automated weekly performance narrative
- Reorder explanation assistant
- Anomaly explanation assistant
- Draft action recommendations
- Follow-up question memory within a session
- Human review workflow for high-impact actions

Guardrails:

- Do not let AI query raw tables directly.
- Do not allow unrestricted SQL execution.
- Do not return sensitive customer or finance fields without permission.
- Include source references.
- Log all actions.

## 11. Production Requirements

Minimum requirements:

- Approved data access layer
- Environment-based configuration
- Secret management
- Data quality checks before AI access
- Retrieval metadata
- Query and response logging
- Error handling
- Evaluation test set
- Documentation for supported questions

Operational requirements:

- Monitor answer failures.
- Monitor stale data access.
- Review generated SQL.
- Track user feedback.
- Add runbooks for bad answers or security incidents.
- Keep prompt and retrieval logic versioned.

## 12. Security and Governance

Security requirements:

- Role-based access control
- Sensitive field masking
- Document-level permissions
- Approved views instead of raw tables
- Prompt and response logging without secrets
- Secure credential storage
- Audit logs for AI-generated queries

Governance requirements:

- Metric ownership
- Business glossary
- Approved question list
- Human review for high-impact decisions
- Model and prompt versioning
- Evaluation records
- Clear limitations for users

## 13. Cost and Scalability

Cost drivers:

- LLM calls
- Embedding generation
- Vector database storage
- Warehouse queries
- Document reprocessing
- Evaluation jobs

Cost controls:

- Cache common metric answers.
- Embed only useful documents.
- Re-embed changed documents only.
- Use metadata filters before vector search.
- Limit query result size.
- Use smaller models for routing and classification.
- Monitor cost per user and use case.

Scalability considerations:

- Separate document retrieval from metric querying.
- Partition vector indexes by domain or access group.
- Use async processing for document ingestion.
- Rate limit expensive requests.
- Add fallback answers when data is stale.

## 14. Skills Demonstrated

This capstone demonstrates:

- AI-ready data architecture
- Semantic layer design
- RAG pipeline design
- Vector database modeling
- Governed data API design
- Data quality for AI systems
- Security and access control
- Audit logging
- Evaluation strategy
- Business communication

## 15. Portfolio Presentation Guide

Present this as a governed AI data product, not a chatbot demo.

Include:

- Business problem and supported questions
- Architecture diagram
- Semantic layer design
- Document ingestion flow
- Access control model
- Example assistant answers with citations
- AI quality and evaluation approach
- Security and governance tradeoffs
- Cost controls

Suggested project story:

"I built an AI business analytics assistant that answers retail operations questions using approved metrics, trusted marts, document retrieval, source citations, and governed data access."

## 16. Future Improvements

Possible improvements:

- Add fine-grained row-level permissions.
- Add dashboard-aware answer generation.
- Add business glossary synchronization.
- Add anomaly detection integration.
- Add action workflow for reorder approvals.
- Add feedback-based evaluation.
- Add multi-tenant support for consultants.
- Add source freshness warnings in every answer.

## Related Concepts

- [Data Engineering For AI](../../../15-ai-ready-data-engineering/data-engineering-for-ai.md)
- [Document Ingestion](../../../15-ai-ready-data-engineering/document-ingestion.md)
- [AI Agent Data Access](../../../15-ai-ready-data-engineering/ai-agent-data-access.md)
- [AI Business Data Assistant](../../../15-ai-ready-data-engineering/ai-data-project/)
