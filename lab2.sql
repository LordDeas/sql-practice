Select product_name, p.product_id, sum(oi.quantity*oi.list_price*(1-oi.discount)) as total_cash
From order_items oi
JOIN products p on oi.product_id = p.product_id
group by p.product_id, p.product_name
order by total_cash desc
limit 5;
Select c.customer_id,c.first_name,c.last_name, count(o.order_id) as total_order
From customers c
JOIN orders o on o.customer_id = c.customer_id
Group by c.customer_id,c.first_name,c.last_name
Order by total_order desc
limit 3