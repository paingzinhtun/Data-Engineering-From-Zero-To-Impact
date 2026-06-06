# Business Problem

## 1. Business Background

A small stationery shop sells products such as pens, notebooks, paper, office tools, art supplies, and accessories.

The shop currently manages its product catalog in a spreadsheet. This works at the beginning, but it becomes harder to manage as the number of products, suppliers, and stock updates grows.

## 2. Current Problem

The shop needs reliable product data to support inventory and profit decisions.

When product data is managed only in a spreadsheet, the business may face problems such as:

- Different staff using different copies of the same file
- Product prices or stock quantities being updated manually
- Duplicate product records
- Missing product names, categories, or supplier details
- Slow manual reporting
- Poor visibility into low-stock products

These problems can lead to wrong business decisions, such as ordering too late, selling products at poor margins, or not knowing which categories hold the most inventory value.

## 3. Why Spreadsheet-Only Tracking Is Risky

Spreadsheets are useful for simple tracking, but they are not always reliable as a long-term data foundation.

Spreadsheet-only tracking is risky because:

- Data can be edited without strong validation rules
- There may be no clear version of the truth
- Manual calculations can be inconsistent
- It is difficult to audit when data was loaded or changed
- Reporting depends too much on manual work

For a growing shop, product data should be stored in a more structured and reliable system.

## 4. Project Goal

The goal of this project is to load a stationery shop product catalog from a CSV file into PostgreSQL.

This project is not only about moving data from CSV into a database. The bigger goal is to create a reliable data foundation for future inventory and sales analysis.

The project will:

- Store product catalog data in a PostgreSQL table
- Apply basic data quality rules
- Validate the loaded data
- Support useful business queries
- Make the process repeatable for beginners

## 5. Business Value

By moving product data into PostgreSQL, the shop can answer important business questions more easily:

- How many active products are currently sold?
- Which products need restocking?
- Which products have the highest profit per unit?
- Which categories hold the most inventory value?
- Which suppliers provide the highest value of stock?

This helps the business owner make better decisions about purchasing, pricing, restocking, and supplier management.

## 6. Who Benefits From This Project

This project benefits:

- Business owners who need better inventory visibility
- Shop staff who need accurate product information
- Purchasing teams who need to know what to reorder
- Finance or accounting users who care about cost and profit
- Beginner data engineers who want to learn how business data moves into a database

## 7. How This Connects to Data Engineering

Data engineering is about building reliable systems that move, store, validate, and prepare data for analysis.

This project demonstrates important beginner data engineering ideas:

- Reading source data from a CSV file
- Creating a structured database table
- Loading data into PostgreSQL
- Validating data quality with SQL
- Writing business queries for decision making
- Documenting the workflow so it can be repeated

Even though this is a small project, it follows the same basic pattern used in real data engineering work: source data, load process, validation, storage, and business analysis.
