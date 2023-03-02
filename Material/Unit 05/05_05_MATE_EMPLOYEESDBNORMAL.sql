-- 1. Display the number of employees in each department. Use GROUP BY to group by department. 
select count(employees.num), departments.name from employees, departments group by departments.name;

--2. For each occupation obtain the average salary. 
select avg(salary), occu_code from employees group by occu_code;

-- 3. Display the departments with more than 5 employees. Use GROUP BY to group by department and HAVING to establish the condition on the groups. 
select count(employees.name), departments.name from employees, departments where dept_num = departments.num group by dept_num;

-- 4. Find the average wages of each department (use the function avg and GROUP BY).
select avg(salary), departments.name from employees, departments where dept_num = departments.num group by dept_num;

-- 5. Display the surname of the salesmen of the 'SALES' department. 
SELECT
    surname
FROM
    employees,
    departments
WHERE
    departments.name = 'sales'
    AND dept_num = departments.num;
--6. Display the sum of salaries of the 'SALES' department. 
SELECT
    sum(salary)
FROM
    employees,
    departments
WHERE
    departments.name = 'sales'
    AND dept_num = departments.num;
--7. Display the count of employees with occupation “EMPLOYEE” in every department (show the name of the department). 
select count(employees.name) num_empl, departments.name from employees, departments where dept_num = departments.num and occu_code = 'EMP' group by dept_num;


--8. Show the number of different occupations in each department. 
select count(occu_code), departments.name from employees, departments where dept_num = departments.num group by dept_num;

--9. Show departments that have more than two people working in the same occupation. 
select count(occu_code), departments.name from employees, departments where dept_num = departments.num group by departments.name having count(occu_code) > 2;

--10. Displays a query that is the union between the table OCCUPATIONS and TOWNS.
(select * from occupations) union (select * from towns);

--11. Do the same query as in exercise 10 but order the results by name. 
(select * from occupations) union (select * from towns) order by name;

--12. Select the occupation names of all the employees of the department with name ‘RESEARCH’ 
--and do the union of this query with the selection of the occupation names of the employees of the 
--department with name ‘SALES’. Use the union operator. 
SELECT
    occupations.name
FROM
    occupations,
    departments,
    employees
WHERE
    occupations.code = employees.occu_code
    AND departments.num = employees.dept_num
    AND departments.name = 'RESEARCH'
UNION
SELECT
    occupations.name
FROM
    occupations,
    departments,
    employees
WHERE
    occupations.code = employees.occu_code
    AND departments.num = employees.dept_num
    AND departments.name = 'SALES';

--13. Repeat the last query showing the repeated results (union all).
SELECT
    occupations.name
FROM
    occupations,
    departments,
    employees
WHERE
    occupations.code = employees.occu_code
    AND departments.num = employees.dept_num
    AND departments.name = 'RESEARCH'
UNION
ALL
SELECT
    occupations.name
FROM
    occupations,
    departments,
    employees
WHERE
    occupations.code = employees.occu_code
    AND departments.num = employees.dept_num
    AND departments.name = 'SALES';

--14. Display the number of sellers in the 'SALES' department. 
SELECT
    count(surname)
FROM
    employees,
    occupations,
    departments
WHERE
    occu_code = occupations.code
    AND dept_num = departments.num
    AND occupations.name = 'SALESMAN'
    AND departments.name = 'SALES';

--15. Display the surnames and occupations of the employees of the 'SALES' department. 
SELECT
    surname, occupations.name
FROM
    employees,
    occupations,
    departments
WHERE
    occu_code = occupations.code
    AND dept_num = departments.num
    AND occupations.name = 'SALESMAN'
    AND departments.name = 'SALES';

--16. Display the number of employees for each occupation of the 'SALES' department. 
SELECT
    count(surname), occupations.name
FROM
    employees,
    occupations,
    departments
WHERE
    occu_code = occupations.code
    AND dept_num = departments.num
    AND departments.name = 'SALES'
group by 
occupations.name;

--17. Display the number of employees of each department whose profession is "EMPLOYEE".
SELECT
    departments.name, count(surname) no_employees
FROM
    employees,
    occupations,
    departments
WHERE
    occu_code = occupations.code
    AND dept_num = departments.num
    AND occupations.name = 'EMPLOYEE'
group by 
departments.name;

--18. Display the department names and the count of employees working into them. 
SELECT
    departments.name, count(surname) no_employees
FROM
    employees,
    occupations,
    departments
WHERE
    occu_code = occupations.code
    AND dept_num = departments.num
group by 
departments.name;

--19. Display the maximum number of employees of all the departments. 
--In other words, find the maximum value of the column showing the maximum number 
--of employees in the previous exercise. 
--(clue: you need exercise 18 as a subquery and you should use MAX function). 
select max(num_employees) 
from (SELECT
    departments.name, count(surname) num_employees
FROM
    employees,
    occupations,
    departments
WHERE
    occu_code = occupations.code
    AND dept_num = departments.num
group by 
departments.name) as temp_query;

--20. Show the departments whose average salary is greater than the average of salaries of all employees. 
SELECT
    departments.name,
    avg(salary)
FROM
    employees,
    departments
WHERE
    departments.num = dept_num
GROUP BY
    departments.name
HAVING
    avg(salary) > (
        SELECT
            avg(salary)
        FROM
            employees
    );

-- 21. Display the name of the department with more employees 
-- and its number of employees. Option 1: combine “having” and 
-- a subselect. In case of a tie, this option will show all the 
-- departments with a maximum number of employees.
SELECT
    DEPARTMENTS.name,
    count(EMPLOYEES.num) AS num_employees
FROM
    employees,
    DEPARTMENTS
WHERE
    EMPLOYEES.dept_num = DEPARTMENTS.num
GROUP BY
    DEPARTMENTS.name
HAVING
    num_employees = (
        SELECT
            max(num_employees)
        FROM
            (
                SELECT
                    DEPARTMENTS.name,
                    count(EMPLOYEES.num) AS num_employees
                FROM
                    EMPLOYEES,
                    DEPARTMENTS
                WHERE
                    EMPLOYEES.dept_num = DEPARTMENTS.num
                GROUP BY
                    DEPARTMENTS.name
            ) AS temp_query
    );

-- 22 Repeat 12 changing “union” for “intersect”.
SELECT
    OCCUPATIONS.name
FROM
    EMPLOYEES,
    DEPARTMENTS,
    OCCUPATIONS
WHERE
    EMPLOYEES.dept_num = DEPARTMENTS.num
    AND EMPLOYEES.occu_code = OCCUPATIONS.code
    AND DEPARTMENTS.name = 'RESEARCH'
INTERSECT
SELECT
    OCCUPATIONS.name
FROM
    EMPLOYEES,
    DEPARTMENTS,
    OCCUPATIONS
WHERE
    EMPLOYEES.dept_num = DEPARTMENTS.num
    AND EMPLOYEES.occu_code = OCCUPATIONS.code
    AND DEPARTMENTS.name = 'SALES';

-- 23.  Repeat 22 but do not use the intersect 
-- operator to query the same data (clue: IN operator).
SELECT
    DISTINCT OCCUPATIONS.name
FROM
    EMPLOYEES,
    DEPARTMENTS,
    OCCUPATIONS
WHERE
    EMPLOYEES.dept_num = DEPARTMENTS.num
    AND EMPLOYEES.occu_code = OCCUPATIONS.code
    AND DEPARTMENTS.name = 'RESEARCH'
    AND OCCUPATIONS.name IN (
        SELECT
            OCCUPATIONS.name
        FROM
            EMPLOYEES,
            DEPARTMENTS,
            OCCUPATIONS
        WHERE
            EMPLOYEES.dept_num = DEPARTMENTS.num
            AND EMPLOYEES.occu_code = OCCUPATIONS.code
            AND DEPARTMENTS.name = 'SALES'
    );
--24. Display the number of employee and occupation name of the employees of the 'SALES' department. 
select employees.num, occupations.name
from employees, occupations, departments
where
employees.occu_code = occupations.code
and departments.num = employees.dept_num
and departments.name = 'SALES';

