# Pipeline Checklist

Use this checklist before treating a pipeline as ready for repeated use.

## Source Check

- [ ] Source system or file location is identified.
- [ ] Source owner is known.
- [ ] Expected delivery schedule is documented.
- [ ] Source file naming pattern or API endpoint is documented.
- [ ] Raw data is preserved when needed for audit or replay.
- [ ] Sensitive fields are identified.

## Schema Check

- [ ] Required columns are listed.
- [ ] Data types are defined.
- [ ] Primary or business keys are identified.
- [ ] Nullable and non-nullable fields are documented.
- [ ] Expected date and timestamp formats are documented.
- [ ] Schema drift behavior is defined.

## Duplication Check

- [ ] Duplicate detection rules are defined.
- [ ] Unique keys or constraints are used where possible.
- [ ] Rerun behavior is documented.
- [ ] Incremental loads use upsert or partition reload logic.
- [ ] Duplicate source records are logged or quarantined.

## Transformation Check

- [ ] Transformation steps are documented.
- [ ] Business rules are explained in plain language.
- [ ] Metric formulas are defined.
- [ ] Join keys are validated.
- [ ] Row counts are checked before and after joins.
- [ ] Null handling is explicit.

## Loading Check

- [ ] Target table or file location is defined.
- [ ] Load mode is documented: append, replace, upsert, or partition reload.
- [ ] Load operation is safe to rerun.
- [ ] Transactions are used for multi-step writes when needed.
- [ ] Empty outputs are handled intentionally.
- [ ] Load row count is logged.

## Quality Check

- [ ] Required fields are checked for missing values.
- [ ] Numeric fields are checked for valid ranges.
- [ ] Date fields are checked for valid ranges.
- [ ] Relationship checks are included.
- [ ] Aggregate totals are compared where possible.
- [ ] Failed records are rejected, quarantined, or clearly reported.

## Monitoring Check

- [ ] Pipeline start and finish are logged.
- [ ] Runtime duration is tracked.
- [ ] Source and target row counts are logged.
- [ ] Failure alerts are defined.
- [ ] Freshness expectations are defined.
- [ ] Volume anomalies are monitored.
- [ ] Owner or escalation path is documented.

## Documentation Check

- [ ] Pipeline purpose is documented.
- [ ] Inputs and outputs are documented.
- [ ] Setup and run commands are included.
- [ ] Environment variables are listed.
- [ ] Known limitations are documented.
- [ ] Backfill instructions are included.
- [ ] Business owner and technical owner are listed.
