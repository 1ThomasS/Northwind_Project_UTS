-- Question 9:

select 
	concat (e.first_name, ' ', e.last_name) as employee_full_name,
	e.title as employee_title,
	round(sum(od.unit_price * quantity)::numeric, 2) as total_sale_amount_excluding_discount,
	count(distinct o.order_id) as total_number_unique_orders,
	count(o.order_id) as total_number_orders,
	round(avg(od.unit_price * od.quantity)::numeric, 2) as average_product_amount,
	round((sum(od.unit_price * od.quantity) / count(distinct o.order_id))::numeric, 2) as average_amount_per_order,
	round(sum(od.unit_price * od.quantity * od.discount)::numeric, 2) as total_discount_amount,
	round(sum(od.unit_price * od.quantity * (1 - od.discount))::numeric, 2) as total_sale_amount_including_discount,
	round((sum(od.unit_price * od.quantity * od.discount) / sum(od.unit_price * od.quantity) * 100)::numeric, 2) as total_discount_percentage
from 
	employees e
inner join orders o on e.employee_id = o.employee_id
inner join order_details od on o.order_id = od.order_id
group by
	e.employee_id,
	e.first_name,
	e.last_name,
	e.title
order by total_sale_amount_including_discount desc;