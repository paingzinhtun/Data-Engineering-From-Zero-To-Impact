# Vector Databases

## 1. What It Is

A vector database stores embeddings and supports similarity search. An embedding is a numeric representation of text, images, products, or other content.

Vector databases are often used in RAG systems, semantic search, recommendation, and AI assistant memory or knowledge retrieval.

## 2. Why It Matters

Traditional databases are good for exact filters and structured queries. Vector databases are useful when you need similarity search, such as finding documents with related meaning instead of exact keywords.

They matter for AI-ready Data Engineering because they require:

- Clean input text.
- Stable IDs.
- Metadata.
- Refresh logic.
- Access control.
- Evaluation.
- Deletion and update handling.

## 3. When to Use It

Use a vector database when:

- Users ask natural-language questions over documents.
- Search should find semantically similar content.
- A RAG system needs retrieval.
- Product descriptions, policies, or support articles need semantic search.
- Metadata filters are needed with similarity search.

Do not use a vector database for simple structured questions that SQL handles better, such as total revenue or current inventory by product.

## 4. Real Business Example

A stationery retailer has product descriptions, return policies, supplier rules, and support FAQs.

A vector database can help an assistant retrieve relevant chunks when a store employee asks:

- Can this item be returned?
- How should this product be stored?
- What is the supplier reorder policy?

For questions like "Which products have high stock but low sales?", the assistant should query structured warehouse data instead.

## 5. Technical Example

Vector record:

```json
{
  "id": "faq-returns-001",
  "embedding": [0.012, -0.045, 0.091],
  "metadata": {
    "document_id": "returns-faq",
    "document_type": "faq",
    "access_level": "internal",
    "updated_at": "2026-01-15"
  },
  "text": "Customers can return unopened stationery within 14 days..."
}
```

Retrieval flow:

```text
user question
  -> create question embedding
  -> vector similarity search
  -> filter by metadata and permissions
  -> return top relevant chunks
  -> AI model generates answer with context
```

## 6. Production Considerations

- Store stable IDs for chunks.
- Include useful metadata.
- Apply permission filters at retrieval time.
- Refresh embeddings when source text changes.
- Delete or expire outdated content.
- Evaluate retrieval quality.
- Monitor index freshness.
- Keep source references for citations or audit.

## 7. Common Mistakes

- Storing embeddings without source metadata.
- Ignoring access control.
- Not updating vectors when documents change.
- Mixing unrelated domains in one index.
- Assuming vector search replaces SQL.
- Not evaluating retrieval accuracy.
- Losing the mapping between chunk and source document.
- Keeping outdated policy content searchable.

## 8. Practice Task

Design a vector index for retail product and policy content.

Define:

1. Content sources.
2. Chunk IDs.
3. Metadata fields.
4. Access rules.
5. Refresh process.
6. Deletion process.
7. Evaluation queries.
8. Questions that should use SQL instead.

## 9. Related Project

- `15-ai-ready-data-engineering/rag-data-pipelines.md`: Vector databases are part of RAG pipelines.
- `15-ai-ready-data-engineering/document-ingestion.md`: Good chunks make better vector search.
- `15-ai-ready-data-engineering/ai-data-project/`: Business assistants may combine SQL and vector retrieval.
