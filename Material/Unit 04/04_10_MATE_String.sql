-- 1.- Find the department names that consist of four characters and a 
-- period followed by another four characters and another period.

SELECT
    dept_name
FROM
    department
WHERE
    dept_name LIKE '____. ____.';

-- 2.- Find the department names that have a blank space in their name.

SELECT
    dept_name
FROM
    department
WHERE
    dept_name LIKE '% %';

-- 3. Find the department names that finish with the letter ‘y’. 

SELECT
    dept_name
FROM
    department
WHERE
    dept_name LIKE '%y';

-- 4. Find the department names that are seven letters long.

SELECT
    dept_name
FROM
    department
WHERE
    dept_name LIKE '_______';

-- 5. Find the names of the departments that have seven letters or more.

SELECT
    dept_name
FROM
    department
WHERE
    dept_name LIKE '_______%';


-- 6. Insert a new department.
-- insert into department values ('Art', '100% online', 25000);

-- Find all the buildings that include a % symbol in their name.

SELECT
    building
FROM
    department
WHERE
    building LIKE '%\%';