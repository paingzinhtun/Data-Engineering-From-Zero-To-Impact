# Datasets

Datasets are practice material. The goal is not to collect random files; it is to practice solving business problems with realistic data.

Do not add fake links. If an exact dataset URL is uncertain, search by the suggested name or topic.

## How To Choose A Dataset

Good practice datasets have:

- Multiple related tables
- Dates
- Business keys
- Numeric measures
- Some quality issues
- Clear business questions

Avoid datasets that:

- Have only one flat table with no business context
- Are too clean to teach quality checks
- Are too large before you understand the problem
- Have unclear licenses

## Public Dataset Ideas

Search for:

- "Kaggle retail sales dataset"
- "UCI online retail dataset"
- "Google BigQuery public datasets retail"
- "Instacart market basket analysis dataset"
- "NYC taxi trip data"
- "GitHub public archive dataset"
- "OpenAQ air quality dataset"
- "World Bank open data"
- "US government open data inventory"
- "OpenStreetMap logistics data"

Before using a public dataset:

- Check license and usage rules.
- Read the data dictionary.
- Confirm whether personal data is included.
- Document assumptions.
- Keep a copy of the source description.

## Synthetic Dataset Ideas

Synthetic data is often better for learning because you can design the business problem and data quality issues.

## Retail

Tables:

- `sales`
- `products`
- `customers`
- `stores`
- `promotions`

Practice questions:

- Which products generate the most gross profit?
- Which categories are growing?
- Which store has the highest average order value?
- Did promotions improve margin?

Quality issues to include:

- Duplicate sale line IDs
- Missing product references
- Negative discount values
- Late-arriving sales records

## Inventory

Tables:

- `inventory_snapshots`
- `products`
- `suppliers`
- `purchase_orders`
- `sales`

Practice questions:

- Which products should be reordered?
- Which products are slow-moving?
- How many days of stock remain?
- Which suppliers create replenishment risk?

Quality issues to include:

- Negative stock quantities
- Missing supplier IDs
- Duplicate inventory snapshots
- Products with sales but no inventory record

## Ecommerce

Tables:

- `orders`
- `order_items`
- `payments`
- `shipments`
- `customers`
- `products`

Practice questions:

- Which orders are paid but not shipped?
- What is daily revenue?
- Which products have the highest refund rate?
- Which customers purchase repeatedly?

Quality issues to include:

- API pagination gaps
- Duplicate order events
- Missing payment status
- Inconsistent fulfillment status

## Finance

Tables:

- `invoices`
- `payments`
- `expenses`
- `accounts`
- `vendors`

Practice questions:

- What is monthly revenue?
- Which invoices are overdue?
- Which expense categories are increasing?
- Does payment data reconcile to invoices?

Quality issues to include:

- Duplicate invoice numbers
- Payments without invoice references
- Negative expense amounts
- Missing account categories

## Logistics

Tables:

- `shipments`
- `delivery_events`
- `routes`
- `drivers`
- `warehouses`

Practice questions:

- Which shipments are delayed?
- Which routes have the longest average delivery time?
- Which warehouses have fulfillment bottlenecks?
- What is on-time delivery rate?

Quality issues to include:

- Missing delivery timestamps
- Out-of-order status events
- Duplicate tracking IDs
- Invalid route references

## Education

Tables:

- `students`
- `courses`
- `enrollments`
- `attendance`
- `assessments`

Practice questions:

- Which courses have low completion?
- Which students are at risk?
- How does attendance relate to performance?
- Which programs need operational support?

Quality issues to include:

- Duplicate student records
- Missing attendance dates
- Invalid course references
- Inconsistent grade formats

## SME Operations

Tables:

- `sales`
- `expenses`
- `customers`
- `products`
- `inventory`
- `staff_tasks`

Practice questions:

- What changed this month?
- Which products or services are most profitable?
- Which customers drive revenue?
- Which operational tasks are delayed?
- Are expenses growing faster than revenue?

Quality issues to include:

- Manually edited spreadsheets
- Missing customer IDs
- Inconsistent product names
- Expense categories with typos

## Synthetic Data Design Tips

- Create at least 4 related tables.
- Include 3 to 12 months of dates.
- Include realistic IDs.
- Include a few deliberate bad records.
- Document the expected output.
- Keep the first version small enough to inspect manually.
