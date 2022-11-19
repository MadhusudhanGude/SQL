/*
 Earlier we have seen aggregate functions being used to calculate min, max, avg etc. for all records of the query. 
 What if the requirement is to calculate subtotals at Department level? In that case we will have to run the query once for every department. 
 Is there a better way to achieve this functionality?
 We can use GROUP BY to achieve such results using a single query. 
 GROUP BY groups the data from the table into different groups based on criteria provided and calculates the aggregate function for each group.
 Thus the result has 1 row for each group.
 */

-- Agreegate without group by: Without Group By Aggregate function produces 1 row for all the rows selected by a query

SELECT Count(employee_id) FROM employees;

-- Group by sibgle column: Use Group By clause to get department wise employee count

SELECT
    department_id,
    Count(employee_id) as "no of employees"
FROM employees
GROUP BY department_id;

/*
 Group by column does not match select columns:
 Group By converts the entire rows in a group into a single row in result. You cannot fetch details from individual rows in a category.
 Let us try to fetch count and names of employees in each department.
 */

SELECT
    employee_id,
    first_name,
    last_name,
    Count(employee_id)
FROM employees
GROUP BY department_id;

-- error

/*
 Note: should match with the attributes mentioned in select and group by,
 i.e what are all the attributes mentioned in select should present in group by, but vise versa is valid case(statement 2)
 */

SELECT
    job_id,
    department_id,
    Count(employee_id)
FROM employees
GROUP BY
    department_id,
    job_id;

SELECT
    department_id,
    Count(employee_id)
FROM employees
GROUP BY
    department_id,
    job_id;

/*Group By Multiple column: Group By can also be used with multiple columns. 
 In that case it treats each distinct combination of the columns as a single category.
 Let us display maximum salary paid to each designation, within each department.
 */

select
    max(salary),
    job_id,
    department_id
from employees
GROUP BY
    department_id,
    job_id;

-- Group by Multiple functions: You can use multiple aggregate functions in the same query as long as category for grouping is the same.

* /
select
    max(salary),
    min(salary),
    job_id,
    department_id
from employees
GROUP BY
    department_id,
    job_id;

-- Nested aggrigate functions: You can nest aggregate functions up to maximum of 2 levels using Group By clause.

SELECT MAX(AVG(Salary)) FROM Employees GROUP BY department_id;

SELECT MAX(AVG(Salary)) FROM Employees GROUP BY department_id;

-- Group by on nullable columns: You can use GROUP BY with columns that contain NULL values

SELECT manager_id, Count(*) FROM Employees GROUP BY manager_id;

/*
 We have now seen how to use GROUP BY in conjunction with aggregate functions to get summary of data category wise. 
 What if we want to filter this summary?
 For e.g. if we want to fetch only those departments whose average salary of their employees is greater than a specific value.
 This can be achieved using HAVING clause. 
 Having allows aggregate functions to be used as filter criteria which cannot be done using WHERE clause.
 */

SELECT
    SUM(Salary),
    AVG(MAX(salary))
FROM employees
GROUP BY department_id
HAVING SUM(Salary) > 90000;

SELECT
    department_id,
    SUM(Salary)
FROM employees
WHERE Salary > 1000
GROUP BY department_id
HAVING Count(employee_id) > 1;

-- Group by errors:

-- 01. Aggregate functions cannot be used in WHERE clause.

SELECT
    first_name,
    Salary,
    department_id
FROM Employees E1
WHERE Salary = MAX(Salary);

-- error

SELECT
    salary,
    max(Salary),
    department_id
FROM Employees E1
group by
    department_id,
    salary
having Salary = MAX(Salary);

-- 02. Aggregate functions cannot be used in WHERE clause even if GROUP BY is used.

SELECT
    department_id,
    SUM(Salary)
FROM Employees
WHERE SUM(Salary) > 2000
GROUP BY department_id;

-- error

SELECT
    salary,
    max(Salary),
    department_id
FROM Employees E1
group by
    department_id,
    salary
having Salary > 2000;

-- 03. nested aggrigate function: Nested aggregate function cannot be used in SELECT clause without GROUP BY clause.

SELECT MAX(AVG(Salary)) FROM Employees;

--error

SELECT MAX(AVG(Salary)) FROM Employees GROUP BY department_id;

-- In correct order by: Order By cannot be used on columns on which Grouping is not being done.

SELECT
    department_id,
    SUM(Salary)
FROM Employees
GROUP BY department_id
ORDER BY job_id;

-- errror;

SELECT
    department_id,
    SUM(Salary)
FROM Employees
GROUP BY department_id
ORDER BY department_id;

/* Write a query to fetch those departments that have average salary greater than 2000.
 --Average salary should be rounded to two decimal places.*/

SELECT
    salary,
    ROUND(salary, 2),
    max(Salary),
    department_id
FROM Employees E1
group by
    department_id,
    salary
having Salary > 2000;