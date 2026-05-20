--QUESTION 1 – Employee Login Discipline & Performance Classification

---Table Structure

CREATE TABLE employee_login (

emp_id INT,

emp_name VARCHAR(50),

login_time DATETIME,

logout_time DATETIME

);

--Insert Data

INSERT INTO employee_login VALUES

(1,'Karthik','2025-01-15 09:05:00','2025-01-15 18:10:00'),

(2,'Veena','2025-01-14 10:30:00','2025-01-14 16:00:00'),

(3,'Ravi','2025-01-13 09:00:00','2025-01-13 20:00:00'),

(4,'Anil','2025-01-12 11:00:00','2025-01-12 14:00:00'),

(5,'Suresh','2025-01-11 09:15:00','2025-01-11 17:00:00');

Question

For each employee:

--1· Convert emp_name to proper case

--2· Identify whether login date is Weekday or Weekend

--3· Calculate total working hours (logout – login)

--4· Round working hours to 2 decimals

--5.
/*
· Use CASE:

o Good Performer if weekday AND working hours ≥ 8

o Bad Performer if weekday AND working hours < 6

o Weekend Login otherwise
*/
-- QUESTION 1 – Employee Login Discipline & Performance Classification

Select 
       emp_id,
       concat(
              upper(left(emp_name,1)),
              lower(substring(emp_name,2))
             ) as proper_name,

       login_time,
       logout_time,

       CASE
            WHEN dayname(login_time) in ('Saturday','Sunday')
            THEN 'Weekend'
            ELSE 'Weekday'
       end as day_type,

       Round(
             timestampdiff(minute, login_time, logout_time) / 60,
             2
            ) as working_hours,

       CASE
            WHEN dayname(login_time) not in ('Saturday','Sunday')
                 AND timestampdiff(minute, login_time, logout_time) / 60 >= 8
            THEN 'Good Performer'

            WHEN dayname(login_time) not in ('Saturday','Sunday')
                 AND timestampdiff(minute, login_time, logout_time) / 60 < 6
            THEN 'Bad Performer'

            ELSE 'Weekend Login'
       end as performance_status
from employee_login;




--QUESTION 2 – Past 7 Days Attendance & Productivity Check

--Table Structure

CREATE TABLE attendance_log (

emp_id INT,

emp_name VARCHAR(50),

login_date DATE,

login_time TIME,

logout_time TIME

);

--Insert Data

INSERT INTO attendance_log VALUES

(1,'Karthik','2025-01-14','09:00:00','18:00:00'),

(2,'Karthik','2025-01-13','09:15:00','17:30:00'),

(3,'Veena','2025-01-12','10:00:00','15:00:00'),

(4,'Ravi','2025-01-10','09:00:00','19:00:00'),

(5,'Anil','2025-01-08','11:00:00','14:00:00');

Question

For each record:

--1· Uppercase employee name

--2· Check if login_date falls within last 7 days from today

--3· Identify Weekday / Weekend

--4· Calculate working hours using TIMEDIFF

---5.
/*
· Use CASE:

o Active & Productive if last 7 days AND hours ≥ 8

o Active but Low Hours if last 7 days AND hours < 8

o Absent from Last 7 Days
*/

-- QUESTION 2 – Past 7 Days Attendance & Productivity Check

Select
       emp_id,
       upper(emp_name) as employee_name,
       login_date,
       login_time,
       logout_time,
       CASE
            WHEN login_date >= curdate() - interval 7 day
            THEN 'Within Last 7 Days'
            ELSE 'Older Record'
       end as last_7_days_status,
       CASE
            WHEN dayname(login_date) in ('Saturday','Sunday')
            THEN 'Weekend'
            ELSE 'Weekday'
       end as day_type,
       Round(
             time_to_sec(
                 TIMEDIFF(logout_time, login_time)
             ) / 3600,
             2
            ) as working_hours,
       CASE
            WHEN login_date >= curdate() - interval 7 day
                 and time_to_sec(timediff(logout_time, login_time)) / 3600 >= 8
            THEN 'Active & Productive'

            WHEN login_date >= curdate() - interval 7 day
                 and time_to_sec(timediff(logout_time, login_time)) / 3600 < 8
            THEN 'Active but Low Hours'
            ELSE 'Absent from Last 7 Days'
       end as productivity_status
from attendance_log;



QUESTION 3 – Weekend Work Abuse Detection

Table Structure

CREATE TABLE weekend_monitor (

emp_id INT,

emp_name VARCHAR(50),

work_date DATE,

login_time TIME,

logout_time TIME

);

Insert Data

INSERT INTO weekend_monitor VALUES

(1,'Ravi','2025-01-11','09:00:00','21:00:00'),

(2,'Veena','2025-01-12','10:00:00','13:00:00'),

(3,'Karthik','2025-01-10','09:00:00','18:00:00'),

(4,'Anil','2025-01-09','11:00:00','14:00:00');

Question

For each employee:

--1· Extract day name from work_date

--2· Lowercase employee name

--3· Calculate working hours

--4· Apply CEIL on hours

--5.
/*
· Use CASE:

o Weekend Overtime if Saturday/Sunday AND hours ≥ 8

o Suspicious Login if weekend AND hours < 4

o Normal Working Day
*/

Select
       emp_id,
       lower(emp_name) as employee_name,
       work_date,
       dayname(work_date) AS day_name,
       ceil(
            time_to_sec(
                timediff(logout_time, login_time)
            ) / 3600
           ) as working_hours,
       CASE
            WHEN day(work_date) in ('Saturday','Sunday')
                 AND time_to_sec(timediff(logout_time, login_time)) / 3600 >= 8
            THEN 'Weekend Overtime'

            WHEN dayname(work_date) in ('Saturday','Sunday')
                 AND time_to_sec(timediff(logout_time, login_time)) / 3600 < 4
            THEN 'Suspicious Login'
            ELSE 'Normal Working Day'
       end as work_status
from weekend_monitor;



--QUESTION 4 – Login Time Deviation & Discipline Score

Table Structure

CREATE TABLE login_discipline (

emp_id INT,

emp_name VARCHAR(50),

login_datetime DATETIME,

logout_datetime DATETIME

);

Insert Data

INSERT INTO login_discipline VALUES

(1,'Karthik','2025-01-15 08:55:00','2025-01-15 18:10:00'),

(2,'Veena','2025-01-15 10:45:00','2025-01-15 16:00:00'),

(3,'Ravi','2025-01-15 09:00:00','2025-01-15 20:30:00'),

(4,'Anil','2025-01-15 11:30:00','2025-01-15 14:00:00');

Question

For each employee:

--1· Extract login hour

--2· Calculate total working hours

--3· Truncate working hours to 1 decimal

--4· Get weekday name

--5
/*
· Use CASE:

o Disciplined if weekday AND login before 9 AND hours ≥ 8

o Late Comer if weekday AND login after 10

o Poor Discipline otherwise
*/

Select
       emp_id,
       emp_name,
       hour(login_datetime) as login_hour,
       Truncate(
                 timestampdiff(minute,
                               login_datetime,
                               logout_datetime
                              ) / 60,
                 1
                ) as working_hours,

       dayname(login_datetime) as weekday_name,

       CASE
            WHEN dayname(login_datetime) not in ('Saturday','Sunday')
                 and hour(login_datetime) < 9
                 and timestampdiff(minute,
                                   login_datetime,
                                   logout_datetime
                                  ) / 60 >= 8
            THEN 'Disciplined'

            WHEN dayname(login_datetime) not in ('Saturday','Sunday')
                 and hour(login_datetime) > 10
            THEN 'Late Comer'

            ELSE 'Poor Discipline'
       END AS discipline_status
from login_discipline;



--QUESTION 5 – Absenteeism vs Performance Correlation

--Table Structure

CREATE TABLE performance_tracker (

emp_id INT,

emp_name VARCHAR(50),

work_date DATE,

login_time TIME,

logout_time TIME

);

--Insert Data

INSERT INTO performance_tracker VALUES

(1,'Karthik','2025-01-09','09:00:00','18:00:00'),

(2,'Karthik','2025-01-10','09:10:00','17:50:00'),

(3,'Veena','2025-01-05','10:00:00','15:00:00'),

(4,'Ravi','2025-01-14','09:00:00','19:00:00'),

(5,'Anil','2025-01-03','11:00:00','14:00:00');

Question

For each record:

--1· Identify whether work_date is within last 7 days

--2· Identify weekday or weekend

--3· Calculate total hours worked

--4· Apply FLOOR to hours

--5
/*
· Use CASE:

o Consistent Performer if last 7 days AND weekday AND hours ≥ 8

o Irregular Performer if hours < 6

o Absent / Old Record
*/


Select
       emp_id,
       emp_name,
       work_date,
       CASE
            WHEN work_date >= curdate() - interval 7 day
            THEN 'Within Last 7 Days'
            ELSE 'Old Record'
       END AS last_7_days_status,
       CASE
            WHEN dayname(work_date) in ('Saturday','Sunday')
            THEN 'Weekend'
            ELSE 'Weekday'
       END AS day_type,
       flo0r(
             time_to_sec(
                 timediff(logout_time, login_time)
             ) / 3600
            ) as total_hours,
       CASE
            WHEN work_date >= curdate() - interval 7 day
                 and DAYNAME(work_date) not in ('Saturday','Sunday')
                 and time_to_sec(timediff(logout_time, login_time)) / 3600 >= 8
            THEN 'Consistent Performer'
            WHEN time_to_sec(timediff(logout_time, login_time)) / 3600 < 6
            THEN 'Irregular Performer'
            ELSE 'Absent / Old Record'
       end as performance_status
from performance_tracker;