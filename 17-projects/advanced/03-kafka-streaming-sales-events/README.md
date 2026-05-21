# Project 03: Kafka Streaming Sales Events

## Business Problem

A retail business wants to know what is happening in stores and online channels while it happens. Batch reports show yesterday's sales, but operations teams need live alerts for unusual sales drops, stockout risk, payment failures, and high-value purchases.

The business needs an event streaming pipeline for sales events that supports real-time dashboards and operational alerts.

## System Goal

Build a Kafka-based streaming pipeline that ingests POS or ecommerce sales events, processes them in near real time, stores them for analysis, and triggers alerts when business rules are met.

## Architecture

```text
POS or ecommerce application
  -> sales event producer
  -> Kafka topic
  -> stream processor
  -> real-time aggregates
  -> dashboard, alerting, warehouse, or lakehouse
```

Core event flow:

- Producer publishes sales events.
- Kafka stores events in partitioned topics.
- Consumer group processes events.
- Stream processor calculates rolling metrics.
- Outputs are written to serving tables, alert channels, and long-term storage.

## Tools

- Apache Kafka or Redpanda for event streaming
- Python, Java, or Node.js producer
- Spark Structured Streaming, Flink, Kafka Streams, or Faust for processing
- PostgreSQL, Redis, Elasticsearch, ClickHouse, or cloud warehouse for serving outputs
- Schema Registry for event contracts
- Docker Compose for local development

## Data Sources

Suggested event types:

- `sale_created`
- `sale_refunded`
- `payment_failed`
- `inventory_adjusted`
- `product_stockout`

Example `sale_created` fields:

- `event_id`
- `event_type`
- `event_time`
- `store_id`
- `sale_id`
- `customer_id`
- `product_id`
- `quantity`
- `unit_price`
- `discount_amount`
- `payment_method`

## Pipeline Design

1. Define event schema and required fields.
2. Produce sample sales events into a Kafka topic.
3. Partition events by store, sale ID, or product depending on access pattern.
4. Consume events with a stream processor.
5. Validate event schema and quarantine invalid events.
6. Deduplicate events using `event_id`.
7. Calculate real-time sales metrics and rolling windows.
8. Handle late-arriving events using event time and watermarks.
9. Write aggregates to a dashboard table or serving store.
10. Send alerts for stockouts, sales drops, or payment failure spikes.

## Data Model

Suggested Kafka topics:

- `retail.sales.events`
- `retail.inventory.events`
- `retail.dead_letter.events`

Suggested serving tables:

- `realtime.sales_by_minute`
- `realtime.sales_by_store`
- `realtime.product_sales_velocity`
- `realtime.payment_failure_alerts`
- `realtime.stockout_alerts`

Suggested event grain:

- One event per business action, such as one sale line item or one payment failure.

## Quality Checks

Event checks:

- `event_id` is not null.
- `event_time` is not null and parseable.
- Event type is accepted.
- Quantity is greater than zero for sale events.
- Revenue fields are not negative.
- Required keys exist for each event type.

Streaming checks:

- Consumer lag is within threshold.
- Dead-letter event count is monitored.
- Duplicate event rate is monitored.
- Late event rate is monitored.
- Checkpoint location is stable.
- Output freshness meets business expectations.

## Scalability Considerations

This architecture is useful when:

- The business needs real-time operational awareness.
- Events come from many stores, apps, or services.
- Consumers need to process the same event stream for different use cases.
- Low-latency alerts are more valuable than daily batch reports.

Design considerations:

- Choose partition keys carefully.
- Track offsets and consumer groups.
- Use event time for business metrics.
- Use checkpoints for recovery.
- Decide between at-least-once and exactly-once processing.
- Keep event schemas versioned.
- Monitor lag, throughput, and failed events.

## Cost Considerations

Main cost drivers:

- Broker infrastructure
- Stream processing compute
- Retention period
- Number of partitions
- Downstream serving databases
- Monitoring and alerting systems

Cost controls:

- Set practical retention periods.
- Avoid excessive partitions.
- Use compacted topics only where needed.
- Keep event payloads lean.
- Separate hot real-time data from cold historical storage.
- Use batch for use cases that do not need real time.

## Security Considerations

Security requirements:

- Authenticate producers and consumers.
- Encrypt data in transit.
- Restrict topic access by application role.
- Avoid sending unnecessary PII in events.
- Mask sensitive fields before analytics outputs.
- Audit topic access and consumer behavior.
- Protect alert channels from leaking customer data.

## Expected Output

Expected deliverables:

- Event schema documentation
- Kafka topic design
- Producer and consumer skeleton
- Stream processing logic
- Real-time sales aggregate tables
- Dead-letter handling design
- Monitoring and alerting plan

Business questions answered:

- Are sales dropping right now?
- Which products are selling fastest in the last 15 minutes?
- Which stores have unusual payment failure rates?
- Which products are close to stockout?
- Is the streaming pipeline behind?

## Future Improvements

- Add Schema Registry.
- Add exactly-once processing where justified.
- Add event replay strategy.
- Add event-driven inventory updates.
- Add streaming feature generation for ML.
- Add anomaly detection.
- Add multi-region disaster recovery.

## Useful When

Use Kafka streaming when the business value depends on low-latency data, multiple consumers need the same events, or event replay is important.

## Overkill When

Streaming is overkill when next-day or hourly reports are enough. It adds broker operations, event schema management, consumer lag monitoring, and more complicated failure modes.

## Related Concepts

- [Streaming Concepts](../../../11-streaming-data/streaming-concepts.md)
- [Kafka Basics](../../../11-streaming-data/kafka-basics.md)
- [Producers Consumers Topics](../../../11-streaming-data/producers-consumers-topics.md)
- [Event Time Vs Processing Time](../../../11-streaming-data/event-time-vs-processing-time.md)
