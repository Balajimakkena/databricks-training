--1. Assign a row number to students ordered by CGPA.
Select ROW_NUMBER() over (order by cgpa desc) as row_num,
       student_name,
       cgpa
from Student;

--32. Rank students based on their CGPA.
Select Rank() over (order by cgpa desc) as std_rank,
       student_name,
       cgpa
from Student;


--33. Display dense rank of staff salaries.
Select DENSE_RANK() OVER(order by salary desc) as rank_n,
       staff_name,
       salary
from Staff;

--34. Find the top 3 highest scoring students using window functions.
with total_mks as( 
  				  Select student_id,
 	    				 sum(marks) as Total
 				  from Mark
   				  group by student_id),
	  rank_mks as (Select student_id,
	   					 Total,
     					 Dense_Rank() over(order by Total desc)as rank_n
					from total_mks)
Select * 
from rank_mks
where rank_n<=3;


--35. Display running total of marks for each student.
Select student_id,
        marks,
        sum(marks) over(partition by student_id
                        order by subject_id ) as running_total
from Mark;


--36. Find the average marks for each subject using window functions.
Select distinct(m.subject_id),
       s.subject_name,
       avg(m.marks) over(partition by m.subject_id)as avg_marks
from Mark m
join Subject s
on m.subject_id = s.subject_id;


--37. Display previous exam marks for each student using LAG().
Select m.student_id,
       s.student_name,
       LAG(m.marks) over()as previous_marks
from Mark m
join Student s
on m.student_id = s.student_id;

--38. Display next exam marks for each student using LEAD().
Select m.student_id,
       s.student_name,
       LEAD(m.marks) over()as next_exam_marks
from Mark m
join Student s
on m.student_id = s.student_id;


--39. Find the highest marks within each subject using MAX() OVER().
Select distinct(m.subject_id),
       s.subject_name,
        max(m.marks) over(partition by m.subject_id)as max_marks
from Mark m
join Subject s
on m.subject_id = s.subject_id;

--40. Display cumulative average marks ordered by exam date.
Select exam_date,
        marks,
        avg(marks) over(order by exam_date asc) as cumulative_avg
from Mark;


--41. Find the first student admitted in each department.
with date_adms as (Select student_name,
                        department_id,
                        ROW_NUMBER() over(partition by department_id
                                        order by admission_year)as ad_date
                from Student)
Select student_name,
        department_id
from date_adms
where ad_date=1;


--42. Display the latest hired staff member in each department.
with date_adms as (Select staff_name,
                        department_id,
                        ROW_NUMBER() over(partition by department_id
                                        order by hire_date)as ad_date
                from Staff)
Select staff_name,
        department_id
from date_adms
where ad_date=1;


--43. Divide students into 4 CGPA quartiles using NTILE().
Select student_name,
        cgpa,
        NTILE(4) over(order by cgpa desc) as CGPA_quartiles
from Student;


--44. Find percentage rank of students based on CGPA.
Select student_name,
        cgpa,
        percent_rank() over(order by cgpa ) as percentage_rank
from Student;


--45. Display cumulative distribution of salaries.
Select staff_name,
        salary,
        cume_dist() over(order by salary) as cumulative_distribution
from Staff
where salary is not null;


--46. Find subjects where a student's marks are above the subject average.
with subject_avg as (Select m.subject_id,
                                s.subject_name,
                                m.marks,
                                avg(m.marks) over(partition by m.subject_id) as sub_avg
                        from Mark m
                        join Subject s
                        on m.subject_id = s.subject_id)
Select *
from subject_avg
where marks>sub_avg;


--47. Find departments whose average staff salary is higher than overall average salary.
With averages as (Select s.staff_name,
                        d.department_name,
                        s.salary,
                        avg(s.salary) over(partition by s.department_id) as dept_avg,
                        avg(s.salary) over() as overall_avg
                from Staff s 
                join Department d 
                on s.department_id=d.department_id)
Select distinct(department_name)
from averages
where dept_avg > overall_avg;


--48. Display students who scored above department average marks.
with student_total AS (
    Select s.student_id,
           s.student_name,
           s.department_id,
           SUM(m.marks) as total_marks
    from Student s
    join Mark m
    on s.student_id = m.student_id
    group by s.student_id,
             s.student_name,
             s.department_id
),

dept_avg as (
    Select student_id,
           student_name,
           department_id,
           total_marks,
           avg(total_marks) over(
               partition by  department_id
           ) AS dept_average
    from student_total
)

Select student_name,
       total_marks,
       dept_average
from dept_avg
where total_marks > dept_average;


--49. Find the nth highest mark (3rd highest) using DENSE_RANK().
with student_total AS (
    Select student_id,
           SUM(marks) AS total_marks
    from Mark
    group by  student_id
),

student_rank AS (
    Select student_id,
           total_marks,
           DENSE_RANK() OVER(
                order by total_marks DESC
           ) AS std_rank
    from student_total
)

Select student_id,
       total_marks
from student_rank
where std_rank = 3;


--50. Generate a report showing student name, department, subject, exam type, marks, department average, and overall rank.
with student_report AS (
    Select s.student_name,
           d.department_name,
           sub.subject_name,
           m.exam_type,
           m.marks,

           avg(m.marks) OVER(
               partition by d.department_id
           ) AS department_average,

           DENSE_RANK() OVER(
               order by m.marks DESC
           ) AS overall_rank

    from Student s
    join Department d
    on s.department_id = d.department_id

    join Mark m
    on s.student_id = m.student_id

    join Subject sub
    on m.subject_id = sub.subject_id
)

Select *
from student_report;

--