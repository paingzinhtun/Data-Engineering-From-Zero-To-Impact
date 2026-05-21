# Normalization Vs Denormalization

## 1. What It Is

Normalization organizes data into separate related tables to reduce duplication and protect consistency.

Denormalization intentionally combines data into wider or repeated structures to make querying faster or easier.

Neither approach is always better. Data Engineers choose based on the purpose of the system.

## 2. Why It Matters

Operational systems often need normalized data to avoid inconsistency. Analytics systems often use denormalized or dimensional structures to make reporting easier.

Understanding the tradeoff helps Data Engineers:

- Design reliable source-style models.
- Build analytics-friendly tables.
- Avoid unnecessary duplication.
- Improve query performance.
- Explain why a warehouse model differs from an application database.

## 3. Core Concepts

- **Normalization:** Splitting data into related tables.
- **Denormalization:** Combining data to reduce joins or simplify use.
- **Redundancy:** Repeated data.
- **Update anomaly:** Inconsistent results after updating repeated values.
- **Read performance:** How quickly users can query data.
- **Write consistency:** How safely data can be inserted or updated.
- **Operational model:** A model designed for transactions and updates.
- **Analytical model:** A model designed for reporting and analysis.

## 4. Real Business Example

A stationery shop has customer and sales data.

In a normalized model:

- Customer details live in `customers`.
- Product details live in `products`.
- Sales events live in `sales`.

This avoids repeating customer names and product categories on every sale row.

In a denormalized reporting table:

- Sale date, customer segment, product category, quantity, and revenue may appear together.

This makes dashboards easier because analysts do not need to join many tables every time.

## 5. Simple Data Model Example

Normalized model:

```text
customers
- customer_id
- customer_name
- customer_segment

products
- product_id
- product_name
- category

sales
- sale_id
- customer_id
- product_id
- sale_date
- quantity
- unit_price
```

Denormalized reporting model:

```text
mart_daily_sales
- sale_date
- product_category
- customer_segment
- total_quantity
- revenue
- gross_profit
```

The normalized model protects relationships. The denormalized mart makes reporting easier.

## 6. Production Considerations

- Normalize when data is frequently inserted or updated.
- Denormalize when users need fast, simple reporting.
- Document which fields are copied from source dimensions.
- Keep denormalized tables refreshable from trusted sources.
- Avoid uncontrolled duplication.
- Validate totals between normalized facts and denormalized marts.
- Use dimensional models for analytics when appropriate.

## 7. Common Mistakes

- Treating denormalization as bad by default.
- Treating one wide spreadsheet as a proper data model.
- Repeating values without a refresh strategy.
- Over-normalizing analytics tables until they are hard to use.
- Denormalizing before understanding relationships.
- Not validating that reporting marts match source facts.

## 8. Practice Task

Take a sales spreadsheet with columns:

- sale_date
- customer_name
- customer_segment
- product_name
- product_category
- quantity
- unit_price

Design:

1. A normalized relational model.
2. A denormalized reporting table.
3. A short explanation of when each version is useful.

## 9. Related Project

- `04-data-modeling/relational-modeling.md`: Start with relational structure.
- `04-data-modeling/dimensional-modeling.md`: Learn a common analytics-focused denormalization pattern.
- `06-data-warehousing/`: Warehouses often use denormalized marts for reporting.
