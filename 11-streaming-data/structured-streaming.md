# Structured Streaming

## 1. What It Is

Structured Streaming is Spark's stream processing API built around DataFrames and SQL-style operations.

It lets Data Engineers process streaming data using concepts similar to batch DataFrames, while handling continuous input, state, triggers, and checkpoints.

## 2. Why It Matters

Structured Streaming is useful when teams already use Spark and need to process event streams or continuously arriving files.

It matters because it supports:

- Streaming reads.
- DataFrame transformations.
- Event-time windows.
- Watermarks.
- Stateful aggregations.
- Checkpoints for recovery.
- Streaming writes to tables, files, or sinks.

## 3. When to Use It

Use Structured Streaming when:

- Your team uses Spark.
- Events arrive continuously.
- You need windowed aggregations.
- You need to process Kafka events.
- You need streaming plus batch-like transformations.
- Checkpointed recovery is important.

It may be overkill when a simple consumer service, batch job, or managed streaming tool is enough.

## 4. Real Business Example

A retail shop sends POS sales events to Kafka.

Structured Streaming reads the topic, parses JSON events, groups sales into five-minute windows by product, and writes the result to a real-time dashboard table.

If the processor restarts, checkpoints help it continue from saved progress instead of starting from scratch.

## 5. Technical Example

Conceptual PySpark Structured Streaming example:

```python
from pyspark.sql import functions as F


raw_events = (
    spark.readStream
    .format("kafka")
    .option("kafka.bootstrap.servers", "localhost:9092")
    .option("subscribe", "retail.sales.completed")
    .load()
)

sales_events = raw_events.selectExpr("CAST(value AS STRING) AS json_value")

windowed_sales = (
    sales_events
    .select(F.from_json("json_value", sales_schema).alias("event"))
    .select("event.*")
    .withWatermark("event_time", "10 minutes")
    .groupBy(
        F.window("event_time", "5 minutes"),
        "product_id",
    )
    .agg(F.sum("quantity").alias("units_sold"))
)

query = (
    windowed_sales.writeStream
    .format("parquet")
    .option("path", "data/gold/realtime_product_sales/")
    .option("checkpointLocation", "checkpoints/realtime_product_sales/")
    .outputMode("append")
    .start()
)
```

## 6. Production Considerations

- Define schemas explicitly.
- Use checkpoint locations for recovery.
- Choose output mode carefully.
- Use watermarks for event-time aggregations.
- Understand at-least-once and exactly-once behavior for each source and sink.
- Make output writes idempotent when possible.
- Monitor streaming query progress and lag.
- Plan state retention and cleanup.

## 7. Common Mistakes

- Running streaming jobs without checkpoints.
- Using processing time when event time is required.
- Forgetting watermarks on stateful aggregations.
- Assuming exactly-once behavior without checking sink support.
- Letting state grow without limits.
- Not defining schemas for JSON events.
- Ignoring duplicate events.
- Treating streaming jobs like short batch scripts.

## 8. Practice Task

Design a Structured Streaming job for retail sales events.

Define:

1. Source topic.
2. Event schema.
3. Event-time field.
4. Window size.
5. Watermark.
6. Aggregation.
7. Output sink.
8. Checkpoint location.
9. Duplicate handling strategy.

## 9. Related Project

- `11-streaming-data/streaming-project/`: Uses a stream processor in the architecture.
- `10-big-data-processing/pyspark-dataframes.md`: Structured Streaming builds on DataFrame concepts.
- `10-big-data-processing/partitioning-shuffling-caching.md`: Streaming aggregations also involve state and shuffle tradeoffs.
