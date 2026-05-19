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


---QUESTION 3 – Experience Parity Validation

--Table

CREATE TABLE employee_experience (

emp_id INT,

emp_name VARCHAR(50),

joining_date DATE,

declared_experience INT,

salary DECIMAL(10,2)

);

--Data

INSERT INTO employee_experience VALUES

(1,'Veena','2018-07-01',4,65000.40),

(2,'Ravi','2014-01-10',12,85000.90),

(3,'Anil','2020-09-01',3,70000.10);

--Question

--For each employee:

--1· Uppercase name
Select
        emp_id,
        upper(emp_name) as employee_name
from employee_experience;



--2· Calculate actual experience from date
Select 
        emp_id,
        joining_date,
        declared_experience,
        timestampdiff(year, joining_date, curdate()) AS actual_experience
from employee_experience;


--3· Find difference between declared and actual experience
Select
        emp_id,
        abs(
                declared_experience - 
                timestampdiff(year, joining_date, curdate())
            ) as experience_difference,
from employee_experience;


--4· Floor salary
Select
        emp_id,
        salary,
        floor(salary) AS floor_salary,
from employee_experience;

--5.
/*
· CASE:

o Overstated if declared > actual

o Understated if declared < actual

o Matched
*/
Select 
        emp_id,
        CASE
                WHEN declared_experience > 
                    TIMESTAMPDIFF(YEAR, joining_date, CURDATE())
                    THEN 'Overstated'
                    
                WHEN declared_experience < 
                    TIMESTAMPDIFF(YEAR, joining_date, CURDATE())
                    THEN 'Understated'
                    
                ELSE 'Matched'
            end as experience_status

From employee_experience;


--QUESTION 4 – Salary Digit Pattern Analysis

--Table

CREATE TABLE salary_digits (

emp_id INT,

emp_name VARCHAR(50),

salary DECIMAL(10,2),

credit_date DATE

);

--Data

INSERT INTO salary_digits VALUES

(1,'Karthik',75000.75,'2025-01-01'),

(2,'Veena',65000.40,'2025-01-02'),

(3,'Suresh',60000.55,'2025-01-03');

--Question

--For each employee:

--1· Extract last two characters of name
Select
        emp_id,
        emp_name,
        right(emp_name, 2) as last_two_characters
from salary_digits;


--2· Get day of month from credit date
Select
        emp_name,
        credit_date,
        day(credit_date) as credit_day
from salary_digits;


--3· Truncate salary to integer
Select
        emp_id,
        emp_name,
        salary,
        Truncate(salary, 0) as truncated_salary
from salary_digits;

--4· Use MOD on salary
Select
        emp_id,
        emp_name,
        salary,
        mod(Truncate(salary,0), 10) as salary_mod_value
from salary_digits;


/*
· CASE:

o Pattern Match if salary MOD 10 equals day

o No Match otherwise
*/
Select
        emp_id,
        emp_name,
        CASE
            WHEN MOD(TRUNCATE(salary,0), 10) = DAY(credit_date)
                THEN 'Pattern Match'
                
            ELSE 'No Match'
        end as pattern_status
from salary_digits;


--QUESTION 5 – Odd–Even Salary Compliance

--Table

CREATE TABLE payroll_control (

emp_id INT,

emp_name VARCHAR(50),

salary DECIMAL(10,2),

payment_date DATE

);

--Data

INSERT INTO payroll_control VALUES

(1,'Ravi',85000.90,'2025-01-15'),

(2,'Anil',70000.10,'2025-01-16'),

(3,'Veena',65000.40,'2025-01-17');

---Question

--For each employee:

--1· Lowercase name
Select 
    emp_id,
    lower(emp_name) as employee_name
from payroll_control;


--2· Extract weekday
Select
        emp_id,
        salary,
        dayname(payment_date) as weekday_name
from payroll_control;

--3· Round salary
Select
        emp_id,
        salary,
        round(salary,0) as rounded_salary
from payroll_control;

--4· Apply MOD on salary
Select
        emp_id,
        salary,
        mod(round(salary,0), 2) as salary_mod_value
from payroll_control;

--5.
/*
· CASE:

o Violation if even salary paid on odd weekday

o Compliant otherwise
*/
Select
        emp_id,
        emp_name,
        payment_date,
        CASE
                WHEN MOD(ROUND(salary,0), 2) = 0
                    AND MOD(DAY(payment_date), 2) = 1
                    THEN 'Violation'
                    
                ELSE 'Compliant'
        end as compliance_status   
from payroll_control;    

--QUESTION 6 – Salary Inflation Drift

--Table

CREATE TABLE inflation_watch (

emp_id INT,

emp_name VARCHAR(50),

salary DECIMAL(10,2),

last_hike DATE

);

--Data

INSERT INTO inflation_watch VALUES

(1,'Karthik',75000.75,'2019-01-01'),

(2,'Veena',65000.40,'2022-01-01'),

(3,'Ravi',85000.90,'2017-01-01');

---Question

--For each employee:

--1· Proper case name
Select 
    emp_id,
     concat(
            upper(left(emp_name,1)),
            lower(substring(emp_name,2))
            ) as employee_name
from inflation_watch;

--2· Calculate years since hike
Select
        emp_id,
        last_hike,
        timestampdiff(year,last_hike,curdate()) as years_since_hike
from inflation_watch;

--3· Apply POWER on years
Select 
        emp_name,
        power(
        timestampdiff(year, last_hike, CURDATE()),
        2
    ) as power_years
from inflation_watch;

--4· Round salary impact
Select
        emp_id,
        emp_name,
        round(
        salary * power(1.05,
        timestampdiff(year, last_hike, cur())),
    2) AS salary_impact
from inflation_watch;

--5
/*
· CASE:

o High Inflation Risk if years > 5

o Moderate

o Low
*/
Select 
        emp_id,
        emp_name,
        last_hike,
        CASE
                WHEN TIMESTAMPDIFF(YEAR, last_hike, CURDATE()) > 5
                    THEN 'High Inflation Risk'
                    
                WHEN TIMESTAMPDIFF(YEAR, last_hike, CURDATE()) BETWEEN 3 AND 5
                    THEN 'Moderate'
                    
                ELSE 'Low'
            end as inflation_status

from inflation_watch;       


--QUESTION 7 – Salary Sign Integrity Check

--Table

CREATE TABLE salary_integrity (

emp_id INT,

emp_name VARCHAR(50),

salary DECIMAL(10,2),

record_date DATE

);

--Data

INSERT INTO salary_integrity VALUES

(1,'Anil',-70000.10,'2025-01-10'),

(2,'Veena',65000.40,'2025-01-10'),

(3,'Ravi',0.00,'2025-01-10');

--Question

--For each employee:

--1· Uppercase name
Select 
    emp_id,
    upper(emp_name) as employee_name
from salary_integrity;

--2· Extract year
Select 
        emp_id,
        record_date,
        year(record_date) as record_year
from salary_integrity;

--3· Apply SIGN on salary
Select
        emp_id,
        emp_name,
        salary,
        sign(salary) as salary_sign
from salary_integrity;


--4· ABS salary
Select
        emp_name,
        salary,
        abs(salary) as absolute_salary
from salary_integrity;

--5.
/*
· CASE:

o Negative Error

o Zero Salary

o Valid
*/
Select 
        emp_name,
        salary,
        CASE
                WHEN salary < 0
                    THEN 'Negative Error'
                    
                WHEN salary = 0
                    THEN 'Zero Salary'
                    
                ELSE 'Valid'
            end as salary_status
from salary_integrity;


--QUESTION 8 – Name Length vs Salary Correlation

--Table

CREATE TABLE name_salary (

emp_id INT,

emp_name VARCHAR(50),

salary DECIMAL(10,2),

join_date DATE

);

--Data

INSERT INTO name_salary VALUES

(1,'Karthik',75000.75,'2019-03-15'),

(2,'Veena',65000.40,'2021-06-20'),

(3,'Ravi',85000.90,'2016-01-10');

--Question

--For each employee:

--1· Calculate name length
Select 
        emp_id,
        emp_name,
        length(emp_name) as name_length
from name_salary;

--2· Calculate years of service
Select 
        emp_name,
        join_date,
        timestampdiff(year, join_date, curdate()) as years_of_service
from name_salary;


--3· Round salary
Select
        emp_name
        salary
        Round(salary,0) as rounded_salary
from name_salary;

--4· Compare name length vs years
/*
· CASE:

o Name Bias if length > years

o Neutral
*/
Select
        emp_name,
        join_date,
        CASE
                WHEN LENGTH(emp_name) >
                    TIMESTAMPDIFF(YEAR, join_date, CURDATE())
                    THEN 'Name Bias'
                    
                ELSE 'Neutral'
            end as comparison_status
from name_salary;



--QUESTION 9 – Salary Spike Detection by Month

--Table

CREATE TABLE salary_monthly (

emp_id INT,

emp_name VARCHAR(50),

salary DECIMAL(10,2),

paid_date DATE

);

--Data

INSERT INTO salary_monthly VALUES

(1,'Karthik',75000.75,'2025-01-31'),

(2,'Veena',65000.40,'2025-02-28'),

(3,'Ravi',85000.90,'2025-03-31');

--Question

--For each record:

--1· Extract month name
Select 
    emp_id,
    emp_name,
    Monthname(paid_date) as month_name
from salary_monthly;

--2· CEIL salary
Select
        emp_id,
        emp_name,
        salary,
        ceil(salary) as ceil_salary
from salary_monthly;

--3· Check last day of month
Select
        emp_name,
        last_date(paid_date) as last_date_of_month
from salary_monthly;

--4
/*
· CASE:

o End Month Spike

o Regular
*/
Select
        emp_name,
        CASE
                WHEN paid_date = LAST_DAY(paid_date)
                    THEN 'End Month Spike'
                    
                ELSE 'Regular'
            end as salary_spike_status

from salary_monthly;

--QUESTION 10 – Salary Digit Sum Audit

--Table

CREATE TABLE digit_audit (

emp_id INT,

emp_name VARCHAR(50),

salary DECIMAL(10,2),

audit_date DATE

);

--Data

INSERT INTO digit_audit VALUES

(1,'Anil',70000.10,'2025-01-01'),

(2,'Veena',65000.40,'2025-01-02');

--Question

--For each employee:

--1· Extract first character of name
Select
        emp_name,
        left(emp_name,1) as first_character
from digit_audit;

--2· Truncate salary
Select
        emp_name,
        salary,
        Truncate(salary,0) as truncated_salary
from digit_audit;

--3· Sum digits logically
Select
        emp_name,
        salary,
        (
                floor(Truncate(salary,0) / 10000) +
                floor((Truncate(salary,0) % 10000) / 1000) +
                floor((Truncate(salary,0) % 1000) / 100) +
                floor((Truncate(salary,0) % 100) / 10) +
                (Truncate(salary,0) % 10)
            ) as  digit_sum
from digit_audit;

--4· Extract day
Select
        emp_name,
        audit_date,
        day(audit_date) as audit_date
from audit_date;

--5
/*
· CASE:

o Digit Alert

o Normal
*/
Select
        emp_name
        audit_date,
        salary,
        CASE
                WHEN (
                    FLOOR(TRUNCATE(salary,0) / 10000) +
                    FLOOR((TRUNCATE(salary,0) % 10000) / 1000) +
                    FLOOR((TRUNCATE(salary,0) % 1000) / 100) +
                    FLOOR((TRUNCATE(salary,0) % 100) / 10) +
                    (TRUNCATE(salary,0) % 10)
                ) > 20
                    THEN 'Digit Alert'
                    
                ELSE 'Normal'
            end as audit_status
from audit_date;



--QUESTION 11 – Weekend Salary Credit Fraud Detection

--Table

CREATE TABLE salary_credit_audit (

emp_id INT,

emp_name VARCHAR(50),

salary DECIMAL(10,2),

credit_date DATE,

bank_code VARCHAR(10)

);

--Data

INSERT INTO salary_credit_audit VALUES

(1,'Karthik',75000.75,'2025-01-04','HDFC01'),

(2,'Veena',65000.40,'2025-01-06','ICIC02'),

(3,'Ravi',85000.90,'2025-01-05','SBIN03'),

(4,'Anil',70000.10,'2025-01-07','AXIS04'),

(5,'Suresh',60000.55,'2025-01-11','HDFC01');

--Question

--For each record:

--1· Extract bank prefix from bank_code
Select 
    emp_id,
    emp_name,
    left(bank_code,4) as  bank_prefix
from  salary_credit_audit;

--2· Identify weekday name of credit_date
Select
        emp_id,
        emp_name,
        dayname(credit_date) as weekday_name
from salary_credit_audit;

--3· Round salary
Select 
        emp_name,
        salary,
        round(salary,0) as rounded_salary
from salary_credit_audit;

--4· Apply MOD on salary
Select
        emp_name,
        salary,
        mod(round(salary,0)) as salary_mod_value
from salary_credit_audit;

--5.
/*
· CASE:

o Weekend Fraud if credited on Saturday/Sunday AND salary MOD 5 = 0

o Bank Review if bank is HDFC

o Else Normal
*/
Select
        emp_name,
        CASE
                WHEN DAYNAME(credit_date) IN ('Saturday','Sunday')
                    AND MOD(ROUND(salary,0),5) = 0
                    THEN 'Weekend Fraud'
                    
                WHEN LEFT(bank_code,4) = 'HDFC'
                    THEN 'Bank Review'
                    
                ELSE 'Normal'
            end as fraud_status
from salary_credit_audit;       



--QUESTION 12 – Salary Credit Time Drift Analysis

--Table

CREATE TABLE salary_time_drift (

emp_id INT,

emp_name VARCHAR(50),

salary DECIMAL(10,2),

credit_ts DATETIME

);

--Data

INSERT INTO salary_time_drift VALUES

(1,'Karthik',75000.75,'2025-01-10 23:45:00'),

(2,'Veena',65000.40,'2025-01-10 09:15:00'),

(3,'Ravi',85000.90,'2025-01-11 00:10:00'),

(4,'Anil',70000.10,'2025-01-09 18:30:00'),

(5,'Suresh',60000.55,'2025-01-10 02:50:00');

--Question

--For each employee:

--1· Extract hour from credit timestamp
Select
        emp_id,
        emp_name,
        hour(credit_ts) as credit_hour
from salary_time_drift;

--2· Convert emp_name to lowercase
Select 
    emp_id,
    lower(emp_name) as employee_name
from salary_time_drift;

--3· Floor salary
Select
        emp_name,
        salary,
        floor(salary) as floor_salary
from salary_time_drift;

--4· Calculate difference between salary and hour
Select
        emp_name,
        abs(floor(salary) - hour(credit_ts)) as salary_hour_difference
from salary_time_drift;

--5
/*
· CASE:

o Midnight Drift if hour between 0–3

o After Hours

o Business Hours
*/

Select  
        emp_name,
        CASE
                WHEN HOUR(credit_ts) BETWEEN 0 AND 3
                    THEN 'Midnight Drift'
                    
                WHEN HOUR(credit_ts) > 18
                    THEN 'After Hours'
                    
                ELSE 'Business Hours'
            end as drift_status
from salary_time_drift;



--QUESTION 13 – Salary Decimal Precision Audit

--Table

CREATE TABLE salary_precision (

emp_id INT,

emp_name VARCHAR(50),

salary DECIMAL(10,4),

record_date DATE

);

--Data

INSERT INTO salary_precision VALUES

(1,'Karthik',75000.7567,'2025-01-01'),

(2,'Veena',65000.4044,'2025-01-02'),

(3,'Ravi',85000.9099,'2025-01-03'),

(4,'Anil',70000.1001,'2025-01-04'),

(5,'Suresh',60000.5555,'2025-01-05');

--Question

--For each record:

--1· Truncate salary to 2 decimals
Select 
        emp_name,
        salary,
        truncate(salary,2) as truncated_salary
from salary_precision;


--2· Calculate difference between rounded and truncated value
Select
        emp_name,
        abs(
        round(salary,2) - truncate(salary,2)
            ) as precision_difference
from salary_precision;


--3· Extract day name
Select
        emp_name,
        record_date,
        dayname(record_date) as day_name
from salary_precision;


--4· Get length of emp_name
Select 
        emp_name,
        length(emp_name) as name_length
from salary_precision;

--5
/*
· CASE:

o Precision Loss if difference > 0.01

o Safe
*/
Select
        emp_name,
        CASE
            WHEN ABS(
                    ROUND(salary,2) - TRUNCATE(salary,2)
                ) > 0.01
                THEN 'Precision Loss'
                
            ELSE 'Safe'
        end as precision_status
from salary_precision;



--QUESTION 14 – Salary Growth Power Index

--Table

CREATE TABLE salary_growth (

emp_id INT,

emp_name VARCHAR(50),

base_salary DECIMAL(10,2),

growth_rate DECIMAL(5,2),

last_hike DATE

);

--Data

INSERT INTO salary_growth VALUES

(1,'Karthik',75000.75,1.08,'2019-01-01'),

(2,'Veena',65000.40,1.05,'2021-01-01'),

(3,'Ravi',85000.90,1.12,'2017-01-01'),

(4,'Anil',70000.10,1.03,'2022-01-01'),

(5,'Suresh',60000.55,1.06,'2020-01-01');

--Question

--For each employee:

--1· Calculate years since last hike
Select
        emp_name,
        last_hike,
        timestampdiff(year,last_hike,curdate()) as years_since_hike
from salary_growth;

--2· Apply POWER using growth_rate and years
Select
        emp_name,
        growth_rate,
        POWER(
                growth_rate,
                timestampdiff(year, last_hike, curdate())
            ) as growth_power_index
from salary_growth;


--3· Round projected salary
Select  
        emp_name,
        base_salary,
        ROUND(
            base_salary *
            POWER(
                    growth_rate,
                    TIMESTAMPDIFF(YEAR, last_hike, CURDATE())
                ),
            2) AS projected_salary
from salary_growth;

--4· Uppercase emp_name
Select 
    emp_id,
    upper(emp_name) as employee_name
from salary_growth;

--5
/*
· CASE:

o Explosive Growth if projected > 150000

o Controlled

o Stagnant
*/
Select
        emp_name,
        CASE
            WHEN round(
                    base_salary *
                    POWER(
                        growth_rate,
                        timestampdiff(year, last_hike, curdate())
                    ),
                2) > 150000
                THEN 'Explosive Growth'
                
            WHEN round(
                    base_salary *
                    POWER(
                        growth_rate,
                        timestampdiff(year, last_hike, curdate())
                    ),
                2) between 90000 AND 150000
                THEN 'Controlled'
                
            ELSE 'Stagnant'
        end as growth_status
from salary_growth;

--QUESTION 15 – Salary Symmetry Check

--Table

CREATE TABLE salary_symmetry (

emp_id INT,

emp_name VARCHAR(50),

salary DECIMAL(10,2),

processed_date DATE

);

--Data

INSERT INTO salary_symmetry VALUES

(1,'Karthik',75557.75,'2025-01-15'),

(2,'Veena',64446.40,'2025-01-16'),

(3,'Ravi',85858.90,'2025-01-17'),

(4,'Anil',70007.10,'2025-01-18'),

(5,'Suresh',60000.55,'2025-01-19');

--Question

--For each record:

--1· Remove decimals from salary
Select
        emp_name,
        truncate(salary,0)as truncated_salary
from salary_symmetry;

--2· Reverse salary digits
Select
        emp_name,
        truncate(salary,0)as salary,
        Reverse(truncate(salary,0)) as reversed_salary
from salary_symmetry;

--3· Extract weekday
Select
        emp_name,
        dayname(processed_date) as weekday_name
from salary_symmetry;

--4· Proper case emp_name
Select
        emp_id,
        concat(
            upper(left(emp_name,1)),
            lower(substring(emp_name,2))
        )as emp_name
from salary_symmetry;

--5
/*
· CASE:

o Symmetric Pay if reversed equals original

o Asymmetric
*/

Select
        emp_name,
        salary,
        CASE
            WHEN truncate(salary,0) = 
                reverse(truncate(salary,0))
                THEN 'Symmetric Pay'
                
            ELSE 'Asymmetric'
        end as symmetry_status
from salary_symmetry;