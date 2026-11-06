-- Top 10 Cuctomers with the most Orders
select top 10
     full_name,
     count(order_id) as total_orders
from vw_OrderDetails
group by full_name
order by total_orders desc;

--Top 10 Customers by Total Spending
select top 10
     full_name,
     sum(total_amount) as total_spendings
from vw_OrderDetails
group by full_name
order by total_spendings desc

--Year with the most Orders
select 
     year(order_date) as order_year,
     count(order_id) as total_orders
from vw_OrderDetails
group by year(order_date)
order by total_orders desc

--Top 10 Products with the most sales
select 
     product_name,
     sum(quantity) as total_quantity_sales
from vw_SalesAnalysis
group by product_name
order by total_quantity_sales desc

--Product  Categories with the most sales
SELECT
    category_name,
    SUM(quantity) AS total_quantity_sold
FROM vw_SalesAnalysis
GROUP BY category_name
ORDER BY total_quantity_sold DESC

--The amount of money every customer spent and total orders for each one

with CustomerOrders as
(select 
     customer_id,
     count(*) as total_orders,
     sum(total_amount) as total_spendings
from orders
group by customer_id
)
SELECT
     c.full_name  ,
     co.total_orders  ,
     co.total_spendings  
from customers c
inner join CustomerOrders co 
     on c.id = co.customer_id
order by co.total_spendings desc

-- Customers with the most complete orders
with customer_stats as
(select 
     customer_id,
     count(*) as total_orders,
     sum(case when status='completed' then 1 else 0 end) as completed_orders,
     sum(case when status='pending' then 1 else 0 end) as pending_orders
from orders
group by customer_id
)
select top 10 
     c.full_name,
     cs.total_orders,
     cs.completed_orders,
     cs.pending_orders
from customer_stats cs
inner join customers c 
     on cs.customer_id=c.id
order by cs.completed_orders desc

--Payment Methods customers use the most 
select
     payment_method,
     count(*) as total_payments,
     round(count(*)*100.0/(select count(*) from payments),1)
     as percentage 
from payments
where amount > 100
group by payment_method
order by total_payments desc
     