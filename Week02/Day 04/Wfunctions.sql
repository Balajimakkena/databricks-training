CREATE TABLE orders (
    order_id INT,
    customer_name VARCHAR(50),
    city VARCHAR(50),
    amount INT,
    order_date DATE
);

INSERT INTO orders VALUES
(1, 'Amit', 'Chennai', 2000, '2023-01-01'),
(2, 'Ravi', 'Hyderabad', 1500, '2023-01-02'),
(3, 'Sneha', 'Chennai', 3000, '2023-01-03'),
(4, 'Kiran', 'Bangalore', 2500, '2023-01-04'),
(5, 'Priya', 'Chennai', 2000, '2023-01-05'),
(6, 'Arjun', 'Hyderabad', 1800, '2023-01-06'),
(7, 'Neha', 'Bangalore', 2200, '2023-01-07'),
(8, 'Vikas', 'Chennai', 3000, '2023-01-08'),
(9, 'Anjali', 'Hyderabad', 1700, '2023-01-09'),
(10, 'Rahul', 'Bangalore', 2600, '2023-01-10'),
(11, 'Suresh', 'Chennai', 2800, '2023-01-11'),
(12, 'Pooja', 'Hyderabad', 1600, '2023-01-12'),
(13, 'Manoj', 'Bangalore', 2400, '2023-01-13'),
(14, 'Divya', 'Chennai', 2100, '2023-01-14'),
(15, 'Karthik', 'Hyderabad', 1900, '2023-01-15'),
(16, 'Meena', 'Bangalore', 2300, '2023-01-16'),
(17, 'Raj', 'Chennai', 2700, '2023-01-17'),
(18, 'Simran', 'Hyderabad', 2000, '2023-01-18'),
(19, 'Deepak', 'Bangalore', 2500, '2023-01-19'),
(20, 'Nisha', 'Chennai', 2600, '2023-01-20');

CREATE TABLE employees (
    emp_id INT,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    join_date DATE
);

INSERT INTO employees VALUES
(1, 'Amit', 'HR', 25000, '2023-01-01'),
(2, 'Ravi', 'IT', 32000, '2023-01-02'),
(3, 'Sneha', 'Finance', 45000, '2023-01-03'),
(4, 'Kiran', 'Sales', 38000, '2023-01-04'),
(5, 'Priya', 'HR', 27000, '2023-01-05'),
(6, 'Arjun', 'IT', 35000, '2023-01-06'),
(7, 'Neha', 'Sales', 36000, '2023-01-07'),
(8, 'Vikas', 'Finance', 50000, '2023-01-08'),
(9, 'Anjali', 'IT', 33000, '2023-01-09'),
(10, 'Rahul', 'Sales', 40000, '2023-01-10'),
(11, 'Suresh', 'HR', 29000, '2023-01-11'),
(12, 'Pooja', 'IT', 34000, '2023-01-12'),
(13, 'Manoj', 'Sales', 37000, '2023-01-13'),
(14, 'Divya', 'Finance', 48000, '2023-01-14'),
(15, 'Karthik', 'IT', 36000, '2023-01-15'),
(16, 'Meena', 'HR', 28000, '2023-01-16'),
(17, 'Raj', 'Sales', 39000, '2023-01-17'),
(18, 'Simran', 'Finance', 47000, '2023-01-18'),
(19, 'Deepak', 'IT', 35000, '2023-01-19'),
(20, 'Nisha', 'HR', 30000, '2023-01-20');




--ROW_NUMBER()
--1.Assign a unique row number to all employees based on salary (highest first). 
Select
    emp_id ,
    emp_name ,
    department,
    salary,
    ROW_NUMBER() over (order by salary desc) as salary_based
from employees;


--2.Assign row numbers to employees within each department based on salary descending. 
Select
    emp_id ,
    emp_name ,
    department,
    salary,
    ROW_NUMBER() over (partition by department
                        order by salary desc) as 
from employees;


--3.Assign row numbers based on employee joining date (latest first). 
Select
    emp_id ,
    emp_name ,
    department,
    salary,
    join_date,
    ROW_NUMBER() over (order by join_date desc) as earlier_joining
from employees;

--4.Assign row numbers within each department based on earliest joining date. 
Select
    emp_id ,
    emp_name ,
    department,
    salary,
    join_date,
    ROW_NUMBER() over (partition by department
                        order by join_date desc) as earlier_joining
from employees;


--5.Assign row numbers to orders based on order date.
 Select 
    order_id  ,
    customer_name ,
    city ,
    amount ,
    order_date,
    ROW_NUMBER(order by order_date) as date_based
from orders;


--6.Assign row numbers to orders within each city based on order amount (highest first).
Select
        customer_name,
        city,
        amount,
        order_date,
        ROW_NUMBER() over (partition by city
                            order by amount desc) as highest_order
from orders;


--7.Assign row numbers to employees based on salary (lowest first). 
Select
        customer_name,
        city,
        amount,
        order_date,
        ROW_NUMBER() over (
                            order by salary asc) as lowest_salary
from orders;


--8.Assign row numbers within department for employees based on name alphabetically. 
Select
        customer_name,
        city,
        amount,
        order_date,
        ROW_NUMBER() over (partition by department
                            order by customer_name asc) as name_based
from orders;




--RANK()
--9.	Rank all employees based on salary (highest first). 
Select
    emp_id ,
    emp_name ,
    department,
    salary,
    join_date,
    rank() over (order by salary desc) as rank_by_salary
from employees;

--10.	Rank employees within each department based on salary. 
Select
    emp_id ,
    emp_name ,
    department,
    salary,
    join_date,
    rank() over (partition by department
                order by salary desc) as rank_by_salary
from employees;


--11.	Rank employees based on joining date (latest gets rank 1). 
Select emp_id,
       emp_name,
       department,
       salary,
       join_date,
       rank() over(order by join_date DESC) as joining_rank
from employees;


--12.	Rank orders based on order amount (highest first).
Select order_id,
       customer_name,
       city,
       amount,
       order_date,
       rank() over(order by amount DESC) as amount_rank
from orders;


--13.	Rank orders within each city based on order amount. 
Select order_id,
       customer_name,
       city,
       amount,
       order_date,
       rank() over(partition BY city order by amount DESC) as city_rank
from orders;

--14.	Rank employees within department based on salary (lowest first). 
Select emp_id,
       emp_name,
       department,
       salary,
       join_date,
       rank() over(partition by department order by salary asc) as salary_rank
from employees;

--15. Rank employees based on name alphabetically
Select emp_id,
       emp_name,
       department,
       salary,
       join_date,
       rank() over(order by emp_name asc) as name_rank
from employees;


--16. Rank orders within each city based on order date
Select order_id,
       customer_name,
       city,
       amount,
       order_date,
       rank() over(partition by city order by order_date asc) as date_rank
from orders;


--Dense_rank()
--17. Assign dense rank to employees based on salary (highest first)
Select emp_id,
       emp_name,
       department,
       salary,
       DENSE_RANK() OVER(ORDER BY salary DESC) AS salary_rank
from employees;

--18. Assign dense rank within each department based on salary
Select emp_id,
       emp_name,
       department,
       salary,
       DENSE_RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS dept_salary_rank
from employees;

--19. Assign dense rank to employees based on joining date
Select emp_id,
       emp_name,
       department,
       join_date,
       DENSE_RANK() OVER(ORDER BY join_date DESC) AS joining_rank
from employees;

--20. Assign dense rank to orders based on order amount
Select order_id,
       customer_name,
       city,
       amount,
       DENSE_RANK() OVER(ORDER BY amount DESC) AS amount_rank
from orders;

--21. Assign dense rank within each city based on order amount
Select order_id,
       customer_name,
       city,
       amount,
       DENSE_RANK() OVER(PARTITION BY city ORDER BY amount DESC) AS city_amount_rank
from orders;


--22. Assign dense rank to employees based on salary (lowest first)
Select emp_id,
       emp_name,
       department,
       salary,
       DENSE_RANK() OVER(ORDER BY salary ASC) AS low_salary_rank
from employees;


 --23. Assign dense rank within department based on joining date
Select emp_id,
       emp_name,
       department,
       join_date,
       DENSE_RANK() OVER(PARTITION BY department ORDER BY join_date DESC) AS dept_join_rank
from employees;


--24. Assign dense rank to orders based on order date
Select order_id,
       customer_name,
       city,
       order_date,
       Dense_rank() over(order by order_date desc) as order_date_rank
from orders;


