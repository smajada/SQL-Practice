-- 1.Write a query in SQL to display the first name, last name, department_id, 
-- and department name for each employee (table:departments,employees).
SELECT
    first_name,
    last_name,
    employees.department_id,
    department_name
FROM
    departments,
    employees
WHERE
    employees.department_id = departments.department_id;

-- 2.Write a query in SQL to display the first and last name, department, city,
-- and state province for each employee (table: employees, departments, locations).
SELECT
    first_name,
    last_name,
    department_name,
    locations.city,
    state_province
FROM
    employees,
    departments,
    locations
WHERE
    employees.department_id = departments.department_id
    AND departments.location_id = locations.location_id;

-- 3.Write a query in SQL to display the first name, last name, salary, and job_title 
-- for all employees (table: employees, jobs).
SELECT
    first_name,
    last_name,
    salary,
    job_title
FROM
    employees,
    jobs
WHERE
    employees.job_id = jobs.job_id;

-- 4.Write a query in SQL to display the first name, last name, department_id and 
-- department name, for all employees for departments 1 and 2  (table: departments, employees).
SELECT
    first_name,
    last_name,
    employees.department_id,
    department_name
FROM
    departments,
    employees
WHERE
    (
        employees.department_id = 1
        OR employees.department_id = 2
    )
    AND employees.department_id = departments.department_id
ORDER BY
    first_name;

-- 5.Write a query in SQL to display those employees who contain a letter ‘a’ 
-- into their first name and also display their last name, department, city, and state_province 
-- (table: departments, employees, locations).
SELECT
    first_name,
    last_name,
    department_name,
    city,
    state_province
FROM
    departments,
    employees,
    locations
WHERE
    first_name LIKE 'a%'
    AND departments.department_id = employees.department_id
    AND departments.location_id = locations.location_id;

-- 6.Write a query in SQL to display those employees whose first name contains a 
-- letter ‘e’ in the third position and are part of the Purchasing department 
-- (table: departments, employees).

SELECT
    first_name,
    last_name,
    department_name
FROM
    departments,
    employees
WHERE
    first_name like '__e%'
    AND department_name like 'Purchasing';