-- 1. Show the last name, occupation and department number of each employee.
select surname, occupation, dept_num from employees;

--2. Show the number and name of each department.
select num, name from departments;

-- 3. Show all the data of all the employees.
select * from employees;

-- 4. Employee data sorted by last name ascendent.
select * from employees order by surname asc;
-- 5. Employee data sorted by department number descending.
select * from employees order by dept_num desc;

-- 6. Employee data sorted by department number descending and, within each department,
-- sort data by employee surname ascending.
select * from employees order by dept_num desc, surname asc;

-- 7. Show the data of the employees whose salary is greater than 20000.
select * from employees where salary > 20000;

-- 8. Show the data of the employees whose occupation is 'SALESMAN'.
select * from employees where occupation = 'salesman';

-- 9. Select the surname and occupation of the employees of department number 20.
select surname, occupation from employees, departments where department = 20;

-- 10. Select employees whose occupation is 'SALESMAN'. Show data sorted by surname.
select * from employees where occupation = 'salesman' order by surname;

-- 11. Show employees whose department is 20 or 30 and whose occupation is 'MANAGER'.
-- Sort the result by dept_num descendent and surname ascendent.
SELECT *
FROM employees, departments
WHERE departments.num = employees.dept_num
AND (dept_num = 20 OR dept_num = 30)
AND occupation = 'manager'
order by dept_num desc, surname asc;


-- 12. Show employees who have a salary greater than 20000 or who belong to the department
-- number 20.
select * from employees, departments where departments.num = employees.dept_num and (salary > 20000 or dept_num = 20);

-- 13. Show employees sorted by their occupation and by their surname.
select * from employees order by occupation, surname;

-- 14. Select employees from the EMPLOYEES table whose surname starts with 'S'.
select * from employees where surname like 'S%';

-- 15. Select from the EMPLOYEE table those rows whose SURNAME starts with 'C 'and the
-- occupation has an 'E' in any position.
select * from employees where surname like 'C%' and occupation like '%e%';

-- 16. Select employees whose salary is between 10000 and 20000.
select * from employees where salary between 10000 and 20000;

-- 17. Obtain the employees whose occupation is 'SALESMAN' and have a commission
-- exceeding 1000.
select * from employees where occupation = 'salesman' and commission > 1000;

-- 18. Number and surnames of the employees whose surname ends with 'S' and have a salary
-- higher than 30000.
select num, surname from employees where surname like '%S' and salary > 30000;

-- 19. Data of the departments whose name starts with 'A' and ends with ???G???.
select * from departments where name like 'A%G';

-- 20. Show the surnames of the employees who do not have a commission (clue: is NULL).
select surname from employees where commission is null;

-- 21. Show the surnames of the employees who do not have a commission and whose last
-- name begins with 'H' (clue: is NULL).
select surname from employees where comission is null and surname like 'H%';

-- 22. Show the surnames of the employees whose occupation is 'SALESMAN', 'MANAGER' or
-- 'EMPLOYEE'.
select surname from employees where occupation = 'SALESMAN' or occupation = 'MANAGER' or occupation = 'EMPLOYEE';

-- 23. Show the surnames of the employees whose occupation is neither "MANAGER" nor
-- "EMPLOYEE", and also have a salary higher than 20000.
select surname from employees where occupation not in ('MANAGER', 'EMPLOYEE') and salary > 20000;

-- 24. Select the surname, salary and department number of employees whose salary is
-- greater than 20000 in departments 10 or 30.
SELECT surname, salary, dept_num FROM employees
WHERE dept_num IN ('10', '30') AND salary > 20000;

-- 25. Show the surname and number of employees whose salary is not between 10000 and
-- 20000.
surname, num from employees where salary not in (between 10000 and 20000);

-- 26. Get the surnames of all employees in lowercase.
select lower(surname) from employees;

-- 27. In a query, concatenate the name of each employee with his/her surname.
select concat(name, ' ', surname) as full_name from employees;

-- 28. Show the surname and the length of the surname (function LENGTH) of all employees,
-- sorted by the length of the surnames of the employees descending.
SELECT surname, LENGTH(surname) AS l_surnames FROM employees ORDER BY l_surnames DESC;

-- 29. Show data of the employees whose surname have 4 characters and ends with ???N???. Do a
-- version using the function LENGTH and another one without it.
select * from employees where length(surname) = 4 and surname like '%N';
select * from employees where surname like '___N';


-- 30. Obtain the years of recruitment of all employees (YEAR function) but without duplicated
-- data. Order the results.
select year(begin_date) from employees order by begin_date;

-- 31. Show the data of the employees that have been recruited in the year 1992.
select * from employees where year(begin_date) = '1992';

-- 32. Show data of employees who have been recruited in the month of February of any year
-- (function MONTHNAME).
select * from employees where MONTHNAME(begin_date) = 'February';

-- 33. Show the data of the employees whose surname begins with 'R' and have been recruited
-- in the year 1990.
select * from employees where year(begin_date) = '1990' and surname like 'R%';

-- 34. Show the name, surname, department name of the employees who have no commission
-- (clue: is NULL).
select employees.name, surname, departments.name from employees, departments where commission is null and employees.dept_num = departments.num;

-- 35. Show the name, surname and occupation of employees with the name, surname and
-- occupation of their managers. Columns must have different names and you must order it by
-- the manager surname.
select t.name empl_name, t.surname empl_surname, t.occupation empl_occupation,
s.name man_name, s.surname man_surname, s.occupation man_occupation
from employees t, employees s
where t.manager = s.num
order by s.surname;