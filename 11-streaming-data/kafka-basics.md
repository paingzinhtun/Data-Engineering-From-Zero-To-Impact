# Kafka Basics

## 1. What It Is

Apache Kafka is a distributed event streaming platform. It stores streams of events in topics so producers can write events and consumers can read them.

Kafka is commonly used as the event backbone between operational systems, stream processors, analytics systems, and downstream applications.

## 2. Why It Matters

Kafka helps decouple systems. A POS system can publish sales events once, and multiple consumers can independently use those events for dashboards, alerts, inventory updates, or analytics.

Kafka matters because it supports:

- High-throughput event ingestion.
- Durable event storage.
- Multiple independent consumers.
- Partitioned parallel processing.
- Replay from stored offsets.
- Event-driven architecture.

## 3. When to Use It

Use Kafka when:

- Multiple systems need the same event stream.
- Events are continuous and high volume.
- Consumers need independent processing.
- Replay is useful.
- Systems should be decoupled.
- Streaming infrastructure is justified by the business need.

Kafka is overkill when a simple queue, database table, webhook, or batch file solves the problem.

## 4. Real Business Example

A retail business publishes POS sales to a Kafka topic named `retail.sales.completed`.

Different consumers use the topic:

- Dashboard consumer updates real-time revenue.
- Inventory consumer updates stock estimates.
- Alert consumer detects unusually high sales.
- Data lake consumer stores raw events.

Each consumer can process the same events without requiring the POS system to know every downstream use case.

## 5. Technical Example

Kafka concepts:

```text
topic: named event stream
partition: ordered subset of a topic
offset: event position in a partition
producer: writes events to topics
consumer: reads events from topics
consumer group: group of consumers sharing work
```

Topic with partitions:

```text
retail.sales.completed
  partition 0: offset 0, 1, 2, ...
  partition 1: offset 0, 1, 2, ...
  partition 2: offset 0, 1, 2, ...
```

Event key idea:

```text
key = store_id or product_id
value = sale event JSON
```

Keys can influence which partition receives an event, which affects ordering for related events.

## 6. Production Considerations

- Choose topic names clearly.
- Define event schemas and compatibility rules.
- Choose partition keys carefully.
- Monitor consumer lag.
- Plan topic retention.
- Secure access to topics.
- Handle poison messages or invalid events.
- Understand delivery semantics.
- Keep producers and consumers observable.

## 7. Common Mistakes

- Creating topics without naming standards.
- Choosing poor partition keys.
- Assuming global event ordering across all partitions.
- Not monitoring consumer lag.
- Ignoring schema evolution.
- Storing sensitive data without controls.
- Using Kafka as a database replacement.
- Adding Kafka when a simpler integration is enough.

## 8. Practice Task

Design Kafka topics for a retail business.

Define:

1. Sales completed topic.
2. Inventory changed topic.
3. Customer signup topic.
4. Event key for each topic.
5. Expected consumers.
6. Retention period.
7. Sensitive fields.
8. Monitoring needs.

## 9. Related Project

- `11-streaming-data/streaming-project/`: Uses Kafka as the event topic layer.
- `11-streaming-data/producers-consumers-topics.md`: Explains producer and consumer roles in more detail.
- `13-cloud-data-engineering/`: Managed Kafka-like services are common in cloud data platforms.
