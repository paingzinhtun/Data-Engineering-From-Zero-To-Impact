# 11 - Streaming Data

## What This Section Covers

This section covers event-driven data, producers, consumers, queues, streams, ordering, delivery guarantees, duplicate handling, latency, windowing, and real-time analytics use cases.

## Why It Matters In Data Engineering

Some business problems need fresh data quickly: inventory changes, payments, user events, logistics updates, alerts, and operational monitoring. Streaming systems help process data continuously, but they also introduce reliability and complexity tradeoffs.

## What You Should Be Able To Do

After studying this section, you should be able to:

- Explain the difference between batch and streaming.
- Describe events, producers, consumers, and topics.
- Handle duplicate or late-arriving events conceptually.
- Understand basic latency and throughput tradeoffs.
- Identify when streaming is worth the added complexity.
- Design a simple event-driven data flow.

## Related Projects In This Repo

- `17-projects/`: Order event, inventory event, and operational alerting projects.
- `14-production-engineering/`: Reliability patterns for running streaming systems.

## Start Here

Recommended order:

1. [streaming-concepts.md](streaming-concepts.md)
2. [kafka-basics.md](kafka-basics.md)
3. [producers-consumers-topics.md](producers-consumers-topics.md)
4. [event-time-vs-processing-time.md](event-time-vs-processing-time.md)
5. [structured-streaming.md](structured-streaming.md)
6. [streaming-project/](streaming-project/)

Project: [Kafka Streaming Sales Events](../17-projects/advanced/03-kafka-streaming-sales-events/)

## Navigation

Previous: [10 - Big Data Processing](../10-big-data-processing/)  
Next: [12 - Data Quality Testing Observability](../12-data-quality-testing-observability/)
