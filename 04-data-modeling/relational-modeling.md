# Relational Modeling

## 1. What It Is

Relational modeling is the practice of organizing data into tables with defined columns, keys, and relationships. It is based on the idea that business entities such as customers, products, orders, suppliers, and inventory can be represented as related tables.

In a relational model, each table should have a clear purpose and each row should represent one instance of that purpose.

## 2. Why It Matters

Relational modeling helps Data Engineers build systems that are consistent, queryable, and easier to validate.

It matters because:

- Business data is often relational by nature.
- SQL depends on clear table relationships.
- Good models reduce duplication and confusion.
- Constraints can protect data quality.
- Joins become safer when keys are well designed.
- Data warehouses often start from relational source systems.

Without relational modeling, data becomes a collection of disconnected files and unclear spreadsheets.

## 3. Core Concepts

- **Entity:** A business object such as customer, product, sale, or supplier.
- **Table:** A collection of records for one entity or event.
- **Row:** One record in a table.
- **Column:** One attribute of a row.
- **Primary key:** A unique identifier for each row.
- **Foreign key:** A reference from one table to another.
- **Relationship:** How tables connect, such as one-to-many or many-to-many.
- **Constraint:** A database rule that protects validity.
- **Cardinality:** The number of possible related records between tables.
- **Grain:** What one row represents.

## 4. Real Business Example

A small stationery shop tracks customers, products, and sales.

The business needs to answer:

- Which customers buy most often?
- Which products sell fastest?
- Which product categories generate the most revenue?
- Which sales happened online versus in-store?

A relational model might include:

- `customers`: one row per customer
- `products`: one row per product
- `sales`: one row per sales transaction line
- `inventory`: one row per product stock record

This model lets the shop connect sales to customers and products using keys.

## 5. Simple Data Model Example

```sql
CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    customer_segment VARCHAR(50) NOT NULL
);

CREATE TABLE products (
    product_id INTEGER PRIMARY KEY,
    product_name VARCHAR(120) NOT NULL,
    category VARCHAR(80) NOT NULL
);

CREATE TABLE sales (
    sale_id INTEGER PRIMARY KEY,
    customer_id INTEGER NOT NULL REFERENCES customers (customer_id),
    product_id INTEGER NOT NULL REFERENCES products (product_id),
    sale_date DATE NOT NULL,
    quantity INTEGER NOT NULL,
    unit_price NUMERIC(10, 2) NOT NULL
);
```

Grain:

- `customers`: one row per customer
- `products`: one row per product
- `sales`: one row per product sold in a transaction

## 6. Production Considerations

- Define the grain of every table.
- Use stable keys rather than names as identifiers.
- Add constraints for important rules.
- Avoid mixing multiple business concepts into one table.
- Document relationships between tables.
- Validate foreign key relationships.
- Plan for source-system changes.
- Use clear naming conventions.

## 7. Common Mistakes

- Joining tables by names instead of IDs.
- Creating tables without primary keys.
- Not defining grain.
- Storing repeated groups in one column.
- Mixing customer, order, and product fields in one flat table without purpose.
- Ignoring many-to-many relationships.
- Assuming source system IDs are always clean and stable.

## 8. Practice Task

Design a relational model for a small stationery shop.

Include:

1. Customers
2. Products
3. Sales
4. Inventory
5. Suppliers

For each table, define:

- Grain
- Primary key
- Important columns
- Foreign keys
- One data quality rule

## 9. Related Project

- `04-data-modeling/retail-data-model-example/`: Retail star schema example.
- `02-sql-and-databases/`: SQL joins depend on relational modeling.
- `17-projects/`: Retail and inventory projects should start with clear entities and relationships.
