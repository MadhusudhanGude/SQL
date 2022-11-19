/*
Subquery is a query within a query. A subquery must be enclosed in brackets and can be used in SELECT, FROM, WHERE and HAVING clauses.
Subquery in SELECT and FROM clause are rarely used. Subqueries in WHERE and HAVING clauses are classified into Independent and Correlated subqueries.
*/
select * from employee_details;

-- A subquery in SELECT clause can return a single value (single row and single column). better to provide an alias name
select id, first_name,last_name ,(select avg(salary) from employee_details) from employee_details;

-- A subquery in FROM clause is also called an Inline View and it should be aliased in the query
-- The subquery filters three columns from the employee table which are displayed by the parent query.
SELECT * FROM (SELECT ID, first_name, SALARY FROM employee_details) A

/*
Independent Query:
------------------
In an independent subquery, the inner and outer query are independent of each other.
You can run an inner query and inspect its result independent of the outer query. 
Independent subquery are further classified into single row and multiple row types depending upon the number of rows returned.

Query execution seq:
1. inner query executes
2. the result of inner query is substitued inouter query
3.outer query executes
*/
-- Ex1: Single row equality operator: Fetch details of employees who are getting highest salary.
SELECT Id, first_name, Salary, department FROM employee_details E1 WHERE Salary = (SELECT MAX(Salary) FROM employee_details E2)

-- Single row nested functions: Display the department in which the maximum total salary is paid to the employees.
SELECT department FROM employee_details GROUP BY department HAVING SUM(Salary) = (SELECT MAX(SUM(Salary)) FROM employee_details GROUP BY department);

-- Multiple row IN operator: Display the details of computer which are allocated to the employees
SELECT cd.id, cd.make, Model FROM computer_details cd WHERE id IN (SELECT distinct CompId FROM Employee_details);

/*
Independent subquery can be replaced by join if it is used with IN clause to fetch foreign keys from another table. 
The JOIN solution for query in example 3 (Multiple Row- In Operator) 
*/
SELECT distinct C.id, Make, Model FROM computer_details C join Employee_details E on E.CompId = C.id order by c.id;
-- The above query can be written in the below format
SELECT distinct C.id, Make, Model FROM computer_details C, Employee_details E WHERE E.CompId = C.id order by c.id;

/* No Subquery equalent: A Join cannot be replaced by a subquery if it is using columns from both the tables in SELECT clause. 
Attributes from subquery tables cannot be accessed in the outer query.
*/
SELECT e.Id, first_name, E.CompId, Make FROM computer_details C, Employee_details E WHERE E.CompId = C.id;

-- Subquery madatory: A Subquery must be used if value of aggregate function is required in where clause.
SELECT first_name,department, salary FROM Employee_details WHERE Salary>(SELECT AVG(Salary) FROM Employee_details);

-- Question: Display the employee id and date for most recent joined employee.
select id, first_name, doj from  Employee_details where doj = (select max(doj) from Employee_details);

/*
Correlated subquery:
A Correlated subquery is one in which the inner query that depends upon the outer query for it's execution. 
Specifically it uses a column from one of the tables in the outer query. 
The inner query is executed iteratively for each selected row of the outer query. 
In case of independent subquery, the inner query just executes once.
*/
-- Example: Display the details of all employees whose salary is greater than or equal to average salary of the employees in their own department.
SELECT Id, first_name, department, Salary FROM Employee_details E1 
WHERE Salary >=(SELECT AVG(Salary) FROM Employee_details E2 WHERE E1.department = E2.department);
-- Display the details of all employees whose salary is greater than their manager’s salary.
SELECT e.Id, e.first_name, e.department, e.Salary "EMP_sal", m.salary "M_salary" FROM Employee_details E join  Employee_details M on e.manager = m.id
WHERE e.salary > m.salary; 

SELECT Id, e.first_name, e.department, e.Salary "EMP_sal" FROM Employee_details E
WHERE Salary > (SELECT Salary FROM Employee_details M WHERE E.Manager = M.ID);

/*
EXISTS keyword is used to check presence of rows in the subquery. 
The main query returns the row only if at least one row exists in the subquery. 
EXISTS clause follows short circuit logic i.e. the query calculation is terminated as soon as criteria is met. 
As a result it is generally faster than equivalent join statements.
*/
-- Question: display the computer details which are allocated to employees
SELECT id, Make, Model FROM computer_details C WHERE EXISTS (SELECT 1 FROM Employee_details E WHERE E.CompId = C.id);

SELECT distinct c.id, Make, Model FROM computer_details C join employee_details e on c.id = e.compid;

/*
NOT EXISTS is opposite of EXISTS i.e. 
it is used to check absence of rows in the subquery. The main query returns the row only if at least no row exists in the subquery. 
It also uses short circuit logic and is hence faster.
*/
-- Question: display the computer details which not are allocated to employees
SELECT id, Make, Model FROM computer_details C WHERE NOT EXISTS (SELECT 1 FROM Employee_details E WHERE E.CompId = C.id);
