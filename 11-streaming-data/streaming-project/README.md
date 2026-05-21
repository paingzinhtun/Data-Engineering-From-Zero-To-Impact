# Real-time Retail Sales Events Pipeline

## 1. What It Is

This project defines a real-time retail sales events pipeline.

The pipeline captures POS sales events, publishes them to Kafka, processes the stream, and updates a real-time dashboard or alerting system.

## 2. Why It Matters

Retail operations sometimes need faster feedback than daily batch reporting.

Real-time sales events can support:

- Promotion monitoring.
- Stockout alerts.
- Fast-selling product detection.
- Store operations dashboards.
- Fraud or anomaly detection.
- Live ecommerce and POS visibility.

The goal is not to replace the warehouse. The goal is to add real-time awareness where the business can act on it.

## 3. When to Use It

Use this architecture when:

- POS or ecommerce systems can produce events.
- Business users need near-real-time visibility.
- Alerts can trigger useful action.
- Streaming infrastructure can be operated reliably.
- Late-arriving and duplicate events can be handled.

Do not use this architecture when:

- Daily batch reporting is enough.
- No one will act on real-time alerts.
- Source systems only provide batch exports.
- The team cannot monitor and maintain streaming jobs.
- The business problem is unclear.

## 4. Real Business Example

A stationery retailer runs a back-to-school promotion.

During the promotion, POS systems emit a `sale_completed` event for each sale. The stream processor calculates product-level sales every few minutes.

If notebook sales spike and stock drops below a threshold, the alert system notifies operations to transfer inventory or reorder.

## 5. Technical Example

Architecture:

```text
POS event
  -> Kafka topic
  -> stream processor
  -> real-time dashboard/alert
```

Suggested components:

```text
producer:
  POS or ecommerce application publishing sale events

topic:
  retail.sales.completed

stream processor:
  Spark Structured Streaming, Flink, Kafka Streams, or a consumer service

outputs:
  realtime_product_sales
  stockout_alerts
  promotion_sales_dashboard
```

Example event:

```json
{
  "event_id": "evt-3001",
  "event_type": "sale_completed",
  "event_time": "2026-01-15T10:15:00Z",
  "store_id": "STORE-01",
  "sales_channel": "store",
  "product_id": "P-NOTEBOOK-A5",
  "customer_id": "C-100",
  "quantity": 3,
  "unit_price": 4.00
}
```

Key design decisions:

- Topic: `retail.sales.completed`
- Event key: `store_id` or `product_id`
- Partitions: enough for expected throughput
- Consumer group: one per independent application
- Offset commits: after successful processing
- Delivery expectation: usually at-least-once with idempotent outputs
- Checkpoints: required for stream processor recovery
- Time basis: event time for business windows

## 6. Production Considerations

- Define event schema and ownership.
- Include unique event IDs.
- Use UTC event timestamps.
- Handle late-arriving data.
- Handle duplicate events.
- Monitor Kafka topic throughput and consumer lag.
- Monitor stream processor checkpoints.
- Define alert thresholds carefully.
- Avoid noisy alerts.
- Store raw events for replay and audit.
- Align real-time outputs with warehouse metrics where possible.

## 7. Common Mistakes

- Building streaming before confirming the business action.
- Ignoring duplicate events under at-least-once processing.
- Assuming exactly-once is guaranteed end to end.
- Not using checkpoints.
- Counting sales by processing time instead of event time.
- Not handling late-arriving events.
- Choosing poor partition keys.
- Not reconciling streaming metrics with batch warehouse metrics.

## 8. Practice Task

Design and document the pipeline.

Include:

1. Event schema.
2. Producer system.
3. Kafka topic name.
4. Partition key.
5. Consumer groups.
6. Stream processor logic.
7. Event-time window.
8. Late-arriving data behavior.
9. Checkpoint location.
10. Dashboard or alert output.
11. Reconciliation with batch sales data.

## 9. Related Project

- `11-streaming-data/streaming-concepts.md`: Streaming foundations.
- `11-streaming-data/kafka-basics.md`: Kafka topic and partition concepts.
- `11-streaming-data/event-time-vs-processing-time.md`: Time handling for business metrics.
- `11-streaming-data/structured-streaming.md`: Example stream processing approach.
- `14-production-engineering/`: Streaming pipelines need production reliability practices.
