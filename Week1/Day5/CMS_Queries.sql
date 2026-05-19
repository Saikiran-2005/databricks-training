# SQL College Management System – Practice Queries

=======================

--Q1. List all students along with their department names.
>> SELECT s.student_id, s.student_name, d.department_name, s.cgpa
   FROM Student s
   LEFT JOIN Department d ON s.department_id = d.department_id
   ORDER BY s.student_id;

--Q2. Display all staff members and their department names, including staff without departments.
>> SELECT st.staff_id, st.staff_name, st.designation, d.department_name, st.salary
   FROM Staff st
   LEFT JOIN Department d ON st.department_id = d.department_id
   ORDER BY st.staff_id;

--Q3. Find all departments that currently have no students assigned.
>> SELECT d.department_id, d.department_name, d.department_block_number
   FROM Department d
   LEFT JOIN Student s ON d.department_id = s.department_id
   WHERE s.student_id IS NULL
   GROUP BY d.department_id, d.department_name, d.department_block_number;

--Q4. Show students who do not have any marks recorded.
>> SELECT s.student_id, s.student_name, s.admission_year, d.department_name
   FROM Student s
   LEFT JOIN Department d ON s.department_id = d.department_id
   LEFT JOIN Mark m ON s.student_id = m.student_id
   WHERE m.student_id IS NULL
   ORDER BY s.student_id;

--Q5. Display subjects that are not assigned to any staff member.
>> SELECT subject_id, subject_name, subject_code, semester, credits
   FROM Subject
   WHERE staff_id IS NULL;

---

--Q6. Find the average CGPA department-wise.
>> SELECT d.department_id, d.department_name,
          ROUND(AVG(s.cgpa), 2) AS avg_cgpa, COUNT(s.student_id) AS student_count
   FROM Department d
   LEFT JOIN Student s ON d.department_id = s.department_id
   GROUP BY d.department_id, d.department_name
   ORDER BY avg_cgpa DESC NULLS LAST;

--Q7. Display departments where the average CGPA is greater than 8.0.
>> SELECT d.department_id, d.department_name, ROUND(AVG(s.cgpa), 2) AS avg_cgpa
   FROM Department d
   LEFT JOIN Student s ON d.department_id = s.department_id
   GROUP BY d.department_id, d.department_name
   HAVING AVG(s.cgpa) > 8.0
   ORDER BY avg_cgpa DESC;

--Q8. Find the total number of students in each department.
>> SELECT d.department_id, d.department_name, COUNT(s.student_id) AS student_count
   FROM Department d
   LEFT JOIN Student s ON d.department_id = s.department_id
   GROUP BY d.department_id, d.department_name
   ORDER BY student_count DESC;

--Q9. Display the highest and lowest marks scored in each subject.
>> SELECT subj.subject_id, subj.subject_name,
          MAX(m.marks) AS highest_marks, MIN(m.marks) AS lowest_marks,
          COUNT(m.marks) AS total_marks_recorded
   FROM Subject subj
   LEFT JOIN Mark m ON subj.subject_id = m.subject_id
   GROUP BY subj.subject_id, subj.subject_name
   ORDER BY subj.subject_id;

--Q10. Find students who scored more than 90 in any exam.
>> SELECT DISTINCT s.student_id, s.student_name, s.cgpa, MAX(m.marks) AS highest_marks
   FROM Student s
   JOIN Mark m ON s.student_id = m.student_id
   WHERE m.marks > 90
   GROUP BY s.student_id, s.student_name, s.cgpa
   ORDER BY highest_marks DESC;

---

--Q11. Display the names of students who belong to the Computer Science department.
>> SELECT s.student_id, s.student_name, s.gender, s.city, s.cgpa
   FROM Student s
   WHERE s.department_id = 1
   ORDER BY s.student_id;

--Q12. Find the number of subjects handled by each staff member.
>> SELECT st.staff_id, st.staff_name, st.designation, COUNT(subj.subject_id) AS subject_count
   FROM Staff st
   LEFT JOIN Subject subj ON st.staff_id = subj.staff_id
   GROUP BY st.staff_id, st.staff_name, st.designation
   ORDER BY subject_count DESC;

--Q13. Display students along with the total marks they obtained across all subjects.
>> SELECT s.student_id, s.student_name, d.department_name,
          SUM(m.marks) AS total_marks, COUNT(m.marks) AS exam_count,
          ROUND(AVG(m.marks), 2) AS avg_marks
   FROM Student s
   LEFT JOIN Department d ON s.department_id = d.department_id
   LEFT JOIN Mark m ON s.student_id = m.student_id
   GROUP BY s.student_id, s.student_name, d.department_name
   ORDER BY total_marks DESC NULLS LAST;

--Q14. Find departments with more than 2 staff members.
>> SELECT d.department_id, d.department_name, COUNT(st.staff_id) AS staff_count
   FROM Department d
   LEFT JOIN Staff st ON d.department_id = st.department_id
   GROUP BY d.department_id, d.department_name
   HAVING COUNT(st.staff_id) > 2
   ORDER BY staff_count DESC;

--Q15. Display students whose CGPA is above the average CGPA.
>> SELECT s.student_id, s.student_name, d.department_name, s.cgpa,
          ROUND((SELECT AVG(cgpa) FROM Student WHERE cgpa IS NOT NULL), 2) AS avg_cgpa
   FROM Student s
   LEFT JOIN Department d ON s.department_id = d.department_id
   WHERE s.cgpa > (SELECT AVG(cgpa) FROM Student WHERE cgpa IS NOT NULL)
   ORDER BY s.cgpa DESC;

---

--Q16. Find staff members earning more than the average salary of their department.
>> WITH dept_avg_salary AS (
       SELECT department_id, AVG(salary) AS dept_avg_salary
       FROM Staff
       WHERE salary IS NOT NULL
       GROUP BY department_id
   )
   SELECT st.staff_id, st.staff_name, d.department_name, st.salary,
          ROUND(das.dept_avg_salary, 2) AS dept_avg_salary
   FROM Staff st
   LEFT JOIN Department d ON st.department_id = d.department_id
   LEFT JOIN dept_avg_salary das ON st.department_id = das.department_id
   WHERE st.salary IS NOT NULL AND st.salary > das.dept_avg_salary
   ORDER BY st.salary DESC;

--Q17. Display the second highest salary among staff members.
>> SELECT staff_id, staff_name, designation, salary
   FROM Staff
   WHERE salary IS NOT NULL
   ORDER BY salary DESC
   LIMIT 1 OFFSET 1;

--Q18. Find students who scored the highest marks in each subject.
>> WITH subject_max_marks AS (
       SELECT subject_id, MAX(marks) AS max_marks
       FROM Mark
       GROUP BY subject_id
   )
   SELECT s.student_id, s.student_name, subj.subject_name, m.marks, m.exam_type
   FROM Mark m
   JOIN subject_max_marks smm ON m.subject_id = smm.subject_id AND m.marks = smm.max_marks
   JOIN Student s ON m.student_id = s.student_id
   JOIN Subject subj ON m.subject_id = subj.subject_id
   ORDER BY subj.subject_id;

---

--Q19. Display all students and their marks, including students without marks.
>> SELECT s.student_id, s.student_name, d.department_name,
          subj.subject_name, m.exam_type, m.marks, m.exam_date
   FROM Student s
   LEFT JOIN Department d ON s.department_id = d.department_id
   LEFT JOIN Mark m ON s.student_id = m.student_id
   LEFT JOIN Subject subj ON m.subject_id = subj.subject_id
   ORDER BY s.student_id, m.exam_date;

--Q20. Find subjects where the average marks are below 70.
>> SELECT subj.subject_id, subj.subject_name, subj.subject_code,
          ROUND(AVG(m.marks), 2) AS avg_marks, COUNT(m.marks) AS total_marks_recorded
   FROM Subject subj
   LEFT JOIN Mark m ON subj.subject_id = m.subject_id
   GROUP BY subj.subject_id, subj.subject_name, subj.subject_code
   HAVING AVG(m.marks) < 70
   ORDER BY avg_marks;

---

--Q21. Display students ordered by CGPA in descending order.
>> SELECT s.student_id, s.student_name, d.department_name, s.cgpa, s.admission_year
   FROM Student s
   LEFT JOIN Department d ON s.department_id = d.department_id
   WHERE s.cgpa IS NOT NULL
   ORDER BY s.cgpa DESC;

--Q22. Find the total salary expenditure department-wise.
>> SELECT d.department_id, d.department_name,
          ROUND(SUM(st.salary), 2) AS total_salary, COUNT(st.staff_id) AS staff_count
   FROM Department d
   LEFT JOIN Staff st ON d.department_id = st.department_id
   GROUP BY d.department_id, d.department_name
   ORDER BY total_salary DESC NULLS LAST;

--Q23. Display departments where the total salary exceeds 200000.
>> SELECT d.department_id, d.department_name,
          ROUND(SUM(st.salary), 2) AS total_salary, COUNT(st.staff_id) AS staff_count
   FROM Department d
   LEFT JOIN Staff st ON d.department_id = st.department_id
   GROUP BY d.department_id, d.department_name
   HAVING SUM(st.salary) > 200000
   ORDER BY total_salary DESC;

--Q24. Find students admitted after 2021 and having CGPA above 7.5.
>> SELECT s.student_id, s.student_name, d.department_name, s.admission_year, s.cgpa
   FROM Student s
   LEFT JOIN Department d ON s.department_id = d.department_id
   WHERE s.admission_year > 2021 AND s.cgpa > 7.5
   ORDER BY s.cgpa DESC;

--Q25. Display the number of students admitted each year.
>> SELECT admission_year, COUNT(student_id) AS student_count
   FROM Student
   WHERE admission_year IS NOT NULL
   GROUP BY admission_year
   ORDER BY admission_year DESC;
