# SQL CTEs - Output

---

## Database Schema

```sql
-- SQL Window Functions and CTE Assignment
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
- [CTEs – Common Table Expressions](#ctes--common-table-expressions)
- [Recursive CTEs](#recursive-ctes)
- [CTEs with Filters and Advanced Combinations](#ctes-with-filters-and-advanced-combinations)

---

## CTEs – Common Table Expressions

Q21. Create a CTE to calculate total sales per employee
```sql
WITH employee_sales AS (
    SELECT employee_id, SUM(total_amount) AS total_sales
    FROM orders
    GROUP BY employee_id
)
SELECT e.employee_name, es.total_sales
FROM employees e
JOIN employee_sales es ON e.employee_id = es.employee_id;
```
| employee_name | total_sales |
|---------------|-------------|
| Alice Johnson | 4350.00     |
| Bob Smith     | 3150.00     |
| Charlie Brown | 1400.00     |
| Diana Prince  | 2050.00     |

---

Q22. Use a CTE to find employees whose sales exceed company average
```sql
WITH employee_sales AS (
    SELECT employee_id, SUM(total_amount) AS total_sales
    FROM orders
    GROUP BY employee_id
),
company_avg AS (
    SELECT AVG(total_sales) AS avg_sales
    FROM employee_sales
)
SELECT e.employee_name, es.total_sales
FROM employees e
JOIN employee_sales es ON e.employee_id = es.employee_id
JOIN company_avg ca ON es.total_sales > ca.avg_sales;
```
| employee_name | total_sales |
|---------------|-------------|
| Alice Johnson | 4350.00     |
| Bob Smith     | 3150.00     |

---

Q23. Create multiple CTEs to calculate customer total spending and rankings
```sql
WITH customer_spending AS (
    SELECT customer_id, SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
),
customer_rankings AS (
    SELECT customer_id, total_spent,
           RANK() OVER (ORDER BY total_spent DESC) AS spending_rank
    FROM customer_spending
)
SELECT c.customer_name, cr.total_spent, cr.spending_rank
FROM customers c
JOIN customer_rankings cr ON c.customer_id = cr.customer_id;
```
| customer_name   | total_spent | spending_rank |
|-----------------|-------------|---------------|
| Acme Corp       | 3550.00     | 1             |
| Tech Solutions  | 1350.00     | 4             |
| Global Retail   | 700.00      | 5             |
| Blue Sky Ltd    | 1850.00     | 3             |
| NextGen Systems | 3500.00     | 2             |

---

## Recursive CTEs

Q24. Write a recursive CTE to generate numbers from 1 to 10
```sql
WITH RECURSIVE numbers AS (
    SELECT 1 AS num
    UNION ALL
    SELECT num + 1
    FROM numbers
    WHERE num < 10
)
SELECT * FROM numbers;
```
| num |
|-----|
| 1   |
| 2   |
| 3   |
| 4   |
| 5   |
| 6   |
| 7   |
| 8   |
| 9   |
| 10  |

---

Q25. Use a recursive CTE to display employee hierarchy data
```sql
WITH RECURSIVE employee_hierarchy AS (
    SELECT employee_id, employee_name, manager_id, 1 AS hierarchy_level
    FROM employees
    WHERE manager_id IS NULL
    UNION ALL
    SELECT e.employee_id, e.employee_name, e.manager_id, eh.hierarchy_level + 1
    FROM employees e
    JOIN employee_hierarchy eh ON e.manager_id = eh.employee_id
)
SELECT * FROM employee_hierarchy;
```
| employee_id | employee_name | manager_id | hierarchy_level |
|-------------|---------------|------------|-----------------|
| 1           | Alice Johnson | NULL       | 1               |
| 3           | Charlie Brown | NULL       | 1               |
| 5           | Ethan Hunt    | NULL       | 1               |
| 7           | George Miller | NULL       | 1               |
| 2           | Bob Smith     | 1          | 2               |
| 4           | Diana Prince  | 3          | 2               |
| 6           | Fiona Green   | 5          | 2               |
| 8           | Hannah Lee    | 7          | 2               |

---

## CTEs with Filters and Advanced Combinations

Q26. Create a CTE that filters orders above the average order amount
```sql
WITH avg_order AS (
    SELECT AVG(total_amount) AS avg_amount
    FROM orders
)
SELECT o.order_id, o.customer_id, o.total_amount
FROM orders o
JOIN avg_order a ON o.total_amount > a.avg_amount;
```
| order_id | customer_id | total_amount |
|----------|-------------|--------------|
| 103      | 1           | 1200.00      |
| 106      | 5           | 1500.00      |
| 108      | 1           | 1100.00      |
| 110      | 4           | 950.00       |
| 111      | 5           | 2000.00      |

---

Q27. Use a CTE and window function together to rank customers by total spending
```sql
WITH customer_spending AS (
    SELECT customer_id, SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
)
SELECT customer_id, total_spent,
       RANK() OVER (ORDER BY total_spent DESC) AS spending_rank
FROM customer_spending;
```
| customer_id | total_spent | spending_rank |
|-------------|-------------|---------------|
| 1           | 3550.00     | 1             |
| 5           | 3500.00     | 2             |
| 4           | 1850.00     | 3             |
| 2           | 1350.00     | 4             |
| 3           | 700.00      | 5             |

---

Q28. Find the second-highest salary in each department
```sql
SELECT *
FROM (
    SELECT employee_name, department, salary,
           DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS salary_rank
    FROM employees
) t
WHERE salary_rank = 2;
```
| employee_name | department | salary   | salary_rank |
|---------------|------------|----------|-------------|
| Hannah Lee    | Finance    | 82000.00 | 2           |
| Fiona Green   | HR         | 58000.00 | 2           |
| Charlie Brown | IT         | 90000.00 | 2           |
| Bob Smith     | Sales      | 65000.00 | 2           |

---

Q29. Display difference between each employee salary and department maximum salary
```sql
SELECT employee_name, department, salary,
       MAX(salary) OVER (PARTITION BY department) - salary AS salary_difference
FROM employees;
```
| employee_name | department | salary   | salary_difference |
|---------------|------------|----------|-------------------|
| George Miller | Finance    | 85000.00 | 0.00              |
| Hannah Lee    | Finance    | 82000.00 | 3000.00           |
| Ethan Hunt    | HR         | 60000.00 | 0.00              |
| Fiona Green   | HR         | 58000.00 | 2000.00           |
| Charlie Brown | IT         | 90000.00 | 5000.00           |
| Diana Prince  | IT         | 95000.00 | 0.00              |
| Alice Johnson | Sales      | 70000.00 | 0.00              |
| Bob Smith     | Sales      | 65000.00 | 5000.00           |

---

Q30. Combine CTEs and window functions to find the top-performing employee in each department based on total sales
```sql
WITH employee_sales AS (
    SELECT employee_id, SUM(total_amount) AS total_sales
    FROM orders
    GROUP BY employee_id
),
department_sales AS (
    SELECT e.employee_name, e.department, es.total_sales,
           RANK() OVER (PARTITION BY e.department ORDER BY es.total_sales DESC) AS dept_rank
    FROM employees e
    JOIN employee_sales es ON e.employee_id = es.employee_id
)
SELECT employee_name, department, total_sales
FROM department_sales
WHERE dept_rank = 1;
```
| employee_name | department | total_sales |
|---------------|------------|-------------|
| Diana Prince  | IT         | 2050.00     |
| Alice Johnson | Sales      | 4350.00     |

---

Database : PostgreSQL
Tables   : employees, customers, orders
