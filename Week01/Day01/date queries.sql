
--1.Select employes hired in the year 2020
Select name 
from Employee
where year(hire_date)=2020


--2.Select employees hired in January of any year:
SELECT Name 
FROM Employee
WHERE MONTH(hire_date) = 1;


--3.Select employees hired before 2019
SELECT Name 
FROM Employee
WHERE year(hire_date) < 2019


--4.Select employes hired on or after March 1, 2021
 Select name
 From Employee
 where hire_date>='2021-03-01'


--5.Select employees hired in the last 2 years.
SELECT Name 
FROM Employee
WHERE datediff(curdate(),hire_date)<=2



