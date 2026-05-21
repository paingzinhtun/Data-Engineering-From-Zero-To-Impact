# dbt Project Structure

## 1. What It Is

dbt project structure is the organization of files and folders used to manage models, tests, documentation, macros, seeds, and configuration.

A clear project structure helps teams understand where transformations belong and how data moves through layers.

## 2. Why It Matters

Without structure, dbt projects can become a pile of SQL files. A good structure supports maintainability, review, onboarding, and production reliability.

It helps teams:

- Separate staging, intermediate, and mart logic.
- Find models quickly.
- Apply naming conventions.
- Manage tests and docs.
- Review changes by layer.
- Scale the project over time.

## 3. When to Use It

Use a clear dbt project structure from the beginning of any serious dbt project.

It is especially important when:

- More than one person contributes.
- Models feed dashboards.
- There are many source systems.
- The project supports production reporting.
- Tests and documentation are required.

## 4. Real Business Example

A retail dbt project starts with only sales data, then adds inventory, customers, suppliers, and product performance reporting.

If the project has clear folders from the beginning, the team can add new models without confusion.

Example:

- Sales staging models go in `models/staging/sales/`.
- Inventory staging models go in `models/staging/inventory/`.
- Shared enriched models go in `models/intermediate/`.
- Business-facing marts go in `models/marts/`.

## 5. Technical Example

Example structure:

```text
dbt_retail_project/
  dbt_project.yml
  models/
    staging/
      sources.yml
      stg_sales.sql
      stg_products.sql
      stg_customers.sql
      stg_inventory_snapshots.sql
    intermediate/
      int_sales_enriched.sql
    marts/
      core/
        dim_product.sql
        dim_customer.sql
        fact_sales.sql
      reporting/
        mart_daily_sales.sql
        mart_inventory_reorder.sql
  seeds/
    product_category_mapping.csv
  tests/
  macros/
```

Model naming pattern:

```text
stg_      source-cleaned staging models
int_      reusable intermediate models
dim_      dimensions
fact_     facts
mart_     business-facing marts
```

## 6. Production Considerations

- Use consistent naming conventions.
- Keep staging models close to source systems.
- Keep marts aligned with business domains.
- Store docs and tests near related models.
- Use project configuration intentionally.
- Avoid circular model dependencies.
- Make ownership clear for critical marts.
- Keep the structure simple enough for contributors to understand.

## 7. Common Mistakes

- Putting every model in one folder.
- Mixing staging and mart logic.
- Using inconsistent prefixes.
- Creating too many folders too early.
- Not documenting folder purpose.
- Letting temporary analysis models become production models.
- Not separating business-facing marts from technical layers.

## 8. Practice Task

Design a dbt folder structure for retail analytics.

Include:

1. Staging folder.
2. Intermediate folder.
3. Core marts folder.
4. Reporting marts folder.
5. Seeds folder.
6. Tests folder.
7. Naming conventions.
8. One example model in each layer.

## 9. Related Project

- `09-dbt-and-analytics-engineering/dbt-retail-project/`: Defines a retail dbt project flow.
- `06-data-warehousing/warehouse-project/`: dbt can implement the warehouse transformations.
- `14-production-engineering/`: Project structure supports maintainability and review.
