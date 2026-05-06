## Question 1
Select all columns from the Employee table.

**Answer:**
Select * from Employee

## Question 2
Select only the name and salary columns from the Employee table

**Answer:**
Select name , salary from Employee

## Question 3
Select employees who are older than 30.

**Answer:**
Select name from Employee
where age > 30

## Question 4
Select the names of all departments.

**Answer:**
Select name from Department

## Question 5
Select employees who work in the IT department.

**Answer:**

Select e.name from Employee e join Department d on e.department_id=d.department_id
where d.name="IT"

