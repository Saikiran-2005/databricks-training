
# SQL Practice Queries - Output

---

## Database Schema

```sql
-- Create Department table
CREATE TABLE Department (
    department_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- Create Employee table
CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT,
    salary DECIMAL(10, 2),
    department_id INT,
    hire_date DATE,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

-- Create Project table
CREATE TABLE Project (
    project_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

-- Insert data into Department table
INSERT INTO Department (department_id, name) VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Marketing');

-- Insert data into Employee table
INSERT INTO Employee (emp_id, name, age, salary, department_id, hire_date) VALUES
(1, 'John Doe', 28, 50000.00, 1, '2020-01-15'),
(2, 'Jane Smith', 34, 60000.00, 2, '2019-07-23'),
(3, 'Bob Brown', 45, 80000.00, 1, '2018-02-12'),
(4, 'Alice Blue', 25, 45000.00, 3, '2021-03-22'),
(5, 'Charlie P.', 29, 50000.00, 2, '2019-12-01'),
(6, 'David Green', 38, 70000.00, 4, '2022-05-18'),
(7, 'Eve Black', 40, 55000.00, 3, '2021-08-30');

-- Insert data into Project table
INSERT INTO Project (project_id, name, department_id) VALUES
(1, 'Project Alpha', 1),
(2, 'Project Beta', 2),
(3, 'Project Gamma', 1),
(4, 'Project Delta', 3),
(5, 'Project Epsilon', 4),
(6, 'Project Zeta', 4),
(7, 'Project Eta', 3);

-- Insert additional data into Employee table to test edge cases for joins and nested queries
INSERT INTO Employee (emp_id, name, age, salary, department_id, hire_date) VALUES
(8, 'Frank White', 32, 48000.00, NULL, '2021-07-10'),  -- Employee without a department
(9, 'Grace Kelly', 27, 65000.00, 1, '2018-11-13'),
(10, 'Hannah Lee', 30, 53000.00, 4, '2020-02-25');

-- Insert additional data into Project table to test edge cases for joins
INSERT INTO Project (project_id, name, department_id) VALUES
(8, 'Project Theta', 1),
(9, 'Project Iota', NULL);  -- Project without a department
```

---

## Table of Contents
- [Basic Queries](#basic-queries)
- [String Matching Queries](#string-matching-queries)
- [Date Queries](#date-queries)
- [Aggregate Queries](#aggregate-queries)
- [Group By Queries](#group-by-queries)
- [Having Queries](#having-queries)
- [Order By Queries](#order-by-queries)
- [Join Queries](#join-queries)
- [Nested and Correlated Queries](#nested-and-correlated-queries)
- [Combined Moderate Difficulty Queries](#combined-moderate-difficulty-queries)

---

## Basic Queries

Q1. Select all columns from the Employee table
```sql
SELECT * FROM Employee;
```
| emp_id | name        | age | salary   | department_id | hire_date  |
|--------|-------------|-----|----------|---------------|------------|
| 1      | John Doe    | 28  | 50000.00 | 1             | 2020-01-15 |
| 2      | Jane Smith  | 34  | 60000.00 | 2             | 2019-07-23 |
| 3      | Bob Brown   | 45  | 80000.00 | 1             | 2018-02-12 |
| 4      | Alice Blue  | 25  | 45000.00 | 3             | 2021-03-22 |
| 5      | Charlie P.  | 29  | 50000.00 | 2             | 2019-12-01 |
| 6      | David Green | 38  | 70000.00 | 4             | 2022-05-18 |
| 7      | Eve Black   | 40  | 55000.00 | 3             | 2021-08-30 |
| 8      | Frank White | 32  | 48000.00 | NULL          | 2021-07-10 |
| 9      | Grace Kelly | 27  | 65000.00 | 1             | 2018-11-13 |
| 10     | Hannah Lee  | 30  | 53000.00 | 4             | 2020-02-25 |

---

Q2. Select only the name and salary columns from the Employee table
```sql
SELECT name, salary FROM Employee;
```
| name        | salary   |
|-------------|----------|
| John Doe    | 50000.00 |
| Jane Smith  | 60000.00 |
| Bob Brown   | 80000.00 |
| Alice Blue  | 45000.00 |
| Charlie P.  | 50000.00 |
| David Green | 70000.00 |
| Eve Black   | 55000.00 |
| Frank White | 48000.00 |
| Grace Kelly | 65000.00 |
| Hannah Lee  | 53000.00 |

---

Q3. Select employees who are older than 30
```sql
SELECT * FROM Employee WHERE age > 30;
```
| emp_id | name        | age | salary   | department_id | hire_date  |
|--------|-------------|-----|----------|---------------|------------|
| 2      | Jane Smith  | 34  | 60000.00 | 2             | 2019-07-23 |
| 3      | Bob Brown   | 45  | 80000.00 | 1             | 2018-02-12 |
| 6      | David Green | 38  | 70000.00 | 4             | 2022-05-18 |
| 7      | Eve Black   | 40  | 55000.00 | 3             | 2021-08-30 |
| 8      | Frank White | 32  | 48000.00 | NULL          | 2021-07-10 |

---

Q4. Select the names of all departments
```sql
SELECT name FROM Department;
```
| name      |
|-----------|
| IT        |
| HR        |
| Finance   |
| Marketing |

---

Q5. Select employees who work in the IT department
```sql
SELECT e.name
FROM Employee e
JOIN Department d ON e.department_id = d.department_id
WHERE d.name = 'IT';
```
| name        |
|-------------|
| John Doe    |
| Bob Brown   |
| Grace Kelly |

---

## String Matching Queries

Q6. Select employees whose names start with 'J'
```sql
SELECT name FROM Employee WHERE name LIKE 'J%';
```
| name       |
|------------|
| John Doe   |
| Jane Smith |

---

Q7. Select employees whose names end with 'e'
```sql
SELECT name FROM Employee WHERE name LIKE '%e';
```
| name        |
|-------------|
| John Doe    |
| Alice Blue  |
| Frank White |
| Hannah Lee  |

---

Q8. Select employees whose names contain 'a'
```sql
SELECT name FROM Employee WHERE name LIKE '%a%';
```
| name        |
|-------------|
| Jane Smith  |
| Alice Blue  |
| Charlie P.  |
| David Green |
| Eve Black   |
| Frank White |
| Grace Kelly |
| Hannah Lee  |

---

Q9. Select employees whose names are exactly 9 characters long
```sql
SELECT name FROM Employee WHERE LENGTH(name) = 9;
```
| name      |
|-----------|
| Bob Brown |
| Eve Black |

---

Q10. Select employees whose names have 'o' as the second character
```sql
SELECT name FROM Employee WHERE name LIKE '_o%';
```
| name      |
|-----------|
| John Doe  |
| Bob Brown |

---

## Date Queries

Q11. Select employees hired in the year 2020
```sql
SELECT * FROM Employee WHERE YEAR(hire_date) = 2020;
```
| emp_id | name       | age | salary   | department_id | hire_date  |
|--------|------------|-----|----------|---------------|------------|
| 1      | John Doe   | 28  | 50000.00 | 1             | 2020-01-15 |
| 10     | Hannah Lee | 30  | 53000.00 | 4             | 2020-02-25 |

---

Q12. Select employees hired in January of any year
```sql
SELECT * FROM Employee WHERE MONTH(hire_date) = 1;
```
| emp_id | name     | age | salary   | department_id | hire_date  |
|--------|----------|-----|----------|---------------|------------|
| 1      | John Doe | 28  | 50000.00 | 1             | 2020-01-15 |

---

Q13. Select employees hired before 2019
```sql
SELECT * FROM Employee WHERE hire_date < '2019-01-01';
```
| emp_id | name        | age | salary   | department_id | hire_date  |
|--------|-------------|-----|----------|---------------|------------|
| 3      | Bob Brown   | 45  | 80000.00 | 1             | 2018-02-12 |
| 9      | Grace Kelly | 27  | 65000.00 | 1             | 2018-11-13 |

---

Q14. Select employees hired on or after March 1, 2021
```sql
SELECT * FROM Employee WHERE hire_date >= '2021-03-01';
```
| emp_id | name        | age | salary   | department_id | hire_date  |
|--------|-------------|-----|----------|---------------|------------|
| 4      | Alice Blue  | 25  | 45000.00 | 3             | 2021-03-22 |
| 6      | David Green | 38  | 70000.00 | 4             | 2022-05-18 |
| 7      | Eve Black   | 40  | 55000.00 | 3             | 2021-08-30 |
| 8      | Frank White | 32  | 48000.00 | NULL          | 2021-07-10 |

---

Q15. Select employees hired in the last 2 years
```sql
SELECT * FROM Employee
WHERE hire_date >= CURDATE() - INTERVAL 2 YEAR;
```
> No results to be displayed.

---

## Aggregate Queries

Q16. Select the total salary of all employees
```sql
SELECT SUM(salary) AS total_salary FROM Employee;
```
| total_salary |
|--------------|
| 576000.00    |

---

Q17. Select the average salary of employees
```sql
SELECT AVG(salary) AS avg_salary FROM Employee;
```
| avg_salary |
|------------|
| 57600.00   |

---

Q18. Select the minimum salary in the Employee table
```sql
SELECT MIN(salary) AS min_salary FROM Employee;
```
| min_salary |
|------------|
| 45000.00   |

---

Q19. Select the number of employees in each department
```sql
SELECT department_id, COUNT(*) AS NoOfEmp
FROM Employee
GROUP BY department_id;
```
| department_id | NoOfEmp |
|---------------|---------|
| NULL          | 1       |
| 1             | 3       |
| 2             | 2       |
| 3             | 2       |
| 4             | 2       |

---

Q20. Select the average salary of employees in each department
```sql
SELECT department_id, AVG(salary) AS avg_salary
FROM Employee
GROUP BY department_id;
```
| department_id | avg_salary |
|---------------|------------|
| NULL          | 48000.00   |
| 1             | 65000.00   |
| 2             | 55000.00   |
| 3             | 50000.00   |
| 4             | 61500.00   |

---

## Group By Queries

Q21. Select the total salary for each department
```sql
SELECT department_id, SUM(salary) AS total_salary
FROM Employee
GROUP BY department_id;
```
| department_id | total_salary |
|---------------|--------------|
| NULL          | 48000.00     |
| 1             | 195000.00    |
| 2             | 110000.00    |
| 3             | 100000.00    |
| 4             | 123000.00    |

---

Q22. Select the average age of employees in each department
```sql
SELECT department_id, AVG(age) AS avg_age
FROM Employee
GROUP BY department_id;
```
| department_id | avg_age |
|---------------|---------|
| NULL          | 32.0000 |
| 1             | 33.3333 |
| 2             | 31.5000 |
| 3             | 32.5000 |
| 4             | 34.0000 |

---

Q23. Select the number of employees hired in each year
```sql
SELECT YEAR(hire_date) AS hire_year, COUNT(*) AS NoOfEmp
FROM Employee
GROUP BY YEAR(hire_date);
```
| hire_year | NoOfEmp |
|-----------|---------|
| 2018      | 2       |
| 2019      | 2       |
| 2020      | 2       |
| 2021      | 3       |
| 2022      | 1       |

---

Q24. Select the highest salary in each department
```sql
SELECT department_id, MAX(salary) AS highest_salary
FROM Employee
GROUP BY department_id;
```
| department_id | highest_salary |
|---------------|----------------|
| NULL          | 48000.00       |
| 1             | 80000.00       |
| 2             | 60000.00       |
| 3             | 55000.00       |
| 4             | 70000.00       |

---

Q25. Select the department with the highest average salary
```sql
SELECT department_id, AVG(salary) AS avg_salary
FROM Employee
GROUP BY department_id
ORDER BY AVG(salary) DESC
LIMIT 1;
```
| department_id | avg_salary |
|---------------|------------|
| 1             | 65000.00   |

---

## Having Queries

Q26. Select departments with more than 2 employees
```sql
SELECT department_id, COUNT(*) AS NoOfEmp
FROM Employee
GROUP BY department_id
HAVING COUNT(*) > 2;
```
| department_id | NoOfEmp |
|---------------|---------|
| 1             | 3       |

---

Q27. Select departments with an average salary greater than 55000
```sql
SELECT department_id, AVG(salary) AS avg_salary
FROM Employee
GROUP BY department_id
HAVING AVG(salary) > 55000;
```
| department_id | avg_salary |
|---------------|------------|
| 1             | 65000.00   |
| 4             | 61500.00   |

---

Q28. Select years with more than 1 employee hired
```sql
SELECT YEAR(hire_date) AS hire_year, COUNT(*) AS total
FROM Employee
GROUP BY YEAR(hire_date)
HAVING COUNT(*) > 1;
```
| hire_year | total |
|-----------|-------|
| 2018      | 2     |
| 2019      | 2     |
| 2020      | 2     |
| 2021      | 3     |

---

Q29. Select departments with a total salary expense less than 100000
```sql
SELECT department_id, SUM(salary) AS total_salary
FROM Employee
GROUP BY department_id
HAVING SUM(salary) < 100000;
```
| department_id | total_salary |
|---------------|--------------|
| NULL          | 48000.00     |

---

Q30. Select departments with the maximum salary above 75000
```sql
SELECT department_id, MAX(salary) AS above_75000
FROM Employee
GROUP BY department_id
HAVING MAX(salary) > 75000;
```
| department_id | above_75000 |
|---------------|-------------|
| 1             | 80000.00    |

---

## Order By Queries

Q31. Select all employees ordered by their salary in ascending order
```sql
SELECT * FROM Employee ORDER BY salary ASC;
```
| emp_id | name        | age | salary   | department_id | hire_date  |
|--------|-------------|-----|----------|---------------|------------|
| 4      | Alice Blue  | 25  | 45000.00 | 3             | 2021-03-22 |
| 8      | Frank White | 32  | 48000.00 | NULL          | 2021-07-10 |
| 1      | John Doe    | 28  | 50000.00 | 1             | 2020-01-15 |
| 5      | Charlie P.  | 29  | 50000.00 | 2             | 2019-12-01 |
| 10     | Hannah Lee  | 30  | 53000.00 | 4             | 2020-02-25 |
| 7      | Eve Black   | 40  | 55000.00 | 3             | 2021-08-30 |
| 2      | Jane Smith  | 34  | 60000.00 | 2             | 2019-07-23 |
| 9      | Grace Kelly | 27  | 65000.00 | 1             | 2018-11-13 |
| 6      | David Green | 38  | 70000.00 | 4             | 2022-05-18 |
| 3      | Bob Brown   | 45  | 80000.00 | 1             | 2018-02-12 |

---

Q32. Select all employees ordered by their age in descending order
```sql
SELECT * FROM Employee ORDER BY age DESC;
```
| emp_id | name        | age | salary   | department_id | hire_date  |
|--------|-------------|-----|----------|---------------|------------|
| 3      | Bob Brown   | 45  | 80000.00 | 1             | 2018-02-12 |
| 7      | Eve Black   | 40  | 55000.00 | 3             | 2021-08-30 |
| 6      | David Green | 38  | 70000.00 | 4             | 2022-05-18 |
| 2      | Jane Smith  | 34  | 60000.00 | 2             | 2019-07-23 |
| 8      | Frank White | 32  | 48000.00 | NULL          | 2021-07-10 |
| 10     | Hannah Lee  | 30  | 53000.00 | 4             | 2020-02-25 |
| 5      | Charlie P.  | 29  | 50000.00 | 2             | 2019-12-01 |
| 1      | John Doe    | 28  | 50000.00 | 1             | 2020-01-15 |
| 9      | Grace Kelly | 27  | 65000.00 | 1             | 2018-11-13 |
| 4      | Alice Blue  | 25  | 45000.00 | 3             | 2021-03-22 |

---

Q33. Select all employees ordered by their hire date in ascending order
```sql
SELECT * FROM Employee ORDER BY hire_date ASC;
```
| emp_id | name        | age | salary   | department_id | hire_date  |
|--------|-------------|-----|----------|---------------|------------|
| 3      | Bob Brown   | 45  | 80000.00 | 1             | 2018-02-12 |
| 9      | Grace Kelly | 27  | 65000.00 | 1             | 2018-11-13 |
| 2      | Jane Smith  | 34  | 60000.00 | 2             | 2019-07-23 |
| 5      | Charlie P.  | 29  | 50000.00 | 2             | 2019-12-01 |
| 1      | John Doe    | 28  | 50000.00 | 1             | 2020-01-15 |
| 10     | Hannah Lee  | 30  | 53000.00 | 4             | 2020-02-25 |
| 4      | Alice Blue  | 25  | 45000.00 | 3             | 2021-03-22 |
| 8      | Frank White | 32  | 48000.00 | NULL          | 2021-07-10 |
| 7      | Eve Black   | 40  | 55000.00 | 3             | 2021-08-30 |
| 6      | David Green | 38  | 70000.00 | 4             | 2022-05-18 |

---

Q34. Select employees ordered by their department and then by their salary
```sql
SELECT * FROM Employee ORDER BY department_id, salary;
```
| emp_id | name        | age | salary   | department_id | hire_date  |
|--------|-------------|-----|----------|---------------|------------|
| 8      | Frank White | 32  | 48000.00 | NULL          | 2021-07-10 |
| 1      | John Doe    | 28  | 50000.00 | 1             | 2020-01-15 |
| 9      | Grace Kelly | 27  | 65000.00 | 1             | 2018-11-13 |
| 3      | Bob Brown   | 45  | 80000.00 | 1             | 2018-02-12 |
| 5      | Charlie P.  | 29  | 50000.00 | 2             | 2019-12-01 |
| 2      | Jane Smith  | 34  | 60000.00 | 2             | 2019-07-23 |
| 4      | Alice Blue  | 25  | 45000.00 | 3             | 2021-03-22 |
| 7      | Eve Black   | 40  | 55000.00 | 3             | 2021-08-30 |
| 10     | Hannah Lee  | 30  | 53000.00 | 4             | 2020-02-25 |
| 6      | David Green | 38  | 70000.00 | 4             | 2022-05-18 |

---

Q35. Select departments ordered by the total salary of their employees
```sql
SELECT department_id, SUM(salary) AS total_salary
FROM Employee
GROUP BY department_id
ORDER BY total_salary DESC;
```
| department_id | total_salary |
|---------------|--------------|
| 1             | 195000.00    |
| 4             | 123000.00    |
| 2             | 110000.00    |
| 3             | 100000.00    |
| NULL          | 48000.00     |

---

## Join Queries

Q36. Select employee names along with their department names
```sql
SELECT e.name, d.name AS department_name
FROM Employee e
JOIN Department d ON e.department_id = d.department_id;
```
| name        | department_name |
|-------------|-----------------|
| John Doe    | IT              |
| Bob Brown   | IT              |
| Grace Kelly | IT              |
| Jane Smith  | HR              |
| Charlie P.  | HR              |
| Alice Blue  | Finance         |
| Eve Black   | Finance         |
| David Green | Marketing       |
| Hannah Lee  | Marketing       |

---

Q37. Select project names along with the department names they belong to
```sql
SELECT p.name, d.name AS department_name
FROM Department d
JOIN Project p ON d.department_id = p.department_id;
```
| name            | department_name |
|-----------------|-----------------|
| Project Alpha   | IT              |
| Project Gamma   | IT              |
| Project Theta   | IT              |
| Project Beta    | HR              |
| Project Delta   | Finance         |
| Project Eta     | Finance         |
| Project Epsilon | Marketing       |
| Project Zeta    | Marketing       |

---

Q38. Select employee names and their corresponding project names
```sql
SELECT e.name AS employee, p.name AS project
FROM Employee e
JOIN Project p ON e.department_id = p.department_id;
```
| employee    | project         |
|-------------|-----------------|
| John Doe    | Project Alpha   |
| Bob Brown   | Project Alpha   |
| Grace Kelly | Project Alpha   |
| Jane Smith  | Project Beta    |
| Charlie P.  | Project Beta    |
| John Doe    | Project Gamma   |
| Bob Brown   | Project Gamma   |
| Grace Kelly | Project Gamma   |
| Alice Blue  | Project Delta   |
| Eve Black   | Project Delta   |
| David Green | Project Epsilon |
| Hannah Lee  | Project Epsilon |
| David Green | Project Zeta    |
| Hannah Lee  | Project Zeta    |
| Alice Blue  | Project Eta     |
| Eve Black   | Project Eta     |
| John Doe    | Project Theta   |
| Bob Brown   | Project Theta   |
| Grace Kelly | Project Theta   |

---

Q39. Select all employees and their departments, including those without a department
```sql
SELECT e.name, d.name AS department
FROM Employee e
LEFT JOIN Department d ON e.department_id = d.department_id;
```
| name        | department |
|-------------|------------|
| John Doe    | IT         |
| Bob Brown   | IT         |
| Grace Kelly | IT         |
| Jane Smith  | HR         |
| Charlie P.  | HR         |
| Alice Blue  | Finance    |
| Eve Black   | Finance    |
| David Green | Marketing  |
| Hannah Lee  | Marketing  |
| Frank White | NULL       |

---

Q40. Select all departments and their employees, including departments without employees
```sql
SELECT d.name, e.name AS employee
FROM Department d
LEFT JOIN Employee e ON d.department_id = e.department_id;
```
| name      | employee    |
|-----------|-------------|
| IT        | John Doe    |
| IT        | Bob Brown   |
| IT        | Grace Kelly |
| HR        | Jane Smith  |
| HR        | Charlie P.  |
| Finance   | Alice Blue  |
| Finance   | Eve Black   |
| Marketing | David Green |
| Marketing | Hannah Lee  |

---

Q41. Select employees who are not assigned to any project
```sql
SELECT e.name
FROM Employee e
LEFT JOIN Project p ON e.department_id = p.department_id
WHERE p.project_id IS NULL;
```
| name        |
|-------------|
| Frank White |

---

Q42. Select employees and the number of projects their department is working on
```sql
SELECT e.name, COUNT(p.project_id) AS total_projects
FROM Employee e
LEFT JOIN Project p ON e.department_id = p.department_id
GROUP BY e.name;
```
| name        | total_projects |
|-------------|----------------|
| Alice Blue  | 2              |
| Bob Brown   | 3              |
| Charlie P.  | 1              |
| David Green | 2              |
| Eve Black   | 2              |
| Frank White | 0              |
| Grace Kelly | 3              |
| Hannah Lee  | 2              |
| Jane Smith  | 1              |
| John Doe    | 3              |

---

Q43. Select the departments that have no employees
```sql
SELECT d.name
FROM Department d
LEFT JOIN Employee e ON d.department_id = e.department_id
WHERE e.emp_id IS NULL;
```
> No results to be displayed.

---

Q44. Select employee names who share the same department with 'John Doe'
```sql
SELECT name
FROM Employee
WHERE department_id = (
    SELECT department_id
    FROM Employee
    WHERE name = 'John Doe'
);
```
| name        |
|-------------|
| John Doe    |
| Bob Brown   |
| Grace Kelly |

---

Q45. Select the department name with the highest average salary
```sql
SELECT d.name, AVG(e.salary) AS avg_salary
FROM Department d
JOIN Employee e ON d.department_id = e.department_id
GROUP BY d.name
ORDER BY avg_salary DESC
LIMIT 1;
```
| name | avg_salary |
|------|------------|
| IT   | 65000.00   |

---

## Nested and Correlated Queries

Q46. Select the employee with the highest salary
```sql
SELECT name, salary
FROM Employee
WHERE salary = (
    SELECT MAX(salary)
    FROM Employee
);
```
| name      | salary   |
|-----------|----------|
| Bob Brown | 80000.00 |

---

Q47. Select employees whose salary is above the average salary
```sql
SELECT name, salary
FROM Employee
WHERE salary > (
    SELECT AVG(salary)
    FROM Employee
);
```
| name        | salary   |
|-------------|----------|
| Jane Smith  | 60000.00 |
| Bob Brown   | 80000.00 |
| David Green | 70000.00 |
| Grace Kelly | 65000.00 |

---

Q48. Select the second highest salary from the Employee table
```sql
SELECT MAX(salary) AS second_highest
FROM Employee
WHERE salary < (
    SELECT MAX(salary)
    FROM Employee
);
```
| second_highest |
|----------------|
| 70000.00       |

---

Q49. Select the department with the most employees
```sql
SELECT d.name, COUNT(e.emp_id) AS total_employees
FROM Department d
JOIN Employee e ON d.department_id = e.department_id
GROUP BY d.name
ORDER BY total_employees DESC
LIMIT 1;
```
| name | total_employees |
|------|-----------------|
| IT   | 3               |

---

Q50. Select employees who earn more than the average salary of their department
```sql
SELECT e.name, e.salary, e.department_id
FROM Employee e
WHERE e.salary > (
    SELECT AVG(salary)
    FROM Employee
    WHERE department_id = e.department_id
);
```
| name        | salary   | department_id |
|-------------|----------|---------------|
| Jane Smith  | 60000.00 | 2             |
| Bob Brown   | 80000.00 | 1             |
| David Green | 70000.00 | 4             |
| Eve Black   | 55000.00 | 3             |

---

Q51. Select the nth highest salary (for example, 3rd highest)
```sql
SELECT DISTINCT salary
FROM Employee
ORDER BY salary DESC
LIMIT 1 OFFSET 2;
```
| salary   |
|----------|
| 65000.00 |

---

Q52. Select employees who are older than all employees in the HR department
```sql
SELECT name, age
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
```
| name        | age |
|-------------|-----|
| Bob Brown   | 45  |
| David Green | 38  |
| Eve Black   | 40  |

---

Q53. Select departments where the average salary is greater than 55000
```sql
SELECT d.name, AVG(e.salary) AS avg_salary
FROM Department d
JOIN Employee e ON d.department_id = e.department_id
GROUP BY d.name
HAVING AVG(e.salary) > 55000;
```
| name      | avg_salary |
|-----------|------------|
| IT        | 65000.00   |
| Marketing | 61500.00   |

---

Q54. Select employees who work in a department with at least 2 projects
```sql
SELECT name
FROM Employee
WHERE department_id IN (
    SELECT department_id
    FROM Project
    GROUP BY department_id
    HAVING COUNT(*) >= 2
);
```
| name        |
|-------------|
| John Doe    |
| Bob Brown   |
| Alice Blue  |
| David Green |
| Eve Black   |
| Grace Kelly |
| Hannah Lee  |

---

Q55. Select employees who were hired on the same date as 'Jane Smith'
```sql
SELECT name, hire_date
FROM Employee
WHERE hire_date = (
    SELECT hire_date
    FROM Employee
    WHERE name = 'Jane Smith'
);
```
| name       | hire_date  |
|------------|------------|
| Jane Smith | 2019-07-23 |

---

## Combined Moderate Difficulty Queries

Q56. Select the total salary of employees hired in the year 2020
```sql
SELECT SUM(salary) AS total_salary
FROM Employee
WHERE YEAR(hire_date) = 2020;
```
| total_salary |
|--------------|
| 103000.00    |

---

Q57. Select the average salary of employees in each department, ordered by average salary descending
```sql
SELECT department_id, AVG(salary) AS avg_salary
FROM Employee
GROUP BY department_id
ORDER BY avg_salary DESC;
```
| department_id | avg_salary |
|---------------|------------|
| 1             | 65000.00   |
| 4             | 61500.00   |
| 2             | 55000.00   |
| 3             | 50000.00   |
| NULL          | 48000.00   |

---

Q58. Select departments with more than 1 employee and an average salary greater than 55000
```sql
SELECT department_id, COUNT(*) AS total_emp, AVG(salary) AS avg_salary
FROM Employee
GROUP BY department_id
HAVING COUNT(*) > 1 AND AVG(salary) > 55000;
```
| department_id | total_emp | avg_salary |
|---------------|-----------|------------|
| 1             | 3         | 65000.00   |
| 4             | 2         | 61500.00   |

---

Q59. Select employees hired in the last 2 years, ordered by their hire date
```sql
SELECT name, hire_date
FROM Employee
WHERE hire_date >= CURDATE() - INTERVAL 2 YEAR
ORDER BY hire_date;
```
> No results to be displayed.

---

Q60. Select the total number of employees and the average salary for each department
```sql
SELECT department_id,
       COUNT(*) AS total_employees,
       AVG(salary) AS avg_salary
FROM Employee
GROUP BY department_id;
```
| department_id | total_employees | avg_salary |
|---------------|-----------------|------------|
| NULL          | 1               | 48000.00   |
| 1             | 3               | 65000.00   |
| 2             | 2               | 55000.00   |
| 3             | 2               | 50000.00   |
| 4             | 2               | 61500.00   |

---

Q61. Select the name and salary of employees whose salary is above the average salary of the company
```sql
SELECT name, salary
FROM Employee
WHERE salary > (
    SELECT AVG(salary)
    FROM Employee
);
```
| name        | salary   |
|-------------|----------|
| Jane Smith  | 60000.00 |
| Bob Brown   | 80000.00 |
| David Green | 70000.00 |
| Grace Kelly | 65000.00 |

---

Q62. Select the names of employees who are hired on the same date as the oldest employee
```sql
SELECT name, hire_date
FROM Employee
WHERE hire_date = (
    SELECT MIN(hire_date)
    FROM Employee
);
```
| name      | hire_date  |
|-----------|------------|
| Bob Brown | 2018-02-12 |

---

Q63. Select department names along with the total number of projects, ordered by number of projects
```sql
SELECT d.name, COUNT(p.project_id) AS total_projects
FROM Department d
LEFT JOIN Project p ON d.department_id = p.department_id
GROUP BY d.name
ORDER BY total_projects DESC;
```
| name      | total_projects |
|-----------|----------------|
| IT        | 3              |
| Finance   | 2              |
| Marketing | 2              |
| HR        | 1              |

---

Q64. Select the employee name with the highest salary in each department
```sql
SELECT e.name, e.salary, e.department_id
FROM Employee e
WHERE e.salary = (
    SELECT MAX(salary)
    FROM Employee
    WHERE department_id = e.department_id
);
```
| name        | salary   | department_id |
|-------------|----------|---------------|
| Jane Smith  | 60000.00 | 2             |
| Bob Brown   | 80000.00 | 1             |
| David Green | 70000.00 | 4             |
| Eve Black   | 55000.00 | 3             |

---

Q65. Select the names and salaries of employees who are older than the average age of their department
```sql
SELECT e.name, e.age, e.department_id
FROM Employee e
WHERE e.age > (
    SELECT AVG(age)
    FROM Employee
    WHERE department_id = e.department_id
);
```
| name        | age | department_id |
|-------------|-----|---------------|
| Jane Smith  | 34  | 2             |
| Bob Brown   | 45  | 1             |
| David Green | 38  | 4             |
| Eve Black   | 40  | 3             |

---

Database : MySQL v5.7
Tables   : Employee, Department, Project
