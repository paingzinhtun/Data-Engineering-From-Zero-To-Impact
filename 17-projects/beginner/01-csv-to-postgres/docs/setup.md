# Setup Guide

## Purpose

This guide helps beginners run the CSV to PostgreSQL product catalog project on their own computer.

The project uses:

- PostgreSQL
- CSV data
- SQL scripts
- Markdown documentation

No Python, Docker, cloud tools, or extra data engineering tools are required for this first project.

## 1. Install PostgreSQL

Download and install PostgreSQL from the official PostgreSQL website:

```text
https://www.postgresql.org/download/
```

During installation, remember:

- the PostgreSQL username, usually `postgres`
- the password you set
- the port, usually `5432`

PostgreSQL usually installs both:

- `psql`, the command line tool
- pgAdmin, the graphical user interface

## 2. Open psql or pgAdmin

You can use either psql or pgAdmin.

### Option A: psql

Open a terminal or PowerShell window.

Connect to PostgreSQL:

```powershell
psql -U postgres
```

If PostgreSQL asks for a password, enter the password you created during installation.

### Option B: pgAdmin

Open pgAdmin.

Then:

1. Connect to your PostgreSQL server
2. Enter your password if asked
3. Open the Query Tool when you are ready to run SQL scripts

## 3. Create the Database

Run this script first:

```text
sql/01_create_database.sql
```

### psql option

From the project folder:

```powershell
psql -U postgres -f sql/01_create_database.sql
```

### pgAdmin option

Open `sql/01_create_database.sql`, copy the SQL, paste it into the pgAdmin Query Tool, and run it.

This creates the database:

```text
stationery_shop
```

## 4. Connect to the Database

After creating the database, connect to `stationery_shop` before running the next scripts.

### psql option

```powershell
psql -U postgres -d stationery_shop
```

Or, if you are already inside psql:

```sql
\c stationery_shop
```

### pgAdmin option

In pgAdmin:

1. Refresh the database list
2. Click the `stationery_shop` database
3. Open the Query Tool for that database

## 5. Create the Products Table

Run this script:

```text
sql/02_create_table.sql
```

### psql option

From the project folder:

```powershell
psql -U postgres -d stationery_shop -f sql/02_create_table.sql
```

### pgAdmin option

Open `sql/02_create_table.sql`, copy the SQL, paste it into the Query Tool connected to `stationery_shop`, and run it.

This creates the `products` table.

## 6. Load the CSV File

The source CSV file is:

```text
data/products.csv
```

The project load script is:

```text
sql/03_load_data.sql
```

### Important Difference: COPY vs \copy

`COPY` is a PostgreSQL server command.

It tries to read the CSV file from the database server machine.

`\copy` is a psql command.

It reads the CSV file from your local computer and sends it to PostgreSQL.

### psql option

If you use psql, `\copy` is usually the easiest method.

From the project folder:

```powershell
psql -U postgres -d stationery_shop -f sql/03_load_data.sql
```

The script uses this relative path:

```text
data/products.csv
```

make sure you run the command from the project root folder:

```text
01-csv-to-postgres
```

The load script also uses a transaction. If the CSV load fails, PostgreSQL can roll back the load instead of leaving the table empty after `TRUNCATE`.

### pgAdmin option

The main `sql/03_load_data.sql` script is designed for psql.

pgAdmin query windows may not support `\copy` because it is a psql command, not normal SQL.

For pgAdmin users, there are two practical options.

### pgAdmin Option 1: Use the Import Tool

1. Right-click the `products` table
2. Choose Import/Export Data
3. Choose Import
4. Select the CSV file
5. Set format to CSV
6. Turn Header on
7. Match the CSV columns to the table columns
8. Run the import

This is often the easiest pgAdmin method.

### pgAdmin Option 2: Use COPY With an Absolute Path

If PostgreSQL has permission to read the file, you can use `COPY` with a full path.

Example:

```sql
COPY products (
    product_id,
    product_name,
    category,
    brand,
    cost_price,
    selling_price,
    stock_quantity,
    reorder_level,
    supplier_name,
    is_active
)
FROM 'C:/tmp/products.csv'
WITH (
    FORMAT csv,
    HEADER true
);
```

On Windows, using `C:/tmp/products.csv` may work better than loading from the Desktop because PostgreSQL may not have permission to read Desktop files.

## 7. Run Validation Queries

Run this script after loading the CSV:

```text
sql/04_validation_queries.sql
```

### psql option

```powershell
psql -U postgres -d stationery_shop -f sql/04_validation_queries.sql
```

### pgAdmin option

Open the script, paste it into the Query Tool connected to `stationery_shop`, and run it.

Some validation queries are expected to return `0 rows`.

That usually means the data passed the check.

## 8. Run Business Analysis Queries

Run this script:

```text
sql/05_business_queries.sql
```

### psql option

```powershell
psql -U postgres -d stationery_shop -f sql/05_business_queries.sql
```

### pgAdmin option

Open the script, paste it into the Query Tool connected to `stationery_shop`, and run it.

These queries answer business questions such as:

- which products need restocking
- which products have the highest profit
- which category has the most inventory value
- which supplier provides the highest value of stock

## 9. Common Errors and Fixes

### Error: database already exists

This can happen if you already created `stationery_shop`.

Fix:

Use the existing database, or drop it only if you are sure you want to start again.

For this beginner project, `01_create_database.sql` uses a simple `CREATE DATABASE` statement, so it is expected to fail if the database already exists.

### Error: relation products already exists

This means the `products` table already exists.

Fix:

If you only want to reload data, run `sql/03_load_data.sql`.

For this beginner project, `02_create_table.sql` uses a simple `CREATE TABLE` statement, so it is expected to fail if the table already exists.

### Error: could not open file for reading

This usually happens when using `COPY`.

PostgreSQL may not have permission to read the CSV file from your folder.

Fix:

- Use psql with `\copy`
- Or use pgAdmin Import/Export Data
- Or move the CSV to a simpler path such as `C:/tmp/products.csv`

### Error: \copy does not work in pgAdmin

`\copy` is a psql command.

It may not work in pgAdmin Query Tool.

Fix:

Use the pgAdmin Import/Export Data tool or use `COPY` with an absolute path.

### Error: extra data after last expected column

This can happen if CSV values contain commas that PostgreSQL reads as extra columns.

Fix:

For this beginner project, avoid commas inside CSV values.

### Error: null value violates not-null constraint

This means a required column has missing data.

Fix:

Check the CSV file and make sure required fields such as product name, category, prices, stock quantity, and reorder level are filled in.

### Error: check constraint violation

This means the data broke a business rule.

Examples:

- negative price
- negative stock quantity
- selling price lower than cost price

Fix:

Correct the CSV data, then reload it.

## Final Check

After setup is complete, you should be able to:

- see the `stationery_shop` database
- see the `products` table
- load more than 100 product rows
- run validation checks
- run business analysis queries

At this point, the project is ready for screenshots and portfolio documentation.
