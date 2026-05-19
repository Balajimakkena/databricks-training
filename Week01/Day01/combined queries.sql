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


--6.Select the name and salary of employees whose salary is above the average salary of their department.
Select e.name as Emp_name,e.salary as Emp_sal
From Employee e
join Department d
on e.department_id=d.department_id
where e.salary>(Select avg(e1.salary)
                From Employee e1
                where e1.department_id=e.department_id)


--7.Select the names of employees who are hired on the same date as the oldest employee in the company
Select name
From Employee
where hire_date = (
    Select MIN(hire_date)
    From Employee
)


--8.Select the department names along with the total number of projects they are working on,ordered by the number of projects.
Select d.name as Dept_name,count(distict(e.emp_id)) as No_of_projects
from Employee e
join Department d
join Project p
on e.department_id=d.department_id=p.department_id
group by d.name
order by No_of_projects desc


--9.Select the employee name with the highest salary in each department.
Select d.name as Emp_name,max(e.salary) as Highest_sal
from Employee e
join Department d
on e.department_id=d.department_id
group by d.name
order by Highest_sal desc


--10.Select names and salaries of the employees who are older than the average in of their employees
Select e.name,e.salary
from Employee e
join Department d
on e.department_id=d.department_id
where e.age>(Select avg(age)
from Employee e
where e.department_id=d.department_id)
