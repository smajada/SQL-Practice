-- 1. In the university database, find the names of the 
-- departments with a budget higher than the budget of the music department.

SELECT
    DISTINCT A.dept_name
FROM
    department AS A,
    department AS B
WHERE
    A.budget > B.budget
    AND B.dept_name = 'Music';

-- 2. Create a database “ages”. Use it.
Create database ages;
use ages;

-- 3. Create a table "person."
create table person (name varchar(20), birthday date);

-- 4. Insert some data.
insert into person (name, birthday) values ("Assange", "1971-06-03");
insert into person (name, birthday) values ("Snowden", "1983-06-21");

-- 5. Compute the age. Hint: I have used the DATE_FORMAT(NOW(), '%Y%m%d') function.
SELECT name, DATE_FORMAT(NOW(), '%Y %m %d') - DATE_FORMAT(birthday, '%Y %m %d') as age from person;