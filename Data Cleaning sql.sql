CREATE TABLE dbo.categories (
    id INT NOT NULL PRIMARY KEY,
    name NVARCHAR(100),
    description NVARCHAR(500),
    product_count INT,
    average_price DECIMAL(10,2)
);
CREATE TABLE dbo.customers (
    id INT NOT NULL PRIMARY KEY,
    full_name NVARCHAR(150),
    email NVARCHAR(255),
    created_at DATETIME2,
    loyalty_points INT
);
CREATE TABLE dbo.order_items (
    id INT NOT NULL PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    subtotal DECIMAL(10,2),
    product_name NVARCHAR(150)
);
CREATE TABLE dbo.orders (
    id INT NOT NULL PRIMARY KEY,
    customer_id INT,
    order_date DATETIME2,
    status NVARCHAR(50),
    total_amount DECIMAL(10,2)
);
CREATE TABLE dbo.payments (
    id INT NOT NULL PRIMARY KEY,
    order_id INT,
    payment_date DATETIME2,
    amount DECIMAL(10,2),
    payment_method NVARCHAR(50)
);
CREATE TABLE dbo.products(
id INT NOT NULL PRIMARY KEY,
name NVARCHAR(150),
category_id INT,
price DECIMAL(10,2),
stock INT
);
SELECT COUNT(*) AS CategoriesCount
FROM dbo.categories;

SELECT COUNT(*) AS CustomersCount
FROM dbo.customers;
SELECT name, is_disabled
FROM sys.triggers
WHERE parent_id = OBJECT_ID('dbo.categories');
SELECT 
    COUNT(*) AS CategoriesCount,
    MAX(id) AS MaxCategoryID
FROM dbo.categories;
SELECT name, type_desc
FROM sys.objects
WHERE name = 'categories';
SELECT
    name,
    type_desc,
    is_disabled
FROM sys.check_constraints
WHERE parent_object_id = OBJECT_ID('dbo.categories');
SELECT COUNT(*) AS CategoriesCount
FROM dbo.categories;
SELECT COUNT(*) AS CategoriesCount
FROM dbo.categories;
SELECT COUNT(*) AS TotalCustomers
FROM dbo.customers;

SELECT TOP 10 id, full_name, created_at
FROM dbo.customers
ORDER BY id;

SELECT TOP 10 *
FROM dbo.categories
ORDER BY id;
SELECT TOP 10 id, created_at
FROM dbo.orders
ORDER BY id;
SELECT TOP 10 id, order_date
FROM dbo.orders
ORDER BY id;
SELECT TOP 10 id, payment_date
FROM dbo.payments
ORDER BY id;
SELECT 'categories' AS table_name, COUNT(*) AS total_rows FROM dbo.categories
UNION ALL
SELECT 'customers', COUNT(*) FROM dbo.customers
UNION ALL
SELECT 'products', COUNT(*) FROM dbo.products
UNION ALL
SELECT 'orders', COUNT(*) FROM dbo.orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM dbo.order_items
UNION ALL
SELECT 'payments', COUNT(*) FROM dbo.payments;
-- Orders χωρίς υπαρκτό customer
SELECT COUNT(*) AS invalid_orders
FROM dbo.orders o
LEFT JOIN dbo.customers c ON o.customer_id = c.id
WHERE c.id IS NULL;

-- Products χωρίς υπαρκτή category
SELECT COUNT(*) AS invalid_products
FROM dbo.products p
LEFT JOIN dbo.categories c ON p.category_id = c.id
WHERE c.id IS NULL;

-- Order items χωρίς υπαρκτό order
SELECT COUNT(*) AS invalid_order_items_orders
FROM dbo.order_items oi
LEFT JOIN dbo.orders o ON oi.order_id = o.id
WHERE o.id IS NULL;

-- Order items χωρίς υπαρκτό product
SELECT COUNT(*) AS invalid_order_items_products
FROM dbo.order_items oi
LEFT JOIN dbo.products p ON oi.product_id = p.id
WHERE p.id IS NULL;

-- Payments χωρίς υπαρκτό order
SELECT COUNT(*) AS invalid_payments
FROM dbo.payments pay
LEFT JOIN dbo.orders o ON pay.order_id = o.id
WHERE o.id IS NULL;
-- Orders → Customers
ALTER TABLE dbo.orders
ADD CONSTRAINT FK_orders_customers
FOREIGN KEY (customer_id) REFERENCES dbo.customers(id);

-- Products → Categories
ALTER TABLE dbo.products
ADD CONSTRAINT FK_products_categories
FOREIGN KEY (category_id) REFERENCES dbo.categories(id);

-- Order Items → Orders
ALTER TABLE dbo.order_items
ADD CONSTRAINT FK_order_items_orders
FOREIGN KEY (order_id) REFERENCES dbo.orders(id);

-- Order Items → Products
ALTER TABLE dbo.order_items
ADD CONSTRAINT FK_order_items_products
FOREIGN KEY (product_id) REFERENCES dbo.products(id);

-- Payments → Orders
ALTER TABLE dbo.payments
ADD CONSTRAINT FK_payments_orders
FOREIGN KEY (order_id) REFERENCES dbo.orders(id);
 
 SELECT
    email,
    COUNT(*) AS occurrences
FROM dbo.customers
GROUP BY email
HAVING COUNT(*) > 1;
SELECT *
FROM dbo.customers
WHERE email IN (
    'arjun.young@example.net',
    'grace.nakamura@example.org',
    'lucas.smith@example.com'
)
ORDER BY email, id;

SELECT
    c.id,
    c.full_name,
    c.email,
    COUNT(o.id) AS total_orders
FROM dbo.customers c
LEFT JOIN dbo.orders o
    ON c.id = o.customer_id
WHERE c.email IN (
    'arjun.young@example.net',
    'grace.nakamura@example.org',
    'lucas.smith@example.com'
)
GROUP BY c.id, c.full_name, c.email
ORDER BY c.email, c.id;

SELECT
    c.id AS customer_id,
    c.full_name,
    o.id AS order_id,
    o.order_date,
    o.total_amount,
    o.status
FROM dbo.customers c
INNER JOIN dbo.orders o
    ON c.id = o.customer_id
WHERE c.email IN (
    'arjun.young@example.net',
    'grace.nakamura@example.org',
    'lucas.smith@example.com'
)
ORDER BY c.email, c.id, o

SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN full_name IS NULL THEN 1 ELSE 0 END) AS null_names,
    SUM(CASE WHEN email IS NULL THEN 1 ELSE 0 END) AS null_emails,
    SUM(CASE WHEN created_at IS NULL THEN 1 ELSE 0 END) AS null_created_at,
    SUM(CASE WHEN loyalty_points IS NULL THEN 1 ELSE 0 END) AS null_loyalty_points
FROM dbo.customers;

SELECT
    name,
    COUNT(*) AS occurrences
FROM dbo.products
GROUP BY name
HAVING COUNT(*) > 1;

SELECT *
FROM dbo.products
WHERE name IN (
    'backpack',
    'chair',
    'drone watch',
    'laptop',
    'necklace',
    'necklace backpack',
    'shoes',
    'shoes book',
    'table',
    't-shirt',
    'watch'
)
ORDER BY name, id;

SELECT
    COUNT(*) AS total_products,
    SUM(CASE WHEN name IS NULL THEN 1 ELSE 0 END) AS null_names,
    SUM(CASE WHEN category_id IS NULL THEN 1 ELSE 0 END) AS null_category_id,
    SUM(CASE WHEN price IS NULL THEN 1 ELSE 0 END) AS null_prices,
    SUM(CASE WHEN stock IS NULL THEN 1 ELSE 0 END) AS null_stock
FROM dbo.products;

SELECT
    customer_id,
    order_date,
    total_amount,
    COUNT(*) AS occurrences
FROM dbo.orders
GROUP BY customer_id, order_date, total_amount
HAVING COUNT(*) > 1;

SELECT COUNT(*) AS duplicate_groups
FROM (
    SELECT customer_id, order_date, total_amount
    FROM dbo.orders
    GROUP BY customer_id, order_date, total_amount
    HAVING COUNT(*) > 1
) AS duplicates;

SELECT
    COUNT(*) AS total_orders,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS null_customer_id,
    SUM(CASE WHEN order_date IS NULL THEN 1 ELSE 0 END) AS null_order_date,
    SUM(CASE WHEN status IS NULL THEN 1 ELSE 0 END) AS null_status,
    SUM(CASE WHEN total_amount IS NULL THEN 1 ELSE 0 END) AS null_total_amount
FROM dbo.orders;

SELECT
    order_id,
    product_id,
    COUNT(*) AS occurrences
FROM dbo.order_items
GROUP BY order_id, product_id
HAVING COUNT(*) > 1;

SELECT *
FROM dbo.order_items
WHERE (order_id = 149 AND product_id = 8)
   OR (order_id = 278 AND product_id = 22)
   OR (order_id = 254 AND product_id = 46)
   OR (order_id = 91 AND product_id = 74)
   OR (order_id = 212 AND product_id = 100)
ORDER BY order_id, product_id;

SELECT
    oi.product_id,
    oi.product_name AS order_item_name,
    p.name AS products_table_name
FROM dbo.order_items oi
JOIN dbo.products p
    ON oi.product_id = p.id
WHERE LOWER(oi.product_name) <> LOWER(p.name);

SELECT COUNT(*) AS mismatched_product_names
FROM dbo.order_items oi
JOIN dbo.products p
    ON oi.product_id = p.id
WHERE LOWER(oi.product_name) <> LOWER(p.name);

SELECT
    order_id,
    product_id,
    COUNT(*) AS occurrences
FROM dbo.order_items
GROUP BY order_id, product_id
HAVING COUNT(*) > 1;

SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS null_order_id,
    SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS null_product_id,
    SUM(CASE WHEN quantity IS NULL THEN 1 ELSE 0 END) AS null_quantity,
    SUM(CASE WHEN subtotal IS NULL THEN 1 ELSE 0 END) AS null_subtotal,
    SUM(CASE WHEN product_name IS NULL THEN 1 ELSE 0 END) AS null_product_name
FROM dbo.order_items;

SELECT
    order_id,
    payment_date,
    amount,
    COUNT(*) AS occurrences
FROM dbo.payments
GROUP BY order_id, payment_date, amount
HAVING COUNT(*) > 1;

SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS null_order_id,
    SUM(CASE WHEN payment_date IS NULL THEN 1 ELSE 0 END) AS null_payment_date,
    SUM(CASE WHEN amount IS NULL THEN 1 ELSE 0 END) AS null_amount,
    SUM(CASE WHEN payment_method IS NULL THEN 1 ELSE 0 END) AS null_payment_method
FROM dbo.payments;

SELECT
    name,
    COUNT(*) AS occurrences
FROM dbo.categories
GROUP BY name
HAVING COUNT(*) > 1;

SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN name IS NULL THEN 1 ELSE 0 END) AS null_name,
    SUM(CASE WHEN description IS NULL THEN 1 ELSE 0 END) AS null_description,
    SUM(CASE WHEN product_count IS NULL THEN 1 ELSE 0 END) AS null_product_count,
    SUM(CASE WHEN average_price IS NULL THEN 1 ELSE 0 END) AS null_average_price
FROM dbo.categories;
SELECT
    id,
    order_id,
    product_id,
    quantity,
    subtotal,
    product_name,
    COUNT(*) AS occurrences
FROM dbo.order_items
GROUP BY
    id,
    order_id,
    product_id,
    quantity,
    subtotal,
    product_name
HAVING COUNT(*) > 1;
SELECT
    id,
    order_id,
    payment_date,
    amount,
    payment_method,
    COUNT(*) AS occurrences
FROM dbo.payments
GROUP BY
    id,
    order_id,
    payment_date,
    amount,
    payment_method
HAVING COUNT(*) > 1;

SELECT
    id,
    name,
    description,
    product_count,
    average_price,
    COUNT(*) AS occurrences
FROM dbo.categories
GROUP BY
    id,
    name,
    description,
    product_count,
    average_price
HAVING COUNT(*) > 1;

SELECT
    id,
    full_name,
    email,
    created_at,
    loyalty_points,
    COUNT(*) AS occurrences
FROM dbo.customers
GROUP BY
    id,
    full_name,
    email,
    created_at,
    loyalty_points
HAVING COUNT(*) > 1;

SELECT
    id,
    name,
    category_id,
    price,
    stock,
    COUNT(*) AS occurrences
FROM dbo.products
GROUP BY
    id,
    name,
    category_id,
    price,
    stock
HAVING COUNT(*) > 1;

SELECT
    id,
    customer_id,
    order_date,
    status,
    total_amount,
    COUNT(*) AS occurrences
FROM dbo.orders
GROUP BY
    id,
    customer_id,
    order_date,
    status,
    total_amount
HAVING COUNT(*) > 1;

SELECT *
FROM dbo.products
WHERE price < 0
   OR stock < 0;

   SELECT *
FROM dbo.order_items
WHERE quantity <= 0
   OR subtotal < 0;

   SELECT *
FROM dbo.orders
WHERE total_amount < 0;

SELECT *
FROM dbo.payments
WHERE amount < 0;

SELECT *
FROM dbo.categories
WHERE product_count < 0
   OR average_price < 0;

   SELECT DISTINCT status
FROM dbo.orders;

SELECT status, COUNT(*) AS total_orders
FROM dbo.orders
GROUP BY status;

SELECT DISTINCT payment_method
FROM dbo.payments;

SELECT payment_method, COUNT(*) AS total_payments
FROM dbo.payments
GROUP BY payment_method;

SELECT
    o.id AS order_id,
    o.total_amount,
    SUM(oi.subtotal) AS calculated_total
FROM dbo.orders o
JOIN dbo.order_items oi
    ON o.id = oi.order_id
GROUP BY o.id, o.total_amount;

SELECT *
FROM dbo.order_items
WHERE order_id = 1;

SELECT *
FROM dbo.payments
WHERE order_id = 1;

SELECT COUNT(*) AS mismatched_orders
FROM (
    SELECT
        o.id,
        o.total_amount,
        SUM(oi.subtotal) AS calculated_total
    FROM dbo.orders o
    JOIN dbo.order_items oi
        ON o.id = oi.order_id
    GROUP BY o.id, o.total_amount
) AS order_totals
WHERE ABS(total_amount - calculated_total) > 0.01;

SELECT
    o.id AS order_id,
    o.total_amount,
    SUM(p.amount) AS total_paid
FROM dbo.orders o
JOIN dbo.payments p
    ON o.id = p.order_id
GROUP BY o.id, o.total_amount;

SELECT COUNT(*) AS mismatched_payments
FROM (
    SELECT
        o.id,
        o.total_amount,
        SUM(p.amount) AS total_paid
    FROM dbo.orders o
    JOIN dbo.payments p
        ON o.id = p.order_id
    GROUP BY o.id, o.total_amount
) AS payment_totals
WHERE ABS(total_amount - total_paid) > 0.01;

SELECT o.id AS order_id
FROM dbo.orders o
LEFT JOIN dbo.payments p
    ON o.id = p.order_id
WHERE p.id IS NULL;
