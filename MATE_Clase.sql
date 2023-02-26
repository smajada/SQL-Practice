--ejercicio practica base de datos exercice
--primer paso
ALTER TABLE
    employees
ADD
    COLUMN mentor_id INT;

--segundo paso
ALTER TABLE
    employees
ADD
    CONSTRAINT mentor_employee_id_fk FOREIGN KEY (mentor_id) REFERENCES employees(employee_id);

--tercer paso
ALTER TABLE
    employees DROP FOREIGN KEY mentor_employee_id_fk;

--cuarto paso
ALTER TABLE
    employees DROP COLUMN mentor_id;

--quinto paso
SELECT
    *
FROM
    employees;

--cuarto ejercicio
''' es falso''' --quinto ejercicio
-- para poder ver las FK and PK
SELECT
    CONSTRAINT_NAME,
    CONSTRAINT_TYPE
FROM
    INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE
    TABLE_NAME = 'employees';

--queries
SELECT
    instructor.name,
    department.building
FROM
    instructor,
    department
WHERE
    instructor.dept_name = department.dept_name;

--columnes amb eL mateix nom es quan escriuriem instructor.name...
SELECT
    instructor.name,
    department.budget
FROM
    instructor,
    department
WHERE
    instructor.dept_name = department.dept_name;

SELECT
    name,
    budget
FROM
    instructor,
    department
WHERE
    instructor.dept_name = department.dept_name;

SELECT
    name,
    course_id
FROM
    instructor,
    teaches
WHERE
    instructor.ID = teaches.ID;

----------------------------- 19/01/2023 -----------------------------
-- SELECT a query WHERE the name of the department is "????. ???."
SELECT
    dept_name
FROM
    department
WHERE
    dept_name LIKE "____. ___.";

-- SELECT all the dept. names that have the letter "e"
SELECT
    dept_name
FROM
    department
WHERE
    dept_name LIKE "%e%";

-- select all the dept_names that have exactly 7 characters
SELECT
    dept_name
FROM
    department
WHERE
    dept_name LIKE "_______";

-- Match all the dept_names that have 7 or more characters
SELECT
    dept_name
FROM
    department
WHERE
    dept_name LIKE "%_______";

-- select those professional skills de la base de dades professional_skills that have an accomplishment or 100%
SELECT
    *
FROM
    professional_skills
WHERE
    accomplishment LIKE '%10\%' ----------------------------- 23/01/2023 -----------------------------
    -- Select the first character starting from the end of the name column
SELECT
    substring(name, -1)
FROM
    instructor;

-- Order the instructor table by salaries
SELECT
    *
FROM
    instructor
ORDER BY
    salary;

-- Order the instructor table by salaries and then by names
SELECT
    *
FROM
    instructor
ORDER BY
    salary,
    name;

-- select all the table instructor where salary is greather than 60000 and smaller or equal to 80000
SELECT
    *
FROM
    instructor
WHERE
    salary BETWEEN 60000
    AND 80000;

-- select all from the table instructors where the tuple dept_name, salary is equal to Elec. Eng. and 80000
SELECT
    *
FROM
    instructor
WHERE
    (dept_name, salary) = ("Elec. Eng.", 80000);

----------------------------- 23/01/2023 -----------------------------
-- select the courses of 2017, spring of 2018 and make a union
(
    SELECT
        course_id
    FROM
        section
    WHERE
        semester = 'Fall'
        AND year = 2017
)
INTERSECT
(
    SELECT
        course_id
    FROM
        section
    WHERE
        semester = 'Spring'
        AND year = 2018
) ----------------------------- 02/02/2023 -----------------------------
-- Select the departments that have a bigger budget than the music department
SELECT
    d1.dept_name
FROM
    department AS d1,
    department AS d2
WHERE
    d2.dept_name = "Music"
    AND d1.budget > d2.budget;

SELECT
    dept_name
FROM
    department
WHERE
    budget > (
        SELECT
            budget
        FROM
            department
        WHERE
            dept_name = "Music"
    );

----------------------------- 09/02/2023 -----------------------------
-- Find the average salary for each building
SELECT
    building,
    avg(salary) AS avg_salary
FROM
    instructor,
    department
WHERE
    department.dept_name = instructor.dept_name
GROUP BY
    building;

-- Find the average salary of the departments in the 'Painter' building
SELECT
    department.dept_name,
    building,
    avg(salary) AS avg_salary
FROM
    instructor,
    department
WHERE
    department.dept_name = instructor.dept_name
    AND building = 'Painter'
GROUP BY
    dept_name;

-- Find the average salary for those department with an average salary higher than $50000
SELECT
    building,
    avg(salary) AS avg_salary
FROM
    instructor,
    department
WHERE
    department.dept_name = instructor.dept_name
GROUP BY
    department.dept_name
HAVING
    avg(salary) > 50000;

----------------------------- 10/02/2023 -----------------------------
-- Find courses offered in Fall 2017 and in Spring 2018
SELECT
    DISTINCT course_id
FROM
    section
WHERE
    semester = 'Fall'
    AND year = 2017
    AND course_id IN (
        SELECT
            course_id
        FROM
            section
        WHERE
            semester = 'Spring'
            AND year = 2018
    );

-- Find courses offered in Fall 2017 but not in Spring 2018
SELECT
    DISTINCT course_id
FROM
    section
WHERE
    semester = 'Fall'
    AND year = 2017
    AND course_id NOT IN (
        SELECT
            course_id
        FROM
            section
        WHERE
            semester = 'Spring'
            AND year = 2018
    );

-- Name all instructors whose name is neither “Mozart” nor Einstein”
SELECT
    DISTINCT name
FROM
    instructor
WHERE
    name NOT IN ('Mozart', 'Einstein');

-- Find the total number of (distinct) students who have taken course 
-- sections taught by the instructor with ID 10101
SELECT
    count(DISTINCT ID)
FROM
    takes
WHERE
    (course_id, sec_id, semester, year) IN (
        SELECT
            course_id,
            sec_id,
            semester,
            year
        FROM
            teaches
        WHERE
            ID = 10101
    );

-- How to do it combining table teaches and takes
SELECT
    count(DISTINCT t1.ID)
FROM
    takes t1,
    teaches t2
WHERE
    t1.course_id = t2.course_id
    AND t1.sec_id = t2.sec_id
    AND t1.semester = t2.semester
    AND t1.year = t2.year
    AND t2.ID = '10101';

----------------------------- 14/02/2023 -----------------------------
-- Find all students who have taken all courses offered in the Biology department.
SELECT
    DISTINCT S.ID,
    S.name
FROM
    student AS S
WHERE
    NOT EXISTS (
        (
            SELECT
                course_id
            FROM
                course
            WHERE
                dept_name = 'Biology'
        )
        EXCEPT
            (
                SELECT
                    T.course_id
                FROM
                    takes AS T
                WHERE
                    S.ID = T.ID
            )
    );

-- Find all courses that were offered at most once in 2017
SELECT
    T.course_id
FROM
    course AS T
WHERE
    UNIQUE (
        SELECT
            R.course_id
        FROM
            section AS R
        WHERE
            T.course_id = R.course_id
            AND R.year = 2017
    );

----------------------------- 14/02/2023 -----------------------------
-- Find the average instructors’ salaries of those departments 
-- where the average salary is greater than $42,000 without subqueries
SELECT
    dept_name,
    avg(salary) AS avg_salary
FROM
    instructor
GROUP BY
    dept_name
HAVING
    avg_salary > 42000;

-- Find the average instructors’ salaries of those departments 
-- where the average salary is greater than $42,000 without the having clausule.
SELECT
    dept_name,
    avg_salary
FROM
    (
        SELECT
            dept_name,
            avg(salary) avg_salary
        FROM
            instructor
        GROUP BY
            dept_name
    ) AS my_subquery
WHERE
    avg_salary > 42000;

-- Find all departments with the maximum budget
SELECT
    dept_name,
    max(budget)
FROM
    department;

---------------------
SELECT
    d1.dept_name
FROM
    department d1
EXCEPT
SELECT
    d1.dept_name
FROM
    department d1,
    department d2
WHERE
    d1.budget < d2.budget;

----------------------------- 16/02/2023 -----------------------------
WITH my_alias(max_budget) AS (
    SELECT
        max(budget) max_budget
    FROM
        department
)
SELECT
    dept_name,
    budget
FROM
    department,
    my_alias
WHERE
    department.budget = my_alias.max_budget;

----------------------------- 17/02/2023 -----------------------------
-- 1. Total salary for the departments
-- 2. Total promig del salary total
-- 3. Seleccionar els departaments amb un salary superior al promig
WITH total_salary(dept_name, sum_salary) AS (
    SELECT
        dept_name,
        sum(salary) sum_salary
    FROM
        instructor
    GROUP BY
        dept_name
),
avg_table(avg_column) AS (
    SELECT
        avg(sum_salary)
    FROM
        total_salary
)
SELECT
    dept_name,
    sum_salary
FROM
    total_salary,
    avg_table
WHERE
    sum_salary > avg_column;

-- Calculate the numbre of instructors of each department without subqueries
SELECT
    dept_name,
    count(*) AS num_instructors
FROM
    instructor
GROUP BY
    dept_name;

-- Calculate the numbre of instructors of each department using scalar subqueries
SELECT
    dept_name,
    (
        SELECT
            count(*)
        FROM
            instructor
        WHERE
            department.dept_name = instructor.dept_name
    ) AS num_instructors
FROM
    department --- Find the number of instructors in every building
SELECT
    building,
    count(*) AS num_instructors
FROM
    instructor,
    department
WHERE
    instructor.dept_name = department.dept_name
GROUP BY
    building;

-----------------
SELECT
    DISTINCT d1.building,
    (
        SELECT
            count(*)
        FROM
            instructor,
            department d2
        WHERE
            instructor.dept_name = d2.dept_name
            AND d1.building = d2.building
    ) AS num_instructors
FROM
    department d1;

----------------------------- 21/02/2023 -----------------------------
-- Borrar todas las filas en la tabla 
--instructores en las que el edificio sea Watson
DELETE FROM
    instructor
WHERE
    dept_name (
        SELECT
            dept_name
        FROM
            departament
        WHERE
            building = 'Watson'
    );

-- Delete instructors from departments with a budget lower
-- than 80000
DELETE FROM
    instructor
WHERE
    dept_name (
        SELECT
            dept_name
        FROM
            departament
        WHERE
            budget < 80000
    );

-- Delete all instructors whose salary is less than the 
-- average salary of instructors
DELETE FROM
    instructor
WHERE
    salary < (
        SELECT
            avg(salary)
        FROM
            instructor
    );

-- Insert as a instructor the music students with more than
-- 30 credits
INSERT INTO
    instructor
SELECT
    ID,
    name,
    dept_name,
    18000
WHERE
    dept_name = 'Music'
    AND total_cred > 30;

----------------------------- 23/02/2023 -----------------------------
-- Recompute and update tot_creds value for all students
UPDATE
    student S
SET
    tot_cred = (
        SELECT
            sum(C.credits)
        FROM
            takes T,
            course C
        WHERE
            S.ID = T.ID
            AND T.grade <> 'F'
            AND T.grade IS NOT NULL
        GROUP BY
            S.ID
    );

-- Change tot_cred to show a 0 instead of NULL
UPDATE
    student
SET
    tot_cred =(
        SELECT
            CASE
                WHEN sum(C.credits) IS NOT NULL THEN sum(C.credits)
                ELSE 0
            END
        FROM
            takes T,
            course C
        WHERE
            student.ID = T.ID
            AND T.course_id = C.course_id
            AND T.grade <> 'F'
            AND T.grade IS NOT NULL
    );