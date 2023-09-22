-- Question 10:

with category_emp_sales as (
select 
	c.category_name as category_name,
	concat (e.first_name, ' ', e.last_name) as employee_full_name,
	round(sum(od.unit_price * od.quantity * (1 - od.discount))::numeric, 2) as total_sale_amount
from
	employees e
inner join orders o on e.employee_id = o.employee_id
inner join order_details od on o.order_id = od.order_id
inner join products p on od.product_id = p.product_id
inner join categories c on p.category_id = c.category_id
group by
	c.category_id,
	e.employee_id,
	e.first_name,
	e.last_name
)
select 
	ce_sale.category_name,
	ce_sale.employee_full_name,
	round(ce_sale.total_sale_amount, 2) as total_sale_amount,
	round(ce_sale.total_sale_amount / sum(ce_sale.total_sale_amount) over (partition by ce_sale.employee_full_name), 5) as percent_of_employee_sales,
	round(ce_sale.total_sale_amount / sum(sum(ce_sale.total_sale_amount)) over (partition by ce_sale.category_name), 5) as percent_of_category_sales
from category_emp_sales ce_sale
group by 
	ce_sale.category_name,
	ce_sale.employee_full_name,
	ce_sale.total_sale_amount
order by 
	ce_sale.category_name asc,
	ce_sale.total_sale_amount desc;
