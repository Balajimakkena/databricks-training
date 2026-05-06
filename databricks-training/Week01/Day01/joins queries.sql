##Question 1
Select employee names along with their department names

**Answer:**
Select e.name as Emp_Name,d.name as Dept_Name
From Employee e
join Department d on e.department_id = d.department_id

##Question 2
Select employee names and their coresponding project names

**Answer:**
Select e.name as Emp_Name,p.name as P_Name
From Employee e
join Project p on e.department_id=p.department_id

##Question 3
Select all employees and their departments, including those without a department.

**Answer:**
Select e.name as Emp_Name,d.name as Dept_Name
From Employee e
left join Department d on e.department_id = d.department_id

##Question 4
Select all departments and their employees, including departments without employees

**Answer:**
Select d.name as Dept_Name,e.name as Emp_Name
From Department d 
left join Employee e on d.department_id = e.department_id

##Question 5
Select employes who are not asigned to any project

**Answer:**
Select e.name AS Employee
From Employee e
Left join Project p 
on e.department_id = p.department_id
where p.project_id IS NULL;

##Question 6
Select employees and the number of projects their department is working on.

**Answer:**
Select e.name AS Employee,count(distinct(p.project_id)) as No_of_projects
From Employee e
Left join Project p 
on e.department_id = p.department_id
group by e.emp_id,e.name

##Question 7
Select project names along with the department names they belong to.
  
**Answer:**
Select d.name as department,p.name as P_Name
From Project p
join Department d on p.department_id=d.department_id

##Question 8
Select the departments that have no employees

**Answer:**
Select d.name as department
From Department d
left join Employee e 
on d.department_id=e.department_id
where e.name is null

##Question 9
Select employee names who share the same department with 'John Doe'

**Answer:**
Select e1.name 
From Employee e1
join Employee e2
on e1.department_id=e2.department_id
where e2.name="John Doe"

##Question 10
Select the department name with the highest average salary.

**Answer:**
Select d.name as department,sum(e.salary) as highest_avg_sal
From Employee e
join Department d
on e.department_id=d.department_id
group by d.name
order by highest_avg_sal desc
limit 1

