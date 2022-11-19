select * from employees;

select department_id, sum(salary) from employees GROUP BY department_id HAVING SUM(salary) > 10000;

-- Aggrigate fns can not be used in where clause
select department_id, salary from employees where salary = max(salary); -- error
select department_id, salary, max(salary) from employees GROUP by salary, department_id HAVING salary = max(salary);
select department_id, salary, max(salary) from employees where sum(salary) >2000 GROUP by salary, department_id HAVING salary = max(salary); -- error

select max(avg(salary)) from employees; -- error
select max(avg(salary)) from employees group by department_id;

-- select department_id, salary, ROUND(salary,2), max(salary) from employees GROUP by salary, department_id HAVING salary = max(salary);

-- union and union all
SELECT * from employees where job_id = 'IT_PROG';
SELECT * from employees where job_id = 'PU_CLERK';