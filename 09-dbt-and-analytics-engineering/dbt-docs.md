# dbt Docs

## 1. What It Is

dbt docs are generated documentation for a dbt project. They describe models, columns, sources, tests, and lineage.

dbt can generate a documentation website that helps users understand how data flows from raw sources to final marts.

## 2. Why It Matters

Data models are only useful if people understand them. Documentation helps analysts, engineers, and business users know what a table means, how it is built, and whether it is appropriate for their question.

dbt docs help teams:

- Explain model grain.
- Document columns and metrics.
- Show lineage.
- Improve onboarding.
- Reduce repeated questions.
- Support review and governance.

## 3. When to Use It

Use dbt docs when:

- Models are used by analysts or business users.
- A table feeds dashboards.
- Metrics need explanation.
- Lineage matters.
- A project is shared across a team.
- New contributors need to understand the warehouse.

Documentation should be created as models are built, not after everything is finished.

## 4. Real Business Example

A retail analyst sees `mart_inventory_reorder` and wants to know whether `reorder_quantity` is actual purchase quantity or a recommendation.

Good dbt docs explain:

- The mart's purpose.
- Its grain.
- Source models.
- Column meanings.
- Refresh cadence.
- Metric formulas.
- Known limitations.

This prevents misuse of the data.

## 5. Technical Example

Model documentation YAML:

```yaml
version: 2

models:
  - name: mart_daily_sales
    description: Daily sales performance for retail reporting.
    columns:
      - name: sales_date
        description: Calendar date of the sale.
        tests:
          - not_null
          - unique
      - name: revenue
        description: Sum of quantity sold multiplied by unit price.
      - name: gross_profit
        description: Revenue minus product cost amount.
```

Common docs commands:

```bash
dbt docs generate
dbt docs serve
```

## 6. Production Considerations

- Document model purpose and grain.
- Document important columns and metrics.
- Keep docs updated with code changes.
- Include known limitations.
- Use lineage to review downstream impact.
- Publish docs where the team can access them.
- Treat undocumented critical models as incomplete.
- Review documentation in pull requests.

## 7. Common Mistakes

- Leaving descriptions blank.
- Writing descriptions that repeat the column name only.
- Not documenting grain.
- Not explaining business logic.
- Generating docs once and never updating them.
- Documenting only marts and ignoring important staging sources.
- Assuming lineage alone explains meaning.

## 8. Practice Task

Write dbt documentation for `mart_daily_sales`.

Include:

1. Model purpose.
2. Grain.
3. Source models.
4. Column descriptions.
5. Metric definitions.
6. Tests.
7. Known limitations.

Then explain how a business user should use the model.

## 9. Related Project

- `09-dbt-and-analytics-engineering/dbt-retail-project/`: Includes docs as part of the project flow.
- `18-templates/`: Future templates can support model and metric documentation.
- `19-interview-and-career/`: Good docs make projects easier to explain professionally.
