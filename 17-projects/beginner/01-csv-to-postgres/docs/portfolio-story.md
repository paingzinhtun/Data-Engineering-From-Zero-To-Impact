# Portfolio Story

## 1. Short Project Summary

This project loads a stationery shop product catalog from a CSV file into PostgreSQL.

After loading the data, I used SQL to validate the product data and answer simple business questions about inventory, restocking, suppliers, and profit.

This is a beginner data engineering project focused on building a reliable data foundation from spreadsheet-style data.

## 2. Business Problem Explanation

A small stationery shop tracks product catalog data in a spreadsheet.

This can work at first, but it creates problems as the business grows:

- product data can be copied into multiple files
- manual updates can create mistakes
- low-stock products can be missed
- profit analysis can take too much manual work
- reporting depends on spreadsheet cleanup

The business needs a more reliable way to store and analyze product data.

## 3. Technical Implementation Explanation

I created a simple data workflow:

```text
CSV file -> PostgreSQL table -> validation queries -> business queries
```

The project includes:

- a realistic `products.csv` file
- a PostgreSQL database named `stationery_shop`
- a `products` table with proper data types
- constraints to protect basic data quality
- a CSV load script
- validation SQL queries
- business analysis SQL queries
- Markdown documentation for setup and learning

The project intentionally uses only CSV, PostgreSQL, SQL, and Markdown so the first version stays beginner-friendly.

It does not use Python, Docker, Airflow, dbt, or cloud tools because the goal of Project 01 is to understand the foundation first.

## 4. Business Value Created

This project helps the shop understand its product catalog more clearly.

The SQL queries can answer questions such as:

- how many active products are sold
- which products need restocking
- which products have high profit per unit
- which categories hold the most inventory value
- which suppliers provide the highest value of stock

This supports better decisions about restocking, pricing, supplier management, and inventory planning.

## 5. Skills Demonstrated

This project demonstrates:

- CSV data preparation
- PostgreSQL database creation
- table design
- SQL data loading
- data type selection
- primary key usage
- check constraints
- data validation
- business analysis with SQL
- beginner-friendly documentation
- connecting technical work to business value

## 6. What I Learned

I learned that data engineering is not only about moving data.

It is also about making sure data is reliable enough for business decisions.

Key lessons:

- data needs structure before it can support reporting
- constraints help prevent bad data
- validation queries help build trust in loaded data
- not every query returning rows means an error
- restocking results are business insight, not bad data
- documentation makes a project easier for others to understand

## 7. How I Would Explain This In An Interview

I would explain it like this:

> This was my first practical data engineering project. I used a stationery shop scenario where product catalog data was stored in a CSV file. I designed a PostgreSQL table, loaded the CSV data, added constraints for basic data quality, and wrote validation queries to confirm the load worked correctly. Then I wrote business queries to identify active products, low-stock items, high-margin products, inventory value by category, and supplier inventory value. The project is small, but it shows the core data engineering workflow: load data, validate data, store it reliably, and use it for business analysis.

## 8. LinkedIn Post Draft

I completed Project 01 in my data engineering learning roadmap: CSV to PostgreSQL for a stationery shop product catalog.

The business scenario was simple: a small stationery shop tracks products in a spreadsheet and needs more reliable data for inventory and profit analysis.

In this project, I:

- created a realistic product catalog CSV
- designed a PostgreSQL products table
- loaded CSV data into PostgreSQL
- added basic constraints for data quality
- wrote validation queries
- wrote business analysis queries for restocking, profit, suppliers, and inventory value
- documented the project for beginners

This project helped me understand that data engineering is not just about loading data. It is about creating a reliable data foundation for business decisions.

## 9. GitHub Project Description

A beginner-friendly data engineering project that loads a stationery shop product catalog from CSV into PostgreSQL, validates the loaded data, and uses SQL to answer inventory and profit analysis questions.

Tools used:

- CSV
- PostgreSQL
- SQL
- Markdown

Project focus:

- reliable data loading
- data quality checks
- business-focused SQL queries
- beginner-friendly documentation

## 10. Future Version Ideas

Future versions could add:

- a staging table for raw CSV data
- a load log table
- monthly inventory snapshots
- sales transaction data
- more advanced profit analysis
- a simple dashboard connected to PostgreSQL
- a Python loader in a later project

These improvements would make the project more realistic, but they are intentionally left out of Project 01 so the first version stays focused and easy to understand.
