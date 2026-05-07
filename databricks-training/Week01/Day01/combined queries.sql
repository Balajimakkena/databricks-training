--1.Select the total salary of employees hired in the year 2020.
Select sum(salary)
From Employee
where year(hire_date)=2020

--2.Select the average salary of employees in each department, ordered by the average salary in descending order.
Select d.name,avg(e.salary) as Avg_sal
From Employee e
join Department d
on e.department_id=d.department_id
group by d.name
order by Avg_sal desc


--3.Select departments with more than 1 employee and an average salary greater than 55000.
Select d.name
From Employee e
join Department d
on e.department_id=d.department_id
group by d.name
having count(e.emp_id)>1 and avg(e.salary)>55000


--4.Select employees hired in the last 2 years, ordered by their hire date.
Select name,hire_date
From Employee
where timestampdiff(year,hire_date,curdate())<=2
order by hire_date desc


--5.Select the total number of employees and the average salary for departments with more than employees
Select d.name AS Department,
       COUNT(e.emp_id) AS Total_Employees,
       AVG(e.salary) AS Average_Salary
From Employee e
join Department d
ON e.department_id = d.department_id
group by d.name
having COUNT(e.emp_id) > 2;