# Logging And Error Handling

## 1. What It Is

Logging is the practice of recording what a program is doing. Error handling is the practice of responding clearly when something goes wrong.

Together, they make data pipelines easier to debug, monitor, and operate.

## 2. Why It Matters for Data Engineering

Data pipelines often run without a person watching them. When a pipeline fails, logs may be the only way to understand what happened.

Logging and error handling help Data Engineers:

- Know which file or API endpoint was processed.
- Record row counts.
- Detect missing data.
- Capture error details.
- Avoid silent failures.
- Support incident investigation.
- Build operational trust.

## 3. Core Concepts

- **Logger:** Object used to write log messages.
- **Log level:** Severity such as `DEBUG`, `INFO`, `WARNING`, `ERROR`, or `CRITICAL`.
- **Exception:** An error raised by Python.
- **Try/except:** Python syntax for handling exceptions.
- **Fail fast:** Stop early when required conditions are not met.
- **Silent failure:** A failure that does not raise or log a clear error.
- **Operational metric:** A logged value such as row count, duration, or rejected records.

## 4. Real-World Example

A daily inventory pipeline runs at 6 AM. One day, the supplier file is missing.

Without logging, the dashboard may simply show stale data and users may not know why.

With logging and clear error handling, the pipeline records:

- Which file was expected.
- That the file was missing.
- When the failure happened.
- Which step failed.

This makes the issue faster to fix and easier to communicate.

## 5. Python Example

```python
import logging
from pathlib import Path

import pandas as pd


logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s %(levelname)s %(message)s",
)


def read_orders(file_path: Path) -> pd.DataFrame:
    if not file_path.exists():
        raise FileNotFoundError(f"Orders file not found: {file_path}")

    logging.info("Reading orders from %s", file_path)
    orders = pd.read_csv(file_path)
    logging.info("Read %s order rows", len(orders))
    return orders


try:
    df = read_orders(Path("data/raw/orders.csv"))
except FileNotFoundError:
    logging.exception("Pipeline failed because the input file is missing")
    raise
except Exception:
    logging.exception("Pipeline failed unexpectedly")
    raise
```

## 6. Production Considerations

- Log pipeline start and finish.
- Log input and output row counts.
- Log file paths, table names, and source endpoints.
- Use appropriate log levels.
- Raise errors when required data is missing.
- Avoid logging secrets or sensitive personal data.
- Include enough context to debug failures.
- Send logs to a central system in production environments.

## 7. Common Mistakes

- Using only `print` statements.
- Catching exceptions and doing nothing.
- Logging vague messages such as `failed`.
- Logging credentials or tokens.
- Continuing after critical validation errors.
- Not logging row counts.
- Not re-raising exceptions after logging fatal failures.
- Treating warnings and errors the same.

## 8. Practice Task

Add logging to a CSV pipeline.

Your script should log:

1. Pipeline start time.
2. Input file path.
3. Input row count.
4. Validation failures.
5. Output file path.
6. Output row count.
7. Pipeline completion.

Then intentionally run it with a missing file and confirm the error message is useful.

## 9. Related Project

- `03-python-for-data-engineering/examples/read_csv.py`: Logs file validation and row counts.
- `03-python-for-data-engineering/examples/api_extract.py`: Logs API extraction behavior.
- `12-data-quality-testing-observability/`: Logging is a foundation for observability.
