# SQL NULL Functions – ISNULL, COALESCE, NULLIF

=======================

## Schema Tables: Employees, Orders, Products

---

## Table Structure & Sample Data

```sql
CREATE TABLE Employees (
    emp_id INT,
    name VARCHAR(50),
    salary INT,
    bonus INT,
    manager_id INT
);

INSERT INTO Employees VALUES
(1, 'Amit',  50000, NULL,  101),
(2, 'John',  NULL,  5000,  102),
(3, 'Sara',  60000, NULL,  NULL),
(4, 'David', NULL,  NULL,  103),
(5, 'Priya', 45000, 3000,  101),
(6, 'Kiran', NULL,  NULL,  NULL),
(7, 'Ravi',  70000, 7000,  102),
(8, 'Neha',  NULL,  2000,  NULL);

CREATE TABLE Orders (
    order_id INT,
    customer_name VARCHAR(50),
    amount INT,
    discount INT,
    coupon_code VARCHAR(20)
);

INSERT INTO Orders VALUES
(101, 'Amit',  1000, NULL, 'DISC10'),
(102, 'John',  NULL, 50,   NULL),
(103, 'Sara',  2000, NULL, 'DISC20'),
(104, 'David', NULL, NULL, NULL),
(105, 'Priya', 1500, 100,  NULL),
(106, 'Kiran', NULL, NULL, 'DISC5'),
(107, 'Ravi',  3000, NULL, NULL),
(108, 'Neha',  NULL, 200,  'DISC15');

CREATE TABLE Products (
    product_id INT,
    product_name VARCHAR(50),
    price INT,
    category VARCHAR(50),
    stock INT
);

INSERT INTO Products VALUES
(1, 'Laptop',     50000, 'Electronics', 10),
(2, 'Phone',      NULL,  'Electronics', NULL),
(3, 'Tablet',     30000, NULL,          5),
(4, 'Headphones', NULL,  NULL,          NULL),
(5, 'Monitor',    20000, 'Electronics', 0),
(6, 'Keyboard',   NULL,  'Accessories', 15),
(7, 'Mouse',      500,   NULL,          NULL),
(8, 'Printer',    NULL,  'Electronics', 3);
```

---

## Quick Concept Reference

-- ISNULL(col, value)   → replaces NULL with a given value
-- COALESCE(a, b, c)   → returns the first non-NULL value
-- NULLIF(a, b)         → returns NULL if a = b, else returns a
-- IS NULL              → filters rows where value IS NULL
-- IS NOT NULL          → filters rows where value IS NOT NULL

---

## LEVEL 1 – Basic NULL Filtering

--Q1. Show all employees whose salary is NULL
>> SELECT * FROM Employees
   WHERE salary IS NULL;

--Q2. Show all orders where discount is NOT NULL
>> SELECT * FROM Orders
   WHERE discount IS NOT NULL;

--Q3. Get products where category is NULL
>> SELECT * FROM Products
   WHERE category IS NULL;

--Q4. Count number of employees with NULL manager_id
>> SELECT COUNT(*) AS null_manager_count
   FROM Employees
   WHERE manager_id IS NULL;

---

## LEVEL 2 – ISNULL Replacement

--Q5. Replace NULL salary with 0
>> SELECT emp_id, name, ISNULL(salary, 0) AS salary
   FROM Employees;

--Q6. Replace NULL bonus with 1000
>> SELECT emp_id, name, ISNULL(bonus, 1000) AS bonus
   FROM Employees;

--Q7. Show order amount; if NULL replace with 500
>> SELECT order_id, customer_name, ISNULL(amount, 500) AS amount
   FROM Orders;

--Q8. Replace NULL stock with 0
>> SELECT product_id, product_name, ISNULL(stock, 0) AS stock
   FROM Products;

---

## LEVEL 3 – COALESCE

--Q9. Show employee earnings: use salary, if NULL use bonus
>> SELECT emp_id, name, COALESCE(salary, bonus) AS earnings
   FROM Employees;

--Q10. Show first available value: salary → bonus → 0
>> SELECT emp_id, name, COALESCE(salary, bonus, 0) AS earnings
   FROM Employees;

--Q11. Show product price: price → 1000 (default)
>> SELECT product_id, product_name, COALESCE(price, 1000) AS price
   FROM Products;

--Q12. Get customer payment: amount → discount → 0
>> SELECT order_id, customer_name, COALESCE(amount, discount, 0) AS payment
   FROM Orders;

---

## LEVEL 4 – NULLIF

--Q13. Convert salary to NULL if salary = 0
>> SELECT emp_id, name, NULLIF(salary, 0) AS salary
   FROM Employees;

--Q14. Convert discount to NULL if discount = 0
>> SELECT order_id, customer_name, NULLIF(discount, 0) AS discount
   FROM Orders;

--Q15. Use NULLIF to avoid divide by zero
>> SELECT order_id, amount, discount,
          amount / NULLIF(discount, 0) AS amount_per_discount
   FROM Orders;

--Q16. Replace coupon_code with NULL if it is 'DISC10'
>> SELECT order_id, customer_name, NULLIF(coupon_code, 'DISC10') AS coupon_code
   FROM Orders;

---

## LEVEL 5 – Real-Time Scenarios

--Q17. Calculate total earnings: salary + bonus (handle NULL properly)
>> SELECT emp_id, name,
          ISNULL(salary, 0) + ISNULL(bonus, 0) AS total_earnings
   FROM Employees;

--Q18. Show employees where both salary AND bonus are NULL
>> SELECT emp_id, name
   FROM Employees
   WHERE salary IS NULL AND bonus IS NULL;

--Q19. Show products where price is NULL but category is NOT NULL
>> SELECT product_id, product_name, price, category
   FROM Products
   WHERE price IS NULL AND category IS NOT NULL;

--Q20. Show orders where both amount and discount are NULL
>> SELECT order_id, customer_name
   FROM Orders
   WHERE amount IS NULL AND discount IS NULL;

---

## LEVEL 6 – Advanced

--Q21. Show employee income using COALESCE: salary → bonus → 1000
>> SELECT emp_id, name,
          COALESCE(salary, bonus, 1000) AS income
   FROM Employees;

--Q22. Replace empty discount with NULL using NULLIF
>> SELECT order_id, customer_name,
          NULLIF(discount, 0) AS discount
   FROM Orders;

--Q23. Show final payable amount: amount - discount (handle NULL)
>> SELECT order_id, customer_name,
          ISNULL(amount, 0) - ISNULL(discount, 0) AS final_payable
   FROM Orders;

--Q24. Find employees where salary is NULL but manager exists
>> SELECT emp_id, name, salary, manager_id
   FROM Employees
   WHERE salary IS NULL AND manager_id IS NOT NULL;
