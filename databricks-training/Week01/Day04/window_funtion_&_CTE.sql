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

--6.Display the highest salary in each department using a window function.
Select * 
From (Select employee_name,
        department,
        salary,
        Rank() over (PARTITION by department
                    ORDER by salary desc) as dept_rank
    from employees) as employee_rank
where dept_rank=1

--7.Calculate the running total of order amounts ordered by order_date.
Select order_id,
        order_date,
        order_amount,
        sum(order_amount) over (order by order_date asc) as running_total,
 from orders


--8.Calculate the cumulative sales amount for each employee.
Select employee_id,
        order_id,
        order_date,
        total_amount,
        sum(total_amount) over (PARTITION by employee_id
                                order by order_date asc) as cumulative_total
from orders


--9.Use LAG() to show the previous order amount for each customer.
Select customer_id,
        order_id,
        order_date,
        total_amount,
        LAG(total_amount) over (PARTITION by customer_id
                                order by order_date) as Previous_order_amount
from orders


--10.Use LEAD() to show the next order amount for each customer.
Select customer_id,
        order_id,
        order_date,
        total_amount,
        LEAD(total_amount) over (PARTITION by customer_id
                                order by order_date) as Next_order_amount
from orders


--11.Find the difference between the current order amount and previous order amount.
Select customer_id,
        order_id,
        order_date,
        total_amount,
        LAG(total_amount) over (PARTITION by customer_id
                                order by order_date) as Previous_order_amount,
        total_amount  - Previous_order_amount as Amount_difference
from orders