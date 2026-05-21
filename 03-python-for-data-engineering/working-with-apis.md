# Working With APIs

## 1. What It Is

Working with APIs in Python means sending requests to software systems, receiving responses, handling errors, and converting returned data into files or database tables.

Most beginner API extraction uses HTTP requests and JSON responses.

## 2. Why It Matters for Data Engineering

Many business tools expose data through APIs instead of direct database access. Ecommerce platforms, payment processors, CRMs, marketing tools, support systems, and inventory systems often require API extraction.

Data Engineers use Python API scripts to:

- Pull daily orders.
- Extract customer records.
- Collect payment and refund data.
- Load marketing campaign performance.
- Capture support ticket history.
- Build raw data archives for later transformation.

## 3. Core Concepts

- **Endpoint:** A URL that exposes a specific resource.
- **HTTP method:** The action, such as `GET` or `POST`.
- **Header:** Metadata sent with a request, often including authentication.
- **Query parameter:** A URL value used for filtering or pagination.
- **Status code:** A numeric result such as `200`, `401`, `404`, or `429`.
- **Timeout:** A limit on how long the request waits.
- **Pagination:** A pattern for retrieving large result sets over multiple requests.
- **Rate limit:** A restriction on how many requests can be made in a time period.
- **JSON response:** Structured data returned by many APIs.

## 4. Real-World Example

An ecommerce company needs yesterday's orders loaded into a warehouse every morning.

A Python extractor can:

1. Request orders from the ecommerce API.
2. Use query parameters to filter by update date.
3. Handle pagination until all orders are collected.
4. Respect rate limits.
5. Store raw JSON responses.
6. Log the number of records extracted.
7. Fail clearly if the API returns an error.

This creates a repeatable source for reporting, inventory planning, and customer analytics.

## 5. Python Example

```python
import logging

import requests


logging.basicConfig(level=logging.INFO, format="%(levelname)s %(message)s")

url = "https://api.example.com/orders"
params = {"limit": 100, "page": 1}
headers = {"Accept": "application/json"}

try:
    response = requests.get(url, params=params, headers=headers, timeout=30)
    response.raise_for_status()
except requests.Timeout as exc:
    raise RuntimeError("API request timed out") from exc
except requests.HTTPError as exc:
    raise RuntimeError(f"API returned an error: {response.status_code}") from exc

payload = response.json()
orders = payload.get("orders", [])

logging.info("Extracted %s orders", len(orders))
```

## 6. Production Considerations

- Always use request timeouts.
- Check status codes before trusting responses.
- Handle pagination intentionally.
- Respect rate limits and retry guidance.
- Store raw responses when practical.
- Do not hardcode API tokens.
- Log request counts and extracted row counts.
- Validate important fields in the response.
- Monitor schema changes from API providers.

## 7. Common Mistakes

- Extracting only the first page of results.
- Omitting timeouts.
- Ignoring `429 Too Many Requests`.
- Treating every response as valid JSON.
- Hardcoding tokens in scripts.
- Not logging failed requests.
- Not capturing enough context to debug API failures.
- Assuming API fields will never change.

## 8. Practice Task

Choose a public JSON API and write a Python script that:

1. Sends a `GET` request with a timeout.
2. Checks the status code.
3. Parses the JSON response.
4. Logs how many records were extracted.
5. Includes a placeholder for pagination.
6. Writes the raw response to a file.

Then write three validation checks you would apply before loading the data.

## 9. Related Project

- `01-fundamentals/api-basics.md`: Learn API concepts before building extractors.
- `03-python-for-data-engineering/examples/api_extract.py`: Starter API extraction script.
- `05-etl-elt-pipelines/`: API extractors become pipeline extraction steps.
