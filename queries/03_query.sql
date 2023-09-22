-- Question 3:

select * from employees;
select 
	concat (e.first_name, ' ', e.last_name) as employee_full_name,
	e.title as employee_title,
	date_part ('year', age (e.hire_date, e.birth_date)) as employee_age,
	concat (m.first_name, ' ', m.last_name) as manager_full_name,
	m.title as manager_title
from employees e
	inner join employees m on e.reports_to = m.employee_id
order by employee_age, employee_title;

