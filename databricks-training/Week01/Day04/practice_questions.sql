--01.List all students along with their department names.
Select s.student_name,
       d.department_name
from Student s
join Department d
on s.department_id=d.department_id;

--2.Display all staff members and their department names, including staff without departments.
Select s.staff_id,
       s.staff_name,
       d.department_name
from Staff s
left join Department d
on s.department_id=d.department_id;

--3.Find all departments that currently have no students assigned.
Select s.student_name,
       d.department_name,
       d.department_id
from Department d
left join Student s
on s.department_id=d.department_id;


--4.Show students who do not have any marks recorded.
Select s.student_id,
       s.student_name,
       m.marks
from Mark m
join Student s
on m.student_id=s.student_id
where marks is null;


--5.Display subjects that are not assigned to any staff member.
Select s.subject_id,
       s.subject_name,
       S.subject_id
from Subject s
left join Staff S
on s.staff_id=S.staff_id
where s.staff_id is null;

--6.Find the average CGPA department-wise.
Select d.department_id,
       d.department_name,
       avg(s.cgpa) as cgpa
from Student s
join Department d
on d.department_id=s.department_id
group by s.department_id;


--7.Display departments where the average CGPA is greater than 8.0.
Select d.department_id,
       d.department_name,
       avg(s.cgpa) as cgpa
from Student s
join Department d
on d.department_id=s.department_id
group by s.department_id
having cgpa > 8;


--8.Find the total number of students in each department.
Select d.department_id,
       d.department_name,
       count(student_id) as No_of_Students
from Student s
join Department d
on d.department_id=s.department_id
group by s.department_id;


--9.Display the highest and lowest marks scored in each subject.
Select s.subject_id,
       s.subject_name,
       min(m.marks) as lowest,
       max(m.marks) as highest
from Subject s
join Mark m
on s.subject_id = m.subject_id
group by m.subject_id;


--10.Find students who scored more than 90 in any exam.
Select s.student_id,
       s.student_name,
       m.marks
from Student s
join Mark m 
on s.student_id = m.student_id
where m.marks > 90;

--11.Display the names of students who belong to the Computer Science department.
Select s.student_name,
       d.department_name
from Student s
join Department d 
on s.department_id = d.department_id
where d.department_name = 'Computer Science';


--12.Find the number of subjects handled by each staff member.
Select s.staff_id,
       s.staff_name,
       count(S.subject_id) as No_of_Subjects
from Staff s 
join Subject S 
on s.staff_id = S.staff_id
group by S.staff_id;

--13.Display students along with the total marks they obtained across all subjects.
Select s.student_id,
       s.student_name,
       sum(m.marks) as total
from Student s 
join Mark m 
on s.student_id = m.student_id
group by m.student_id;


--14.Find departments with more than 2 staff members.
Select d.department_id,
       d.department_name,
       count(s.staff_id) as No_of_Staff
from Department d 
join Staff s 
on d.department_id = s.department_id
group by s.department_id
having No_of_Staff > 2;

--15.Display students whose CGPA is above the average CGPA.
Select student_id,
       student_name,
       cgpa
from Student
where cgpa > (Select avg(cgpa)
                from Student);


--16.Find staff members earning more than the average salary of their department.
Select s.staff_name,
       s.salary
from Staff s
where s.salary > (Select avg(S.salary)
                   from Staff S 
                   where s.department_id = S.department_id);


--17.Display the second highest salary among staff members.
Select staff_name,
       salary
from Staff
order by salary desc
limit 1 offset 1;


--18.Find students who scored the highest marks in each subject.
Select m.student_id,
       m.marks as highest_marks
from Mark m
where marks>=(Select max(marks)
              from Mark 
              where subject_id = m.subject_id );


--19.Display all students and their marks, including students without marks.
Select s.student_id,
       m.subject_id,
       s.student_name,m.marks
from Student s 
left join Mark m 
on s.student_id = m.student_id;


--20.Find subjects where the average marks are below 70.
Select distinct(subject_id),
        marks
from Mark m
where 70>(Select avg(marks)
          from Mark 
          where subject_id = m.subject_id);


--21.Display students ordered by CGPA in descending order.
Select student_id,
       cgpa
from Student
order by cgpa desc;


--22.Find the total salary expenditure department-wise.
Select d.department_name,
       sum(s.salary) as expenditure
from Department d 
left join Staff s 
on d.department_id = s.department_id
group by d.department_id
order by expenditure desc;


--23.Display departments where the total salary exceeds 200000.
Select d.department_name,
       sum(s.salary) as expenditure
from Department d 
left join Staff s 
on d.department_id = s.department_id
group by d.department_id
having expenditure > 200000;
 

 --24.Find students admitted after 2021 and having CGPA above 7.5.
 Select student_name,
        cgpa
 from Student
 where admission_year>2021 and cgpa >= 7.5;


 --25.Display the number of students admitted each year.
 Select admission_year,
        COUNT(*)
 from Student 
 group by admission_year
 order by admission_year asc;

--26.Find the city with the maximum number of students.
Select city, 
       count(*) as count
from Student 
group by city
order by count desc
limit 1;

--27. Display all departments and their staff count, including empty departments.
Select d.department_id,
       d.department_name,
       count(s.staff_id) as count
from Department d 
left join Staff s 
on d.department_id = s.department_id
group by d.department_id;


--28. Find students who have failed in at least one subject (marks < 50).
Select distinct(student_id)
from Mark
where marks < 50;

--29. Display staff hired before 2018.
Select staff_name
from Staff
where year(hire_date) < 2018;


--30. Find departments where no staff salary is recorded as NULL.
Select d.department_name
from Department d 
join Staff s 
on d.department_id = s.department_id
group by s.department_id
having count(*) = count(s.salary);

