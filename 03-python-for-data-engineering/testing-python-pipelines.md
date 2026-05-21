# Testing Python Pipelines

## 1. What It Is

Testing Python pipelines means checking that pipeline logic behaves correctly before it runs on important data. Tests can validate functions, transformations, schemas, edge cases, and expected outputs.

Testing is not only for software engineers. Data Engineers need tests because incorrect pipeline logic can create incorrect business metrics.

## 2. Why It Matters for Data Engineering

Data pipelines can fail silently. A script might run successfully but produce wrong totals, duplicate rows, missing customers, or incorrect inventory values.

Testing helps Data Engineers:

- Protect important transformations.
- Catch schema changes.
- Validate business rules.
- Reduce manual checking.
- Refactor code with confidence.
- Prevent repeated production incidents.

## 3. Core Concepts

- **Unit test:** Tests one function or small piece of logic.
- **Integration test:** Tests multiple components working together.
- **Assertion:** A statement that expected behavior is true.
- **Fixture:** Reusable test data or setup.
- **Schema test:** Checks expected columns and types.
- **Data quality test:** Checks rules such as not-null, unique, or accepted values.
- **Regression test:** Prevents a previous bug from returning.
- **Edge case:** A rare but important input condition.

## 4. Real-World Example

A retail pipeline calculates gross profit:

```text
gross_profit = quantity * (unit_price - cost_price)
```

If a future code change accidentally uses `sale_price` instead of `unit_price`, the pipeline may still run but produce wrong profit metrics.

A test with known input and expected output can catch the error before the report reaches business users.

## 5. Python Example

```python
import pandas as pd


def add_revenue(df: pd.DataFrame) -> pd.DataFrame:
    required_columns = {"quantity", "unit_price"}
    missing_columns = required_columns - set(df.columns)
    if missing_columns:
        raise ValueError(f"Missing columns: {sorted(missing_columns)}")

    result = df.copy()
    result["revenue"] = result["quantity"] * result["unit_price"]
    return result


def test_add_revenue() -> None:
    input_df = pd.DataFrame(
        {
            "quantity": [2, 3],
            "unit_price": [10.0, 5.0],
        }
    )

    output_df = add_revenue(input_df)

    assert output_df["revenue"].tolist() == [20.0, 15.0]
```

## 6. Production Considerations

- Put transformation logic in functions so it can be tested.
- Test business-critical calculations.
- Test edge cases such as missing columns and null values.
- Keep small test datasets easy to understand.
- Add data quality checks in addition to code tests.
- Run tests before changing production pipelines.
- Include tests in CI when the project matures.
- Do not rely only on visual inspection of outputs.

## 7. Common Mistakes

- Testing only that the script runs.
- Not testing business calculations.
- Using huge test datasets that are hard to reason about.
- Ignoring nulls, duplicates, and invalid values.
- Writing tests after an incident but not keeping them.
- Mixing test data with production data.
- Not making transformation functions testable.
- Treating data quality checks and unit tests as interchangeable.

## 8. Practice Task

Write tests for a small sales transformation.

Create a function that:

1. Validates required columns.
2. Calculates `revenue`.
3. Calculates `gross_profit`.
4. Raises an error if `quantity` is negative.

Then write tests for:

1. A normal valid row.
2. A missing required column.
3. A negative quantity.
4. A null price.

## 9. Related Project

- `12-data-quality-testing-observability/`: Data quality testing extends these ideas to datasets and pipelines.
- `05-etl-elt-pipelines/`: Pipeline stages should include validation and tests.
- `17-projects/`: Portfolio projects should include tests for important transformation logic.
