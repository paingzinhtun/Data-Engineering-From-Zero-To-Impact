# Streaming Concepts

## 1. What It Is

Streaming data is data processed continuously as events happen. Instead of waiting for a daily batch file, a streaming system receives and processes events one by one or in small groups.

An event is a record that says something happened, such as:

- A sale was completed.
- Inventory changed.
- A payment succeeded.
- A product was viewed.
- A delivery was delayed.

## 2. Why It Matters

Some business problems need fresh data quickly. Streaming helps teams react to operational changes faster than batch processing.

Streaming matters for:

- Real-time dashboards.
- Fraud or anomaly alerts.
- Inventory stockout alerts.
- Order status updates.
- Customer activity tracking.
- Operational monitoring.
- Event-driven automation.

Streaming also adds complexity, so it should be used only when freshness has real value.

## 3. When to Use It

Use streaming when:

- Data must be processed within seconds or minutes.
- Events happen continuously.
- Alerts or automation depend on fresh data.
- Batch latency is too slow for the business need.
- Systems need to react to events.

Streaming is overkill when:

- A daily or hourly batch is enough.
- The business does not act on real-time data.
- The team cannot operate streaming infrastructure.
- The source system only produces daily exports.
- Simpler batch pipelines meet the requirement.

## 4. Real Business Example

A retail stationery shop wants to detect fast-selling products during a promotion.

With batch processing, the team may only see results the next morning.

With streaming, each POS sale creates an event. The stream processor updates product sales counts in near real time. If notebooks sell faster than expected and stock drops below a threshold, the system can alert the operations team.

## 5. Technical Example

Streaming architecture:

```text
POS sale event
  -> event producer
  -> Kafka topic
  -> stream processor
  -> real-time dashboard or alert
```

Example event:

```json
{
  "event_id": "evt-1001",
  "event_type": "sale_completed",
  "event_time": "2026-01-15T10:30:00Z",
  "store_id": "STORE-01",
  "product_id": "P-100",
  "quantity": 2,
  "unit_price": 4.50
}
```

Important terms:

```text
producer: application that writes events
topic: named stream of events
consumer: application that reads events
partition: ordered subset of a topic
offset: position of an event in a partition
checkpoint: saved processing progress
```

## 6. Production Considerations

- Define event schemas.
- Include unique event IDs.
- Track event time and processing time.
- Handle late-arriving data.
- Design for duplicates.
- Choose delivery guarantees intentionally.
- Use checkpoints to recover from failures.
- Monitor lag, throughput, errors, and freshness.
- Decide when streaming is worth the operational cost.

## 7. Common Mistakes

- Using streaming when batch is enough.
- Not defining event schemas.
- Assuming events always arrive in order.
- Ignoring duplicate events.
- Ignoring late-arriving data.
- Confusing event time with processing time.
- Treating exactly-once as automatic and universal.
- Not monitoring consumer lag.

## 8. Practice Task

Design a streaming flow for retail sales events.

Define:

1. Event name.
2. Event fields.
3. Producer system.
4. Topic name.
5. Consumer or stream processor.
6. Dashboard or alert output.
7. Late-arriving data behavior.
8. Duplicate handling strategy.

## 9. Related Project

- `11-streaming-data/streaming-project/`: Real-time Retail Sales Events Pipeline.
- `05-etl-elt-pipelines/batch-processing.md`: Compare batch and streaming tradeoffs.
- `14-production-engineering/`: Streaming systems need strong operational practices.
