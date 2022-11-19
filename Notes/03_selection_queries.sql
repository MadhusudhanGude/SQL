--select queries allows us to retrive data from one or more tables in a rational databaase. below are the examples.

-- fetch all columns and all rows
select * from employee_details;

--select specify number of columns
select doj, department, designation from employee_details;

/*
select with alias
Keyword "AS' is optional
*/
select ename as "Employee name", doj "Date of Joining" from employee_details;

/*
Const:-  A hardcoded value in select clause will appear as an additional column in the result with the same value on all records.
*/
SELECT EName, 30 AS Value FROM employee_details;
/*
DISTINCT:-  Use DISTINCT clause to remove duplicates. Usage of DISTINCT should be avoided as far as possible as it can lead to performance issues.
*/
SELECT DISTINCT department FROM employee_details; -- single column
SELECT DISTINCT department, Manager FROM employee_details; -- multiple columns

/*
Where Clause: used to filter rows based on some conidition
*/
-- Use comparison operators to restrict rows. The filter criteria can be on attributes that are not on the select clause.
SELECT ID, ENAME FROM employee_details WHERE SALARY > 40000;
select id, ename from employee_details where ename = 'Max'; -- Text values need to be enclosed in single quotes.
select ename as "Employee name", doj "Date of Joining" from employee_details WHERE UPPER(Ename) = UPPER('max');
-- AND operator can be used to combine multiple conditions when all conditions must evaluate to true.
select id, ename, department, designation from employee_details where salary > 2000 and LOWER(designation) = LOWER('MANAGER');
-- OR operator can be used to combine multiple conditions when only one of the conditions must evaluate to true.
SELECT ID, ename, department, salary FROM employee_details WHERE SALARY > 123453 OR department = 'RND';
-- BETWEEN operator is used to check for values within a range. The result includes both the boundary values.
SELECT ID, ENAME, salary FROM employee_details WHERE SALARY BETWEEN 10000 and 50000;
/*IN operator is used to check for multiple values of an attribute. 
It is equivalent to OR operation on multiple equality condition on the attribute on individual values.
*/
select id, ename, department from employee_details where department in (Upper('hR'),UPPER('PAY'));
-- IN with duplicates: If IN clause contains duplicate values then the database server will remove duplicates before executing the query.
SELECT ID, ENAME, department FROM employee_details WHERE department IN ('HR', 'HR');
-- not in: NOT operator is used to negate the condition
SELECT ID, ENAME, department FROM employee_details WHERE department not IN ('HR');
-- =Null: Equal to operator cannot be used to check for NULL values
select id, ename, department, manager from employee_details where manager = NULL;
/*if CHAR data types are stored with trailing spaces. While filtering them using equality operator you need not provide trailing spaces.
Trailing spaces are ignored for CHAR data type.
Leading spaces are not ignored for CHAR data type. If you use them you will not fetch any records.*/
select id, ename, designation, department from employee_details where department = 'RND';
/*
You can also filter for VARCHAR2 columns using equality operator.
Trailing spaces are not ignored for VARCHAR2 data type.
Leading spaces are not ignored for VARCHAR2 data type
*/
select id, ename, designation, department from employee_details where ename = 'Max';


/*
Like Operator: LIKE operator is used to match a character pattern. It allows us to use wild cards.
SQL supports two wild cards: '%' which matches with any number of characters and '_' which matches with exactly one character.
*/
select id, ename from employee_details where ename LIKE 'V%'; -- starting with letter V
select id, ename from employee_details where ename LIKE '%x'; -- ending with letter x
select id, ename from employee_details where ename LIKE '%a%'; -- anywhere having letter a
select id, ename, doj from employee_details where doj LIKE '__-___-__'; -- fixed parrtern
--Mixed pattern: Displays those rows where name contains second character as ‘a’ followed by any number of characters.
SELECT ID, ENAME FROM employee_details WHERE ENAME LIKE '_a%';