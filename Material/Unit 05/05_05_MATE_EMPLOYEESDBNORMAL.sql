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