# Environment Variables

## 1. What It Is

Environment variables are configuration values provided to a program by its runtime environment.

They are commonly used for settings such as file paths, database hostnames, ports, usernames, environment names, and feature flags.

## 2. Why It Matters

Code should not hardcode environment-specific values. A pipeline should be able to run in development, staging, and production with different configuration.

Environment variables help Data Engineers:

- Separate code from configuration.
- Avoid hardcoded paths.
- Move projects between environments.
- Configure containers and cloud jobs.
- Keep examples safer and more reusable.

Secrets can be passed through environment variables, but they should originate from a secure secret manager in production.

## 3. When to Use It

Use environment variables for:

- Database hosts and ports.
- Input and output paths.
- Runtime environment names.
- API base URLs.
- Non-secret configuration.
- Secret references or injected secret values.

Avoid using environment variables as a permanent secret storage system.

## 4. Real Business Example

A retail pipeline writes to a local PostgreSQL database during development and to a cloud warehouse in production.

The code can read:

- `ENVIRONMENT`
- `DATABASE_HOST`
- `DATABASE_NAME`
- `INPUT_BUCKET`
- `OUTPUT_SCHEMA`

The same code runs in both places with different values.

## 5. Technical Example

Python example:

```python
import os


def get_required_env(name: str) -> str:
    value = os.getenv(name)
    if not value:
        raise EnvironmentError(f"Missing required environment variable: {name}")
    return value


database_host = get_required_env("DATABASE_HOST")
database_name = get_required_env("DATABASE_NAME")
```

Example `.env.example`:

```text
ENVIRONMENT=development
DATABASE_HOST=localhost
DATABASE_PORT=5432
DATABASE_NAME=retail
INPUT_PATH=data/raw/sales.csv
```

## 6. Production Considerations

- Document required variables.
- Provide `.env.example` without real secrets.
- Validate required variables at startup.
- Use separate values per environment.
- Avoid logging secret values.
- Use managed secrets for sensitive values.
- Keep defaults safe.
- Fail clearly when configuration is missing.

## 7. Common Mistakes

- Hardcoding production paths.
- Committing `.env` files with real secrets.
- Not documenting required variables.
- Using the same configuration for development and production.
- Logging environment variables.
- Providing unsafe defaults.
- Treating environment variables as a replacement for secrets management.

## 8. Practice Task

Create configuration for a retail pipeline.

Define environment variables for:

1. Runtime environment.
2. Input path.
3. Output path.
4. Database host.
5. Database name.
6. Database user.
7. Secret reference.
8. Log level.

Write a small validation function that fails when required variables are missing.

## 9. Related Project

- `03-python-for-data-engineering/examples/load_to_postgres.py`: Uses environment variables for PostgreSQL.
- `05-etl-elt-pipelines/templates/python-etl-template.py`: Loads pipeline configuration from environment variables.
- `13-cloud-data-engineering/iam-and-security.md`: Configuration and security are connected.
