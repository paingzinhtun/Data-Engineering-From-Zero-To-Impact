# 04 - Data Modeling

## What This Section Covers

This section covers how to design data structures that represent business processes clearly. Topics include entities, relationships, normalization, denormalization, facts, dimensions, keys, grain, and metric definitions.

## Why It Matters In Data Engineering

Poor data models create confusion, duplicated logic, slow queries, and inconsistent reporting. Good models make data easier to understand, validate, query, and reuse across teams.

## What You Should Be Able To Do

After studying this section, you should be able to:

- Identify core business entities and relationships.
- Define the grain of a table.
- Choose appropriate keys.
- Design normalized and dimensional models.
- Explain tradeoffs between storage, performance, and usability.
- Document metrics and business definitions.

## Related Projects In This Repo

- `17-projects/`: Retail warehouse, supplier performance, and customer 360 projects.
- `06-data-warehousing/`: Dimensional modeling and analytics-ready schema examples.

## Start Here

Recommended order:

1. [relational-modeling.md](relational-modeling.md)
2. [normalization-vs-denormalization.md](normalization-vs-denormalization.md)
3. [dimensional-modeling.md](dimensional-modeling.md)
4. [facts-and-dimensions.md](facts-and-dimensions.md)
5. [slowly-changing-dimensions.md](slowly-changing-dimensions.md)
6. [metric-definitions.md](metric-definitions.md)
7. [retail-data-model-example/](retail-data-model-example/)

Project: [Retail Sales Warehouse](../17-projects/intermediate/02-retail-sales-warehouse/)

## Navigation

Previous: [03 - Python For Data Engineering](../03-python-for-data-engineering/)  
Next: [05 - ETL ELT Pipelines](../05-etl-elt-pipelines/)
