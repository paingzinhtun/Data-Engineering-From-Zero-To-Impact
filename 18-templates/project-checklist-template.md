# Project Checklist Template

Use this checklist before calling a data engineering project complete.

This checklist tests completeness. Use the [business impact scorecard](business-impact-scorecard.md) separately to evaluate evidence, judgment, and value.

## 1. Problem Clarity

- [ ] The business problem is clearly stated.
- [ ] Target users are identified.
- [ ] The project explains why the data work matters.
- [ ] Expected business decisions or outputs are listed.
- [ ] Success criteria are defined.

## 2. Data Sources

- [ ] Source systems or files are documented.
- [ ] Source owners are identified where possible.
- [ ] Refresh frequency is documented.
- [ ] Expected schema is documented.
- [ ] Sample data is available.
- [ ] Source limitations are documented.

## 3. Schema Design

- [ ] Raw tables are defined.
- [ ] Staging tables are defined.
- [ ] Fact and dimension tables are defined where needed.
- [ ] Mart tables are defined for business outputs.
- [ ] Table grain is documented.
- [ ] Primary keys and foreign keys are identified.

## 4. Extraction

- [ ] Extraction logic is implemented or specified.
- [ ] Missing source handling is defined.
- [ ] API pagination is handled if needed.
- [ ] API timeouts and retries are considered.
- [ ] Raw data preservation is defined.
- [ ] Extraction logs row counts or file names.

## 5. Transformation

- [ ] Dates are standardized.
- [ ] IDs are cleaned.
- [ ] Numeric fields are validated.
- [ ] Business metrics are calculated.
- [ ] Joins are documented.
- [ ] Transformation assumptions are documented.

## 6. Loading

- [ ] Target tables are created.
- [ ] Load method is documented.
- [ ] Credentials are not hardcoded.
- [ ] Load process is idempotent or rerun behavior is documented.
- [ ] Incremental or full-refresh strategy is clear.
- [ ] Loaded row counts are logged.

## 7. Quality Checks

- [ ] Required columns are checked.
- [ ] Required fields are not null.
- [ ] Primary keys are unique.
- [ ] Duplicates are handled.
- [ ] Accepted values are checked.
- [ ] Referential integrity is checked.
- [ ] Freshness is checked.
- [ ] Revenue, cost, quantity, or other business sanity checks exist.

## 8. Tests

- [ ] Core transformation logic has tests.
- [ ] Edge cases are tested.
- [ ] Bad input behavior is tested.
- [ ] Tests can run locally.
- [ ] Test instructions are documented.

## 9. Documentation

- [ ] README is complete.
- [ ] Architecture is documented.
- [ ] Setup steps are documented.
- [ ] How to run the project is documented.
- [ ] Data model is documented.
- [ ] Data quality checks are documented.
- [ ] Expected outputs are documented.
- [ ] Future improvements are listed.

## 10. Deployment

- [ ] Local setup is reproducible.
- [ ] `.env.example` exists if environment variables are needed.
- [ ] Docker Compose exists if local services are needed.
- [ ] Scheduling approach is documented.
- [ ] CI/CD plan is documented if relevant.
- [ ] Deployment assumptions are documented.

## 11. Production Readiness

- [ ] Logging is implemented.
- [ ] Errors are handled clearly.
- [ ] Retries are used where appropriate.
- [ ] Backfill strategy is documented.
- [ ] Monitoring needs are documented.
- [ ] Alerting needs are documented.
- [ ] Security considerations are documented.
- [ ] Cost considerations are documented.
- [ ] Ownership and maintenance notes are included.
