##Question 1
SELECT the total salary of all employees

**Answer:**
Select sum(salary) as Total_salary
From Employee

##Question 2
Select average salary of all employees

**Answer:**
Select avg(salary) as Average_Salary
From Employee

##Question 3
Select the minimum salary in the Employee Table

**Answer:**
Select min(salary) as Minimum_Salary
From Employee

##Question 4
Select number of employees in each department

**Answer:**
Select d.name as Department,count(e.department_id) as No_of_emp
From Employee e join Department d on e.department_id=d.department_id
group by d.name

##Question 5
Select average salary of employees in each department 

**Answer:**
Select d.name as Department,avg(salary) as Avg_salary
From Employee e join Department d on e.department_id=d.department_id
group by d.name
