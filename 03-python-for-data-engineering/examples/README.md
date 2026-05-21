# Python Examples

## 1. What It Is

This folder contains beginner-friendly Python examples for common Data Engineering tasks.

The examples are intentionally small:

- `read_csv.py`: Read and validate a CSV file with pandas.
- `api_extract.py`: Extract JSON data from an HTTP API with requests.
- `load_to_postgres.py`: Load a pandas DataFrame into PostgreSQL with SQLAlchemy.

## 2. Why It Matters for Data Engineering

These examples show patterns that appear in real pipelines: validate inputs, log row counts, handle failures, use environment variables, and avoid hardcoded credentials.

## 3. Core Concepts

- File validation with `pathlib`
- DataFrame loading with pandas
- API requests with timeouts
- Error handling with exceptions
- Logging for pipeline visibility
- Database loading with SQLAlchemy
- Environment-based configuration

## 4. Real-World Example

A retail data pipeline may read a daily sales CSV, extract product updates from an API, then load cleaned records into PostgreSQL for analysis.

These examples show the starter pieces of that workflow.

## 5. Python Example

Run an example from this folder:

```bash
python read_csv.py ../../data/raw/orders.csv
```

Set PostgreSQL environment variables before running the loader:

```bash
export POSTGRES_HOST=localhost
export POSTGRES_PORT=5432
export POSTGRES_DB=retail_practice
export POSTGRES_USER=data_user
export POSTGRES_PASSWORD=data_password
```

On Windows PowerShell:

```powershell
$env:POSTGRES_HOST="localhost"
$env:POSTGRES_PORT="5432"
$env:POSTGRES_DB="retail_practice"
$env:POSTGRES_USER="data_user"
$env:POSTGRES_PASSWORD="data_password"
```

## 6. Production Considerations

- Add project dependency files before using these in a real project.
- Store secrets in environment variables or a secrets manager.
- Add tests around transformation logic.
- Add retries where appropriate.
- Store raw API responses when useful for audit and debugging.
- Use orchestration for scheduled workflows.

## 7. Common Mistakes

- Running scripts from the wrong directory.
- Forgetting required environment variables.
- Hardcoding credentials.
- Ignoring API pagination.
- Loading data without validating columns.
- Treating examples as complete production pipelines.

## 8. Practice Task

Use these scripts as a starting point:

1. Create a small CSV file.
2. Read it with `read_csv.py`.
3. Modify the script to validate your own required columns.
4. Run `api_extract.py` against a public JSON API.
5. Modify `load_to_postgres.py` to load your own DataFrame.

## 9. Related Project

- `../python-basics-for-de.md`
- `../files-and-formats.md`
- `../working-with-apis.md`
- `../logging-error-handling.md`
- `../../17-projects/`
