select * from orders
select * from customers

create view dbo.vw_OrderDetails AS
select 
     o.id as order_id,
     o.order_date,
     o.status,
     o.total_amount,
     c.id as customer_id,
     c.full_name,
     c.email
     from orders o
     inner join customers c
     on c.id = o.customer_id

     select * from vw_OrderDetails

     CREATE VIEW dbo.vw_SalesAnalysis AS
SELECT
    oi.order_id,
    oi.product_id,
    p.name AS product_name,
    c.name AS category_name,
    oi.quantity,
    oi.subtotal
FROM order_items oi
INNER JOIN products p
    ON oi.product_id = p.id
INNER JOIN categories c
    ON p.category_id = c.id

    SELECT *
FROM dbo.vw_SalesAnalysis
