# CSV to PostgreSQL: Stationery Shop Product Catalog

## 1. Project Overview

This is Project 01 in a larger data engineering learning roadmap.

The project loads a stationery shop product catalog from a CSV file into PostgreSQL. After loading the data, SQL queries are used to validate the data and answer simple business questions about inventory, suppliers, and profit.

The focus is not only on loading a CSV file. The main goal is to build a reliable data foundation that a small business could use for future inventory and sales analysis.

This project is intentionally small and practical. It uses only CSV, PostgreSQL, SQL, and Markdown.

## 2. Business Problem

A small stationery shop currently tracks product catalog data in a spreadsheet.

This creates common business problems:

- Product data may be copied into multiple files
- Manual updates can create mistakes
- Duplicate or missing product records may appear
- Low-stock products are hard to monitor
- Profit and inventory reports take too much manual work

The shop needs a more reliable way to store and query product data.

## 3. Project Goal

The goal of this project is to:

- Load product catalog data from CSV into PostgreSQL
- Store the data in a structured `products` table
- Validate that the loaded data is clean and reliable
- Run business queries for inventory and profit analysis
- Document the workflow clearly for beginners

## 4. What This Project Demonstrates

This project demonstrates beginner data engineering concepts:

- Organizing a small data project
- Creating a PostgreSQL database
- Creating a table with proper data types and constraints
- Loading CSV data into PostgreSQL
- Running data quality checks
- Writing SQL queries for business analysis
- Documenting setup steps and expected outputs

## 5. Tools Used

- CSV file
- PostgreSQL
- SQL scripts
- pgAdmin or psql
- Markdown documentation

No Python, Docker, Airflow, dbt, or cloud tools are used in this project.

## 6. Dataset Description

The dataset contains more than 100 stationery shop products.

Example product categories:

- Writing
- Paper
- Office Tools
- Art Supplies
- Accessories

Main columns:

| Column | Description |
| --- | --- |
| `product_id` | Unique product identifier |
| `product_name` | Name of the product |
| `category` | Product category |
| `brand` | Product brand |
| `cost_price` | Purchase cost for the shop |
| `selling_price` | Selling price to customers |
| `stock_quantity` | Current stock available |
| `reorder_level` | Minimum stock level before reorder |
| `supplier_name` | Supplier providing the product |
| `is_active` | Whether the product is currently sold |
| `loaded_at` | Timestamp automatically added when data is loaded into PostgreSQL |

The CSV file does not include `loaded_at`. PostgreSQL fills this column automatically during the load.

## 7. Project Folder Structure

```text
01-csv-to-postgres/
+-- data/
|   +-- products.csv
+-- sql/
|   +-- 01_create_database.sql
|   +-- 02_create_table.sql
|   +-- 03_load_data.sql
|   +-- 04_validation_queries.sql
|   +-- 05_business_queries.sql
+-- docs/
|   +-- business-problem.md
|   +-- architecture.md
|   +-- setup.md
|   +-- expected-output.md
|   +-- data-quality-checks.md
|   +-- learning-notes.md
|   +-- portfolio-story.md
+-- screenshots/
|   +-- .gitkeep
+-- README.md
+-- .gitignore
```

## 8. Data Flow

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

## 9. How to Run the Project

Detailed setup instructions are available in:

```text
docs/setup.md
```

Quick run order:

### Step 1: Create the Database

Run:

```text
sql/01_create_database.sql
```

Database name:

```text
stationery_shop
```

### Step 2: Connect to the Database

Connect to the `stationery_shop` database before running the next scripts.

In psql:

```sql
\c stationery_shop
```

### Step 3: Create the Products Table

Run:

```text
sql/02_create_table.sql
```

This creates the `products` table with data types, constraints, and default values.

### Step 4: Load the CSV Data

Run:

```text
sql/03_load_data.sql
```

The load script is designed for psql beginners and uses `\copy` to load the local CSV file:

```powershell
cd path\to\Data-Engineering-From-Zero-To-Impact\17-projects\beginner\01-csv-to-postgres
psql -U postgres -d stationery_shop -f sql/03_load_data.sql
```

Run this command from the project root folder so this relative path can be found:

```text
data/products.csv
```

For pgAdmin users, the Import/Export Data tool may be easier than running the `\copy` script.

### Step 5: Run Validation Queries

Run:

```text
sql/04_validation_queries.sql
```

Some checks should return `0 rows`. That usually means the data passed the quality check.

### Step 6: Run Business Queries

Run:

```text
sql/05_business_queries.sql
```

These queries answer practical inventory and profit questions.

## 10. Validation Checks

The project validates:

- total row count
- missing product names
- missing categories
- negative cost or selling prices
- selling price lower than cost price
- negative stock or reorder levels
- duplicate product IDs
- duplicate product name and brand combinations
- products needing restocking
- inactive products
- missing `loaded_at` values

Important note:

Not every query returning rows means there is an error. For example, products needing restocking are useful business insight, not bad data.

## 11. Business Questions Answered

The SQL business queries answer:

1. How many active products does the shop sell?
2. Which products need restocking?
3. Which products have the highest profit per unit?
4. Which products have the highest profit margin percentage?
5. What is the total inventory cost value?
6. What is the total potential sales value?
7. What is the inventory value by category?
8. Which supplier provides the highest inventory value?
9. Which category has the most products?
10. Which products have low stock but high profit margin?

## 12. Example Insights

Example insights from this project:

- Some active products are at or below their reorder level and should be reviewed for purchasing.
- Paper has a high inventory cost value, so it may need close stock monitoring.
- Some low-cost accessories have strong profit margin percentages.
- Supplier inventory value helps identify which suppliers are most important to the shop.
- Inactive products should be separated from active inventory analysis.

These insights help the shop owner make better decisions about restocking, pricing, and supplier management.

## 13. Screenshots

Screenshots can be added later to show:

- `stationery_shop` database in pgAdmin
- `products` table structure
- successful CSV load with 120 rows
- validation query showing total row count
- validation checks that return `0 rows`
- restocking query results
- inventory value by category
- supplier inventory value

Suggested folder:

```text
screenshots/
```

## 14. What I Learned

In this project, I learned how to:

- structure a beginner data engineering project
- move CSV data into PostgreSQL
- design a table with useful constraints
- validate loaded data using SQL
- separate data quality errors from business insights
- write SQL queries that support real business decisions
- document a project for GitHub portfolio readers

## 15. Future Improvements

Future versions could add:

- staging table for raw CSV data
- load log table
- monthly inventory snapshots
- sales transaction data
- dashboard connected to PostgreSQL
- automated loading in a later project
- Python loader in a later project

These improvements are intentionally not included in Project 01 so the first version stays simple and beginner-friendly.

Production note:

In a real business system, CSV loading would usually be automated and logged. This project keeps the process manual so beginners can understand each step clearly.

## 16. Portfolio Explanation

This project shows the foundation of a simple data engineering workflow:

```text
Source data -> Database load -> Data validation -> Business analysis
```

It is small enough for beginners to understand but still connected to a real business problem.

The project demonstrates that data engineering is not only about tools. It is about creating reliable data that helps people make better decisions.
