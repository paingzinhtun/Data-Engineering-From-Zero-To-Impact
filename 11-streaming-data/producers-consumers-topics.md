# Producers Consumers Topics

## 1. What It Is

Producers, consumers, and topics are core streaming concepts.

A **producer** writes events.

A **topic** stores a named stream of events.

A **consumer** reads events from a topic.

In Kafka, topics are split into partitions. Consumers track offsets to know which events they have processed.

## 2. Why It Matters

These concepts define how data moves through a streaming system. Understanding them helps Data Engineers design reliable event flows, scale consumers, replay data, and debug processing delays.

They matter because:

- Producers define event quality.
- Topics organize event streams.
- Partitions enable parallelism.
- Offsets track progress.
- Consumer groups allow scalable consumption.

## 3. When to Use It

Use producer-topic-consumer design when:

- Systems need event-driven communication.
- Multiple consumers need the same event stream.
- Data should be processed continuously.
- Replay or decoupling is useful.
- Work should be parallelized across consumers.

Use simpler direct API calls or batch loads when continuous event streams are not needed.

## 4. Real Business Example

A POS system produces sale events to `retail.sales.completed`.

Consumers include:

- `inventory-service`: updates estimated stock.
- `analytics-stream`: calculates near-real-time sales metrics.
- `alert-service`: sends stockout warnings.
- `lake-writer`: stores raw events for history.

Each consumer group tracks its own offsets, so each system can process at its own pace.

## 5. Technical Example

Consumer group example:

```text
topic: retail.sales.completed
partitions: 3

consumer group: real_time_dashboard
  consumer A reads partition 0
  consumer B reads partition 1
  consumer C reads partition 2
```

Offset example:

```text
partition 0:
  offset 100: sale event
  offset 101: sale event
  offset 102: sale event

consumer committed offset: 101
next event to process: 102
```

At-least-once processing:

```text
process event
write output
commit offset
```

If the consumer fails after writing output but before committing the offset, the event may be processed again. This is why idempotent writes matter.

## 6. Production Considerations

- Use stable event IDs.
- Choose partition keys based on ordering and scaling needs.
- Commit offsets only after successful processing.
- Design consumers to handle duplicates.
- Monitor consumer lag.
- Use consumer groups for scalable processing.
- Define dead-letter handling for invalid events.
- Keep topic schemas documented.

## 7. Common Mistakes

- Assuming all events in a topic have global order.
- Committing offsets before processing succeeds.
- Not handling duplicate events.
- Using too few partitions for high throughput.
- Using too many partitions without operational need.
- Reusing one consumer group for unrelated applications.
- Ignoring invalid event handling.
- Not documenting event ownership.

## 8. Practice Task

Design a producer and consumer setup for retail sales events.

Define:

1. Producer application.
2. Topic name.
3. Event key.
4. Number of partitions.
5. Consumer groups.
6. Offset commit strategy.
7. Duplicate handling.
8. Dead-letter strategy.

## 9. Related Project

- `11-streaming-data/kafka-basics.md`: Kafka provides topics, partitions, offsets, and consumer groups.
- `11-streaming-data/streaming-project/`: Applies these concepts to real-time retail sales.
- `05-etl-elt-pipelines/idempotency.md`: Consumers need idempotent output behavior.
