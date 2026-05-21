DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS inventory;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    city VARCHAR(80) NOT NULL,
    customer_segment VARCHAR(40) NOT NULL,
    created_at DATE NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE products (
    product_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_name VARCHAR(120) NOT NULL,
    category VARCHAR(80) NOT NULL,
    cost_price NUMERIC(10, 2) NOT NULL CHECK (cost_price >= 0),
    sale_price NUMERIC(10, 2) NOT NULL CHECK (sale_price >= 0),
    is_active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE inventory (
    product_id INTEGER PRIMARY KEY REFERENCES products (product_id),
    quantity_on_hand INTEGER NOT NULL CHECK (quantity_on_hand >= 0),
    reorder_level INTEGER NOT NULL CHECK (reorder_level >= 0),
    last_updated DATE NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE sales (
    sale_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id INTEGER NOT NULL REFERENCES customers (customer_id),
    product_id INTEGER NOT NULL REFERENCES products (product_id),
    sale_date DATE NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(10, 2) NOT NULL CHECK (unit_price >= 0),
    channel VARCHAR(30) NOT NULL CHECK (channel IN ('store', 'online')),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_sales_sale_date ON sales (sale_date);
CREATE INDEX idx_sales_customer_id ON sales (customer_id);
CREATE INDEX idx_sales_product_id ON sales (product_id);
CREATE INDEX idx_products_category ON products (category);
