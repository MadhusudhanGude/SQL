/*
DELETE statement is used to delete records from a single table in a relational database.
The database system ensures that no constraints are violated during execution of a delete statement.
Any violation of constraints results in failure of the statement.

TRUNCATE statement can also be used to delete data from tables.
TRUNCATE statement deletes all rows from the table as it does not support WHERE clause.
TRUNCATE statement is a faster option compared to DELETE when you have to delete all rows from the table.
*/

-- Delete statement with WHERE clause is used to delete those rows that meet the filter criteria.
delete from employee_details where id =6;
-- Multiple rows can be deleted using a single delete statement.
DELETE FROM employee_details WHERE department ='PAY' and Manager = 7;
-- Any attempt to delete a record that violates the foreign key results in a failure.
delete from employee_details where id =1;
-- Delete statement will remove all rows of a table if it is used without a where clause.
DELETE FROM Employee;