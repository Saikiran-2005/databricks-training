# SQL REGEX – Basic Assignment
=======================

## Table Structure

CREATE TABLE regex_practice (
    id           INT,
    full_text    VARCHAR(200),
    email        VARCHAR(100),
    phone        VARCHAR(30),
    mixed_value  VARCHAR(100)
);

---

## mixed_value Extractions

--Q1. Extract numeric characters that appear at the very beginning of `mixed_value`. Stop as soon as a non-numeric character appears.

>> SELECT id, mixed_value,
          REGEXP_SUBSTR(mixed_value, '^[0-9]+') AS leading_digits
   FROM regex_practice;

--Q2. Extract numeric characters that appear at the very end of `mixed_value`. No alphabetic or special characters should be included.

>> SELECT id, mixed_value,
          REGEXP_SUBSTR(mixed_value, '[0-9]+$') AS trailing_digits
   FROM regex_practice;

--Q3. Extract only the first single character of `mixed_value`, regardless of whether it is a letter or a number.

>> SELECT id, mixed_value,
          REGEXP_SUBSTR(mixed_value, '^.') AS first_char
   FROM regex_practice;

--Q4. Extract only the last single character of `mixed_value`.

>> SELECT id, mixed_value,
          REGEXP_SUBSTR(mixed_value, '.$') AS last_char
   FROM regex_practice;

--Q5. Extract exactly two consecutive numeric characters that appear anywhere in `mixed_value`. Do not extract more or fewer than two digits.

>> SELECT id, mixed_value,
          REGEXP_SUBSTR(mixed_value, '[0-9]{2}') AS two_digits
   FROM regex_practice;

--Q6. Extract exactly one numeric character that appears anywhere in `mixed_value`.

>> SELECT id, mixed_value,
          REGEXP_SUBSTR(mixed_value, '[0-9]{1}') AS one_digit
   FROM regex_practice;

--Q8. Extract the numeric portion that is present between alphabetic characters in `mixed_value`.

>> SELECT id, mixed_value,
          REGEXP_SUBSTR(mixed_value, '(?<=[a-zA-Z])[0-9]+(?=[a-zA-Z])') AS digits_between_alpha
   FROM regex_practice;

--Q13. Extract only alphabetic characters that appear together as a continuous sequence in `mixed_value`.

>> SELECT id, mixed_value,
          REGEXP_SUBSTR(mixed_value, '[a-zA-Z]+') AS alpha_sequence
   FROM regex_practice;

--Q14. Extract only numeric characters that appear together as a continuous sequence in `mixed_value`.

>> SELECT id, mixed_value,
          REGEXP_SUBSTR(mixed_value, '[0-9]+') AS numeric_sequence
   FROM regex_practice;

---

## email Extractions

--Q9. Extract the text that appears before the `@` symbol in `email`. The extracted value must not include `@` itself.

>> SELECT id, email,
          REGEXP_SUBSTR(email, '^[^@]+') AS local_part
   FROM regex_practice;

--Q10. Extract the text that appears after the `@` symbol including the domain name in `email`.

>> SELECT id, email,
          REGEXP_SUBSTR(email, '@(.+)', 1, 1, NULL, 1) AS domain_full
   FROM regex_practice;

--Q11. Extract only the domain name (text after `@`, excluding `@` itself) from `email`.

>> SELECT id, email,
          REGEXP_SUBSTR(email, '[^@]+$') AS domain_name
   FROM regex_practice;

--Q12. Extract only the text that appears after the last dot in the `email` address (i.e., the TLD).

>> SELECT id, email,
          REGEXP_SUBSTR(email, '[^.]+$') AS tld
   FROM regex_practice;

---

## phone Extractions

--Q7. Extract the country code present at the beginning of the `phone` number. The extracted value must contain only the country code digits (no `+` or `-`).

>> SELECT id, phone,
          REGEXP_SUBSTR(phone, '[0-9]+') AS country_code
   FROM regex_practice;

--Q20. Extract the numeric characters that appear immediately after the `+` sign in `phone`. Include only the digits that represent the country code.

>> SELECT id, phone,
          REGEXP_SUBSTR(phone, '(?<=\\+)[0-9]+(?=-)') AS code_after_plus
   FROM regex_practice;

---

## full_text Extractions

--Q15. Extract exactly the first three characters of `full_text`.

>> SELECT id, full_text,
          REGEXP_SUBSTR(full_text, '^.{3}') AS first_three
   FROM regex_practice;

--Q16. Extract exactly the last two characters of `full_text`.

>> SELECT id, full_text,
          REGEXP_SUBSTR(full_text, '.{2}$') AS last_two
   FROM regex_practice;

--Q17. Extract the employee number portion that appears between the alphabetic prefix and the first underscore in `full_text`.

>> SELECT id, full_text,
          REGEXP_SUBSTR(full_text, '(?<=[A-Z])[0-9]+(?=_)') AS emp_number
   FROM regex_practice;

--Q18. Extract the country code that appears at the end of `full_text`.

>> SELECT id, full_text,
          REGEXP_SUBSTR(full_text, '[0-9]+$') AS end_country_code
   FROM regex_practice;

--Q19. Extract the alphabetic text that appears between two underscore characters in `full_text`.

>> SELECT id, full_text,
          REGEXP_SUBSTR(full_text, '(?<=_)[A-Za-z]+(?=_)') AS text_between_underscores
   FROM regex_practice;

---

> **Database:** MySQL
> **Table:** regex_practice
