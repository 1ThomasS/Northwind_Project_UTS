-- Question 8:

with median_calculation as (
select 
	c.category_name,
	round(avg(p.unit_price)::numeric, 2) as average_unit_price,
	percentile_cont(0.5) within group (order by unit_price asc) as median_unit_price
from
	categories c
inner join products p on c.category_id = p.category_id
group by 
	c.category_name
),
average_unit_price_calculation as (
    select
        c.category_name,
        round(avg(p.unit_price)::numeric, 2) as average_unit_price
    from
        categories c
    inner join products p on c.category_id = p.category_id
    where
        p.discontinued = 0
    group by
        c.category_name
)
select
	c.category_name as category_name,
	p.product_name as product_name,
	p.unit_price as unit_price,
	ac.average_unit_price,
	round(mc.median_unit_price::numeric, 2) as median_unit_price,
	case 
		when p.unit_price < ac.average_unit_price then 'Below Average'
		when p.unit_price = ac.average_unit_price then 'Equal Average'
		when p.unit_price > ac.average_unit_price then 'Over Average'
	end as average_unit_price_position,
	case
		when p.unit_price < mc.median_unit_price then 'Below Median'
		when p.unit_price = mc.median_unit_price then 'Equal Median'
		when p.unit_price > mc.median_unit_price then 'Over Median'
	end as median_unit_price_position
from 
	categories c
inner join products p on c.category_id = p.category_id
inner join median_calculation mc on c.category_name = mc.category_name
inner join average_unit_price_calculation ac on c.category_name  = ac.category_name
where p.discontinued = 0
group by 
	c.category_name,
	p.product_name,
	p.unit_price,
	ac.average_unit_price,
	mc.median_unit_price
order by 
	c.category_name asc,
	p.product_name asc;
