--1.Select employees whose names start with 'J'.
Select name from Employee
where name like "J%"


--2.Select employees whose names end with 'e'.
Select name from Employee
where name like "%e"


--3.Select employes whose names contain'a'
Select name from Employee
where name like "%a%"


--4.Select employees whose names are exactly 9 characters long
Select name from Employee
having length(name)=9


--5.Select employees whose names have 'o' as the second character.
Select name from Employee
where name like "_o%"
