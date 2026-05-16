--Table Structure

CREATE TABLE employee_payments (

emp_id INT PRIMARY KEY,

emp_name VARCHAR(50),

department VARCHAR(30),

base_salary DECIMAL(10,2),

bonus DECIMAL(10,2),

joining_date DATE

);

--Insert Data

INSERT INTO employee_payments VALUES

(1,'karthik','Data',75000.75,5000.50,'2019-03-15'),

(2,'veena','HR',65000.40,4000.25,'2021-06-20'),

(3,'ravi','Data',85000.90,6000.75,'2016-01-10'),

(4,'anil','Finance',70000.10,NULL,'2020-09-01'),

(5,'suresh','HR',60000.55,3000.30,'2022-11-25');

--Questions

--1.Convert emp_name to proper case ---upper /lower ---Initcap (CamelCase).
Select concat(
                upper(substring(emp_name,1,1)),
                lower(substring(emp_name,2))
                ) as Formatted_name
from employee_payments;


--2.Calculate total income = base_salary + bonus (NULL safe) +
Select emp_id,
       emp_name,
       department,
       base_salary,
       bonus,
       base_salary + IFNULL(bonus,0) as total_income
From employee_payments;

--3.Round total income to nearest integer.
Select   round(base_salary + IFNULL(bonus,0)) as total_income
from employee_payments;


--4.· Extract joining year
Select year(joining_date) as joining_year
from employee_payments;

--5.Use CASE to classify:
/* 
Senior if experience > 7 years
Mid if between 4 and 7
Junior otherwise
*/
Select emp_name,
       base_salary,
       case 
        when timestampdiff(year,joining_date,curdate()) > 7 then "Senior"
        when timestampdiff(year,joining_date,curdate()) between 4 and 7 then "Mid"
        else "Junior"
       end as position 
from employee_payments;


--QUESTION 2: Order Delivery Delay Analysis

--Table Structure

CREATE TABLE orders_delivery (

order_id INT,

customer_name VARCHAR(50),

order_date DATE,

delivery_date DATE,

order_amount DECIMAL(10,2)

);

--Insert Data

INSERT INTO orders_delivery VALUES

(101,'rajesh','2025-01-01','2025-01-05',12500.75),

(102,'meena','2025-01-10','2025-01-10',8400.40),

(103,'arun','2025-01-15','2025-01-20',15600.90),

(104,'pooja','2025-01-18',NULL,9200.10);

--Questions

--1.Uppercase customer name
update orders_delivery 
set customer_name=upper(customer_name)
where customer_name is not null;
Select *
from orders_delivery;


--2.Calculate delivery days using date difference
Select customer_name,
        order_date,
        delivery_date,
        datediff(delivery_date,order_date) as delivery_days
from orders_delivery;

--3.Replace NULL delivery date with today
update orders_delivery
set delivery_date=curdate()
where delivery_date is null;
Select * 
from orders_delivery;

--4.Truncate order amount to 1 decimal
Select order_id,
       customer_name,
       order_amount,
       Truncate(order_amount,1) as truncated_amount
from orders_delivery;

--5.Use CASE:
/*
o Same-day

o Delayed (>3 days)

o Pending
*/
Select order_id,
       customer_name,
       order_date,
       delivery_date,
       case 
        when datediff(order_date,joining_date) is null then 'Pending'
        when datediff(order_date,joining_date) > 3 then 'delayed 3 days'
        when datediff(order_date,joining_date) = 0 then 'same-day'
        else 'normal'
       end as delivery_status
from orders_delivery;

--QUESTION 3: Customer Spending Pattern

--Table Structure

CREATE TABLE customer_spending (

cust_id INT,

cust_name VARCHAR(50),

city VARCHAR(30),

purchase_amount DECIMAL(10,2),

purchase_date DATE

);

--Insert Data

INSERT INTO customer_spending VALUES

(1,'amit','mumbai',12000.75,'2024-12-01'),

(2,'neha','delhi',8500.40,'2024-12-15'),

(3,'rohit','mumbai',15500.90,'2024-11-20'),

(4,'kavya','chennai',6000.10,'2024-10-05');

--Questions

--Display:

--1· Customer name with first letter capitalized
update customer_spending
set cust_name=concat(upper(substring(cust_name,1,1)),
                      lower(substring(cust_name,2)))
where cust_name is not null;

Select *
from customer_spending;

--2· Month name of purchase
Select cust_name,
        city,
        purchase_amount,
        purchase_date,
        Monthname(purchase_date) as purchase_month
from customer_spending;
       

--3· Rounded purchase amount
Select cust_name,
        city,
        purchase_amount,
        purchase_date,
        round(purchase_amount) as amount
from customer_spending;

--4· Absolute value of purchase (defensive logic)
Select cust_name,
        city,
        purchase_amount,
        purchase_date,
        abs(purchase_amount) as amount
from customer_spending;


/*
5· CASE:

o High spender > 15000

o Medium 8000–15000

o Low otherwise

*/
Select cust_name,
        city,
        purchase_amount,
        purchase_date,
        CASE 
            when purchase_amount >15000 then 'High spender'
            when purchase_amount between 8000 and 15000 then 'Medium'
            else 'low'
        END as purchase_status
from customer_spending;



--QUESTION 4: Subscription Validity Check

--Table Structure

CREATE TABLE subscriptions (

user_id INT,

user_email VARCHAR(100),

start_date DATE,

end_date DATE,

subscription_fee DECIMAL(10,2)

);

--Insert Data

INSERT INTO subscriptions VALUES

(1,'karthik@gmail.com','2024-01-01','2025-01-01',12000.50),

(2,'veena@yahoo.com','2024-06-15','2024-12-15',8500.75),

(3,'ravi@hotmail.com','2023-03-01','2024-03-01',15000.90);

--Questions

--For each user:

--1· Extract email domain
Select user_email,
        substring_index(user_email,'@',-1) as email_domain
from subscriptions;

--2· Calculate subscription duration in months
Select user_id,
        start_date,
        end_date,
        timestampdiff(month,start_date,end_date) as subscription_duration
from subscriptions;

--3· Format fee with commas
Select user_id,
        Format(subscription_fee,2) as subscription_fee
from subscriptions;

--4· Find remaining days from today
Select user_id,
        datadiff(end_date,curdate())as remaining_days
from subscriptions;
--5.
/*
· CASE:

o Active

o Expiring Soon (≤30 days)

o Expired
*/
Select user_id,
       user_email,
       start_date,
       end_date,
       CASE 
            when datediff (end_date,curdate()) >0 then 'Expired'
            when datediff(end_date,curdate()) <=30 then 'Expiring soon'
            else 'Active'
         END as subscription_status
from subscriptions;