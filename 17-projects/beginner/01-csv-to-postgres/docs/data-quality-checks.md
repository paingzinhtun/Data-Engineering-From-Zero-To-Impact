# Data Quality Checks

## 1. What Is Data Quality?

Data quality means checking whether data is accurate, complete, consistent, and useful for decision making.

In this project, data quality checks help confirm that the product catalog was loaded correctly from CSV into PostgreSQL.

Good data quality means the business can trust the results from SQL queries.

## 2. Why Data Quality Matters for a Stationery Shop

A stationery shop uses product data to make daily business decisions.

For example, the shop owner may need to know:

- which products need restocking
- which products are profitable
- which suppliers provide important stock
- how much inventory value is currently in the shop

If the product data is wrong, the business decisions may also be wrong.

Examples:

- A missing product name makes the item hard to identify.
- A negative stock quantity gives an incorrect inventory picture.
- A selling price lower than cost price may cause the shop to lose money.
- Duplicate products may make reports count the same item more than once.

## 3. Data Quality Checks Used in This Project

### Row Count Check

The row count check confirms how many product records were loaded into PostgreSQL.

Business reason:

If the CSV has 120 products, the database should also show 120 loaded rows.

### Missing Value Check

Missing value checks look for important fields that are empty.

In this project, important fields include:

- product name
- category
- cost price
- selling price
- stock quantity
- reorder level

Business reason:

The shop needs complete product information to manage stock and reporting.

### Negative Price Check

This check looks for negative `cost_price` or `selling_price` values.

Business reason:

Product prices should not be negative in normal business data.

### Selling Price Lower Than Cost Price Check

This check finds products where `selling_price` is lower than `cost_price`.

Business reason:

If a product is sold below cost, the shop may lose money on each sale.

### Negative Stock Check

This check looks for negative `stock_quantity` or `reorder_level` values.

Business reason:

Stock values and reorder levels should not be negative in normal inventory tracking.

### Duplicate Product Check

Duplicate checks look for repeated product IDs or repeated product name and brand combinations.

Business reason:

Duplicate products can make reports inaccurate. The shop may accidentally count the same item more than once.

### Restocking Check

The restocking check finds products where:

```text
stock_quantity <= reorder_level
```

Business reason:

These products may need to be reordered soon.

This check returning rows is not necessarily an error. It is useful business insight.

## 4. Which Checks Are Errors

Some checks should return `0 rows`.

If they return rows, the data probably needs to be fixed.

Error checks include:

- missing product names
- missing categories
- negative cost price
- negative selling price
- selling price lower than cost price
- negative stock quantity
- negative reorder level
- duplicate product ID
- missing `loaded_at` values

For these checks, `0 rows` usually means the data passed the check.

## 5. Which Checks Are Business Insights

Not every query returning rows means there is an error.

Some checks are meant to give useful business information.

Business insight checks include:

- products that need restocking
- inactive products
- inventory value by category
- supplier inventory value
- high profit margin products

For example, if the restocking query returns rows, that is useful. It tells the shop owner which products may need to be reordered.

## 6. Common Beginner Mistakes

### Thinking No Rows Means Failure

For many data quality checks, no rows is a good result.

Example:

If the negative price check returns no rows, it means there are no negative prices.

### Thinking Every Result Means Bad Data

Some queries are designed to return useful business results.

Example:

The restocking query should return products that need attention. Those rows are business insight, not necessarily errors.

### Forgetting to Connect to the Correct Database

After creating the database, make sure you connect to:

```text
stationery_shop
```

before creating tables or loading data.

### Loading the CSV Into the Wrong Table

Always confirm that the data is loaded into the `products` table.

### Ignoring File Path Issues

CSV loading can fail if PostgreSQL cannot read the file path.

For pgAdmin users, using the Import/Export Data tool or a simple path such as `C:/tmp/products.csv` may be easier.

## 7. How This Connects to Real Data Engineering

Real data engineering is not only about moving data from one place to another.

It is also about making sure the data is reliable before people use it for decisions.

This project introduces the same basic pattern used in real data work:

- load source data
- validate the data
- identify errors
- separate errors from business insights
- document the checks
- use clean data for reporting

Even though this is a beginner project, the data quality mindset is professional. A reliable data pipeline should not only load data. It should also prove that the data is safe to use.
