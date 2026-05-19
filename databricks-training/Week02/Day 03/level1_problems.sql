--QUESTION 1 – Salary Risk Flagging Based on Tax Shock

--Table

CREATE TABLE salary_audit (

emp_id INT,

emp_name VARCHAR(50),

salary DECIMAL(10,2),

tax_percent DECIMAL(5,2),

last_revision DATE

);

--Data

INSERT INTO salary_audit VALUES

(1,'karthik',75000.75,10.5,'2022-01-15'),

(2,'veena',65000.40,18.0,'2023-06-01'),

(3,'ravi',85000.90,25.0,'2020-11-20');

--Question

--For each employee:

--1· Normalize name to lowercase
Select
    emp_id,
    lower(emp_name) as employee_name
from salary_audit;

--2· Calculate net salary after tax and round it
Select
        emp_id,
        salary,
        tax_percent,
        round(
            salary - (salary * tax_percent / 100),2) as  net_salary
from salary_audit;

--3· Extract revision year
Select
        emp_id,
        salary,
        year(last_revision) as revision_year
from salary_audit;


--4· Find months since revision
Select
        emp_id,
        last_revision,
        timestampdiff(month, last_revision, curdate()) as months_since_revision
from salary_audit;

--5
/*
· Use CASE:

o Flag Tax Shock if tax > 20 AND months > 24

o Flag Review Needed if tax between 15–20

o Else Stable
*/
Select 
        emp_id,
        CASE
                WHEN tax_percent > 20 
                    AND TIMESTAMPDIFF(month, last_revision, curdate()) > 24
                    THEN 'Flag Tax Shock'
                    
                WHEN tax_percent between 15 and 20
                    THEN 'Flag Review Needed'
                    
                ELSE 'Stable'
            end as salary_status        
from salary_audit;

--QUESTION 2 – Bonus Abuse Detection

--Table

CREATE TABLE bonus_monitor (

emp_code INT,

emp_name VARCHAR(50),

base_salary DECIMAL(10,2),

bonus DECIMAL(10,2),

bonus_date DATE

);

--Data

INSERT INTO bonus_monitor VALUES

(101,'Anil',70000.10,30000.00,'2025-01-10'),

(102,'Suresh',60000.55,3000.30,'2024-03-15'),

(103,'Ravi',85000.90,15000.75,'2023-12-01');

--Question

--For each record:

--1· Convert name to proper case
SELECT 
    emp_code,
    concat(
        upper(left(emp_name,1)),
        low(substring(emp_name,2))
    ) as employee_name
from bonus_monitor;


--2· Calculate bonus percentage of salary (rounded)
Select
        emp_code,
        base_salary,
        bonus,
        round((bonus / base_salary) * 100, 2) as  bonus_percentage
from bonus_monitor;
         


--3· Extract day name of bonus
Select 
        emp_code,
        base_salary,
        bonus,
        dayname(bonus_date) AS bonus_day
from bonus_monitor;


--4· Find absolute salary–bonus difference
Select
        emp_code,
        base_salary,
        bonus,
        abs(base_salary - bonus) as salary_bonus_difference
from bonus_monitor;


--5
/*
· CASE:

o Suspicious if bonus > 30% AND weekend

o Normal if bonus <= 20%

o Audit
*/

Select      
        emp_code,
        base_salary,
        bonus,
        CASE
            WHEN (bonus / base_salary) * 100 > 30
                AND dayname(bonus_date) IN ('Saturday','Sunday')
                THEN 'Suspicious'
                
            WHEN (bonus / base_salary) * 100 <= 20
                THEN 'Normal'
                
            ELSE 'Audit'
        end as  bonus_status

from bonus_monitor;