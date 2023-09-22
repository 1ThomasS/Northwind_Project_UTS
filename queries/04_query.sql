-- Question 4:


with output_ as( 
select 
	to_char (order_date, 'Month YYYY') as month_year,
	order_id,
	freight
from
	orders
where 
	extract ('year' from order_date) between 1997 and 1998
)
select
	month_year,
	count (order_id) as total_number_of_orders,
	round(sum (freight)) as total_freight
from output_
group by month_year
having 	count(order_id) > 35
order by total_freight desc;
