# Architecture

## 1. Architecture Overview

This project uses a simple data architecture for loading a stationery shop product catalog from a CSV file into PostgreSQL.

The main idea is to take product data from a spreadsheet-style file, store it in a database table, validate the data, and then use SQL queries to answer business questions.

This is Project 01, so the architecture is intentionally simple and beginner-friendly.

## 2. Data Flow Diagram Using Plain Text

```text
CSV File
   |
   v
PostgreSQL Table
   |
   v
Validation Queries
   |
   v
Business Analysis Queries
   |
   v
Future Dashboard
```

## 3. Components

### CSV File

The CSV file is the source data for the project.

It contains the stationery shop product catalog, including product names, categories, prices, stock quantities, reorder levels, suppliers, and active status.

Project file:

```text
data/products.csv
```

### PostgreSQL Database

PostgreSQL stores the product catalog in a structured table.

This makes the data easier to query, validate, and use for reporting than a spreadsheet alone.

Database name:

```text
stationery_shop
```

### SQL Scripts

The SQL scripts make the project repeatable.

Instead of manually creating tables and writing one-time commands, each step is saved in a script.

Scripts include:

- create the database
- create the products table
- load the CSV data
- validate the loaded data
- answer business questions

### Validation Queries

Validation queries check whether the loaded data is reliable.

They help find issues such as missing product names, missing categories, negative prices, duplicate product IDs, and missing load timestamps.

Clean validation results give more confidence that the data can be used for analysis.

### Business Queries

Business queries turn product data into useful information.

They help answer questions about active products, restocking needs, profit per unit, profit margin, inventory value, supplier value, and category size.

These queries help connect the technical work to real business decisions.

## 4. Why This Architecture Is Suitable for Beginners

This architecture is suitable for beginners because it uses only a few core tools:

- CSV for source data
- PostgreSQL for database storage
- SQL scripts for loading, validation, and analysis
- Markdown for documentation

The flow is easy to understand because each step has a clear purpose.

Beginners can learn how data moves from a file into a database without needing advanced tools.

## 5. Why This Architecture Is Useful for Small Businesses

Small businesses often start with spreadsheets because they are simple and familiar.

This architecture keeps the spreadsheet-style source file but adds a more reliable database layer.

For a stationery shop, this helps with:

- better inventory visibility
- easier restocking analysis
- clearer supplier tracking
- better profit analysis
- repeatable reporting

The business can still keep the process simple while improving data reliability.

## 6. Limitations of This Architecture

This architecture is useful for learning, but it has limitations:

- CSV loading is still manual
- There is no automated schedule
- There is no separate staging table
- There is no load history table
- File path handling can be different across computers
- Data changes are not tracked over time
- It is not designed for large production systems

These limitations are acceptable for Project 01 because the goal is to learn the basic data engineering workflow first.

## 7. Future Improvements

Future versions of this project could add:

- a staging table for raw CSV data
- a load log table to track each import
- stronger data quality checks
- monthly inventory snapshots
- sales data for revenue analysis
- a dashboard connected to PostgreSQL
- automated loading in a later project

For now, the architecture stays simple so beginners can focus on the foundation: load data, validate data, and use SQL to answer business questions.
