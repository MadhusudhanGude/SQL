/*
Use UNION and UNION ALL clause to combine results from two or more SELECT statements.
The select statements may be from same or different tables.
They must have same number of columns and their data types at same position in both the query
must be compatible (either same or convertible through automatic conversion).
Note: UNION removes all duplicates from the result.
Two records are considered duplicates if values at corresponding positions of all their columns match.
*/
-- Use UNION to combine data from two SELECT statements and remove duplicates.
SELECT CompId FROM employee_details UNION SELECT id FROM computer_details;
-- UNION ALL does not remove duplicates.
SELECT CompId FROM employee_details UNION ALL SELECT id FROM computer_details;
-- The number of columns in both SELECT statements must be the same.
SELECT first_name, CompId FROM employee_details UNION ALL SELECT id FROM computer_details; --error
-- Data Type of columns at same position in both SELECT statements must be the same.
SELECT first_name FROM employee_details UNION ALL SELECT id FROM computer_details; --error
/*
UNION clause does not guarantee the order in which rows from both SELECT statements will appear in the final result.
You can use ORDER BY to sort the final result.
ORDER BY clause can be placed only once and it must be at the end of second SELECT statement.
*/
SELECT CompId FROM employee_details e UNION SELECT id FROM computer_details c ORDER BY CompId;