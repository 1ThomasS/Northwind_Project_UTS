-- Question 5:

with percentage_change as (
select 
	p.product_name,
	round((first_value (od.unit_price) over (partition by p.product_name order by o.order_date desc))::numeric, 2) as current_price,
	round((first_value (od.unit_price) over (partition by p.product_name order by o.order_date asc))::numeric, 2) as previous_price,
	round(((first_value (od.unit_price) over (partition by p.product_name order by o.order_date desc) - first_value (od.unit_price) over (partition by p.product_name order by o.order_date asc))/
	first_value (od.unit_price) over (partition by p.product_name order by o.order_date asc) * 100)::numeric, 2)as percentage_increase
from orders o
inner join order_details od on o.order_id = od.order_id
inner join products p on p.product_id = od.product_id
)
select
	distinct p.product_name,
	current_price,
	previous_price,
	percentage_increase
from percentage_change pc
inner join products p on pc.product_name = p.product_name
where 
	percentage_increase < 20 or percentage_increase > 30
order by 
	percentage_increase asc;