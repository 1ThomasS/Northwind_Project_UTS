-- Question 1: 
select 
	product_name, 
	unit_price 
from 
	products p
where 
	unit_price between 20 and 50
	and p.discontinued = 0
order by 
	unit_price desc;
    
    