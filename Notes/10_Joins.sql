/*
How do we fetch data from multiple tables in a single query? 
Let us say we want to display employee id, employee name along with computer id, model of the computer allocated to the employee in a single
tabular format. We can meet such requirements by using JOINS which can combine data from multiple tables
In addition we also have Cross Join also called Cartesian product which is of academic interest only and is rarely used.
*/

/*
Cross Join:
-----------
CROSS Join is also referred to as Cartesian Product. 
A CROSS join with m rows in table A and n rows in table B will always produce m * n rows. 
Essentially it combines each row from the first table with each row of the second table. 
A cross join is rarely used as it mostly produces lot of meaningless data. 
However it is useful to understand the concept of other joins.
*/
SELECT e.id, e.first_name, e.compid AS E_COMPID, c.id, c.model
FROM employee_details e CROSS JOIN computer_details c;

--select * from players;
--select * from teams;
select p.id as "Player ID", p.fname as "Player Name", p.team_id as "p_teamID",
t.id T_id, t.name as "Team Name"
from players p CROSS join teams t;
-- -------------------------------------------------------------------------------------
/*
Inner Join:
-----------
INNER Join is the most frequently used JOIN.
It matches the records from both tables based on the join predicate and returns only the matched rows. 
For ease of understanding one can think that:-
first a Cartesian Product is created and then all the rows that do not meet the join condition are dropped from the result.
Inner join also has a short hand syntax given its wide use. Let us understand this join using tables in Employee database:
*/
SELECT e.id, e.first_name, e.compid AS E_COMPID, c.id, c.model
FROM employee_details e JOIN computer_details c on e.compid = c.id;

select p.id as "Player ID", p.fname as "Player Name", p.team_id as "p_teamID",
t.id T_id, t.name as "Team Name"
from players p join teams t on p.team_id = t.id order by p.id;

/*
Inner Joins With Condition:
While using Inner Joins there can be situation where you want to filter rows based on some criteria,
e.g. a need to fetch all employees from ETA who are allocated a computer.
The filter condition can be supplied in two ways when using ANSI syntax ( t1 INNER JOIN t2 ON condition).
*/
-- Option 1: Using a WHERE clause
/*
The query is evaluated using a two step process:
Step 1. Two tables are joined using join condition and resultset is evaluated
Step 2. Filter condition in WHERE clause is applied on all the rows of the resultset to give the final result
*/
SELECT e.id, e.first_name,e.department, e.compid AS E_COMPID, c.id, c.model
FROM employee_details e JOIN computer_details c on e.compid = c.id where e.department ='RND';

select p.id as "Player ID", p.fname as "Player Name", p.team_id as "p_teamID",
t.id T_id, t.name as "Team Name"
from players p join teams t on p.team_id = t.id where p.id > 30 and t.name='Royals' order by p.id;

-- Option 2: Combining with the join condition using AND operator
/* Here the query is evaluated in a single step,
--as the filter condition is applied right at the time of join condition evaluation.*/
SELECT e.id, e.first_name,e.department, e.compid AS E_COMPID, c.id, c.model
FROM employee_details e JOIN computer_details c on e.compid = c.id and e.department ='RND';

select p.id as "Player ID", p.fname as "Player Name", p.team_id as "p_teamID",
t.id T_id, t.name as "Team Name"
from players p join teams t on p.team_id = t.id and p.id > 30 and t.name='Royals' order by p.id;

/*Question: display computer id and model of computers that are manufactured in 2019 and are allocated to employees. 
We also need to display employee id and name of the person to whom the computer is allocated.*/
SELECT e.id, e.first_name,e.department, e.compid AS E_COMPID, c.id, c.model, c.myear
FROM employee_details e JOIN computer_details c on e.compid = c.id and c.myear = 2019;


-- -------------------------------------------------------------------------------------------------------
/*
Self Join:
----------
SELF Join represents join of a table with itself. 
In this example we use inner self join to retrive employee's manager name. 
The Cartesian product of Employee table with itself will contain n x n rows. 
However only the rows which have manager matching id and these appears on the result.
*/
SELECT EMP.ID EMPID, EMP.first_name EMPNAME, MGR.ID MGRID, MGR.first_name MGRNAME 
FROM employee_details EMP INNER JOIN employee_details MGR ON EMP.MANAGER = MGR.ID order by EMP.ID;

-- Question: Display id and name of employees other than max Kollar who work in the same department as ‘Max Kollar’
select E1.ID, e1.first_name, e1.department from employee_details e1 INNER join employee_details e2
on e1.department = e2.department and e1.id <> e2.id and e2.last_name = 'Kollar' and e2.first_name = 'Max';

/* Joining multiple table
Senario:
Use Inner Join and Self Join to display id, name, manager id, manager name of all employees who have been allocated computers. 
Also display the make of the allocated computer.*/

SELECT EMP.ID EMPID, EMP.first_name EMPNAME, MGR.ID MGRID, MGR.first_name MGRNAME, cd.make 
FROM employee_details EMP INNER JOIN employee_details MGR
ON EMP.MANAGER = MGR.ID join computer_details cd on emp.compid = cd.id order by EMP.ID;

/*
Senario 2:
Display id, name, manager id, manager name of employees
whose managers have computers that are manufactured in same year as their computer.
*/
SELECT EMP.ID, EMP.first_name || '.' || EMP.last_name EMPNAME, MGR.Id MgrId, MGR.first_name || '.' || MGR.last_name MgrName,
ECD.Model AS E_MODEL,  MCD.Model AS M_MODEL, ecd.myear as "Emp comp year", mcd.myear as "MGR comp year"
FROM employee_details EMP INNER JOIN employee_details MGR ON EMP.MANAGER = MGR.ID
join computer_details ecd on emp.compid = ecd.id
INNER join computer_details mcd on mgr.compid = mcd.id
and ecd.myear = mcd.myear order by EMP.ID;

-- --------------------------------------------------------------------------------------------
/*
LEFT OUTER:
-----------
LEFT OUTER Join for tables A and B will always return all records from table A even if matching record is not found in table B
as per the join condition.For records where match is found the result set is exactly same as the inner join result.
However for non matching records all columns from table B appear as NULL in the result.
*/

SELECT EMP.ID, EMP.first_name || '.' || EMP.last_name EMPNAME, EMP.COMPID AS E_COMPID, C.ID AS C_COMPID, MODEL
FROM employee_details EMP LEFT OUTER JOIN computer_details C ON EMP.COMPID = C.id;

/*
Left Outer Join with condition
Left Outer Join is used to fetch all rows from a main table and some additional information from a lookup table
using join condition. Unlike INNER JOINs additional conditions have to be supplied carefully depending
upon the business requirement.
If the objective is to filter all records from the resultset then the filter condition must be supplied through the WHERE clause,
e.g. a need to show employee details and model of their allocated computer for all employees who belong to 'HR'.
*/
SELECT EMP.ID, EMP.first_name || '.' || EMP.last_name EMPNAME, EMP.COMPID AS E_COMPID, emp.department, C.ID AS C_COMPID, MODEL, c.myear MakeYear
FROM employee_details EMP LEFT OUTER JOIN computer_details C ON EMP.COMPID = C.id where emp.department = 'HR';

/*
However care must be taken that this filter condition is using an attribute from the main table.
Any attempt to filter (except check for NULL) using attribute from lookup table
will result in wrong output as all NULL rows will get filtered and the purpose of using OUTER join will get defeated.

If we want to conditionally fetch values from the lookup table then the additional criteria
must be combined with the join condition using AND operator,
e.g. a need to show details of all employees and in addition model of allocated computer for only those employees who are allocated a computer manufactured in '2014'.
*/
SELECT EMP.ID, EMP.first_name || '.' || EMP.last_name EMPNAME, EMP.COMPID AS E_COMPID, C.ID AS C_COMPID, MODEL, c.myear MakeYear
FROM employee_details EMP LEFT OUTER JOIN computer_details C ON EMP.COMPID = C.id and c.myear = 2019; -- will not filter null values


SELECT EMP.ID, EMP.first_name || '.' || EMP.last_name EMPNAME, EMP.COMPID AS E_COMPID, C.ID AS C_COMPID, MODEL, c.myear MakeYear
FROM employee_details EMP LEFT OUTER JOIN computer_details C ON EMP.COMPID = C.id where c.myear = 2019; -- will filter null values

-- ---------------------------------------------------------------------------------------------------------------------------------
/*
Right outer join:
-----------------
RIGHT OUTER Join for tables A and B will always return all records from table B even if matching record is not found in table A
as per the join condition. Right outer join is the mirror image of left join. 
In fact it is rarely used because the same resultset can be obtained by using a left join and reversing the order of the tables in the query.
*/

SELECT EMP.ID, EMP.first_name || '.' || EMP.last_name EMPNAME, EMP.COMPID AS E_COMPID, C.ID AS C_COMPID, MODEL, c.myear MakeYear
FROM employee_details EMP RIGHT OUTER JOIN computer_details C ON EMP.COMPID = C.id;

-------------------------------------------------------------------------------------------------
/*
Full outer Join:
----------------
FULL OUTER Join combines the effect of both LEFT OUTER JOIN and the RIGHT OUTER JOIN. 
Full Outer Join between table A and table B returns matched as well as unmatched rows from both tables. 
For two tables with p and q rows, a 1:1 relationship and m matched rows 
 - the total number of rows in the resultset is m + (p - m) + (q - m) = p + q - m.
 */
SELECT EMP.ID, EMP.first_name || '.' || EMP.last_name EMPNAME, EMP.COMPID AS E_COMPID, C.ID AS C_COMPID, MODEL, c.myear MakeYear
FROM employee_details EMP FULL OUTER JOIN computer_details C ON EMP.COMPID = C.id
