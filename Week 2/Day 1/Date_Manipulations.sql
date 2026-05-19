# DATE & TIMESTAMP FUNCTIONS IN MYSQL

=======================

## Schema Tables: orders

---

## Table Structure & Sample Data

```sql
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    order_date DATE,
    order_timestamp TIMESTAMP,
    delivery_date DATE,
    order_amount DECIMAL(10,2)
);

INSERT INTO orders VALUES
(1, 'Karthik', '2024-01-15', '2024-01-15 10:30:45', '2024-01-20', 2500.00),
(2, 'Veena',   '2024-02-18', '2024-02-18 18:45:20', '2024-02-22', 3200.50),
(3, 'Ravi',    '2024-03-02', '2024-03-02 09:15:10', '2024-03-08', 4100.75),
(4, 'Anil',    '2024-03-09', '2024-03-09 14:05:55', '2024-03-15', 1800.00),
(5, 'Suresh',  '2024-01-07', '2024-01-07 23:55:00', '2024-01-12', 2900.00);
```

---

## DATE & TIMESTAMP Data Types

| Type      | Stores                        |
|-----------|-------------------------------|
| DATE      | YYYY-MM-DD                    |
| TIME      | HH:MM:SS                      |
| DATETIME  | Date + time (no timezone)     |
| TIMESTAMP | Date + time (timezone aware)  |

---

## Current Date & Time Functions

--Q1. Get current date
>> SELECT CURDATE();
>> SELECT CURRENT_DATE();

--Q2. Get current time
>> SELECT CURTIME();
>> SELECT CURRENT_TIME();

--Q3. Get current date and time
>> SELECT NOW();
>> SELECT CURRENT_TIMESTAMP;

---

## Extracting Date Parts

--Q4. Extract year, month, day using YEAR(), MONTH(), DAY()
>> SELECT YEAR(order_date), MONTH(order_date), DAY(order_date)
   FROM orders;

--Q5. Extract year, month, day using EXTRACT()
>> SELECT EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date), EXTRACT(DAY FROM order_date)
   FROM orders;

--Q6. Get month name and day name
>> SELECT MONTHNAME(order_date), DAYNAME(order_date)
   FROM orders;

---

## Weekday & Weekend Functions

--Q7. Get weekday number and day of week
>> SELECT WEEKDAY(order_date), DAYOFWEEK(order_date)
   FROM orders;

-- Note: WEEKDAY() → 0–6 (Monday=0) | DAYOFWEEK() → 1–7 (Sunday=1)

--Q8. Identify weekend orders using DAYNAME
>> SELECT order_id, order_date
   FROM orders
   WHERE DAYNAME(order_date) IN ('Saturday', 'Sunday');

--Q9. Identify weekend orders using DAYOFWEEK
>> SELECT order_id, order_date
   FROM orders
   WHERE DAYOFWEEK(order_date) IN (1, 7);

--Q10. Identify weekday orders
>> SELECT order_id, order_date
   FROM orders
   WHERE DAYOFWEEK(order_date) BETWEEN 2 AND 6;

---

## Date Arithmetic

--Q11. Add 5 days to order date
>> SELECT order_date, DATE_ADD(order_date, INTERVAL 5 DAY)
   FROM orders;

--Q12. Subtract 3 days from order date
>> SELECT order_date, DATE_SUB(order_date, INTERVAL 3 DAY)
   FROM orders;

--Q13. Add 1 month to order date
>> SELECT DATE_ADD(order_date, INTERVAL 1 MONTH)
   FROM orders;

--Q14. Subtract 2 months from order date
>> SELECT DATE_SUB(order_date, INTERVAL 2 MONTH)
   FROM orders;

--Q15. Add 1 year to order date
>> SELECT DATE_ADD(order_date, INTERVAL 1 YEAR)
   FROM orders;

---

## Date Difference Functions

--Q16. Calculate delivery days using DATEDIFF
>> SELECT order_id, DATEDIFF(delivery_date, order_date) AS delivery_days
   FROM orders;

--Q17. Calculate difference in days and months using TIMESTAMPDIFF
>> SELECT TIMESTAMPDIFF(DAY, order_date, delivery_date) AS days_diff,
          TIMESTAMPDIFF(MONTH, order_date, delivery_date) AS months_diff
   FROM orders;

---

## First & Last Day of Month

--Q18. Get last day of the month
>> SELECT LAST_DAY(order_date)
   FROM orders;

--Q19. Get first day of the month
>> SELECT DATE_SUB(order_date, INTERVAL DAY(order_date)-1 DAY)
   FROM orders;

---

## Date Formatting

--Q20. Format date as DD-MM-YYYY
>> SELECT DATE_FORMAT(order_date, '%d-%m-%Y')
   FROM orders;

--Q21. Format date as Month DD, YYYY
>> SELECT DATE_FORMAT(order_date, '%M %d, %Y')
   FROM orders;

--Q22. Format timestamp as DD-MM-YYYY HH:MM:SS
>> SELECT DATE_FORMAT(order_timestamp, '%d-%m-%Y %H:%i:%s')
   FROM orders;

-- Common Format Specifiers:
-- %Y → Year (2024) | %y → Year (24) | %m → Month number | %M → Month name
-- %d → Day | %W → Weekday name | %H → Hour | %i → Minutes | %s → Seconds

--Q23. Convert string to date using STR_TO_DATE
>> SELECT STR_TO_DATE('15-01-2024', '%d-%m-%Y');

---

## Filtering by Date

--Q24. Filter orders placed in January
>> SELECT * FROM orders
   WHERE MONTH(order_date) = 1;

--Q25. Filter orders placed in February using MONTHNAME
>> SELECT * FROM orders
   WHERE MONTHNAME(order_date) = 'February';

--Q26. Filter orders placed in the last 7 days
>> SELECT * FROM orders
   WHERE order_date >= CURDATE() - INTERVAL 7 DAY;

--Q27. Filter orders placed today using timestamp
>> SELECT * FROM orders
   WHERE DATE(order_timestamp) = CURDATE();

---

## Financial Year Logic

--Q28. Determine financial year for each order using CASE
>> SELECT order_date,
          CASE
              WHEN MONTH(order_date) >= 4 THEN CONCAT(YEAR(order_date), '-', YEAR(order_date)+1)
              ELSE CONCAT(YEAR(order_date)-1, '-', YEAR(order_date))
          END AS financial_year
   FROM orders;
