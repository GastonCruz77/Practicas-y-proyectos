--Práctica 1.1 Fundamentos de SQL - Guía del Alumno Vol.2

select first_name  || q'[']' || last_name "nombre y apellido" from hr.employees
where first_name like 'Luis' or first_name like 'Ellen';

--5)
select employee_id, last_name, job_id, hire_date STARTDATE
from hr.employees;

--7)
select DISTINCT job_id 
from hr.employees;

--8)
select employee_id "Emp #", last_name Employee, job_id Job, hire_date "Hire Date"
from hr.employees;

--9)
select last_name || ', ' || job_id "Employee and Title"
from hr.employees;

--10)
select employee_id || ', ' || first_name || ', ' || last_name || ', ' || email || ', ' || phone_number || ', ' || hire_date || ', ' || 
job_id || ', ' || salary || ', ' || commission_pct || ', ' || manager_id || ', ' || department_id THE_OUTPUT
from hr.employees;
