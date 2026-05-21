# AI Agent Data Access

## 1. What It Is

AI agent data access is the design of safe, governed ways for AI systems to query databases, APIs, documents, and business tools.

An AI agent should not receive unrestricted access to production systems. It should use controlled interfaces such as semantic layers, read-only APIs, approved SQL templates, and permission-aware retrieval.

## 2. Why It Matters

AI assistants can help business users ask questions in natural language, but they can also create risk if they access sensitive data, run expensive queries, misunderstand metrics, or take unsafe actions.

Data Engineers help by providing:

- Governed data APIs.
- Semantic layers.
- Read-only access.
- Query limits.
- Audit logs.
- Access control.
- Metric definitions.
- Safe tool boundaries.

## 3. When to Use It

Use governed AI agent access when:

- An assistant answers business questions from databases.
- AI tools query warehouse tables.
- Agents retrieve documents based on permissions.
- Users ask operational questions in natural language.
- Business data includes sensitive fields.
- Answers need lineage or source references.

Do not connect an AI assistant directly to unrestricted production databases.

## 4. Real Business Example

A retail manager asks:

- Which products should I reorder?
- Why did sales drop?
- Which products have high stock but low sales?

The AI assistant should query approved marts or APIs, not raw tables with sensitive customer data.

The assistant may use a semantic layer that defines revenue, stock level, reorder threshold, and slow-moving products consistently.

## 5. Technical Example

Safe architecture:

```text
business database
  -> semantic layer
  -> read-only data API
  -> AI assistant
  -> business answer with source references
```

Example API response:

```json
{
  "question": "Which products should I reorder?",
  "data_source": "mart_inventory_reorder",
  "results": [
    {
      "product_id": "P-100",
      "product_name": "A5 Notebook",
      "quantity_on_hand": 8,
      "reorder_level": 20,
      "recommended_action": "reorder"
    }
  ]
}
```

Guardrails:

```text
read-only access
approved tables only
row limits
cost limits
permission filters
query logging
no destructive actions
```

## 6. Production Considerations

- Use read-only access by default.
- Restrict tables and columns.
- Hide or mask sensitive fields.
- Use semantic definitions for metrics.
- Log questions and queries.
- Apply row and cost limits.
- Validate generated SQL before execution.
- Provide source references.
- Monitor hallucinated or unsupported answers.

## 7. Common Mistakes

- Giving AI unrestricted database credentials.
- Letting agents run write or delete commands.
- Exposing sensitive customer fields.
- Allowing expensive unbounded queries.
- Not defining metrics.
- Not logging AI data access.
- Trusting generated SQL without validation.
- Mixing document retrieval and structured analytics without clear routing.

## 8. Practice Task

Design safe AI data access for a retail assistant.

Define:

1. Approved datasets.
2. Blocked datasets.
3. Sensitive columns.
4. Semantic metrics.
5. Data API endpoints.
6. Query limits.
7. Access logging.
8. Example questions and allowed answer sources.

## 9. Related Project

- `15-ai-ready-data-engineering/ai-data-project/`: AI Business Data Assistant.
- `13-cloud-data-engineering/iam-and-security.md`: IAM principles apply to AI access.
- `04-data-modeling/metric-definitions.md`: Semantic layers depend on clear metrics.
