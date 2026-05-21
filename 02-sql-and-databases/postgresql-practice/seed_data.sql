INSERT INTO customers (customer_name, email, city, customer_segment, created_at)
VALUES
    ('Aung Retail Co.', 'orders@aungretail.example', 'Yangon', 'SME', '2026-01-01'),
    ('Mandalay Market', 'buying@mandalaymarket.example', 'Mandalay', 'SME', '2026-01-02'),
    ('Naypyitaw Office Supplies', 'procurement@npos.example', 'Naypyitaw', 'Business', '2026-01-03'),
    ('Hlaing Family Store', 'hlaingstore@example.com', 'Yangon', 'Retail', '2026-01-04'),
    ('Online Shopper 101', 'customer101@example.com', 'Bago', 'Consumer', '2026-01-05'),
    ('Bagan Boutique', 'hello@baganboutique.example', 'Bagan', 'SME', '2026-01-06');

INSERT INTO products (product_name, category, cost_price, sale_price, is_active)
VALUES
    ('Premium Rice 25kg', 'Grocery', 28.00, 35.00, TRUE),
    ('Cooking Oil 5L', 'Grocery', 12.00, 16.50, TRUE),
    ('Instant Coffee Pack', 'Beverage', 4.50, 7.50, TRUE),
    ('Green Tea Box', 'Beverage', 3.00, 5.25, TRUE),
    ('Notebook Set', 'Stationery', 2.20, 4.00, TRUE),
    ('Ballpoint Pen Box', 'Stationery', 5.00, 8.50, TRUE),
    ('Laundry Detergent 3kg', 'Household', 7.00, 11.00, TRUE),
    ('Dish Soap 1L', 'Household', 1.80, 3.25, TRUE);

INSERT INTO inventory (product_id, quantity_on_hand, reorder_level, last_updated)
VALUES
    (1, 18, 10, '2026-01-15'),
    (2, 7, 12, '2026-01-15'),
    (3, 40, 15, '2026-01-15'),
    (4, 9, 10, '2026-01-15'),
    (5, 65, 20, '2026-01-15'),
    (6, 14, 15, '2026-01-15'),
    (7, 5, 8, '2026-01-15'),
    (8, 30, 10, '2026-01-15');

INSERT INTO sales (customer_id, product_id, sale_date, quantity, unit_price, channel)
VALUES
    (1, 1, '2026-01-01', 2, 35.00, 'store'),
    (1, 2, '2026-01-01', 3, 16.50, 'store'),
    (2, 3, '2026-01-02', 10, 7.50, 'online'),
    (3, 5, '2026-01-02', 20, 4.00, 'store'),
    (4, 7, '2026-01-03', 4, 11.00, 'store'),
    (5, 3, '2026-01-03', 2, 7.50, 'online'),
    (6, 4, '2026-01-04', 8, 5.25, 'online'),
    (2, 1, '2026-01-04', 1, 35.00, 'store'),
    (3, 6, '2026-01-05', 5, 8.50, 'store'),
    (5, 8, '2026-01-05', 6, 3.25, 'online'),
    (1, 7, '2026-01-06', 2, 11.00, 'store'),
    (4, 2, '2026-01-06', 1, 16.50, 'online'),
    (6, 5, '2026-01-07', 12, 4.00, 'store'),
    (2, 3, '2026-01-07', 4, 7.50, 'online'),
    (5, 1, '2026-01-08', 1, 35.00, 'online'),
    (3, 2, '2026-01-08', 6, 16.50, 'store'),
    (1, 4, '2026-01-09', 5, 5.25, 'online'),
    (4, 8, '2026-01-09', 10, 3.25, 'store'),
    (6, 7, '2026-01-10', 3, 11.00, 'online'),
    (2, 6, '2026-01-10', 2, 8.50, 'store'),
    (5, 5, '2026-01-11', 6, 4.00, 'online'),
    (1, 3, '2026-01-11', 3, 7.50, 'store'),
    (4, 1, '2026-01-12', 2, 35.00, 'store'),
    (3, 7, '2026-01-12', 1, 11.00, 'online');
