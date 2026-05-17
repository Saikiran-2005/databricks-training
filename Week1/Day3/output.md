# SQL Window Functions

---

## Database Schema

```sql
-- SQL Window Functions
-- Compatible with PostgreSQL

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    department VARCHAR(100),
    manager_id INT NULL,
    salary DECIMAL(10,2),
    hire_date DATE
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(100)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    employee_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- Insert Employees
INSERT INTO employees VALUES
(1, 'Alice Johnson', 'Sales', NULL, 70000, '2020-01-15'),
(2, 'Bob Smith', 'Sales', 1, 65000, '2021-03-20'),
(3, 'Charlie Brown', 'IT', NULL, 90000, '2019-07-01'),
(4, 'Diana Prince', 'IT', 3, 95000, '2018-11-11'),
(5, 'Ethan Hunt', 'HR', NULL, 60000, '2022-02-10'),
(6, 'Fiona Green', 'HR', 5, 58000, '2023-05-12'),
(7, 'George Miller', 'Finance', NULL, 85000, '2017-09-18'),
(8, 'Hannah Lee', 'Finance', 7, 82000, '2021-08-30');

-- Insert Customers
INSERT INTO customers VALUES
(1, 'Acme Corp', 'New York'),
(2, 'Tech Solutions', 'Chicago'),
(3, 'Global Retail', 'Dallas'),
(4, 'Blue Sky Ltd', 'Seattle'),
(5, 'NextGen Systems', 'Boston');

-- Insert Orders
INSERT INTO orders VALUES
(101, 1, 1, '2024-01-10', 500),
(102, 2, 2, '2024-01-11', 700),
(103, 1, 1, '2024-01-15', 1200),
(104, 3, 3, '2024-01-18', 300),
(105, 4, 4, '2024-01-20', 900),
(106, 5, 2, '2024-01-25', 1500),
(107, 2, 1, '2024-02-01', 650),
(108, 1, 3, '2024-02-05', 1100),
(109, 3, 4, '2024-02-10', 400),
(110, 4, 2, '2024-02-15', 950),
(111, 5, 1, '2024-02-20', 2000),
(112, 1, 4, '2024-02-25', 750);

-- Notes:
-- Multiple departments for PARTITION BY exercises.
-- Salary variations for ranking exercises.
-- Multiple customer orders for LAG/LEAD analysis.
-- Manager hierarchy included for recursive CTE practice.
```

---

## Table of Contents
- [Window Functions – ROW_NUMBER, RANK, DENSE_RANK](#window-functions--row_number-rank-dense_rank)
- [Window Functions – Aggregate with OVER()](#window-functions--aggregate-with-over)

---

## Window Functions – ROW_NUMBER, RANK, DENSE_RANK

Q1. Use ROW_NUMBER() to assign a row number to employees ordered by salary descending
```sql
SELECT employee_name, salary,
       ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num
FROM employees;
```
| employee_name | salary   | row_num |
|---------------|----------|---------|
| Diana Prince  | 95000.00 | 1       |
| Charlie Brown | 90000.00 | 2       |
| George Miller | 85000.00 | 3       |
| Hannah Lee    | 82000.00 | 4       |
| Alice Johnson | 70000.00 | 5       |
| Bob Smith     | 65000.00 | 6       |
| Ethan Hunt    | 60000.00 | 7       |
| Fiona Green   | 58000.00 | 8       |

---

Q2. Use RANK() to rank employees by salary
```sql
SELECT employee_name, salary,
       RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM employees;
```
| employee_name | salary   | salary_rank |
|---------------|----------|-------------|
| Diana Prince  | 95000.00 | 1           |
| Charlie Brown | 90000.00 | 2           |
| George Miller | 85000.00 | 3           |
| Hannah Lee    | 82000.00 | 4           |
| Alice Johnson | 70000.00 | 5           |
| Bob Smith     | 65000.00 | 6           |
| Ethan Hunt    | 60000.00 | 7           |
| Fiona Green   | 58000.00 | 8           |

---

Q3. Use DENSE_RANK() to rank employees by salary
```sql
SELECT employee_name, salary,
       DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_salary_rank
FROM employees;
```
| employee_name | salary   | dense_salary_rank |
|---------------|----------|-------------------|
| Diana Prince  | 95000.00 | 1                 |
| Charlie Brown | 90000.00 | 2                 |
| George Miller | 85000.00 | 3                 |
| Hannah Lee    | 82000.00 | 4                 |
| Alice Johnson | 70000.00 | 5                 |
| Bob Smith     | 65000.00 | 6                 |
| Ethan Hunt    | 60000.00 | 7                 |
| Fiona Green   | 58000.00 | 8                 |

---

Q4. Find the top 3 highest-paid employees using a window function
```sql
SELECT *
FROM (
    SELECT employee_name, salary,
           ROW_NUMBER() OVER (ORDER BY salary DESC) AS rn
    FROM employees
) t
WHERE rn <= 3;
```
| employee_name | salary   | rn |
|---------------|----------|----|
| Diana Prince  | 95000.00 | 1  |
| Charlie Brown | 90000.00 | 2  |
| George Miller | 85000.00 | 3  |

---

Q5. Rank employees within each department using PARTITION BY
```sql
SELECT employee_name, department, salary,
       RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dept_rank
FROM employees;
```
| employee_name | department | salary   | dept_rank |
|---------------|------------|----------|-----------|
| George Miller | Finance    | 85000.00 | 1         |
| Hannah Lee    | Finance    | 82000.00 | 2         |
| Ethan Hunt    | HR         | 60000.00 | 1         |
| Fiona Green   | HR         | 58000.00 | 2         |
| Diana Prince  | IT         | 95000.00 | 1         |
| Charlie Brown | IT         | 90000.00 | 2         |
| Alice Johnson | Sales      | 70000.00 | 1         |
| Bob Smith     | Sales      | 65000.00 | 2         |

---

## Window Functions – Aggregate with OVER()

Q6. Display the highest salary in each department using a window function
```sql
SELECT employee_name, department, salary,
       MAX(salary) OVER (PARTITION BY department) AS highest_department_salary
FROM employees;
```
| employee_name | department | salary   | highest_department_salary |
|---------------|------------|----------|---------------------------|
| George Miller | Finance    | 85000.00 | 85000.00                  |
| Hannah Lee    | Finance    | 82000.00 | 85000.00                  |
| Ethan Hunt    | HR         | 60000.00 | 60000.00                  |
| Fiona Green   | HR         | 58000.00 | 60000.00                  |
| Charlie Brown | IT         | 90000.00 | 95000.00                  |
| Diana Prince  | IT         | 95000.00 | 95000.00                  |
| Alice Johnson | Sales      | 70000.00 | 70000.00                  |
| Bob Smith     | Sales      | 65000.00 | 70000.00                  |

---

Q7. Calculate the running total of order amounts ordered by order_date
```sql
SELECT order_id, order_date, total_amount,
       SUM(total_amount) OVER (ORDER BY order_date) AS running_total
FROM orders;
```
| order_id | order_date | total_amount | running_total |
|----------|------------|--------------|---------------|
| 101      | 2024-01-10 | 500.00       | 500.00        |
| 102      | 2024-01-11 | 700.00       | 1200.00       |
| 103      | 2024-01-15 | 1200.00      | 2400.00       |
| 104      | 2024-01-18 | 300.00       | 2700.00       |
| 105      | 2024-01-20 | 900.00       | 3600.00       |
| 106      | 2024-01-25 | 1500.00      | 5100.00       |
| 107      | 2024-02-01 | 650.00       | 5750.00       |
| 108      | 2024-02-05 | 1100.00      | 6850.00       |
| 109      | 2024-02-10 | 400.00       | 7250.00       |
| 110      | 2024-02-15 | 950.00       | 8200.00       |
| 111      | 2024-02-20 | 2000.00      | 10200.00      |
| 112      | 2024-02-25 | 750.00       | 10950.00      |

---

Q8. Calculate the cumulative sales amount for each employee
```sql
SELECT employee_id, order_id, total_amount,
       SUM(total_amount) OVER (PARTITION BY employee_id ORDER BY order_date) AS cumulative_sales
FROM orders;
```
| employee_id | order_id | total_amount | cumulative_sales |
|-------------|----------|--------------|------------------|
| 1           | 101      | 500.00       | 500.00           |
| 1           | 103      | 1200.00      | 1700.00          |
| 1           | 107      | 650.00       | 2350.00          |
| 1           | 111      | 2000.00      | 4350.00          |
| 2           | 102      | 700.00       | 700.00           |
| 2           | 106      | 1500.00      | 2200.00          |
| 2           | 110      | 950.00       | 3150.00          |
| 3           | 104      | 300.00       | 300.00           |
| 3           | 108      | 1100.00      | 1400.00          |
| 4           | 105      | 900.00       | 900.00           |
| 4           | 109      | 400.00       | 1300.00          |
| 4           | 112      | 750.00       | 2050.00          |

---

Q9. Use LAG() to show the previous order amount for each customer
```sql
SELECT customer_id, order_id, order_date, total_amount,
       LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS previous_order_amount
FROM orders;
```
| customer_id | order_id | order_date | total_amount | previous_order_amount |
|-------------|----------|------------|--------------|-----------------------|
| 1           | 101      | 2024-01-10 | 500.00       | NULL                  |
| 1           | 103      | 2024-01-15 | 1200.00      | 500.00                |
| 1           | 108      | 2024-02-05 | 1100.00      | 1200.00               |
| 1           | 112      | 2024-02-25 | 750.00       | 1100.00               |
| 2           | 102      | 2024-01-11 | 700.00       | NULL                  |
| 2           | 107      | 2024-02-01 | 650.00       | 700.00                |
| 3           | 104      | 2024-01-18 | 300.00       | NULL                  |
| 3           | 109      | 2024-02-10 | 400.00       | 300.00                |
| 4           | 105      | 2024-01-20 | 900.00       | NULL                  |
| 4           | 110      | 2024-02-15 | 950.00       | 900.00                |
| 5           | 106      | 2024-01-25 | 1500.00      | NULL                  |
| 5           | 111      | 2024-02-20 | 2000.00      | 1500.00               |

---

Q10. Use LEAD() to show the next order amount for each customer
```sql
SELECT customer_id, order_id, order_date, total_amount,
       LEAD(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS next_order_amount
FROM orders;
```
| customer_id | order_id | order_date | total_amount | next_order_amount |
|-------------|----------|------------|--------------|-------------------|
| 1           | 101      | 2024-01-10 | 500.00       | 1200.00           |
| 1           | 103      | 2024-01-15 | 1200.00      | 1100.00           |
| 1           | 108      | 2024-02-05 | 1100.00      | 750.00            |
| 1           | 112      | 2024-02-25 | 750.00       | NULL              |
| 2           | 102      | 2024-01-11 | 700.00       | 650.00            |
| 2           | 107      | 2024-02-01 | 650.00       | NULL              |
| 3           | 104      | 2024-01-18 | 300.00       | 400.00            |
| 3           | 109      | 2024-02-10 | 400.00       | NULL              |
| 4           | 105      | 2024-01-20 | 900.00       | 950.00            |
| 4           | 110      | 2024-02-15 | 950.00       | NULL              |
| 5           | 106      | 2024-01-25 | 1500.00      | 2000.00           |
| 5           | 111      | 2024-02-20 | 2000.00      | NULL              |

---

Q11. Find the difference between current order amount and previous order amount
```sql
SELECT customer_id, order_id, order_date, total_amount,
       total_amount - LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS amount_difference
FROM orders;
```
| customer_id | order_id | order_date | total_amount | amount_difference |
|-------------|----------|------------|--------------|-------------------|
| 1           | 101      | 2024-01-10 | 500.00       | NULL              |
| 1           | 103      | 2024-01-15 | 1200.00      | 700.00            |
| 1           | 108      | 2024-02-05 | 1100.00      | -100.00           |
| 1           | 112      | 2024-02-25 | 750.00       | -350.00           |
| 2           | 102      | 2024-01-11 | 700.00       | NULL              |
| 2           | 107      | 2024-02-01 | 650.00       | -50.00            |
| 3           | 104      | 2024-01-18 | 300.00       | NULL              |
| 3           | 109      | 2024-02-10 | 400.00       | 100.00            |
| 4           | 105      | 2024-01-20 | 900.00       | NULL              |
| 4           | 110      | 2024-02-15 | 950.00       | 50.00             |
| 5           | 106      | 2024-01-25 | 1500.00      | NULL              |
| 5           | 111      | 2024-02-20 | 2000.00      | 500.00            |

---

Q12. Calculate a moving average of the last 3 orders
```sql
SELECT order_id, order_date, total_amount,
       AVG(total_amount) OVER (ORDER BY order_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg
FROM orders;
```
| order_id | order_date | total_amount | moving_avg  |
|----------|------------|--------------|-------------|
| 101      | 2024-01-10 | 500.00       | 500.000000  |
| 102      | 2024-01-11 | 700.00       | 600.000000  |
| 103      | 2024-01-15 | 1200.00      | 800.000000  |
| 104      | 2024-01-18 | 300.00       | 733.333333  |
| 105      | 2024-01-20 | 900.00       | 800.000000  |
| 106      | 2024-01-25 | 1500.00      | 900.000000  |
| 107      | 2024-02-01 | 650.00       | 1016.666667 |
| 108      | 2024-02-05 | 1100.00      | 1083.333333 |
| 109      | 2024-02-10 | 400.00       | 716.666667  |
| 110      | 2024-02-15 | 950.00       | 816.666667  |
| 111      | 2024-02-20 | 2000.00      | 1116.666667 |
| 112      | 2024-02-25 | 750.00       | 1233.333333 |

---

Q13. Use NTILE(4) to divide employees into salary quartiles
```sql
SELECT employee_name, salary,
       NTILE(4) OVER (ORDER BY salary DESC) AS salary_quartile
FROM employees;
```
| employee_name | salary   | salary_quartile |
|---------------|----------|-----------------|
| Diana Prince  | 95000.00 | 1               |
| Charlie Brown | 90000.00 | 1               |
| George Miller | 85000.00 | 2               |
| Hannah Lee    | 82000.00 | 2               |
| Alice Johnson | 70000.00 | 3               |
| Bob Smith     | 65000.00 | 3               |
| Ethan Hunt    | 60000.00 | 4               |
| Fiona Green   | 58000.00 | 4               |

---

Q14. Find the first order placed by each customer using ROW_NUMBER()
```sql
SELECT *
FROM (
    SELECT customer_id, order_id, order_date, total_amount,
           ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date) AS rn
    FROM orders
) t
WHERE rn = 1;
```
| customer_id | order_id | order_date | total_amount | rn |
|-------------|----------|------------|--------------|----|
| 1           | 101      | 2024-01-10 | 500.00       | 1  |
| 2           | 102      | 2024-01-11 | 700.00       | 1  |
| 3           | 104      | 2024-01-18 | 300.00       | 1  |
| 4           | 105      | 2024-01-20 | 900.00       | 1  |
| 5           | 106      | 2024-01-25 | 1500.00      | 1  |

---

Q15. Find the latest order placed by each customer
```sql
SELECT *
FROM (
    SELECT customer_id, order_id, order_date, total_amount,
           ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date DESC) AS rn
    FROM orders
) t
WHERE rn = 1;
```
| customer_id | order_id | order_date | total_amount | rn |
|-------------|----------|------------|--------------|----|
| 1           | 112      | 2024-02-25 | 750.00       | 1  |
| 2           | 107      | 2024-02-01 | 650.00       | 1  |
| 3           | 109      | 2024-02-10 | 400.00       | 1  |
| 4           | 110      | 2024-02-15 | 950.00       | 1  |
| 5           | 111      | 2024-02-20 | 2000.00      | 1  |

---

Q16. Display employee salaries along with department average salary
```sql
SELECT employee_name, department, salary,
       AVG(salary) OVER (PARTITION BY department) AS department_avg_salary
FROM employees;
```
| employee_name | department | salary   | department_avg_salary |
|---------------|------------|----------|-----------------------|
| George Miller | Finance    | 85000.00 | 83500.00              |
| Hannah Lee    | Finance    | 82000.00 | 83500.00              |
| Ethan Hunt    | HR         | 60000.00 | 59000.00              |
| Fiona Green   | HR         | 58000.00 | 59000.00              |
| Charlie Brown | IT         | 90000.00 | 92500.00              |
| Diana Prince  | IT         | 95000.00 | 92500.00              |
| Alice Johnson | Sales      | 70000.00 | 67500.00              |
| Bob Smith     | Sales      | 65000.00 | 67500.00              |

---

Q17. Find employees earning above their department average salary
```sql
SELECT *
FROM (
    SELECT employee_name, department, salary,
           AVG(salary) OVER (PARTITION BY department) AS dept_avg_salary
    FROM employees
) t
WHERE salary > dept_avg_salary;
```
| employee_name | department | salary   | dept_avg_salary |
|---------------|------------|----------|-----------------|
| George Miller | Finance    | 85000.00 | 83500.00        |
| Ethan Hunt    | HR         | 60000.00 | 59000.00        |
| Diana Prince  | IT         | 95000.00 | 92500.00        |
| Alice Johnson | Sales      | 70000.00 | 67500.00        |

---

Q18. Use SUM() OVER(PARTITION BY department) to calculate department payroll
```sql
SELECT employee_name, department, salary,
       SUM(salary) OVER (PARTITION BY department) AS department_payroll
FROM employees;
```
| employee_name | department | salary   | department_payroll |
|---------------|------------|----------|--------------------|
| George Miller | Finance    | 85000.00 | 167000.00          |
| Hannah Lee    | Finance    | 82000.00 | 167000.00          |
| Ethan Hunt    | HR         | 60000.00 | 118000.00          |
| Fiona Green   | HR         | 58000.00 | 118000.00          |
| Charlie Brown | IT         | 90000.00 | 185000.00          |
| Diana Prince  | IT         | 95000.00 | 185000.00          |
| Alice Johnson | Sales      | 70000.00 | 135000.00          |
| Bob Smith     | Sales      | 65000.00 | 135000.00          |

---

Q19. Find percentage contribution of each employee salary within their department
```sql
SELECT employee_name, department, salary,
       ROUND(salary * 100.0 / SUM(salary) OVER (PARTITION BY department), 2) AS salary_percentage
FROM employees;
```
| employee_name | department | salary   | salary_percentage |
|---------------|------------|----------|-------------------|
| George Miller | Finance    | 85000.00 | 50.90             |
| Hannah Lee    | Finance    | 82000.00 | 49.10             |
| Ethan Hunt    | HR         | 60000.00 | 50.85             |
| Fiona Green   | HR         | 58000.00 | 49.15             |
| Charlie Brown | IT         | 90000.00 | 48.65             |
| Diana Prince  | IT         | 95000.00 | 51.35             |
| Alice Johnson | Sales      | 70000.00 | 51.85             |
| Bob Smith     | Sales      | 65000.00 | 48.15             |

---

Q20. Use COUNT() OVER() to show total number of employees alongside each row
```sql
SELECT employee_name, department,
       COUNT(*) OVER () AS total_employees
FROM employees;
```
| employee_name | department | total_employees |
|---------------|------------|-----------------|
| Alice Johnson | Sales      | 8               |
| Bob Smith     | Sales      | 8               |
| Charlie Brown | IT         | 8               |
| Diana Prince  | IT         | 8               |
| Ethan Hunt    | HR         | 8               |
| Fiona Green   | HR         | 8               |
| George Miller | Finance    | 8               |
| Hannah Lee    | Finance    | 8               |

---

Database : MySQL v9
Tables   : employees, customers, orders
