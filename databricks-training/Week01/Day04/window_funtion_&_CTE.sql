--1.Use ROW_NUMBER() to assign a row number to employees ordered by salary descending.
SELECT 
    ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num,
    employee_name,
    salary
FROM employees;

--2.Use RANK() to rank employees by salary.
Select 
    RANK() over (ORDER by salary DESC) as rank_n,
    salary
from employees

--3.Use DENSE_RANK() to rank employees by salary.
Select 
    DENSE_RANK() over (ORDER by salary DESC) as rank_n,
    salary
from employees

--4.Find the top 3 highest-paid employees using a window function.
SELECT DENSE_RANK() OVER (ORDER BY salary DESC) AS rank_n,
       employee_name,
       salary
from employees
where rank_n <= 3

--5.Rank employees within each department using PARTITION BY.
Select employee_name,
        department,
        salary,
        Rank() over (PARTITION by department
                    ORDER by salary desc) as dept_rank
from employees


