##Question 1
Select employes hired in the year 2020

**Answer:**
Select name from Employee
where year(hire_date)=2020

##Question 2
Select employees hired in January of any year:

**Answer:**
SELECT Name 
FROM Employee
WHERE MONTH(hire_date) = 1;

##Question 3
Select employees hired before 2019

**Answer:**
SELECT Name 
FROM Employee
WHERE year(hire_date) < 2019

##Question 4
Select employes hired on or after March 1, 2021

**Answer:**
Select employees hired in the last 2 years.

##Question 5
Select employees hired in the last 2 years.

**Answer:**
SELECT Name 
FROM Employee
WHERE datediff(curdate(),hire_date)<=2



