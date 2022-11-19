/*
Order By clause is used to sort the result of a query in a particular order.
We all know that data in a single column can be sorted in ascending or descending order.

We can also sort data by multiple columns. In such a case data is sorted on primary (first) column first. 
Note: Sorting on secondary column happens only when multiple rows have the same value in the primary column. 
The sort order can be different for the two columns i.e. primary can be sorted in ascending and secondary in descending and vice-versa. 
This two column sorting mechanism can be extended to any number of columns.
*/

-- Single Column Default:  Data is sorted in Ascending Order if the sort order is not specified
select employee_id, first_name, last_name, department_id from employees order by department_id;
-- Single Column assending: You can sort the result based on any data type
select employee_id, first_name, last_name, department_id from employees order by department_id ASC;
-- Single Column descending: Use DESC keyword after the column name to sort result in descending order
select employee_id, first_name, last_name, department_id from employees order by department_id DESC;
-- Multiple columns: Provide comma separated any number of columns in Order by clause to sort on multiple columns
select employee_id, first_name, last_name, department_id, job_id  from employees order by department_id, first_name;
-- Mutliple sort order: Each column in ORDER BY clause can have its own sort order, ascending or descending
select employee_id, first_name, last_name, department_id, job_id  from employees order by department_id asc, first_name desc;
-- Positional sort: Column position in the query can be used as an alternative to column name in ORDER BY clause
select employee_id, first_name, last_name, department_id, hire_date  from employees order by 5;
-- Not in select clause: The column being sorted need not be present in the SELECT clause
select employee_id, first_name, last_name, department_id, hire_date  from employees order by salary;
-- Note: Order By clause must be the last clause in the query.
select employee_id, first_name, last_name, department_id, hire_date  from employees order by salary where id <10; -- error
-- Null columns ASC: You can specify ORDER BY on columns that contain NULL values.
select employee_id, first_name, last_name, manager_id  from employees order by manager_id;
-- Null column DESC: You can specify ORDER BY DESC on columns that contain NULL values.
select employee_id, first_name, last_name, manager_id  from employees order by manager_id desc;
-- Sorting with filter
select employee_id, first_name, last_name, manager_id  from employees where first_name like '__a%' order by first_name, manager_id desc;