--Práctica 2.1 Fundamentos de SQL - Guía del Alumno Vol.2

--1)
select last_name, salary
from hr.employees
where salary > 12000;

--2)
select last_name, department_id
from hr.employees
where employee_id = 176;

--3)
select last_name, salary
from hr.employees
where salary not between 5000 and 12000;

--4)
select last_name, job_id, hire_date
from hr.employees
where last_name like 'Matos' or last_name like 'Taylor'
order by 3 asc;

--5)
select last_name, department_id
from hr.employees
where department_id in (20, 50)
order by last_name;

--6)
select last_name Employee, salary "Monthly Salary"
from hr.employees
where salary between 5000 and 12000
and department_id in (20, 50);

--7)
select last_name, hire_date
from hr.employees
where hire_date like '%1994';

--8)
select last_name, job_id
from hr.employees
where manager_id is null;

--9)
select last_name, salary, commission_pct
from hr.employees
where commission_pct is not null
order by 2 desc, 3 desc;

--10)
select last_name, salary
from hr.employees
where salary > &salario;

--11)
select employee_id, last_name, salary, department_id
from hr.employees
where manager_id = &id_manager
order by &ordenar_por;

--12)
select last_name
from hr.employees
where last_name like '__a%';

--13)
select last_name
from hr.employees
where last_name like '%a%e%';

--14)
select last_name, salary, job_id
from hr.employees
where (job_id like 'SA$_REP' escape '$' 
or job_id like 'ST$_CLERK' escape '$')
and salary not in (2500, 3500, 7000);

--14) de otra forma:
select last_name, salary, job_id
from hr.employees
where job_id in ('SA_REP', 'ST_CLERK')
and salary not in (2500, 3500, 7000);

--15)
select last_name, salary, commission_pct
from hr.employees
where commission_pct = 0.2;
