/*
  Project: CSV to PostgreSQL Product Catalog
  Script: 03_load_data.sql

  Purpose:
  Load data/products.csv into the products table.

  Recommended beginner method:
  Run this script with psql from the project root folder.

  Example:
  cd path\to\Data-Engineering-From-Zero-To-Impact\17-projects\beginner\01-csv-to-postgres
  psql -U postgres -d stationery_shop -f sql/03_load_data.sql

  Why this script uses \copy:
  \copy is a psql command. It reads the CSV file from your local computer.
  This avoids many PostgreSQL server file permission issues on Windows.

  Important:
  \copy works in psql. It may not work in pgAdmin Query Tool.
*/

/*
  BEGIN starts a transaction.
  If the CSV load fails, PostgreSQL can roll back the changes instead of
  leaving the table empty after TRUNCATE.
*/
BEGIN;

/*
  TRUNCATE removes existing rows before loading the CSV again.
  This makes the script safe to rerun during practice.

  RESTART IDENTITY is included for good habit when tables use generated IDs.
  In this project, product_id comes from the CSV, so it is not required,
  but it is still safe here.
*/
TRUNCATE TABLE products RESTART IDENTITY;

/*
  Load only the columns that exist in products.csv.
  The loaded_at column is not included because PostgreSQL fills it automatically
  using DEFAULT CURRENT_TIMESTAMP.

  The path data/products.csv is relative to the folder where you run psql.
  Run psql from the project root folder so this path can be found.
*/
\copy products (
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
FROM 'data/products.csv'
WITH (
    FORMAT csv,
    HEADER true
);

/*
  COMMIT saves the loaded rows only after the load succeeds.
*/
COMMIT;

/*
  pgAdmin note:

  pgAdmin Query Tool usually runs standard SQL, not psql commands.
  If \copy does not work in pgAdmin, use one of these options:

  Option 1:
  Use pgAdmin Import/Export Data on the products table.

  Option 2:
  Copy data/products.csv to C:/tmp/products.csv and run the COPY command below
  in pgAdmin.

  If you use this pgAdmin option, run TRUNCATE first only when you are ready
  to replace the existing table data.

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
*/
