-- Question 6:

with categories_performances as (
select 
	c.category_name,
	case
		when p.unit_price < 20 then '1. Below $20'
		when p.unit_price >= 20 and p.unit_price <= 50 then '2. $20 - $50'
		else '3. Over $50'
	end as price_range,
	cast(sum(od.unit_price * od.quantity * (1 - od.discount)) as integer) as total_amount,
	count(od.order_id) as total_number_orders
from categories c
inner join products p on c.category_id = p.category_id
inner join order_details od on p.product_id = od.product_id
group by 
	c.category_name, price_range
)
select 
	category_name,
	price_range,
	total_amount,
	total_number_orders
from
	categories_performances
order by
	category_name asc,
	price_range asc;
