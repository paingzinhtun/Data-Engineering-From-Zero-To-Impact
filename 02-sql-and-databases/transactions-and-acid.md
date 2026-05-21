# Transactions And ACID

## 1. What It Is

A transaction is a group of database operations treated as one unit of work. Either all operations succeed, or the database can roll them back.

ACID describes four important properties of reliable database transactions:

- **Atomicity:** All steps succeed or none are applied.
- **Consistency:** Data moves from one valid state to another.
- **Isolation:** Concurrent transactions do not interfere incorrectly.
- **Durability:** Committed data is saved even after failure.

## 2. Why It Matters

Data Engineering pipelines often load, update, and transform data. If a pipeline fails halfway through, the database should not be left in a broken state.

Transactions help protect:

- Inventory updates
- Financial records
- Order loading
- Customer updates
- Data warehouse refreshes
- Audit tables
- Batch pipeline consistency

They are especially important when multiple tables must stay aligned.

## 3. Core Concepts

- **BEGIN:** Starts a transaction.
- **COMMIT:** Saves all changes in a transaction.
- **ROLLBACK:** Cancels changes in a transaction.
- **Lock:** A mechanism databases use to protect data during concurrent operations.
- **Isolation level:** Rules for how transactions see each other's changes.
- **Constraint:** A rule that protects data validity.
- **Foreign key:** A constraint that protects relationships between tables.
- **Idempotency:** The ability to rerun a process without creating incorrect duplicates.

## 4. Real Business Example

A retail sale should affect both sales history and inventory.

When a customer buys two units of a product:

1. A row is inserted into `sales`.
2. The product's inventory is reduced by two.

If the sale is inserted but the inventory update fails, the business data becomes inconsistent. The company may think it has more stock than it really does.

A transaction can make both steps succeed together or fail together.

## 5. SQL Examples

Basic transaction:

```sql
BEGIN;

INSERT INTO sales (
    customer_id,
    product_id,
    sale_date,
    quantity,
    unit_price,
    channel
)
VALUES (1, 2, CURRENT_DATE, 1, 39.99, 'store');

UPDATE inventory
SET quantity_on_hand = quantity_on_hand - 1,
    last_updated = CURRENT_DATE
WHERE product_id = 2;

COMMIT;
```

Rollback example:

```sql
BEGIN;

UPDATE inventory
SET quantity_on_hand = quantity_on_hand - 100
WHERE product_id = 1;

ROLLBACK;
```

Protect against invalid stock:

```sql
ALTER TABLE inventory
ADD CONSTRAINT chk_inventory_non_negative
CHECK (quantity_on_hand >= 0);
```

Use a transaction for a batch load:

```sql
BEGIN;

DELETE FROM daily_sales_summary
WHERE sale_date = DATE '2026-01-10';

INSERT INTO daily_sales_summary (sale_date, revenue)
SELECT
    sale_date,
    SUM(quantity * unit_price) AS revenue
FROM sales
WHERE sale_date = DATE '2026-01-10'
GROUP BY sale_date;

COMMIT;
```

## 6. Production Considerations

- Use transactions for multi-step changes that must stay consistent.
- Keep transactions as short as practical.
- Understand that long transactions can block other work.
- Use constraints to prevent invalid data.
- Design batch loads to be rerunnable.
- Log transaction failures clearly.
- Be careful with deletes and updates in production.
- Test rollback behavior before relying on it.

## 7. Common Mistakes

- Loading data into multiple tables without a transaction.
- Forgetting to commit.
- Forgetting to rollback after an error in an interactive session.
- Holding transactions open too long.
- Assuming application code can replace database constraints.
- Updating inventory without checking stock levels.
- Using transactions but still writing non-idempotent load logic.
- Ignoring concurrency when multiple jobs update the same tables.

## 8. Practice Tasks

Using the practice database:

1. Start a transaction.
2. Insert a new sale.
3. Update the matching inventory row.
4. Commit the transaction.
5. Start another transaction.
6. Make a test inventory update.
7. Roll it back.
8. Confirm the rollback worked.
9. Add or inspect constraints that protect data validity.

## 9. Related Project

- `02-sql-and-databases/postgresql-practice/`: Practice safe inserts and updates.
- `05-etl-elt-pipelines/`: Batch loads should use transaction thinking.
- `14-production-engineering/`: Reliable systems require safe failure behavior.
