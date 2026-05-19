 --1.Select total salary of each department
Select d.name as Department,sum(salary) as Total_salary
From Employee e join Department d on e.department_id=d.department_id
group by d.name



--2.Select average ages of Employees in each department
Select d.name as Department,round(avg(age)) as Avg_ages
From Employee e 
join Department d 
on e.department_id=d.department_id
group by d.name


--3.Select number of emlpoyees hired in each year
Select year(hire_date) as Year,count(hire_date) as No_of_emp
From Employee
group by year(hire_date)



--4.Select the highest salary in each department
Select d.name as Department,max(e.salary) as Max_salary
From Employee e join Department d on e.department_id=d.department_id
group by d.name




--5.Select the department with highest salary among all departments
SELECT d.name AS Department, avg(e.salary) AS Avg_salary
FROM Employee e 
JOIN Department d ON e.department_id = d.department_id
GROUP BY d.name
ORDER BY Avg_salary desc
LIMIT 1