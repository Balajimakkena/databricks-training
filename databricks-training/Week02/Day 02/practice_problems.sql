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