# dbt Sources And Seeds

## 1. What It Is

dbt sources define raw tables that already exist in the warehouse. They tell dbt where source data comes from and allow source freshness and lineage tracking.

dbt seeds are CSV files stored in the dbt project and loaded into the warehouse. Seeds are useful for small reference datasets.

## 2. Why It Matters

Sources and seeds help make dbt projects explicit and reproducible.

Sources help teams:

- Document raw input tables.
- Track lineage from source to mart.
- Test source assumptions.
- Monitor freshness.

Seeds help teams:

- Load small mapping tables.
- Maintain simple reference data in Git.
- Support consistent transformation logic.

## 3. When to Use It

Use sources when:

- Data is loaded by another ingestion process.
- dbt transformations depend on raw warehouse tables.
- Freshness should be monitored.
- Lineage should show where data starts.

Use seeds when:

- Reference data is small.
- Values change infrequently.
- The data should be version-controlled.
- Examples include category mappings, region mappings, or accepted status codes.

Do not use seeds for large operational datasets.

## 4. Real Business Example

A retail dbt project may define sources:

- `raw.sales`
- `raw.products`
- `raw.customers`
- `raw.inventory_snapshots`

It may also include a seed:

- `product_category_mapping.csv`

The seed maps messy source categories such as `notebook`, `note book`, and `stationery-notebooks` to a clean category named `Notebooks`.

## 5. Technical Example

Source definition:

```yaml
version: 2

sources:
  - name: raw
    database: retail_warehouse
    schema: raw
    tables:
      - name: sales
        description: Raw POS and ecommerce sales records.
        loaded_at_field: loaded_at
        freshness:
          warn_after:
            count: 24
            period: hour
          error_after:
            count: 48
            period: hour
```

Using a source in a model:

```sql
SELECT *
FROM {{ source('raw', 'sales') }}
```

Seed example:

```csv
source_category,standard_category
note book,Notebooks
notebook,Notebooks
pen,Pens
```

Seed command:

```bash
dbt seed
```

## 6. Production Considerations

- Define all important raw inputs as sources.
- Add freshness checks for time-sensitive sources.
- Document source owners and loading processes.
- Keep seeds small.
- Review seed changes like code.
- Do not put sensitive or large data in seed files.
- Use seeds for stable reference data, not transactional data.
- Test mappings created from seeds.

## 7. Common Mistakes

- Referencing raw tables directly without source definitions.
- Using seeds for large datasets.
- Forgetting freshness checks.
- Not documenting where sources come from.
- Treating seeds as hidden business logic.
- Not reviewing changes to mapping seeds.
- Storing sensitive data in seed CSVs.

## 8. Practice Task

Define dbt sources for a retail warehouse:

1. `raw.sales`
2. `raw.products`
3. `raw.customers`
4. `raw.inventory_snapshots`

Then design one seed file for product category standardization.

Explain:

- Why each source matters.
- Which source needs freshness checks.
- Why the seed is small enough for version control.

## 9. Related Project

- `09-dbt-and-analytics-engineering/dbt-retail-project/`: Uses raw retail sources and possible seeds.
- `05-etl-elt-pipelines/`: Ingestion pipelines create raw tables that dbt sources reference.
- `06-data-warehousing/`: Sources are the warehouse inputs for transformations.
