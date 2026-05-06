## Question 1
Select employees whose names start with 'J'.

**Answer:**
Select name from Employee
where name like "J%"

##Question 2
Select employees whose names end with 'e'.

**Answer:**
Select name from Employee
where name like "%e"

##Question 3
Select employes whose names contain'a'

**Answer:**
Select name from Employee
where name like "%a%"

##Question 4
Select employees whose names are exactly 9 characters long

**Answer:**
Select name from Employee
having length(name)=9

##Question 5
Select employees whose names have 'o' as the second character.

**Answer:**
Select name from Employee
where name like "_o%"
