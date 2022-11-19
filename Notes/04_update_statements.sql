/*
Update statement is used to modify existing records in a single table in a relational database. Update statement can be represented as:
*/
-- The Update statement without the WHERE clause is used to update all rows in a table. This is rarely used in real life scenarios.
UPDATE employee_details SET SALARY = SALARY * 1.10;
-- Single column update: The Update statement with the WHERE clause is used to update only those rows that satisfy the filter criteria.
UPDATE employee_details SET SALARY = SALARY * 1.20 WHERE ID = 2;
-- multiple column update: Multiple columns can be updated in a single update statement.
UPDATE employee_details SET SALARY = SALARY * 1.3, BONUS = SALARY * 0.30 WHERE ID = 1;
-- Duplicate column update: The Update statement fails if the same column is updated multiple times in the same statement.
UPDATE employee_details SET SALARY = 100, SALARY = 200 WHERE ID = 1; -- error
-- multiple statements in where: Just like a SELECT query, there is no limit to filter conditions that can be provided in the WHERE clause.
UPDATE employee_details SET SALARY = SALARY * 1.40 WHERE DESIGNATION = 'Manager' OR department = 'ETA';
-- Foreign key violation: Any attempt to update a record with values that do not exist in the referenced table will result in a failure
UPDATE employee_details SET compid = 2005 WHERE ID = 1; -- error (if compid 2005 not exists in computer table)
update employee_details set id = 1005 where id =1;