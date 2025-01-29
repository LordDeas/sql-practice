select c.customer_id, c.first_name, c.last_name, case
	when count(o.order_id) is null then 0
	else count(o.order_id)
end
from customers c
LEFT Join orders o on o.customer_id = c.customer_id
Group by c.customer_id, c.first_name, c.last_name;
--
-- клиенти які зробили за весь час <5000
select c.first_name,c.last_name, sum(oi.quantity*oi.list_price) as total_sum
from customers c
inner join orders o on c.customer_id= o.customer_id
Join order_items oi on o.order_id = oi.order_id
Group by c.first_name,c.last_name
having sum(oi.quantity*oi.list_price) > 5000;
--сума останього замовлення()
with sort_order as ( select c.first_name,c.last_name, o.order_id, o.order_date,  
row_number() over(partition by c.customer_id order by o.order_date desc ) as rn
from customers c
Join orders o on c.customer_id=o.customer_id

)
--join order_items oi on o.order_id = oi.order_id
select so.first_name,so.last_name,so.order_date, sum(oi.quantity*oi.list_price)
from sort_order so
Join order_items oi on oi.order_id=so.order_id
where rn = 1 
Group by so.first_name,so.last_name,so.order_date
