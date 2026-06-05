# MYSQL NUMERIC FUNCTIONS
=======================

## Table Structure

CREATE TABLE employee_salary (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    base_salary DECIMAL(10,2),
    bonus DECIMAL(10,2),
    tax_percent DECIMAL(5,2),
    experience_years INT
);

---

## Insert Sample Data

INSERT INTO employee_salary VALUES
(1, 'Karthik', 75000.75, 5000.50, 10.00, 6),
(2, 'Veena', 65000.40, 4000.25, 8.50, 4),
(3, 'Ravi', 85000.90, 6000.75, 12.00, 8),
(4, 'Anil', 70000.10, NULL, 9.00, 5),
(5, 'Suresh', 60000.55, 3000.30, 7.50, 3);

---

## ABS – Absolute Value

--Q1. Return the absolute (positive) value of a number.

>> SELECT ABS(-100);

---

## ROUND – Round to Decimals

--Q2. Round salary values to the nearest whole number.

>> SELECT ROUND(base_salary, 0)
   FROM employee_salary;

--Q3. Round salary values to two decimal places.

>> SELECT ROUND(base_salary, 2)
   FROM employee_salary;

---

## CEILING / CEIL – Round Up

--Q4. Round salary values upward to the next integer.

>> SELECT CEIL(base_salary)
   FROM employee_salary;

---

## FLOOR – Round Down

--Q5. Round salary values downward to the nearest integer.

>> SELECT FLOOR(base_salary)
   FROM employee_salary;

---

## TRUNCATE – Cut Decimals (No Rounding)

--Q6. Remove decimal places after one digit without rounding.

>> SELECT TRUNCATE(base_salary, 1)
   FROM employee_salary;

---

## MOD – Remainder

--Q7. Find the remainder when experience years are divided by 2.

>> SELECT MOD(experience_years, 2)
   FROM employee_salary;

---

## POWER / POW – Exponent

--Q8. Calculate 2 raised to the power of 3.

>> SELECT POWER(2, 3);

--Q9. Calculate 5 raised to the power of 2.

>> SELECT POW(5, 2);

---

## SQRT – Square Root

--Q10. Find the square root of 64.

>> SELECT SQRT(64);

---

## SIGN – Sign of Number

--Q11. Determine whether salary values are positive, negative, or zero.

>> SELECT SIGN(base_salary)
   FROM employee_salary;

---

## RAND – Random Number

--Q12. Generate a random number.

>> SELECT RAND();

---

## FORMAT – Format Number as String

--Q13. Format salary values with two decimal places.

>> SELECT FORMAT(base_salary, 2)
   FROM employee_salary;

> Note: FORMAT() returns a string, not a numeric value.

---

## GREATEST – Maximum Value

--Q14. Return the greater value between salary and bonus.

>> SELECT emp_name,
          GREATEST(base_salary, IFNULL(bonus, 0))
   FROM employee_salary;

---

## LEAST – Minimum Value

--Q15. Return the smaller value between salary and bonus.

>> SELECT emp_name,
          LEAST(base_salary, IFNULL(bonus, 0))
   FROM employee_salary;

---

> **Database:** MySQL
> **Table:** employee_salary
> **Note:** Numeric functions are used for mathematical calculations, rounding values, generating random numbers, and comparing numeric data in MySQL.
