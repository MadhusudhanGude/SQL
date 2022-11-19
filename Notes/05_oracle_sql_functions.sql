--select * from employee_details;

--alter table employee_details RENAME column first_name TO last_name;
--alter table employee_details RENAME column ename TO first_name;

/*
Numeric functions: Numeric functions are single row functions that accept a numeric value and return numeric output.
- ABS	ABS(value)	Returns absolute value of a number
- ROUND	ROUND(value, digits)	Rounds the value to specified decimal digits
- CEIL	CEIL(value)	Rounds up the fractional value to next integer
- FLOOR	FLOOR(value)	Rounds down the fractional value to the lower integer
*/
SELECT first_name,
salary, CEIL(salary) AS "Ceiling",
FLOOR(salary) AS "Floor",
ABS(salary) as "Absolute",
round(salary, 1) as "round"  FROM employee_details;

/*
Character functions: Character functions work on character strings and can return a character string or a numeric value.
- UPPER	UPPER(value)	Converts value to upper case
- LOWER	LOWER(value)	Converts value in lower case
- CONCAT	CONCAT(value1, value2)	Concatenates value1 and value2
- LENGTH	LENGTH(value)	Returns the number of characters in value.
*/
SELECT first_name, LENGTH(first_name) "LENGTH",  LOWER(first_name) "LOWERCASE", UPPER(first_name) "UPPERCASE" FROM employee_details;
-- Contact
SELECT first_name,
CONCAT(first_name, last_name) "CONCAT",
first_name || '.' || last_name "ConcatByOperator",
CONCAT(CONCAT(first_name, ', '), last_name) "NestedConcat" FROM employee_details;

-- Substring function is used to extract part of a string. It has the following syntax SUBSTR(value, start_position, length)
select SUBSTR('DATABASE',3,4)from dual;
SELECT last_name,
SUBSTR(last_name,1,4) FIRST4,
SUBSTR(last_name,2,10) TEN_FROM_2,
SUBSTR(last_name,3) ALL_FROM_3 FROM employee_details;

SELECT doj, SUBSTR(doj,1,2) "DAY", SUBSTR(doj,4,3) "MONTH", SUBSTR(doj,8) "YEAR" FROM employee_details;

/*
conversion functions: Use conversion functions to convert data from one format to another.
- TO_CHAR	TO_CHAR(value, format)	Converts a number or a date to a string. Use this function for formatting dates and numbers.
- TO_DATE	TO_DATE (value, format)	Converts a string to a date.
- TO_NUMBER	TO_NUMBER (value, format)	Converts a string to a number.
*/

-- TOChar: Use TO_CHAR to format a number by adding comma at specific locations, adding currency symbols, 
-- determining the number of digits before and after decimal.
SELECT salary,
TO_CHAR(salary) DEF_FORMAT,
TO_CHAR(salary, '9999.99') "FIXED_DIGITS",
TO_CHAR(salary, '99,99,999') "COMMA" FROM employee_details;

select to_char(sysdate+35, 'DD/MM/YYYY') from dual;
select first_name, to_char(doj, 'DD/Mon/YYYY') as doj from employee_details;


/*
Use TO_NUMBER to convert a number string into a number.
The format, if provided, is used to parse the input i.e. the output is not formatted.
*/
SELECT '1000.98' "ORIG_NOFORMAT",
TO_NUMBER('1000.98') "CONV_NOFORMAT",
'1,000.98' "ORIG_FORMAT",
TO_NUMBER('1,000.98', '9,999.99') "CONV_FORMAT" FROM DUAL;

/*
To_date:
If date string is not in default Oracle format then TO_DATE function will give error if used without format string.
*/
SELECT '01-Jan-2014' DATE_STRING, TO_DATE('01-Jan-2014') CONV_NOFORMAT, TO_DATE('01-Jan-2014', 'DD-Mon-YYYY') CONV_FORMAT FROM DUAL;
SELECT 'Jan-01-2014' DATE_STRING, TO_DATE('Jan-01-2014') CONV_NOFORMAT FROM DUAL;
SELECT 'Jan-01-2014' DATE_STRING, TO_DATE('Jan-01-2014', 'Mon-DD-YYYY') CONV_FORMAT FROM DUAL;

/*
Date Functions: Database provides functions to determine the current time
and to perform date operations like adding a specific duration to a date,
finding time difference between two dates etc.
- SYSDATE	SYSDATE	Returns current date of System i.e. the host on which database server is installed.
- SYSTIMESTAMP	SYSTIMESTAMP	Returns current timestamp of the System.
- ADD_MONTHS	ADD_MONTHS(date, n)	Adds n months to the given date.
- MONTHS_BETWEEN	MONTHS_BETWEEN(date1,date2)	Finds difference between two dates in months.
*/
SELECT SYSDATE, SYSTIMESTAMP FROM DUAL;
SELECT doj, ADD_MONTHS(doj, 1) "NEXT_MONTH" FROM employee_details;
SELECT MONTHS_BETWEEN('01-March-2014', '01-Feb-2014') "MONTH_DIFF1",
MONTHS_BETWEEN('10-Jan-2014', '01-Jan-2014') "MONTH_DIFF2" FROM DUAL;

/*
Aggregate functions operate on multiple rows to return a single row.
Some aggregate functions like SUM (total), AVG (average) operates only on numeric columns.
while others like MIN (lowest value), MAX (highest value) and COUNT (number of rows) operate on all data types. 
All aggregate functions ignore NULL values except COUNT(*)
*/
SELECT  MIN(Salary), MAX(Salary), SUM(Salary) FROM employee_details;

-- Use COUNT function to calculate the number of rows returned by a query.
SELECT COUNT(ID) COUNT_ID, COUNT(*) COUNT_STAR, COUNT(manager) COUNT_manager FROM employee_details;
/* Use DISTINCT with COUNT function to get a count of unique values for a column.
--Similary DISTINCT can also be used with other aggregate functions.*/
SELECT COUNT(department) Count1, COUNT(DISTINCT department) Count2 FROM employee_details;

-- AVG function can be treated as SUM / COUNT. It does not consider rows with null values for calculation.
SELECT AVG(Salary) AvgSalary, AVG(Bonus) AvgBonus1, SUM(Bonus) / Count(Bonus) AvgBonus2 FROM employee_details;

-- Use NVL to replace missing data with default value.
-- NVL	NVL(value1, value2)	Substitutes value1 by value2 if value1 is NULL. The data type of value1 and value2 must be same.
select first_name,manager, NVL(manager,'NO Manager') as "Not Assigned" from employee_details;
SELECT first_name, NVL(Manager, 0)  from employee_details;
-- gives the current logged in user
SELECT USER FROM DUAL;