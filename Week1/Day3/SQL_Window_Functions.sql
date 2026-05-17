# SQL Window Functions

=======================

## Window Functions – ROW_NUMBER, RANK, DENSE_RANK

--Q1. Use ROW_NUMBER() to assign a row number to employees ordered by salary descending
>> SELECT employee_name, salary,
          ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num
   FROM employees;

--Q2. Use RANK() to rank employees by salary
>> SELECT employee_name, salary,
          RANK() OVER (ORDER BY salary DESC) AS salary_rank
   FROM employees;

--Q3. Use DENSE_RANK() to rank employees by salary
>> SELECT employee_name, salary,
          DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_salary_rank
   FROM employees;

--Q4. Find the top 3 highest-paid employees using a window function
>> SELECT *
   FROM (
       SELECT employee_name, salary,
              ROW_NUMBER() OVER (ORDER BY salary DESC) AS rn
       FROM employees
   ) t
   WHERE rn <= 3;

--Q5. Rank employees within each department using PARTITION BY
>> SELECT employee_name, department, salary,
          RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dept_rank
   FROM employees;

---

## Window Functions – Aggregate with OVER()

--Q6. Display the highest salary in each department using a window function
>> SELECT employee_name, department, salary,
          MAX(salary) OVER (PARTITION BY department) AS highest_department_salary
   FROM employees;

--Q7. Calculate the running total of order amounts ordered by order_date
>> SELECT order_id, order_date, total_amount,
          SUM(total_amount) OVER (ORDER BY order_date) AS running_total
   FROM orders;

--Q8. Calculate the cumulative sales amount for each employee
>> SELECT employee_id, order_id, total_amount,
          SUM(total_amount) OVER (PARTITION BY employee_id ORDER BY order_date) AS cumulative_sales
   FROM orders;

--Q9. Use LAG() to show the previous order amount for each customer
>> SELECT customer_id, order_id, order_date, total_amount,
          LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS previous_order_amount
   FROM orders;

--Q10. Use LEAD() to show the next order amount for each customer
>> SELECT customer_id, order_id, order_date, total_amount,
          LEAD(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS next_order_amount
   FROM orders;

--Q11. Find the difference between current order amount and previous order amount
>> SELECT customer_id, order_id, order_date, total_amount,
          total_amount - LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS amount_difference
   FROM orders;

--Q12. Calculate a moving average of the last 3 orders
>> SELECT order_id, order_date, total_amount,
          AVG(total_amount) OVER (ORDER BY order_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg
   FROM orders;

--Q13. Use NTILE(4) to divide employees into salary quartiles
>> SELECT employee_name, salary,
          NTILE(4) OVER (ORDER BY salary DESC) AS salary_quartile
   FROM employees;

--Q14. Find the first order placed by each customer using ROW_NUMBER()
>> SELECT *
   FROM (
       SELECT customer_id, order_id, order_date, total_amount,
              ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date) AS rn
       FROM orders
   ) t
   WHERE rn = 1;

--Q15. Find the latest order placed by each customer
>> SELECT *
   FROM (
       SELECT customer_id, order_id, order_date, total_amount,
              ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date DESC) AS rn
       FROM orders
   ) t
   WHERE rn = 1;

--Q16. Display employee salaries along with department average salary
>> SELECT employee_name, department, salary,
          AVG(salary) OVER (PARTITION BY department) AS department_avg_salary
   FROM employees;

--Q17. Find employees earning above their department average salary
>> SELECT *
   FROM (
       SELECT employee_name, department, salary,
              AVG(salary) OVER (PARTITION BY department) AS dept_avg_salary
       FROM employees
   ) t
   WHERE salary > dept_avg_salary;

--Q18. Use SUM() OVER(PARTITION BY department) to calculate department payroll
>> SELECT employee_name, department, salary,
          SUM(salary) OVER (PARTITION BY department) AS department_payroll
   FROM employees;

--Q19. Find percentage contribution of each employee salary within their department
>> SELECT employee_name, department, salary,
          ROUND(salary * 100.0 / SUM(salary) OVER (PARTITION BY department), 2) AS salary_percentage
   FROM employees;

--Q20. Use COUNT() OVER() to show total number of employees alongside each row
>> SELECT employee_name, department,
          COUNT(*) OVER () AS total_employees
   FROM employees;

---

Database : MySQL
Tables : Employees, Orders
