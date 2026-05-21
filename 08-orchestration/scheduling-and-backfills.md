# Scheduling And Backfills

## 1. What It Is

Scheduling defines when a pipeline runs. Backfilling means running a pipeline for past dates or time periods.

Schedules keep data fresh. Backfills help recover missed runs, rebuild historical data, or apply improved logic to old periods.

## 2. Why It Matters

Business users often expect data at a specific time. If a retail sales dashboard is used every morning, the pipeline schedule must match source data availability and business needs.

Backfills matter because pipelines change and failures happen. A professional pipeline should be able to rerun historical periods safely.

## 3. When to Use It

Use scheduling when:

- Data must refresh repeatedly.
- Business users need predictable updates.
- Source data arrives on a known cadence.
- Tasks need automated execution.

Use backfills when:

- A pipeline failed for past dates.
- Logic changed and historical data must be rebuilt.
- A new table needs historical population.
- Late-arriving data needs correction.

## 4. Real Business Example

A POS system exports yesterday's sales at 11:30 PM.

The retail dashboard is reviewed at 8:00 AM.

A good schedule might run at 1:00 AM, leaving time for the file to arrive and the pipeline to finish before business review.

If the pipeline fails for January 10, a backfill should rerun only January 10 without duplicating sales or damaging later dates.

## 5. Technical Example

Daily schedule concept:

```text
source arrival: 23:30
pipeline schedule: 01:00
dashboard expected fresh by: 08:00
```

Backfill concept:

```text
rerun batch_date=2026-01-10
delete/reload only the 2026-01-10 partition
validate row counts
refresh affected marts
```

Airflow schedule example:

```python
@dag(
    dag_id="retail_daily_pipeline",
    schedule="@daily",
    catchup=False,
)
def retail_daily_pipeline():
    ...
```

## 6. Production Considerations

- Schedule after source data is expected to arrive.
- Define timezone behavior clearly.
- Make pipelines safe to rerun by date.
- Use batch dates consistently.
- Plan for late-arriving data.
- Avoid accidental massive backfills.
- Validate outputs after backfills.
- Communicate historical metric changes to users.

## 7. Common Mistakes

- Scheduling before source files arrive.
- Confusing run date with business data date.
- Enabling catchup without understanding impact.
- Backfilling non-idempotent pipelines.
- Rebuilding history without notifying business users.
- Ignoring timezone differences.
- Not testing one-day reruns before large backfills.

## 8. Practice Task

Design scheduling and backfill behavior for a daily sales pipeline.

Define:

1. Source arrival time.
2. Pipeline run time.
3. Business reporting deadline.
4. Batch date rule.
5. Backfill command or process.
6. Tables affected by backfills.
7. Validation after backfill.
8. Communication plan for changed historical metrics.

## 9. Related Project

- `08-orchestration/airflow-project/`: Daily retail pipeline scheduling example.
- `05-etl-elt-pipelines/incremental-loading.md`: Incremental loads and backfills need careful state handling.
- `05-etl-elt-pipelines/idempotency.md`: Backfills require rerunnable logic.
