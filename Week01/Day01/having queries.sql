--1.Select departments with more than 2 employees
select d.name as Department 
from Employee e
join Department d on e.department_id = d.department_id
group by d.name
having count(d.name)>2


--2.Select departments with avg salary is greater than 55000
select d.name as Department 
from Employee e
join Department d on e.department_id = d.department_id
group by d.name
having avg(e.salary)>55000


--3.Select years with more than 1 employee hired
select year(hire_date),count(*)
from Employee 
group by year(hire_date)
having count(year(hire_date))>1


--4.Select departments with total salary expenses less than 100000
Select d.name as Department ,Round(sum(e.salary))
from Employee e
join Department d on e.department_id = d.department_id
group by d.name
having sum(e.salary)>100000



--5.Select departments with maximum salary above 75000
Select d.name as Department ,max(e.salary) as Max_salary
from Employee e
join Department d on e.department_id = d.department_id
group by d.name
having max(e.salary)>75000

