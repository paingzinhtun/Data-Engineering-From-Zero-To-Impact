# Learning Notes

## 1. What Is a CSV File?

A CSV file is a simple text file used to store data in rows and columns.

CSV means comma-separated values.

In this project, the CSV file stores the stationery shop product catalog.

Example:

```text
product_id,product_name,category,cost_price,selling_price
1,Blue Ballpoint Pen,Writing,350,500
```

Why it matters in business:

Many small businesses start with spreadsheet data. A CSV file is a simple way to move that data into another system, such as PostgreSQL.

## 2. What Is PostgreSQL?

PostgreSQL is a database system.

It stores data in a structured way so users can query, validate, and analyze it.

In this project, PostgreSQL stores the stationery shop product catalog in a database named:

```text
stationery_shop
```

Why it matters in business:

PostgreSQL helps the shop keep product data more reliable than a spreadsheet alone.

## 3. What Is a Table?

A table stores data in rows and columns.

In this project, the table is named:

```text
products
```

Each row is one product.

Each column describes one part of the product, such as product name, category, price, stock quantity, or supplier.

Why it matters in business:

A table helps the shop organize product information clearly and consistently.

## 4. What Is a Schema?

A schema describes the structure of the data.

For this beginner project, the schema means the design of the `products` table.

It includes:

- column names
- data types
- required fields
- constraints

Why it matters in business:

A clear schema helps prevent messy data. For example, prices should go into price columns, and stock numbers should go into stock columns.

## 5. What Is Data Loading?

Data loading means moving data from one place into another place.

In this project, data is loaded from:

```text
data/products.csv
```

into:

```text
products table in PostgreSQL
```

Why it matters in business:

Loading data into PostgreSQL allows the shop to run reliable reports instead of manually checking spreadsheets.

## 6. What Is Data Validation?

Data validation means checking whether data is correct and safe to use.

In this project, validation checks include:

- missing product names
- missing categories
- negative prices
- negative stock quantities
- duplicate product IDs
- selling prices lower than cost prices

Why it matters in business:

Bad data can lead to bad decisions. For example, if stock quantity is wrong, the shop may reorder too late or buy too much.

## 7. What Is a Primary Key?

A primary key is a column that uniquely identifies each row in a table.

In this project, the primary key is:

```text
product_id
```

Each product should have one unique `product_id`.

Why it matters in business:

A primary key prevents confusion between products. The shop can update or report on the correct item.

## 8. What Are Data Types?

Data types tell PostgreSQL what kind of data each column should store.

Examples from this project:

- `INTEGER` for stock quantity
- `NUMERIC(10,2)` for prices
- `BOOLEAN` for active or inactive products
- `VARCHAR` for product names
- `TIMESTAMP` for load time

Why it matters in business:

Data types help keep data consistent. For example, stock quantity should be a number, not random text.

## 9. What Are Constraints?

Constraints are rules that protect data quality.

Examples from this project:

- `product_id` must be unique
- `product_name` cannot be empty
- `cost_price` cannot be negative
- `selling_price` cannot be negative
- `selling_price` must be greater than or equal to `cost_price`
- `stock_quantity` cannot be negative

Why it matters in business:

Constraints stop incorrect data from entering the table. This helps the shop trust its reports.

## 10. What Business Questions Can SQL Answer?

SQL can answer useful business questions from the product catalog.

Examples:

- How many active products does the shop sell?
- Which products need restocking?
- Which products have the highest profit per unit?
- Which categories have the highest inventory value?
- Which suppliers provide the most valuable stock?

Why it matters in business:

SQL turns stored data into information the shop owner can use for decisions.

## 11. How This Small Project Connects to Real Data Engineering

This project is small, but it follows a real data engineering pattern:

```text
Source data -> Load data -> Validate data -> Store data -> Analyze data
```

In this project:

- the CSV file is the source data
- PostgreSQL stores the data
- SQL scripts load and validate the data
- business queries answer inventory and profit questions

Why it matters in business:

Real data engineering helps businesses create reliable data foundations. Even a small stationery shop needs clean data to make better decisions about stock, prices, suppliers, and profit.
