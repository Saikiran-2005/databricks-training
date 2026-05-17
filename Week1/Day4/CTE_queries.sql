# SQL CTE Queries

=======================

## CTEs – Common Table Expressions

--Q21. Create a CTE to calculate total sales per employee
>> WITH employee_sales AS (
       SELECT employee_id, SUM(total_amount) AS total_sales
       FROM orders
       GROUP BY employee_id
   )
   SELECT e.employee_name, es.total_sales
   FROM employees e
   JOIN employee_sales es ON e.employee_id = es.employee_id;

--Q22. Use a CTE to find employees whose sales exceed company average
>> WITH employee_sales AS (
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

--Q23. Create multiple CTEs to calculate customer total spending and rankings
>> WITH customer_spending AS (
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

---

## Recursive CTEs

--Q24. Write a recursive CTE to generate numbers from 1 to 10
>> WITH RECURSIVE numbers AS (
       SELECT 1 AS num
       UNION ALL
       SELECT num + 1
       FROM numbers
       WHERE num < 10
   )
   SELECT * FROM numbers;

--Q25. Use a recursive CTE to display employee hierarchy data
>> WITH RECURSIVE employee_hierarchy AS (
       SELECT employee_id, employee_name, manager_id, 1 AS hierarchy_level
       FROM employees
       WHERE manager_id IS NULL
       UNION ALL
       SELECT e.employee_id, e.employee_name, e.manager_id, eh.hierarchy_level + 1
       FROM employees e
       JOIN employee_hierarchy eh ON e.manager_id = eh.employee_id
   )
   SELECT * FROM employee_hierarchy;

--Q26. Create a CTE that filters orders above the average order amount
>> WITH avg_order AS (
       SELECT AVG(total_amount) AS avg_amount
       FROM orders
   )
   SELECT o.order_id, o.customer_id, o.total_amount
   FROM orders o
   JOIN avg_order a ON o.total_amount > a.avg_amount;

--Q27. Use a CTE and window function together to rank customers by total spending
>> WITH customer_spending AS (
       SELECT customer_id, SUM(total_amount) AS total_spent
       FROM orders
       GROUP BY customer_id
   )
   SELECT customer_id, total_spent,
          RANK() OVER (ORDER BY total_spent DESC) AS spending_rank
   FROM customer_spending;

--Q28. Find the second-highest salary in each department
>> SELECT *
   FROM (
       SELECT employee_name, department, salary,
              DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS salary_rank
       FROM employees
   ) t
   WHERE salary_rank = 2;

--Q29. Display difference between each employee salary and department maximum salary
>> SELECT employee_name, department, salary,
          MAX(salary) OVER (PARTITION BY department) - salary AS salary_difference
   FROM employees;

--Q30. Combine CTEs and window functions to find the top-performing employee in each department based on total sales
>> WITH employee_sales AS (
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

