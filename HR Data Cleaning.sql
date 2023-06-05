USE project1
;
SELECT *
FROM hr
;
DESCRIBE hr
;

ALTER TABLE hr
CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NULL
;
SELECT birthdate 
FROM hr
;
UPDATE hr
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'),'%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'),'%Y-%m-%d')
    ELSE NULL
END;
SELECT birthdate
from hr
;
ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

UPDATE hr
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'),'%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'),'%Y-%m-%d')
    ELSE NULL
END;
ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

SELECT hire_date
from hr
;

UPDATE hr
SET termdate = IF(termdate IS NOT NULL AND termdate != '', date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC')), '0000-00-00')
WHERE true;

SELECT termdate from hr;

SET sql_mode = 'ALLOW_INVALID_DATES';

ALTER TABLE hr
MODIFY COLUMN termdate DATE;

ALTER TABLE hr
ADD COLUMN age INT;

UPDATE hr
SET age = timestampdiff(YEAR,birthdate, CURDATE());
SELECT emp_id, first_name, last_name, birthdate, age
FROM hr;

SELECT
	min(age) AS youngest,
    max(age) AS oldest
FROM hr;

SELECT count(*)
FROM hr
WHERE age < 18;