# ETL Vs ELT

## 1. What It Is

ETL and ELT are two common patterns for moving and preparing data.

**ETL** means Extract, Transform, Load. Data is extracted from a source, transformed before reaching the final storage system, then loaded into the target.

**ELT** means Extract, Load, Transform. Data is extracted from a source, loaded into a storage system first, then transformed inside the database, warehouse, or lakehouse.

The main difference is where transformation happens.

## 2. Why It Matters

The choice between ETL and ELT affects architecture, cost, performance, debugging, governance, and team workflow.

Data Engineers need to understand both patterns because modern systems often use a mix:

- ETL for sensitive data, file cleanup, and pre-load validation.
- ELT for warehouse transformations, analytics models, and scalable SQL processing.

The right pattern depends on the data source, target platform, data volume, transformation complexity, compliance needs, and team skills.

## 3. When to Use It

Use ETL when:

- Data must be cleaned before entering the target system.
- The target system should not store raw sensitive data.
- Transformations are easier in Python or another processing tool.
- Source files are messy and need validation first.
- The target database is not designed for heavy transformation.

Use ELT when:

- You have a warehouse or lakehouse that can transform data efficiently.
- You want to preserve raw data for audit and replay.
- Transformations are mostly SQL-based.
- Analysts or analytics engineers need to build modeled layers.
- You want clearer separation between raw, staging, and mart layers.

## 4. Real Business Example

A stationery shop sells online and in-store.

The ecommerce API returns JSON orders. The point-of-sale system exports CSV files. Inventory arrives from supplier spreadsheets.

An ETL approach might clean files with Python before loading only valid records into PostgreSQL.

An ELT approach might load raw orders, raw sales, and raw inventory files into a warehouse first, then use SQL transformations to create clean customer, product, sales, and inventory tables.

In practice, the shop may use both: Python validates that files exist and are readable, then SQL transforms loaded data into reporting models.

## 5. Technical Example

ETL pattern:

```text
Source CSV -> Python validation and cleaning -> PostgreSQL reporting table
```

ELT pattern:

```text
Source CSV -> Raw warehouse table -> SQL staging model -> Analytics mart
```

Simple ETL pseudocode:

```python
raw_orders = extract_orders("orders.csv")
clean_orders = transform_orders(raw_orders)
load_orders(clean_orders, "orders_clean")
```

Simple ELT SQL flow:

```sql
CREATE TABLE staging_orders AS
SELECT
    order_id,
    customer_id,
    order_date,
    quantity * unit_price AS revenue
FROM raw_orders
WHERE order_status = 'completed';
```

## 6. Production Considerations

- Preserve raw data when auditability matters.
- Validate schema before transformation.
- Keep transformation logic documented.
- Separate raw, staging, intermediate, and mart layers.
- Avoid mixing extraction and business logic without reason.
- Consider where compute is cheapest and most reliable.
- Protect sensitive data before loading it broadly.
- Design pipelines so they can be rerun safely.

## 7. Common Mistakes

- Treating ETL and ELT as competing religions instead of patterns.
- Transforming data without preserving raw inputs.
- Loading raw sensitive data without access controls.
- Putting all business logic in untested Python scripts.
- Building warehouse transformations directly on messy raw tables without staging.
- Choosing a pattern based only on tool popularity.

## 8. Practice Task

Choose a retail data source such as daily sales CSV, ecommerce orders API, or supplier inventory spreadsheet.

Write two designs:

1. An ETL design.
2. An ELT design.

For each design, explain:

- Where raw data is stored.
- Where validation happens.
- Where transformation happens.
- What the final table is.
- Which design is better for the scenario and why.

## 9. Related Project

- `05-etl-elt-pipelines/templates/python-etl-template.py`: Starter ETL script structure.
- `06-data-warehousing/`: ELT is common in warehouse modeling.
- `09-dbt-and-analytics-engineering/`: SQL-based ELT transformations are central to analytics engineering.
