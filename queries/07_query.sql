-- Question 7: 

select 
	c.category_name,
	case 
		when sup.country in ('USA', 'Brazil', 'Canada') then 'America'
		when sup.country in ('Japan', 'Singapore', 'Australia') then 'Asia-Pacific'
		else 'Europe'
	end as supplier_region,
	sum(p.unit_in_stock) as unit_in_stock,
	sum(p.unit_on_order) as unit_on_order,
	sum(p.reorder_level) as reorder_level
from 
	suppliers sup
inner join products p on sup.supplier_id = p.supplier_id
inner join categories c on p.category_id = c.category_id
group by supplier_region, c.category_name 
order by c.category_name asc, supplier_region asc, reorder_level asc;