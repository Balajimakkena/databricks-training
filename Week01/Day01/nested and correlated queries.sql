--1.Select the employee with the highest salary
Select name as Emp_Name
From Employee
where salary = (select max(salary)
                From Employee)


--2.Select employees whose salary is above the average salary
Select name as Emp_Name,salary
From Employee
where salary > (select avg(salary)
                From Employee)


--3.Select the second highest salary from the Employee table
Select name 
From Employee 
where salary=(Select max(salary)
From Employee
where salary < (select max(salary)
                From Employee))


--4.Select the department with the most employees
Select d.name as Dept_name,count(e.emp_id) as No_of_emp
From Employee e
join Department d
on e.department_id=d.department_id
group by d.name
having count(e.emp_id)=(Select max(Emp_count)
                        From(Select count(*) as Emp_count
                            From Employee
                            group by department_id) as temp)


--5.Select employees who earn more than the average salary of their department
Select e.name as Dept_name,e.salary
From Employee e
join Department d
on e.department_id=d.department_id
where e.salary >(Select avg(e2.salary)
                from Employee e2
                where e2.department_id=e.department_id)


--6.Select the nth highest salary
 Select name,round(salary)
 from Employee
 where salary=(Select salary
               from Employee
               order by salary desc
               limit 1 offset N-1)


--7.Select employees who are older than all employees in the HR department.
Select e.name
From Employee
where age > (Select max(age)
                From Employee e
                join Department d
                on e.department_id=d.department_id
                where d.name='HR')



--8.Select departments where the average salay is greater than 55000.
Select d.name
From Employee e
join Department d
on e.department_id=d.department
group by e.name
having avg(e.salary)>55000



--9.Select employees who work in a department with at least 2 projects.
Select e.name as Emp_Name,count(*) as No_of_projects
From Employee e
join Project p
on e.department_id=p.department_id
group by e.emp_id
having count(*)>2


--10.Select employees who were hired on the same date as 'Jane Smith'
Select name as Emp_Name
From Employee
where hire_date=(Select hire_date
                from Employee
                where name='Jane Smith') and name<>'Jane Smith'