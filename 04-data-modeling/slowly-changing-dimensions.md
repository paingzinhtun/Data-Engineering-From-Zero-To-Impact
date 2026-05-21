# Slowly Changing Dimensions

## 1. What It Is

Slowly changing dimensions, or SCDs, are methods for handling dimension attributes that change over time.

For example, a customer may move to a new city, a product may change category, or a customer may move from consumer to business segment.

The question is whether analytics should show the current value, the historical value, or both.

## 2. Why It Matters

Business attributes change. If a data model does not handle those changes intentionally, reports can become misleading.

SCD thinking helps Data Engineers:

- Preserve historical analysis.
- Avoid rewriting the past accidentally.
- Track changes to customer or product attributes.
- Support accurate trend reporting.
- Explain why current and historical reports differ.

## 3. Core Concepts

- **SCD Type 1:** Overwrite old values with new values.
- **SCD Type 2:** Create a new dimension row for each historical version.
- **Current flag:** Indicates the active dimension version.
- **Effective start date:** When a dimension version became valid.
- **Effective end date:** When a dimension version stopped being valid.
- **Surrogate key:** A warehouse key that identifies each dimension version.
- **Natural key:** The business or source key that persists across versions.
- **Historical reporting:** Reporting based on values that were true at the time.

## 4. Real Business Example

A stationery shop has a customer called `Mandalay Market`.

In January, the customer segment is `SME`. In March, the business grows and becomes a `Wholesale` customer.

If the model uses SCD Type 1, old sales will now appear under `Wholesale`.

If the model uses SCD Type 2, January and February sales remain under `SME`, while March onward sales appear under `Wholesale`.

The right choice depends on the business question.

## 5. Simple Data Model Example

SCD Type 2 customer dimension:

```text
dim_customer
- customer_key
- customer_id
- customer_name
- customer_segment
- city
- effective_start_date
- effective_end_date
- is_current
```

Example rows:

```text
customer_key | customer_id | segment   | start_date | end_date   | is_current
1            | C-100       | SME       | 2026-01-01 | 2026-02-28 | false
2            | C-100       | Wholesale | 2026-03-01 | null       | true
```

Fact sales should connect to the correct `customer_key` based on the sale date.

## 6. Production Considerations

- Decide which dimensions need history.
- Do not use SCD Type 2 for every attribute automatically.
- Use effective dates consistently.
- Make sure only one current row exists per natural key.
- Join facts to the correct dimension version.
- Document whether reports use current or historical attributes.
- Test late-arriving facts carefully.
- Monitor duplicate current records.

## 7. Common Mistakes

- Overwriting history when historical reporting is required.
- Creating SCD Type 2 tables without clear business need.
- Forgetting effective end dates.
- Allowing multiple current rows for the same natural key.
- Joining facts to current dimensions when historical dimensions are required.
- Not explaining SCD behavior to dashboard users.

## 8. Practice Task

Create a customer dimension design for a stationery shop.

Include:

1. Customer natural key.
2. Customer surrogate key.
3. Customer segment.
4. City.
5. Effective start date.
6. Effective end date.
7. Current flag.

Then explain whether customer segment should use Type 1 or Type 2 for your business scenario.

## 9. Related Project

- `04-data-modeling/retail-data-model-example/`: Provides dimension structure that can be extended with SCD fields.
- `06-data-warehousing/`: Warehouse dimensions often need SCD decisions.
- `20-real-world-case-studies/`: Case studies should explain historical reporting requirements.
