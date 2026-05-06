# SQL Practiced Queries
  
=======================

## Basic Queries

--Q1. Select all columns from the Employee table
>> SELECT * FROM Employee;

--Q2. Select only the name and salary columns from the Employee table
>> SELECT name, salary FROM Employee;

--Q3. Select employees who are older than 30
>> SELECT * FROM Employee WHERE age > 30;

--Q4. Select the names of all departments
>> SELECT name FROM Department;

--Q5. Select employees who work in the IT department
>> SELECT e.name
   FROM Employee e
   JOIN Department d ON e.department_id = d.department_id
   WHERE d.name = 'IT';

---

## String Matching Queries

--Q6. Select employees whose names start with 'J'
>> SELECT name FROM Employee WHERE name LIKE 'J%';

--Q7. Select employees whose names end with 'e'
>> SELECT name FROM Employee WHERE name LIKE '%e';

--Q8. Select employees whose names contain 'a'
>> SELECT name FROM Employee WHERE name LIKE '%a%';

--Q9. Select employees whose names are exactly 9 characters long
>> SELECT name FROM Employee WHERE LENGTH(name) = 9;

--Q10. Select employees whose names have 'o' as the second character
>> SELECT name FROM Employee WHERE name LIKE '_o%';

---

## Date Queries

--Q11. Select employees hired in the year 2020
>> SELECT * FROM Employee WHERE YEAR(hire_date) = 2020;

--Q12. Select employees hired in January of any year
>> SELECT * FROM Employee WHERE MONTH(hire_date) = 1;

--Q13. Select employees hired before 2019
>> SELECT * FROM Employee WHERE hire_date < '2019-01-01';

--Q14. Select employees hired on or after March 1, 2021
>> SELECT * FROM Employee WHERE hire_date >= '2021-03-01';

--Q15. Select employees hired in the last 2 years
>> SELECT * FROM Employee
   WHERE hire_date >= CURDATE() - INTERVAL 2 YEAR;

---

## Aggregate Queries

--Q16. Select the total salary of all employees
>> SELECT SUM(salary) AS total_salary FROM Employee;

--Q17. Select the average salary of employees
>> SELECT AVG(salary) AS avg_salary FROM Employee;

--Q18. Select the minimum salary in the Employee table
>> SELECT MIN(salary) AS min_salary FROM Employee;

--Q19. Select the number of employees in each department
>> SELECT department_id, COUNT(*) AS NoOfEmp
   FROM Employee
   GROUP BY department_id;

--Q20. Select the average salary of employees in each department
>> SELECT department_id, AVG(salary) AS avg_salary
   FROM Employee
   GROUP BY department_id;

---

## Group By Queries

--Q21. Select the total salary for each department
>> SELECT department_id, SUM(salary) AS total_salary
   FROM Employee
   GROUP BY department_id;

--Q22. Select the average age of employees in each department
>> SELECT department_id, AVG(age) AS avg_age
   FROM Employee
   GROUP BY department_id;

--Q23. Select the number of employees hired in each year
>> SELECT YEAR(hire_date) AS hire_year, COUNT(*) AS NoOfEmp
   FROM Employee
   GROUP BY YEAR(hire_date);

--Q24. Select the highest salary in each department
>> SELECT department_id, MAX(salary) AS highest_salary
   FROM Employee
   GROUP BY department_id;

--Q25. Select the department with the highest average salary
>> SELECT department_id, AVG(salary) AS avg_salary
   FROM Employee
   GROUP BY department_id
   ORDER BY AVG(salary) DESC
   LIMIT 1;

---

## Having Queries

--Q26. Select departments with more than 2 employees
>> SELECT department_id, COUNT(*) AS NoOfEmp
   FROM Employee
   GROUP BY department_id
   HAVING COUNT(*) > 2;

--Q27. Select departments with an average salary greater than 55000
>> SELECT department_id, AVG(salary) AS avg_salary
   FROM Employee
   GROUP BY department_id
   HAVING AVG(salary) > 55000;

--Q28. Select years with more than 1 employee hired
>> SELECT YEAR(hire_date) AS hire_year, COUNT(*) AS total
   FROM Employee
   GROUP BY YEAR(hire_date)
   HAVING COUNT(*) > 1;

--Q29. Select departments with a total salary expense less than 100000
>> SELECT department_id, SUM(salary) AS total_salary
   FROM Employee
   GROUP BY department_id
   HAVING SUM(salary) < 100000;

--Q30. Select departments with the maximum salary above 75000
>> SELECT department_id, MAX(salary) AS above_75000
   FROM Employee
   GROUP BY department_id
   HAVING MAX(salary) > 75000;

---

## Order By Queries

--Q31. Select all employees ordered by their salary in ascending order
>> SELECT * FROM Employee ORDER BY salary ASC;

--Q32. Select all employees ordered by their age in descending order
>> SELECT * FROM Employee ORDER BY age DESC;

--Q33. Select all employees ordered by their hire date in ascending order
>> SELECT * FROM Employee ORDER BY hire_date ASC;

--Q34. Select employees ordered by their department and then by their salary
>> SELECT * FROM Employee ORDER BY department_id, salary;

--Q35. Select departments ordered by the total salary of their employees
>> SELECT department_id, SUM(salary) AS total_salary
   FROM Employee
   GROUP BY department_id
   ORDER BY total_salary DESC;

---

## Join Queries

--Q36. Select employee names along with their department names
>> SELECT e.name, d.name AS department_name
   FROM Employee e
   JOIN Department d ON e.department_id = d.department_id;

--Q37. Select project names along with the department names they belong to
>> SELECT p.name, d.name AS department_name
   FROM Department d
   JOIN Project p ON d.department_id = p.department_id;

--Q38. Select employee names and their corresponding project names
>> SELECT e.name AS employee, p.name AS project
   FROM Employee e
   JOIN Project p ON e.department_id = p.department_id;

--Q39. Select all employees and their departments, including those without a department
>> SELECT e.name, d.name AS department
   FROM Employee e
   LEFT JOIN Department d ON e.department_id = d.department_id;

--Q40. Select all departments and their employees, including departments without employees
>> SELECT d.name, e.name AS employee
   FROM Department d
   LEFT JOIN Employee e ON d.department_id = e.department_id;

--Q41. Select employees who are not assigned to any project
>> SELECT e.name
   FROM Employee e
   LEFT JOIN Project p ON e.department_id = p.department_id
   WHERE p.project_id IS NULL;

--Q42. Select employees and the number of projects their department is working on
>> SELECT e.name, COUNT(p.project_id) AS total_projects
   FROM Employee e
   LEFT JOIN Project p ON e.department_id = p.department_id
   GROUP BY e.name;

--Q43. Select the departments that have no employees
>> SELECT d.name
   FROM Department d
   LEFT JOIN Employee e ON d.department_id = e.department_id
   WHERE e.emp_id IS NULL;

--Q44. Select employee names who share the same department with 'John Doe'
>> SELECT name
   FROM Employee
   WHERE department_id = (
       SELECT department_id
       FROM Employee
       WHERE name = 'John Doe'
   );

--Q45. Select the department name with the highest average salary
>> SELECT d.name, AVG(e.salary) AS avg_salary
   FROM Department d
   JOIN Employee e ON d.department_id = e.department_id
   GROUP BY d.name
   ORDER BY avg_salary DESC
   LIMIT 1;

---

## Nested and Correlated Queries

--Q46. Select the employee with the highest salary
>> SELECT name, salary
   FROM Employee
   WHERE salary = (
       SELECT MAX(salary)
       FROM Employee
   );

--Q47. Select employees whose salary is above the average salary
>> SELECT name, salary
   FROM Employee
   WHERE salary > (
       SELECT AVG(salary)
       FROM Employee
   );

--Q48. Select the second highest salary from the Employee table
>> SELECT MAX(salary) AS second_highest
   FROM Employee
   WHERE salary < (
       SELECT MAX(salary)
       FROM Employee
   );

--Q49. Select the department with the most employees
>> SELECT d.name, COUNT(e.emp_id) AS total_employees
   FROM Department d
   JOIN Employee e ON d.department_id = e.department_id
   GROUP BY d.name
   ORDER BY total_employees DESC
   LIMIT 1;

--Q50. Select employees who earn more than the average salary of their department
>> SELECT e.name, e.salary, e.department_id
   FROM Employee e
   WHERE e.salary > (
       SELECT AVG(salary)
       FROM Employee
       WHERE department_id = e.department_id
   );

--Q51. Select the nth highest salary (for example, 3rd highest)
>> SELECT DISTINCT salary
   FROM Employee
   ORDER BY salary DESC
   LIMIT 1 OFFSET 2;

--Q52. Select employees who are older than all employees in the HR department
>> SELECT name, age
   FROM Employee
   WHERE age > ALL (
       SELECT age
       FROM Employee
       WHERE department_id = (
           SELECT department_id
           FROM Department
           WHERE name = 'HR'
       )
   );

--Q53. Select departments where the average salary is greater than 55000
>> SELECT d.name, AVG(e.salary) AS avg_salary
   FROM Department d
   JOIN Employee e ON d.department_id = e.department_id
   GROUP BY d.name
   HAVING AVG(e.salary) > 55000;

--Q54. Select employees who work in a department with at least 2 projects
>> SELECT name
   FROM Employee
   WHERE department_id IN (
       SELECT department_id
       FROM Project
       GROUP BY department_id
       HAVING COUNT(*) >= 2
   );

--Q55. Select employees who were hired on the same date as 'Jane Smith'
>> SELECT name, hire_date
   FROM Employee
   WHERE hire_date = (
       SELECT hire_date
       FROM Employee
       WHERE name = 'Jane Smith'
   );

---

## Combined Moderate Difficulty Queries

--Q56. Select the total salary of employees hired in the year 2020
>> SELECT SUM(salary) AS total_salary
   FROM Employee
   WHERE YEAR(hire_date) = 2020;

Q57. Select the average salary of employees in each department, ordered by average salary descending
>> SELECT department_id, AVG(salary) AS avg_salary
   FROM Employee
   GROUP BY department_id
   ORDER BY avg_salary DESC;

--Q58. Select departments with more than 1 employee and an average salary greater than 55000
>> SELECT department_id, COUNT(*) AS total_emp, AVG(salary) AS avg_salary
   FROM Employee
   GROUP BY department_id
   HAVING COUNT(*) > 1 AND AVG(salary) > 55000;

--Q59. Select employees hired in the last 2 years, ordered by their hire date
>> SELECT name, hire_date
   FROM Employee
   WHERE hire_date >= CURDATE() - INTERVAL 2 YEAR
   ORDER BY hire_date;

--Q60. Select the total number of employees and the average salary for each department
>> SELECT department_id,
          COUNT(*) AS total_employees,
          AVG(salary) AS avg_salary
   FROM Employee
   GROUP BY department_id;

--Q61. Select the name and salary of employees whose salary is above the average salary of the company
>> SELECT name, salary
   FROM Employee
   WHERE salary > (
       SELECT AVG(salary)
       FROM Employee
   );

--Q62. Select the names of employees who are hired on the same date as the oldest employee
>> SELECT name, hire_date
   FROM Employee
   WHERE hire_date = (
       SELECT MIN(hire_date)
       FROM Employee
   );

--Q63. Select department names along with the total number of projects, ordered by number of projects
>> SELECT d.name, COUNT(p.project_id) AS total_projects
   FROM Department d
   LEFT JOIN Project p ON d.department_id = p.department_id
   GROUP BY d.name
   ORDER BY total_projects DESC;

--Q64. Select the employee name with the highest salary in each department
>> SELECT e.name, e.salary, e.department_id
   FROM Employee e
   WHERE e.salary = (
       SELECT MAX(salary)
       FROM Employee
       WHERE department_id = e.department_id
   );

--Q65. Select the names and salaries of employees who are older than the average age of their department
>> SELECT e.name, e.age, e.department_id
   FROM Employee e
   WHERE e.age > (
       SELECT AVG(age)
       FROM Employee
       WHERE department_id = e.department_id
   );

---

Database : MySQL
Tables   : Employee, Department, Project
