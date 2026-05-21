# Pipeline Design Patterns

## 1. What It Is

Pipeline design patterns are reusable ways to structure data workflows. They help Data Engineers build pipelines that are understandable, reliable, and maintainable.

Common patterns include:

- Extract, validate, load, transform
- Raw to staging to mart
- Full refresh
- Incremental load
- Upsert
- Delete and reload partition
- Staging table before target table
- Quarantine invalid records
- Audit table for pipeline runs

## 2. Why It Matters

Without design patterns, pipelines become one-off scripts that are hard to debug and risky to rerun.

Patterns help teams:

- Reuse proven approaches.
- Reduce production risk.
- Improve documentation.
- Support backfills.
- Add monitoring consistently.
- Make onboarding easier.
- Build trust in data outputs.

## 3. When to Use It

Use pipeline design patterns when:

- Building a new ingestion workflow.
- Converting manual reports into automated pipelines.
- Adding reliability to an existing script.
- Designing warehouse layers.
- Handling bad source data.
- Planning retries and backfills.
- Standardizing team development.

Patterns should be adapted to the business problem, not followed blindly.

## 4. Real Business Example

A stationery shop wants to automate daily sales reporting.

A practical pattern:

1. Save the raw sales file unchanged.
2. Validate file and schema.
3. Load valid rows into a staging table.
4. Reject invalid rows into a quarantine table.
5. Transform staging rows into `fact_sales`.
6. Refresh `mart_daily_sales`.
7. Run data quality checks.
8. Record the pipeline run status.

This pattern makes the pipeline easier to operate than a single script that directly overwrites the final report.

## 5. Technical Example

Layered pipeline:

```text
source
  -> raw
  -> staging
  -> intermediate
  -> mart
```

Pipeline run audit table:

```sql
CREATE TABLE pipeline_runs (
    pipeline_run_id BIGSERIAL PRIMARY KEY,
    pipeline_name TEXT NOT NULL,
    batch_date DATE NOT NULL,
    status TEXT NOT NULL,
    source_row_count INTEGER,
    target_row_count INTEGER,
    started_at TIMESTAMP NOT NULL,
    finished_at TIMESTAMP
);
```

Quarantine pattern:

```sql
INSERT INTO rejected_sales (sale_id, rejection_reason)
SELECT
    sale_id,
    'quantity must be greater than zero'
FROM staging_sales
WHERE quantity <= 0;
```

## 6. Production Considerations

- Separate raw, staging, and business-ready outputs.
- Track pipeline run metadata.
- Make retries safe.
- Use transactions for multi-step writes.
- Keep invalid records for review when useful.
- Document failure behavior.
- Add validation before publishing outputs.
- Keep business logic centralized where possible.
- Design for backfills early.

## 7. Common Mistakes

- Writing one script that does everything without clear stages.
- Loading directly from raw files into final reporting tables.
- Not preserving raw inputs.
- Not tracking pipeline runs.
- Treating rejected records as invisible.
- Designing daily runs without backfill support.
- Mixing technical cleanup and business metric logic without documentation.

## 8. Practice Task

Design a pipeline for daily sales and inventory files.

Include:

1. Raw storage location.
2. Staging tables.
3. Validation rules.
4. Rejected record handling.
5. Target fact tables.
6. Mart refresh logic.
7. Pipeline audit table.
8. Monitoring and alerting rules.

## 9. Related Project

- `05-etl-elt-pipelines/templates/pipeline-checklist.md`: Checklist for pipeline readiness.
- `06-data-warehousing/`: Warehouses use layered modeling patterns.
- `17-projects/`: Project labs should follow clear pipeline design patterns.
