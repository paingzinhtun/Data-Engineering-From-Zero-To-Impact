# Advanced Projects

Advanced projects focus on systems that become useful when data volume, velocity, governance, reliability, or AI use cases exceed what a simple database pipeline can handle.

These projects are intentionally architecture-first. Learners should be able to explain not only how the system works, but why the architecture is justified, what it costs, what risks it introduces, and when a simpler design would be better.

## Projects

| Project | Focus | Best For |
| --- | --- | --- |
| `01-lakehouse-bronze-silver-gold` | Lakehouse architecture and layered data design | Mixed structured, semi-structured, analytics, and ML workloads |
| `02-pyspark-batch-processing` | Distributed batch processing | Large files, heavy transformations, and partitioned data |
| `03-kafka-streaming-sales-events` | Real-time event streaming | Live sales alerts, operational dashboards, and event-driven workflows |
| `04-cloud-warehouse-pipeline` | Managed cloud analytics platform | Scalable BI, governed marts, and cloud-native operations |
| `05-ai-ready-data-platform` | AI-ready data access and governance | Business assistants, RAG, semantic layers, and controlled AI querying |

## Portfolio Standard

Each advanced project should eventually include:

- A clear business case for advanced architecture
- Architecture diagram or Mermaid diagram
- Source data simulation
- Data model documentation
- Pipeline implementation
- Quality and observability checks
- Cost and security notes
- Runbook for failures and backfills
- Explanation of when the design is overkill
