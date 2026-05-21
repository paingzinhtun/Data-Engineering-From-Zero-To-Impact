SELECT 'null_sale_line_id' AS check_name, sale_line_id
FROM analytics.fact_sales
WHERE sale_line_id IS NULL;

SELECT 'duplicate_sale_line_id' AS check_name, sale_line_id
FROM analytics.fact_sales
GROUP BY sale_line_id
HAVING COUNT(*) > 1;

SELECT 'non_positive_quantity' AS check_name, sale_line_id
FROM analytics.fact_sales
WHERE quantity <= 0;

SELECT 'negative_sales_amount' AS check_name, sale_line_id
FROM analytics.fact_sales
WHERE net_sales < 0
   OR gross_sales < 0
   OR cost_amount < 0;

SELECT 'net_sales_above_gross_sales' AS check_name, sale_line_id
FROM analytics.fact_sales
WHERE net_sales > gross_sales;

SELECT 'product_reference_missing' AS check_name, sale_line_id
FROM analytics.fact_sales
WHERE product_name IS NULL;

SELECT 'customer_reference_missing' AS check_name, sale_line_id
FROM analytics.fact_sales
WHERE customer_name IS NULL;

SELECT 'invalid_inventory_quantity' AS check_name, product_id
FROM raw.inventory
WHERE quantity_on_hand < 0
   OR reorder_level < 0;

SELECT 'raw_to_fact_row_count_mismatch' AS check_name, NULL AS sale_line_id
WHERE (SELECT COUNT(*) FROM raw.sales) <> (SELECT COUNT(*) FROM analytics.fact_sales);

SELECT 'gross_profit_formula_mismatch' AS check_name, sale_line_id
FROM analytics.fact_sales
WHERE ROUND((net_sales - cost_amount)::numeric, 2) <> ROUND(gross_profit::numeric, 2);

SELECT 'daily_sales_reconciliation_mismatch' AS check_name, NULL AS sale_line_id
WHERE (
    SELECT ROUND(COALESCE(SUM(net_sales), 0)::numeric, 2)
    FROM analytics.fact_sales
) <> (
    SELECT ROUND(COALESCE(SUM(net_sales), 0)::numeric, 2)
    FROM analytics.mart_daily_sales
);
