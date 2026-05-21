# Event Time Vs Processing Time

## 1. What It Is

Event time is when an event actually happened in the real world.

Processing time is when the streaming system processes the event.

These are not always the same. A sale may happen at 10:00, but the event may not be processed until 10:03 because of network delay, system lag, or retries.

## 2. Why It Matters

Business metrics usually care about when something happened, not when the system processed it.

For example, daily sales should be based on sale time, not processing time. If events arrive late and the system uses processing time, sales may be counted on the wrong day.

Understanding event time helps with:

- Accurate windows.
- Late-arriving data.
- Correct daily metrics.
- Reprocessing.
- Alerting rules.
- Watermarks and state cleanup.

## 3. When to Use It

Use event time when:

- Metrics depend on business time.
- Events may arrive late.
- You need daily, hourly, or session windows.
- Reports must match real-world activity.
- Backfilled or replayed events should count in the original period.

Processing time may be acceptable when:

- You only care when the system saw the event.
- The data is operational monitoring data.
- Small timing differences do not affect the business.

## 4. Real Business Example

A POS terminal goes offline during a promotion. It records sales locally and sends events 20 minutes later when the connection returns.

If the stream processor uses processing time, those sales appear late and may distort promotion monitoring.

If it uses event time, the sales are counted in the correct promotion window, even though they arrived late.

## 5. Technical Example

Event:

```json
{
  "event_id": "evt-2001",
  "event_time": "2026-01-15T10:00:00Z",
  "processed_at": "2026-01-15T10:03:12Z",
  "product_id": "P-100",
  "quantity": 2
}
```

Windowing concept:

```text
event-time window:
  group sales by the event_time field

processing-time window:
  group sales by when the processor received the event
```

Late-arriving data:

```text
event happened at 10:00
event arrived at 10:08
allowed lateness: 15 minutes
result: include event in 10:00 window
```

## 6. Production Considerations

- Include event time in every important event.
- Use a consistent timezone, often UTC.
- Define allowed lateness.
- Decide whether late events update previous results.
- Use watermarks where supported.
- Store raw events for replay.
- Monitor late event rates.
- Explain window behavior to business users.

## 7. Common Mistakes

- Using processing time for business metrics that need event time.
- Omitting event time from events.
- Mixing local time zones without conversion.
- Dropping late events without documenting it.
- Letting late data change dashboards without explanation.
- Assuming events always arrive in order.
- Not testing offline or delayed source behavior.

## 8. Practice Task

Design time handling for retail sales events.

Define:

1. Event time field.
2. Processing time field.
3. Timezone standard.
4. Window size.
5. Allowed lateness.
6. Late-arriving event behavior.
7. Dashboard update behavior.
8. Business explanation.

## 9. Related Project

- `11-streaming-data/streaming-project/`: Real-time dashboards must define time behavior.
- `11-streaming-data/structured-streaming.md`: Structured Streaming uses event-time concepts and checkpoints.
- `12-data-quality-testing-observability/`: Late data and freshness should be monitored.
