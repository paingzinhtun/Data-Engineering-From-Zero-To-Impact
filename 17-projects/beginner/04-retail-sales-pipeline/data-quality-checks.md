# Data Quality Checks

## Checks Included

The project includes SQL checks for:

- Missing sale line IDs
- Duplicate sale line IDs
- Negative quantities
- Negative net sales
- Sales missing product records
- Sales missing customer records
- Invalid inventory quantities
- Raw-to-fact row count mismatch
- Gross profit formula mismatch
- Daily sales reconciliation mismatch

## Python Validation

The Python transform step validates:

- Required columns
- File existence
- Date parsing
- Numeric type conversion
- Positive sale quantities
- Non-negative prices and discounts
- Product references for cost calculation
- Customer references for sales ownership

## Why These Checks Matter

Retail reports are only useful when sales, product, customer, and inventory records are trustworthy.

Bad data can cause:

- Overstated revenue
- Incorrect gross profit
- Wrong reorder recommendations
- Missing customer purchase history
- Broken dashboards

## Business Checks Versus Failure Checks

Products below reorder level are not treated as pipeline failures. They are valid business signals surfaced in `analytics.mart_inventory_reorder`.

Quality checks should fail the pipeline when the data cannot be trusted. Business alerts should highlight conditions the business needs to act on.
