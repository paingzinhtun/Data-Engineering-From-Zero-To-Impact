# Business Problem

A stationery shop stores product data in CSV files. The owner needs a reliable product table that can be queried with SQL.

Manual spreadsheet work creates problems:

- Product names are edited inconsistently.
- Prices are hard to validate.
- Inventory and sales files cannot easily join to product data.
- Reports depend on copy-paste work.

The goal is to load product CSV data into PostgreSQL and validate that important fields are present and clean.
