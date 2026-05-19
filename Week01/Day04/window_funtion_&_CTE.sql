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

--12.Calculate a moving average of the last 3 orders.
Select  order_id,
        total_amount,
        avg(total_amount) over (order by order_date
                                rows between 2 preceding and current row) as running_avg
from orders


--13.Use NTILE(4) to divide employees into salary quartiles.
Select employee_name,
        department,
        salary,
        NTILE(4) over (order by salary desc) as salary_quartile
from employees


--14.Find the first order placed by each customer using ROW_NUMBER().
Select *
from(Select customer_id,
        order_id,
        order_date,
        ROW_NUMBER() over (partition by customer_id
                           order by order_date asc) as row_num
	from orders) 
  as cust_row
  where row_num=1

--15.Find the latest order placed by each customer.
Select *
from(Select customer_id,
        order_id,
        order_date as last_order_date,
       total_amount,
        ROW_NUMBER() over (partition by customer_id
                           order by order_date desc) as row_num
	from orders) 
  as cust_row
  where row_num=1

--16.Display employee salaries along with department average salary.
Select employee_name,
        salary,
        department,
        avg(salary) over (partition by department
         ) as dept_avg
from employees

--17.Find employees earning above their department average salary.
Select employee_name,
        salary
from (Select employee_name,
                salary,
                avg(salary) over (partition by department) as dept_avg
        from employees) as Deptm_avg
where salary>dept_avg

--18.Use SUM() OVER(PARTITION BY department) to calculate department payroll.
Select employee_name,
		department,
        salary,
        Sum(salary) over (partition by department) as dept_total
from employees


--19.Find the percentage contribution of each employee salary within their department.
Select employee_name,
        department,
        salary,
        round(
                (salary*100)/
                sum(salary) over (partition by department),2
        ) as perc_sal
from employees

--20.Use COUNT() OVER() to show total number of employees alongside each row.
Select employee_name,
        department,
        salary,
        COUNT(employee_id) over() as emp_count
from employees


--21.Create a CTE to calculate total sales per employee.
with sales_table as (Select employee_id,
        		    sum(total_amount) over (partition by employee_id) as emp_sales
                     from orders)
                     
Select distinct(e.employee_name),s.emp_sales
from employees e
left join sales_table s
on e.employee_id=s.employee_id

--22.Use a CTE to find employees whose sales exceed the company average.
WITH employee_sales AS (
    SELECT 
        employee_id,
        SUM(total_amount) AS total_sales
    FROM orders
    GROUP BY employee_id
)

SELECT *
FROM employee_sales
WHERE total_sales > (
    SELECT AVG(total_sales)
    FROM employee_sales
)

--23.Create multiple CTEs to calculate customer total spending and rankings.
WITH cust_ranking as (Select customer_id,
                                total_amount,
                                sum(total_amount) over (partition 									by customer_id) as cust_total
                               
                        from orders)

select distinct(cr.customer_id),
		c.customer_name,
		cr.cust_total,
                dense_rank() over (order by cust_total desc) as c_rank
from cust_ranking cr
left join customers c
on cr.customer_id=c.customer_id

--24.Write a recursive CTE to generate numbers from 1 to 10.
With recursive numbers as (Select 1 as num

                        union all

                        Select num+1
                        from numbers
                        where num<10)
select *
From numbers


--25.Use a recursive CTE to display employee hierarchy data.
with recursive emp_rec as(Select employee_id,
                                employee_name,
                                manager_id,
                                  1 as level
                        from employees
                        where manager_id is null
                        union all
                        select e.employee_id,
                                e.employee_name,
                                e.manager_id,
                                er.level+1
                        from employees e
                        join emp_rec er
                        on e.manager_id=er.employee_id)
 Select * from emp_rec


 --26.Create a CTE that filters orders above the average order amount.
 with avg_order as (Select customer_id,
                           order_id,
                           order_date,
                           total_amount,
                           avg(total_amount) as avg_total
                   from orders)
select * from avg_order
where total_amount>avg_total

--27.Use a CTE and window function together to rank customers by total spending.
with total_rank as (Select o.customer_id,
                     	   c.customer_name,
                           sum(o.total_amount) as total
                          
                   from orders o
                    join customers c
                    on o.customer_id=c.customer_id
                   group by customer_id)
select customer_name,
        total,
        rank() over (order by total desc) as Rank_by_spending
 from total_rank



--28.Find the second-highest salary in each department.
 with second_highest as
                        (Select employee_name,
                                department,
                                salary,
                                rank() over(partition by department
                                           order by salary desc) as dept_rank
                        from employees)

Select  employee_name,
          department,
           salary,
from second_highest
where dept_rank=2


--29.Display the difference between each employee salary and the department maximum salary.
with max_salary as 
               () Select  employee_name,
                        department,
                         salary,
                        max(salary) over (partition by department) as max_sal
                from employees )
Select  employee_name,
          department,
           salary,
           max_sal - salary as difference_sal
from max_salary


--30.Combine CTEs and window functions to find the top-performing employee in each department based on totalsales.
WITH employee_sales AS (

    SELECT e.employee_id,
           e.employee_name,
           e.department,
           SUM(o.total_amount) AS total_sales
    FROM employees e
    JOIN orders o
    ON e.employee_id = o.employee_id
    GROUP BY e.employee_id,
             e.employee_name,
             e.department
),

ranked_employees AS (

    SELECT employee_id,
           employee_name,
           department,
           total_sales,

           RANK() OVER(
               PARTITION BY department
               ORDER BY total_sales DESC
           ) AS sales_rank

    FROM employee_sales
)

SELECT employee_id,
       employee_name,
       department,
       total_sales
FROM ranked_employees
WHERE sales_rank = 1;