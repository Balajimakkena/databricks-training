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


--QUESTION 5: Loan EMI Risk Categorization

--Table Structure

CREATE TABLE loan_details (

loan_id INT,

customer_name VARCHAR(50),

loan_amount DECIMAL(12,2),

interest_rate DECIMAL(5,2),

loan_start DATE

);

--Insert Data

INSERT INTO loan_details VALUES

(201,'suresh',500000.75,8.5,'2022-01-10'),

(202,'mahesh',750000.40,9.2,'2021-05-20'),

(203,'anita',300000.90,7.8,'2023-07-01');

--Questions

--Compute:

--1· Monthly interest using power function
Select    
    loan_id,
    customer_name,
    loan_amount,
    interest_rate,
    POWER((1 + interest_rate / 100), 1.0/12) - 1 AS monthly_interest,
FROM loan_details;

--2· Years since loan start
Select 
    loan_id,
    customer_name,
    loan_amount,
    interest_rate,
    TIMESTAMPDIFF(YEAR, loan_start, CURDATE()) AS years_since_loan_start,
From loan_details;

--3· Round EMI
Select 
    loan_id,
    customer_name,
    loan_amount,
    interest_rate,
    Round(
        (
            loan_amount * 
            ((interest_rate / 100) / 12) * 
            POWER(
                1 + ((interest_rate / 100) / 12),
                TIMESTAMPDIFF(MONTH, loan_start, CURDATE())
            )
        ) /
        (
            POWER(
                1 + ((interest_rate / 100) / 12),
                TIMESTAMPDIFF(MONTH, loan_start, CURDATE())
            ) - 1
        ),
        2) AS EMI
from loan_details;

--4· Uppercase customer name
Select 
    loan_id,
    UPPER(customer_name) AS customer_name,
    loan_amount,
    interest_rate,
from loan_details;

--5
/*
· CASE:

o High Risk if interest > 9

o Medium Risk

o Low Risk
*/
Select 
    loan_id,
    customer_name,
    loan_amount,
    interest_rate,
        case 
        WHEN interest_rate > 9 THEN 'High Risk'
        WHEN interest_rate between 8 and 9 THEN 'Medium Risk'
        ELSE 'Low Risk'
    End as  risk_category

From loan_details;


--QUESTION 6: Employee Attendance Evaluation

--Table Structure

CREATE TABLE attendance (

emp_id INT,

emp_name VARCHAR(50),

total_days INT,

present_days INT,

record_date DATE

);

--Insert Data

INSERT INTO attendance VALUES

(1,'karthik',30,28,'2025-01-31'),

(2,'veena',30,22,'2025-01-31'),

(3,'ravi',30,18,'2025-01-31');

--Questions


--Calculate:

--1· Attendance percentage (rounded)
Select 
    emp_id,
    total_days,
    present_days,
    ROUND((present_days * 100.0) / total_days, 2) AS attendance_percentage,
from attendance;

--2· Month name
Select 
    emp_id,
    MONTHNAME(record_date) AS month_name,
from attendance;



--3· Difference between total and present days
Select 
    emp_id,
    total_days,
    present_days,
    (total_days - present_days) AS absent_days,
from attendance;

--4· Lowercase employee name
Select 
    emp_id,
    LOWER(emp_name) AS employee_name,
from attendance;
--5
/*· CASE:

o Excellent ≥90%

o Average 75–89%

o Poor otherwise
*/
Select 
    emp_id,
    CASE
        WHEN (present_days * 100.0) / total_days >= 90 
            THEN 'Excellent'
            
        WHEN (present_days * 100.0) / total_days BETWEEN 75 AND 89
            THEN 'Average'
            
        ELSE 'Poor'
    END AS attendance_status
from attendance;


--QUESTION 7: Product Discount Validation

--Table Structure

CREATE TABLE product_sales (

product_id INT,

product_name VARCHAR(50),

mrp DECIMAL(10,2),

selling_price DECIMAL(10,2),

sale_date DATE

);

--Insert Data

INSERT INTO product_sales VALUES

(1,'Laptop',75000.75,68000.50,'2025-01-10'),

(2,'Mobile',35000.40,33000.25,'2025-01-12'),

(3,'Tablet',25000.90,26000.75,'2025-01-15');

--Questions

--Derive:

--1· Discount amount (absolute)
Select
    product_id,
    mrp,
    selling_price,
    ABS(mrp - selling_price) AS discount_amount
from product_sales;

    
--2· Discount percentage
Select
    product_id,
    mrp,
    selling_price,
    round(((mrp - selling_price) / mrp) * 100, 2) as discount_percentage,
from product_sales;


--3· Day name of sale
Select
        product_id,
        dayname(sale_date) as sale_day,
from product_sales;

--4· Proper case product name
Select
    product_id,
    concat(
        UPPER(left(product_name,1)),
        LOWER(substring(product_name,2))
    ) as product_name,
from product_sales;
--5.
/*
· CASE:

o Valid Discount

o Overpriced

o No Discount
*/
Select 
    product_id,
    CASE
        WHEN selling_price < mrp THEN 'Valid Discount'
        WHEN selling_price > mrp THEN 'Overpriced'
        ELSE 'No Discount'
    end as  discount_status
from product_sales;


--QUESTION 8: Insurance Policy Aging

--Table Structure

CREATE TABLE insurance_policies (

policy_id INT,

holder_name VARCHAR(50),

premium_amount DECIMAL(10,2),

policy_start DATE,

policy_end DATE

);

--Insert Data

INSERT INTO insurance_policies VALUES

(301,'arjun',12000.50,'2023-01-01','2026-01-01'),

(302,'megha',8500.75,'2022-06-15','2025-06-15'),

(303,'vinod',15000.90,'2021-03-01','2024-03-01');

--Questions

--Show:

--1· Policy duration in years
Select 
        policy_id,
        policy_start,
        policy_end,
        timestampdiff(year, policy_start, policy_end) as policy_duration_years
from insurance_policies;

--2· Remaining days
Select 
        policy_id,
        policy_start,
        policy_end,
        datediff(policy_end, curdate()) as remaining_days
from insurance_policies;

--3· Rounded premium
Select 
        policy_id,
        premium_amount,
        policy_start,
        policy_end,
        Round(premium_amount, 0) AS rounded_premium
from insurance_policies;

--4· Uppercase holder name
Select
    policy_id,
    upper(holder_name) as holder_name
from insurance_policies;


--5
/*
· CASE:

o Long Term

o Mid Term

o Expired
*/
Select
  policy_id,
  CASE
        WHEN policy_end < CURDATE() 
            THEN 'Expired'
            
        WHEN timestampdiff(YEAR, policy_start, policy_end) >= 3 
            THEN 'Long Term'
            
        ELSE 'Mid Term'
    end as  policy_status
from insurance_policies;


--QUESTION 9: Salary Increment Simulation

--Table Structure

CREATE TABLE salary_revision (

emp_id INT,

emp_name VARCHAR(50),

current_salary DECIMAL(10,2),

rating INT,

last_hike DATE

);

--Insert Data

INSERT INTO salary_revision VALUES

(1,'karthik',75000.75,5,'2023-01-01'),

(2,'veena',65000.40,4,'2024-01-01'),

(3,'ravi',85000.90,3,'2022-01-01');

--Question

--Calculate:

--1· Years since last hike
Select
        emp_id,
        current_salary,
        rating,
        timestampdiff(year, last_hike, curdate()) as years_since_last_hike
from salary_revision;


--2· Increment using rating logic
Select
        emp_id,
        CASE
                WHEN rating = 5 THEN current_salary * 0.20
                WHEN rating = 4 THEN current_salary * 0.10
                WHEN rating = 3 THEN current_salary * 0.05
                ELSE 0
                end as increment_amount
from salary_revision;


--3· New salary (rounded)
Select 
        emp_id,
        round(
                current_salary +
                CASE
                WHEN rating = 5 THEN current_salary * 0.20
                WHEN rating = 4 THEN current_salary * 0.10
                WHEN rating = 3 THEN current_salary * 0.05
                ELSE 0
                end,2) AS new_salary
from salary_revision;

--4· Lowercase name
Select 
    emp_id,
    lower(emp_name) as employee_name
from salary_revision;

--5.
/*
· CASE:

o High Increment

o Moderate

o No Increment
*/
Select
        emp_id,
        CASE
                WHEN rating = 5 THEN 'High Increment'
                WHEN rating = 4 THEN 'Moderate'
                ELSE 'No Increment'
                end as increment_status       
from  salary_revision;


--QUESTION 10: Customer Account Status Evaluation

--Table Structure

CREATE TABLE bank_accounts (

account_id INT,

customer_name VARCHAR(50),

balance DECIMAL(12,2),

last_transaction DATE,

branch VARCHAR(30)

);

--Insert Data

INSERT INTO bank_accounts VALUES

(501,'ramesh',125000.75,'2024-12-20','hyderabad'),

(502,'sita',8500.40,'2023-06-15','delhi'),

(503,'manoj',-2500.90,'2025-01-05','mumbai');

--Questions

--Determine:

--1· Absolute balance
Select 
        account_id,
        customer_name,
        abs(balance) as absolute_balance
from bank_accounts;


--2· Days since last transaction
Select 
        account_id,
        customer_name,
        datediff(curdate(), last_transaction) as days_since_last_transaction
from bank_accounts;

--3· Proper case branch name
Select 
        account_id,
        customer_name,
        concat(
        upper(left(branch,1)),
        lower(substring(branch,2))
                ) AS branch_name
from bank_accounts;


--4· Sign of balance
Select 
        account_id,
        customer_name,
        Sign(balance) as balance_sign
from bank_accounts;

--5.
/*
· CASE:

o Active

o Dormant

o Overdrawn
*/
Select 
        account_id,
        customer_name,
        CASE
                WHEN balance < 0 
                THEN 'Overdrawn'
                
                WHEN DATEDIFF(CURDATE(), last_transaction) > 365 
                THEN 'Dormant'
                
                ELSE 'Active'
        end as  account_status
from bank_accounts;



