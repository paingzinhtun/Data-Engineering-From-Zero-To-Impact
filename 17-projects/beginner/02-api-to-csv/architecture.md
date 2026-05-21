# Architecture

```text
API endpoint
  -> Python requests extractor
  -> JSON response validation
  -> flattened records
  -> CSV output
```

## Components

- Source: HTTP API
- Extractor: Python script
- Output: CSV file
- Validation: status code, response shape, row count

## Important Behaviors

- Use a timeout.
- Check HTTP status codes.
- Plan for pagination.
- Log number of records extracted.
- Do not hardcode API tokens.
