# API Basics

## 1. What It Is

An API, or application programming interface, is a way for software systems to communicate. In Data Engineering, APIs are commonly used to extract data from business tools, ecommerce platforms, payment processors, CRMs, marketing systems, and cloud services.

Most beginner Data Engineering API work uses HTTP APIs that return JSON.

## 2. Why It Matters for Data Engineering

Many important business systems do not provide direct database access. Instead, they expose data through APIs.

Data Engineers use APIs to collect:

- Orders from ecommerce platforms
- Payments from payment processors
- Customer records from CRMs
- Campaign results from marketing tools
- Inventory updates from warehouse systems
- Support tickets from helpdesk tools

Understanding APIs helps you build reliable ingestion pipelines.

## 3. When You Use It

You use APIs when:

- Extracting data from SaaS tools.
- Building automated ingestion jobs.
- Sending cleaned data back into business systems.
- Checking service health.
- Integrating internal applications.
- Preparing data for dashboards or AI systems.

## 4. Real-World Example

An ecommerce business wants a daily report of orders, payments, refunds, and customers.

The Data Engineer may call the ecommerce platform API every morning:

1. Request orders updated since yesterday.
2. Handle pagination to collect all pages.
3. Respect the platform rate limit.
4. Store the JSON response as raw data.
5. Transform the data into database tables.
6. Validate order IDs, totals, currencies, and customer references.

If the API changes or returns an error, the pipeline should log the problem and avoid silently producing incorrect reports.

## 5. Basic Commands or Examples

Common HTTP methods:

```text
GET     Read data
POST    Create data or submit a request
PUT     Replace an existing resource
PATCH   Partially update an existing resource
DELETE  Delete a resource
```

Common status codes:

```text
200  OK
201  Created
400  Bad request
401  Unauthorized
403  Forbidden
404  Not found
429  Too many requests
500  Server error
503  Service unavailable
```

Headers:

```text
Authorization: Bearer <token>
Content-Type: application/json
Accept: application/json
```

Query parameters:

```text
https://api.example.com/orders?status=paid&limit=100&page=2
```

Pagination example:

```text
Page 1: /orders?limit=100&page=1
Page 2: /orders?limit=100&page=2
Page 3: /orders?limit=100&page=3
```

Rate limits:

```text
The API may allow only 100 requests per minute.
If you exceed the limit, it may return 429 Too Many Requests.
```

Example JSON response:

```json
{
  "orders": [
    {
      "order_id": "ORD-1001",
      "customer_id": "C-501",
      "order_total": 89.5,
      "currency": "USD",
      "status": "paid"
    }
  ],
  "page": 1,
  "has_more": true
}
```

Simple API request with `curl`:

```bash
curl "https://api.example.com/orders?limit=100"
```

## 6. Common Mistakes

- Ignoring pagination and collecting only the first page.
- Not handling rate limits.
- Treating every response as successful without checking the status code.
- Not storing raw API responses for debugging.
- Hardcoding secrets or API tokens in code.
- Assuming response fields will never change.
- Not logging failed requests.
- Confusing authentication errors with missing data.

## 7. Practice Task

Choose a public API that returns JSON.

Practice:

1. Identify the endpoint URL.
2. Make a simple `GET` request.
3. Read the status code.
4. Inspect the JSON response.
5. Identify whether pagination exists.
6. List important fields you would store.
7. Write three data quality checks for the response.

Example checks:

- `order_id` must not be missing.
- `order_total` must not be negative.
- `currency` must be one of the expected values.

## 8. Related Project

- `03-python-for-data-engineering/`: Build API ingestion scripts with Python.
- `05-etl-elt-pipelines/`: Turn API extraction into a repeatable pipeline.
- `16-business-use-cases/`: Ecommerce, payments, CRM, and marketing use cases commonly depend on APIs.
