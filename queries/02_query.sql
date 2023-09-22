-- Question 2:
select 
	ship_country, 
	round (avg (shipped_date - order_date)::numeric,2) as average_days_between_order_shipping, 
	count(distinct order_id) as total_number_orders 
from 
	orders 
where 
	extract (year from order_date) = 1998 
group by 
	ship_country
having 
	count (distinct order_id) > 10 and 
	round (avg (shipped_date - order_date)::numeric,2) >= 5
order by 	
	ship_country asc;