--1.Display all students and the courses they are enrolled in. Include students who are not enrolled in any course.
Select s.student_name,c.course_name
From students s
left join enrollments e
on s.student_id = e.student_id
right join courses c
on c.course_id=e.course_id;

--2.Find all courses that currently have no students enrolled.
Select c.course_name,s.student_name
From students s
left join enrollments e
on s.student_id = e.student_id
right join courses c
on c.course_id=e.course_id
where s.student_name is null

--3.Display all instructors and the courses they teach, including instructors who are not assigned to any course.
Select i.instructor_name,c.course_name
From  instructors i
right join courses c
on c.instructor_id=i.instructor_id

--4.Find all courses that do not have an instructor assigned.
Select c.course_name,i.instructor_name
From  instructors i
right join courses c
on c.instructor_id=i.instructor_id
where i.instructor_name is null;

--5.Display all students and enrollment information using a RIGHT JOIN.
Select s.student_name,e.enrollment_id,e.student_id,e.course_id,e.enrollment_date
from enrollments e
right join students s
on s.student_id=e.student_id

--6.Find students who are not enrolled in any course.
Select s.student_name,e.enrollment_id
from enrollments e
right join students s
on s.student_id=e.student_id
where e.enrollment_id is null

--7.Use a FULL OUTER JOIN to display all students and enrollments, including unmatched rows from both tables.
Select s.student_name,e.enrollment_id,e.enrollment_date
from students s
full OUTER join enrollments e
on s.student_id=e.student_id
-->(OR)<--
Select s.student_name,e.enrollment_id,e.enrollment_date
from students s
left join enrollments e
on s.student_id=e.student_id
union 
Select s.student_name,e.enrollment_id,e.enrollment_date
from students s
right join enrollments e
on s.student_id=e.student_id;

--8.Find all courses that have never appeared in the enrollments table.
Select c.course_name 
from courses c
left join enrollments e
on c.course_id=e.course_id
where e.course_id is null

--9.Display all instructors and courses using a FULL OUTER JOIN and identify unmatched rows.
Select i.instructor_name,c.course_name
from courses c
full outer join instructors i
on c.instructor_id=i.instructor_id
where c.course_name is null or i.instructor_name is null
--(OR)
Select i.instructor_name,c.course_name
from courses c
right join instructors i
on c.instructor_id=i.instructor_id
where c.course_name is null 
union 
Select i.instructor_name,c.course_name
from courses c
left join instructors i
on c.instructor_id=i.instructor_id
where i.instructor_name is null;


--10.Create a report showing: student name, course name, and instructor name. Include rows even if course orinstructor information is missing.
SELECT s.student_name,
       c.course_name,
       i.instructor_name
FROM students s
LEFT JOIN enrollments e
ON s.student_id = e.student_id
LEFT JOIN courses c
ON e.course_id = c.course_id
LEFT JOIN instructors i
ON c.instructor_id = i.instructor_id;