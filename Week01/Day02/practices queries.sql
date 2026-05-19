
--*SELECT*
--1.Display all employee details.
Select *
From Employees

--2.Display only employee names and salaries.
Select emp_name,salary
From Employees

--3.Display employee names and departments.
Select emp_name,department
From Employees

--4.Display all employees from the IT department.
Select *
From Employees
where department='IT'

--5.Display employee names and experience.
Select emp_name,experience
From Employees

--*WHERE*--
--1.Find employees with salary greater than 70000.
Select *
From Employees
where salary>70000

--2.Find employees working in Hyderabad.
Select *
From Employees
where city='Hyderabad'

--3.Find employees with experience less than 4 years.
Select *
From Employees
where experience<4

--4.Find employees from Finance department.
Select *
From Employees
where department='Finance'

--5.Find employees whose salary is equal to 52000.
Select *
From Employees
where salary=52000

--*GROUP BY*
--1.Find total salary department-wise.
Select sum(salary) as Total_sal
From Employees
group by department

--2.Find average salary in each department.
Select avg(salary) as Avg_sal
From Employees
group by department

--3.Count employees in each city.
Select count(*)
From Employees
group by city

--4.Find maximum salary in each department.
Select max(salary)
from Employees
group by department

--5.Find minimum experience department-wise.
Select min(experience)
From Employees
group by department

--*HAVING*
--1.Find departments having more than 3 employees.
Select department,count(*)
from Employees
group by department
having count(*)>3

--2.Find departments where average salary is greater than 60000.
Select department
from Employees
group by department
having avg(salary)>60000

--3.Find cities having more than 2 employees.
Select city
From Employees
group by city
having count(*)>2

--4.Find departments where total salary is greater than 200000.
Select department
from Employees
group by department
having sum(salary)>200000

--5.Find departments where maximum salary is above 90000.
Select department
From Employees
group by department
HAVING max(salary)>90000

--*TOP*
--1.Display top 5 highest paid employees.
Select top 5 emp_name,salary
From Employees
order by salary desc

--2.Display top 3 employees with highest experience.
Select top 3 emp_name
From Employees
order by experience desc 

--3.Display top 2 salaries from Finance department.
Select top 2 department,salary
From Employees
where department='Finance'
order by salary desc

--4.Display top 4 employees from Hyderabad.
Select top 4 emp_name
From Employees
where city='Hyderabad'
order by salary

--5.Display top 1 highest salary employee.
Select top 1 emp_name,salary
From Employees 
order by salary desc

--*DISTINCT*
--1.Display distinct department names.
Select distinct(department)
From Employees

--2.Display distinct city names.
Select distinct(city)
From Employees

--3.Display distinct salary values.
Select distinct(salary)
From Employees

--4.Display distinct combinations of department and city.
SELECT DISTINCT department, city
FROM Employees;
--5.Display distinct experience values.
Select distinct(experience)
from Employees

--*COMPARISON OPERATORS*
--1.Find employees with salary >= 80000.
Select emp_name
FROM Employees
where salary >= 80000

--2.Find employees with experience <= 3.
Select emp_name
from Employees
where experience <= 3

--3.Find employees whose salary <> 45000.
Select emp_name
from Employees
where salary <> 45000

--4.Find employees with salary < 50000.
Select emp_name
from Employees
where salary < 50000

--5.Find employees with experience > 5.
Select emp_name
from Employees
where experience > 5



--LOGICAL OPERATORS*
--1.Find employees from IT department AND salary greater than 70000.
Select emp_name
From Employees
where department='IT' and salary > 70000

--2.Find employees from Hyderabad OR Bangalore.
Select emp_name
From Employees
where city='Hyderabad' or city='Bangalore'

--3.Find employees from HR department AND experience less than 3.
Select emp_name
From Employees
where department='HR' and experience<3

--4.Find employees with salary greater than 60000 OR experience greater than 6.
Select emp_name
From Employees
where salary > 60000 and experience > 6

--5.Find employees NOT from Sales department.
Select emp_name
From Employees
where department<>'Sales'


--*IN AND NOT IN*
--1.Find employees working in ('Hyderabad', 'Mumbai').

--2.Find employees whose department IN ('IT', 'Finance').
--3.Find employees whose city NOT IN ('Chennai', 'Pune').
--4.Find employees whose salary IN (45000, 75000, 91000).
--5.Find employees whose department NOT IN ('HR', 'Sales').

--*BETWEEN*
--1.Find employees with salary BETWEEN 50000 AND 80000.
Select emp_name
From Employees
where salary BETWEEN 50000 and 80000

--2.Find employees with experience BETWEEN 3 AND 6.
Select emp_name
From Employees
where experience BETWEEN 3 AND 6

--3.Find employees whose emp_id BETWEEN 105 AND 112.
Select emp_name
From Employees
where emp_id BETWEEN 105 and 112

--4.Find employees with salary NOT BETWEEN 40000 AND 60000.
Select emp_name
From Employees
where salary not BETWEEN 40000 and 60000

--5.Find employees with experience BETWEEN 2 AND 4.
Select emp_name
From Employees
where experience BETWEEN 2 and 4

--*LIKE OPERATOR*
--1.Find employees whose names start with 'R'.
Select emp_name
From Employees
where emp_name like 'R%'

--2.Find employees whose names end with 'a'.
Select emp_name
From Employees
where emp_name like '%a'

--3.Find employees whose names contain 'v'.
Select emp_name
From Employees
where emp_name like '%v%'

--4.Find employees whose city starts with 'B'.
Select emp_name
From Employees
where city like 'B%'

--5.Find employees whose department ends with 's'.
Select emp_name
From Employees
where department like '%s'