--1.Select all employees ordered by salary in ascending order
Select name,salary
From Employee
order by salary asc


--2.Select all employees ordered by their ages in descending order
Select name,age
From Employee
order by age desc


--3.Select all employees ordered by their hire date in ascending order
Select name,hire_date
From Employee
order by hire_date asc


--4.Select all employees by their department and then their salary
Select e.name,d.name,e.salary
From Employee e
join Department d on e.department_id = d.department_id
order by d.name,e.salary asc


--5.Select departments ordered by the total salary of their employee
Select d.name,Sum(e.salary) as Salary
From Employee e
join Department d on e.department_id = d.department_id
group by d.name
order by Salary asc