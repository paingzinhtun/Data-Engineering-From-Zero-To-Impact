# Project 05: AI-Ready Data Platform

## Business Problem

A retail or SME operations team wants to ask business questions in natural language, such as "Which products should I reorder?", "Why did sales drop last week?", or "Which products have high stock but low sales?".

The company has useful data in databases, documents, spreadsheets, dashboards, and policies, but it is not organized for safe AI access. Without governance, an AI assistant may produce wrong answers, expose sensitive data, or use inconsistent business definitions.

## System Goal

Design an AI-ready data platform that gives AI applications governed access to trusted business data, metrics, documents, and metadata.

The goal is not to replace the data warehouse. The goal is to prepare reliable data access patterns for AI assistants, RAG systems, and agentic workflows.

## Architecture

```text
Business databases, warehouse marts, documents, policies
  -> data quality and semantic layer
  -> document ingestion and metadata extraction
  -> vector database
  -> governed data API
  -> AI assistant or agent
  -> business answers with traceable sources
```

Core components:

- Trusted warehouse or marts
- Semantic layer for metrics
- Document ingestion pipeline
- Vector database for retrieval
- Data API for controlled SQL access
- Access control and audit logging
- AI assistant interface

## Tools

Possible tool choices:

- Warehouse: PostgreSQL, BigQuery, Snowflake, Redshift, or DuckDB
- Transformation: SQL, dbt, Python
- Semantic layer: dbt Semantic Layer, Cube, MetricFlow, or custom API
- Document parsing: Python, unstructured, cloud document services
- Vector database: pgvector, Pinecone, Weaviate, Qdrant, Milvus
- API: FastAPI or serverless functions
- Orchestration: Airflow, Dagster, or Prefect
- Observability: logs, quality checks, query audit tables

## Data Sources

Structured data:

- Sales facts
- Inventory snapshots
- Product dimensions
- Customer segments
- Supplier performance
- Promotion data
- Finance summaries

Unstructured or semi-structured data:

- Product manuals
- Supplier contracts
- Return policies
- Store operating procedures
- Business metric documentation
- Meeting notes and decision logs

Metadata:

- Table descriptions
- Column descriptions
- Metric definitions
- Data owner
- Freshness timestamp
- Sensitivity classification

## Pipeline Design

1. Identify business questions AI should answer.
2. Define trusted structured datasets and metrics.
3. Add data quality checks before AI access.
4. Build a semantic layer for approved metrics.
5. Ingest documents and split them into meaningful chunks.
6. Attach metadata such as source, owner, date, topic, and access level.
7. Generate embeddings and store chunks in a vector database.
8. Build a governed data API for AI tools.
9. Restrict AI queries by user role and approved data scope.
10. Log prompts, retrieved sources, generated SQL, and final answers.
11. Evaluate answer quality with test questions.

## Data Model

Suggested structured tables:

- `mart.daily_sales`
- `mart.product_performance`
- `mart.inventory_reorder`
- `mart.customer_value`
- `mart.supplier_performance`
- `semantic.metric_definitions`
- `audit.ai_queries`

Suggested document tables:

- `ai.document_sources`
- `ai.document_chunks`
- `ai.chunk_embeddings`
- `ai.retrieval_logs`

Suggested API concepts:

- Approved metric endpoint
- Product search endpoint
- Reorder recommendation endpoint
- Safe SQL query endpoint
- Source citation endpoint

## Quality Checks

Structured data checks:

- Metrics are fresh.
- Primary keys are unique.
- Required business fields are not null.
- Revenue and quantity values are reasonable.
- Metric definitions are documented.

Document checks:

- Documents have source metadata.
- Chunks are not empty.
- Chunk size is within expected range.
- Restricted documents are classified.
- Embeddings exist for searchable chunks.

AI-specific checks:

- Answers cite source tables or documents.
- Generated SQL uses approved tables.
- User role is checked before retrieval or SQL execution.
- Sensitive fields are not returned.
- Known test questions produce expected answers.

## Scalability Considerations

This architecture is useful when:

- Many users need natural language access to business data.
- Business definitions must remain consistent.
- AI needs both structured metrics and document knowledge.
- Access control and auditability matter.
- AI answers must cite sources.

Design considerations:

- Cache frequent metric results.
- Separate retrieval for documents and structured data.
- Keep vector indexes scoped by domain or permission group.
- Use metadata filters before semantic search.
- Limit generated SQL to approved tables or views.
- Add evaluation sets for answer quality.
- Monitor latency and retrieval quality.

## Cost Considerations

Main cost drivers:

- Embedding generation
- Vector database storage and search
- LLM calls
- Warehouse queries triggered by AI
- Document reprocessing
- Monitoring and evaluation jobs

Cost controls:

- Chunk documents carefully.
- Embed only useful documents.
- Re-embed only changed content.
- Cache common answers and metric queries.
- Use smaller models for classification and routing when appropriate.
- Limit AI query scope and result size.
- Monitor cost per user and use case.

## Security Considerations

Security requirements:

- Enforce user-level or role-level access.
- Do not expose raw sensitive data to AI by default.
- Mask PII before indexing or retrieval.
- Avoid storing secrets in prompts or logs.
- Audit generated SQL and retrieved documents.
- Use approved views instead of direct table access.
- Apply document-level permissions in retrieval.
- Keep human review for high-impact operational actions.

## Expected Output

Expected deliverables:

- AI-ready data architecture
- Semantic layer or approved metric definitions
- Document ingestion and chunking design
- Vector database schema
- Governed data API design
- AI query audit model
- Example business assistant questions and expected answers

Example questions:

- Which products should I reorder this week?
- Why did sales drop last month?
- Which products have high stock but low sales?
- Which customer segment is most profitable?
- What policy explains supplier return terms?
- Which source supports this answer?

## Future Improvements

- Add role-aware retrieval.
- Add SQL generation guardrails.
- Add automated answer evaluation.
- Add business glossary integration.
- Add feedback loop from users.
- Add agent workflows for draft purchase orders.
- Add anomaly explanations from metrics and documents.
- Add source freshness warnings in AI responses.

## Useful When

Use this architecture when the organization wants AI assistants or agents to answer business questions from trusted structured data and documents with governance, traceability, and access control.

## Overkill When

This is overkill if the business only needs static dashboards or a few manual reports. AI-ready platforms require careful governance, evaluation, security, and cost controls. Build reliable marts and metric definitions first.

## Related Concepts

- [Data Engineering For AI](../../../15-ai-ready-data-engineering/data-engineering-for-ai.md)
- [RAG Data Pipelines](../../../15-ai-ready-data-engineering/rag-data-pipelines.md)
- [Vector Databases](../../../15-ai-ready-data-engineering/vector-databases.md)
- [AI Agent Data Access](../../../15-ai-ready-data-engineering/ai-agent-data-access.md)
