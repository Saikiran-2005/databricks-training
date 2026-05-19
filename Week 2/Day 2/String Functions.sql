# STRING FUNCTIONS IN MYSQL

=======================

## Schema Table: employees

---

## Table Structure & Sample Data

```sql
CREATE TABLE employees (

    emp_id INT PRIMARY KEY,

    full_name VARCHAR(100),

    email VARCHAR(100),

    department VARCHAR(50),

    city VARCHAR(50),

    salary VARCHAR(20),

    remarks VARCHAR(200)

);

INSERT INTO employees VALUES

(1, 'Karthik Kondpak', 'karthik.k@gmail.com', 'Data Engineering', 'Hyderabad', '75000', ' Top performer '),

(2, 'Veena Reddy', 'veena_r@company.com', 'Analytics', 'Bangalore', '65000', 'Excellent communication'),

(3, 'Ravi kumar', 'ravi.kumar@org.in', 'Data Science', 'Chennai', '85000', 'Needs improvement'),

(4, 'Anil', 'anil@abc.com', 'DEVOPS', 'Pune', '70000', NULL),

(5, ' Suresh ', 'suresh@xyz.com', 'data engineering', ' hyderabad ', '60000', ' ');

-----------------------------------------------------

## LENGTH() / CHAR_LENGTH()

--Q1. Find length of employee names using LENGTH()
>> SELECT full_name,
          LENGTH(full_name)
   FROM employees;

--Q2. Find character length using CHAR_LENGTH()
>> SELECT full_name,
          CHAR_LENGTH(full_name)
   FROM employees;

-- Note:
-- CHAR_LENGTH() is safer for multi-byte characters.

---

## UPPER() / LOWER()

--Q3. Convert department to uppercase and city to lowercase
>> SELECT UPPER(department),
          LOWER(city)
   FROM employees;

---

## TRIM() / LTRIM() / RTRIM()

--Q4. Remove spaces from names
>> SELECT
          TRIM(full_name),
          LTRIM(full_name),
          RTRIM(full_name)
   FROM employees;

---

## CONCAT()

--Q5. Combine employee name and department
>> SELECT CONCAT(full_name, ' - ', department) AS emp_details
   FROM employees;

---

## CONCAT_WS() (With Separator)

--Q6. Combine emp_id, name and city
>> SELECT CONCAT_WS(' | ', emp_id, full_name, city)
   FROM employees;

---

## SUBSTRING() / SUBSTR() / MID()

--Q7. Extract first 7 characters from email
>> SELECT SUBSTRING(email, 1, 7)
   FROM employees;

--Q8. Extract first 5 characters using SUBSTR()
>> SELECT SUBSTR(email, 1, 5)
   FROM employees;

---

## LEFT() / RIGHT()

--Q9. Get first 4 characters of name and last 3 of city
>> SELECT LEFT(full_name, 4),
          RIGHT(city, 3)
   FROM employees;

---

## INSTR()

--Q10. Find position of '@' in email
>> SELECT email,
          INSTR(email, '@')
   FROM employees;

---

## LOCATE()

--Q11. Find position of '.' in email
>> SELECT email,
          LOCATE('.', email)
   FROM employees;

-- Note:
-- LOCATE() is similar to INSTR() but more flexible.

---

## REPLACE()

--Q12. Replace 'Data' with 'Big Data'
>> SELECT REPLACE(department, 'Data', 'Big Data')
   FROM employees;

---

## REVERSE()

--Q13. Reverse employee names
>> SELECT full_name,
          REVERSE(full_name)
   FROM employees;

---

## LPAD() / RPAD()

--Q14. Pad emp_id with zeros
>> SELECT LPAD(emp_id, 5, '0')
   FROM employees;

--Q15. Pad city name with '*'
>> SELECT RPAD(city, 15, '*')
   FROM employees;

---

## TRIM() + REPLACE() (Combined Usage)

--Q16. Remove all spaces from city names
>> SELECT TRIM(REPLACE(city, ' ', ''))
   FROM employees;

---

## IFNULL()

--Q17. Replace NULL remarks with default text
>> SELECT full_name,
          IFNULL(remarks, 'No remarks')
   FROM employees;

---

## COALESCE()

--Q18. Return remarks or 'N/A'
>> SELECT full_name,
          COALESCE(remarks, 'N/A')
   FROM employees;

---

## FIND_IN_SET()

--Q19. Find position of 'Analytics'
>> SELECT FIND_IN_SET('Analytics', 'Data,Analytics,AI');
