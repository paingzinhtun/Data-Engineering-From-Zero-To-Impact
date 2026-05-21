# Logging

## 1. What It Is

Logging is the practice of recording events, status, metrics, and errors from running software.

For Data Engineering, logs explain what a pipeline did, what data it processed, where it failed, and what outputs it produced.

## 2. Why It Matters

Pipelines often run unattended. When something fails, logs are the first source of evidence.

Logging helps teams:

- Debug failures.
- Track row counts.
- Measure runtime.
- Understand pipeline behavior.
- Support incident response.
- Prove what happened during a run.
- Communicate issues to stakeholders.

## 3. When to Use It

Use logging in:

- Python scripts.
- Airflow tasks.
- API extractors.
- Database load jobs.
- Data quality checks.
- Streaming consumers.
- Cloud functions.

Every recurring production pipeline should produce useful logs.

## 4. Real Business Example

A retail daily sales pipeline fails. The dashboard is stale.

Useful logs show:

- Pipeline start time.
- Input file path.
- Source row count.
- Validation failure details.
- Target table.
- Output row count.
- Error stack trace.

Without logs, the team may spend hours guessing.

## 5. Technical Example

Python logging:

```python
import logging


logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s %(levelname)s %(message)s",
)

logging.info("Pipeline started")
logging.info("Read %s rows from %s", row_count, input_path)
logging.warning("Rejected %s invalid rows", rejected_count)
logging.error("Load failed for table %s", table_name)
```

Useful log fields:

```text
pipeline_name
run_id
batch_date
task_name
source_row_count
target_row_count
duration_seconds
status
```

## 6. Production Considerations

- Use structured logs where possible.
- Include run IDs and batch dates.
- Log row counts and output locations.
- Log exceptions with stack traces.
- Avoid logging secrets or sensitive customer data.
- Send logs to a central location in production.
- Set appropriate log levels.
- Keep log retention reasonable.

## 7. Common Mistakes

- Using only `print`.
- Logging vague messages.
- Not logging row counts.
- Logging passwords or tokens.
- Catching exceptions without logging.
- Logging too much noisy detail.
- Not including enough context to debug.
- Not preserving logs after job completion.

## 8. Practice Task

Add logging to a retail ETL script.

Log:

1. Pipeline start.
2. Batch date.
3. Source path.
4. Source row count.
5. Validation failures.
6. Target table.
7. Target row count.
8. Pipeline finish or failure.

## 9. Related Project

- `03-python-for-data-engineering/logging-error-handling.md`: Introductory logging and error handling.
- `08-orchestration/retries-alerts-monitoring.md`: Orchestrators use logs for failures and retries.
- `12-data-quality-testing-observability/monitoring-and-alerting.md`: Logs support monitoring and alerts.
