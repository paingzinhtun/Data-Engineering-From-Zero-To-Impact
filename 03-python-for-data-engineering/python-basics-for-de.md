# Python Basics For Data Engineering

## 1. What It Is

Python basics for Data Engineering are the parts of Python most often used to move, clean, validate, and load data. This includes variables, functions, lists, dictionaries, loops, files, modules, virtual environments, packages, and command-line scripts.

The goal is not to learn every part of Python. The goal is to write clear, reliable scripts that can support data workflows.

## 2. Why It Matters for Data Engineering

Python is widely used for data ingestion, automation, API extraction, file processing, validation, and orchestration glue code.

Data Engineers use Python to:

- Read files from folders or cloud storage.
- Call APIs.
- Validate data before loading.
- Transform records.
- Connect to databases.
- Write logs.
- Run scheduled jobs.
- Build reusable pipeline utilities.

Good Python habits make pipelines easier to debug, test, and maintain.

## 3. Core Concepts

- **Variable:** A named value used by a program.
- **Function:** A reusable block of logic.
- **List:** An ordered collection of values.
- **Dictionary:** A key-value structure, useful for records and configuration.
- **Module:** A Python file that can be imported.
- **Package:** A collection of modules.
- **Virtual environment:** An isolated Python environment for project dependencies.
- **Dependency:** A library required by a project.
- **Script:** A Python file intended to be run directly.
- **Type:** The kind of value, such as string, integer, float, boolean, list, or dictionary.

## 4. Real-World Example

An inventory team receives a daily CSV export from a warehouse system. A Python script can:

1. Check whether the file exists.
2. Read the file.
3. Validate required columns.
4. Remove invalid rows.
5. Write clean data to a database.
6. Log how many rows were processed.

This is a small example, but it reflects real pipeline work.

## 5. Python Example

```python
from pathlib import Path


def validate_required_columns(columns: list[str], required_columns: list[str]) -> None:
    missing_columns = set(required_columns) - set(columns)
    if missing_columns:
        raise ValueError(f"Missing required columns: {sorted(missing_columns)}")


file_path = Path("data/raw/inventory.csv")

if not file_path.exists():
    raise FileNotFoundError(f"Input file not found: {file_path}")

required = ["product_id", "quantity_on_hand", "reorder_level"]
actual = ["product_id", "quantity_on_hand", "reorder_level"]

validate_required_columns(actual, required)
print("File and columns are valid.")
```

## 6. Production Considerations

- Use virtual environments for dependencies.
- Keep configuration separate from code.
- Avoid hardcoding file paths, credentials, or environment-specific values.
- Use functions to make logic testable.
- Add logging instead of relying only on `print`.
- Validate inputs before processing.
- Fail clearly when required data is missing.
- Keep scripts small enough to understand and maintain.

## 7. Common Mistakes

- Writing one large script with no functions.
- Hardcoding local paths that fail on another machine.
- Ignoring missing files or missing columns.
- Mixing extraction, transformation, loading, and reporting in one unclear block.
- Catching every exception without logging useful details.
- Installing packages globally instead of using a project environment.
- Not documenting how to run the script.

## 8. Practice Task

Create a Python script that:

1. Accepts a path to a CSV file.
2. Checks that the file exists.
3. Checks that required columns are present.
4. Prints or logs the row count.
5. Raises a clear error if validation fails.

Use a small retail or inventory CSV with columns such as `product_id`, `product_name`, `quantity_on_hand`, and `reorder_level`.

## 9. Related Project

- `03-python-for-data-engineering/examples/read_csv.py`: Starter example for reading and validating a CSV.
- `05-etl-elt-pipelines/`: Python scripts often become pipeline steps.
- `17-projects/`: File ingestion projects should use these basics.
