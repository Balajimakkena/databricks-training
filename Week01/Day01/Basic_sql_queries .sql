--1.Select all columns from the Employee table.
Select * 
from Employee

--2.Select only the name and salary columns from the Employee table
Select name , salary 
from Employee


--3.Select employees who are older than 30.
Select name 
from Employee
where age > 30

--4.Select the names of all departments.
Select name from Department


--5.Select employees who work in the IT department.
Select e.name 
from Employee e 
join Department d 
on e.department_id=d.department_id
where d.name="IT"

