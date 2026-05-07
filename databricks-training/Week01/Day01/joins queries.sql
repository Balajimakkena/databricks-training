--1.Select employee names along with their department names
Select e.name as Emp_Name,d.name as Dept_Name
From Employee e
join Department d on e.department_id = d.department_id

--2.Select employee names and their coresponding project names
Select e.name as Emp_Name,p.name as P_Name
From Employee e
join Project p on e.department_id=p.department_id

--3.Select all employees and their departments, including those without a department.
Select e.name as Emp_Name,d.name as Dept_Name
From Employee e
left join Department d on e.department_id = d.department_id

--4.Select all departments and their employees, including departments without employees
Select d.name as Dept_Name,e.name as Emp_Name
From Department d 
left join Employee e on d.department_id = e.department_id

--5.Select employes who are not asigned to any project
Select e.name AS Employee
From Employee e
Left join Project p 
on e.department_id = p.department_id
where p.project_id IS NULL;

--6.Select employees and the number of projects their department is working on.
Select e.name AS Employee,count(distinct(p.project_id)) as No_of_projects
From Employee e
Left join Project p 
on e.department_id = p.department_id
group by e.emp_id,e.name

--7.Select project names along with the department names they belong to.
Select d.name as department,p.name as P_Name
From Project p
join Department d on p.department_id=d.department_id

--8.Select the departments that have no employees
Select d.name as department
From Department d
left join Employee e 
on d.department_id=e.department_id
where e.name is null

--9.Select employee names who share the same department with 'John Doe'
Select e1.name 
From Employee e1
join Employee e2
on e1.department_id=e2.department_id
where e2.name="John Doe"

--10.Select the department name with the highest average salary.
Select d.name as department,sum(e.salary) as highest_avg_sal
From Employee e
join Department d
on e.department_id=d.department_id
group by d.name
order by highest_avg_sal desc
limit 1

