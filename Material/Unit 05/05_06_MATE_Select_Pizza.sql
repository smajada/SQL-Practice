-- A. Find all pizzerias frequented by at least one person under the age of 18. 
select pizzeria
from frequents, person
where frequents.name = person.name
and age < 18;

-- B. Find the names of all females who eat either mushroom or pepperoni pizza (or both).
SELECT
    DISTINCT person.name
FROM
    person,
    eats
WHERE
    person.name = eats.name
    AND gender = 'female'
    AND (
        pizza = 'mushroom'
        OR pizza = 'pepperoni'
    );

-- C. Find the names of all females who eat both mushroom and pepperoni pizza. 
-- Solve it using the same approach we used with relational algebra. 
-- Then solve it using “exists” and/or “not exists”.
(
    SELECT
        person.name,
        pizza
    FROM
        person,
        eats
    WHERE
        person.name = eats.name
        AND gender = 'female'
        AND pizza = 'mushroom'
)
INTERSECT
(
    SELECT
        person.name,
        pizza
    FROM
        person,
        eats
    WHERE
        person.name = eats.name
        AND gender = 'female'
        AND pizza = 'pepperoni'
);

----------------------------------------------------
select name
from Person
where gender='female'
and exists (select Eats.name from Eats
            where Eats.name=Person.name
            and pizza='pepperoni')
and exists (select Eats.name from Eats
            where Eats.name=Person.name
            and pizza='mushroom')

-- D. Find all pizzerias that serve at least one pizza that Amy eats for less than $10.00. 
--Solve it using the same approach we used with relational algebra. 
--Then solve it using “exists” and/or “not exists”.

SELECT
    DISTINCT pizzeria
FROM
    eats,
    serves
WHERE
    name = 'Amy'
    AND price < 10;

---------------------------------------------
select pizzeria
from Serves
where price<10
and exists (select *
            from Eats
            where name='Amy'
            and Eats.pizza=Serves.pizza);

-- E. Find all pizzerias that are frequented by only females or only males.
(
    SELECT
        pizzeria
    FROM
        person,
        frequents
    WHERE
        gender = 'female'
)
EXCEPT
    (
        SELECT
            pizzeria
        FROM
            person,
            frequents
        WHERE
            gender = 'male'
    );

--F. For each person, find all pizzas the person eats that are not served by any pizzeria the person frequents. 
--Return all such person (name) / pizza pairs. 
--Solve it using the same approach we used with relational algebra. 
--Then solve it using “exists” and/or “not exists”.

SELECT
    name,
    pizza
FROM
    Eats
EXCEPT
SELECT
    name,
    pizza
FROM
    Frequents,
    Serves
WHERE
    Frequents.pizzeria = Serves.pizzeria;

----------------------------------------
SELECT
    name,
    pizza
FROM
    Eats
WHERE
    NOT EXISTS(
        SELECT
            *
        FROM
            Frequents,
            Serves
        WHERE
            Frequents.pizzeria = Serves.pizzeria
            AND Frequents.name = Eats.name
            AND Serves.pizza = Eats.pizza
    );

-- G. Find the names of all people who frequent only pizzerias serving at least one pizza they eat. 
-- Solve it using the same approach we used with relational algebra. 
--Then solve it using “exists” and/or “not exists”
select name from person 
EXCEPT
select name 
from (
    select name, pizzeria
    from frequents
    EXCEPT
    select name, pizzeria
    from eats, serves
    where 
    eats.pizza = serves.pizza
) as temp_query;

---------------------------------
select distinct name
from Person
where not exists (
  -- a pizzeria they frequent and does not serve any pizza they eat
  select *
  from Frequents
  where Frequents.name=Person.name
  and not exists (
    select *
    from Eats, Serves
    where Eats.name=Person.name
    and Eats.pizza=Serves.pizza
    and Frequents.pizzeria=Serves.pizzeria
    )
  );

-- H. Find the names of all people who frequent every pizzeria serving at least one pizza they eat. 
-- Solve it using the same approach we used with relational algebra. 
--Then solve it using “exists” and/or “not exists”.
select name
from Person
except
select name
from(
  (select name, pizzeria
  from Frequents)
  except
  (select name, pizzeria
  from Eats, Serves
  where Eats.pizza=Serves.pizza) 
)as my_subquery;
------------------------------------------------
select name 
from Person
where not exists(
  -- a pizzeria that serves a pizza they eat and they don't frequent
  select *
  from Eats, Serves
  where Person.name=Eats.name
  and Serves.pizza=Eats.pizza
  and Serves.pizzeria not in (
    select pizzeria
    from Frequents
    where Frequents.name=Person.name
    )
  );

-- I. Find the pizzeria serving the cheapest pepperoni pizza. 
-- In the case of ties, return all of the cheapest-pepperoni pizzerias. 
-- Solve it using the same approach we used with relational algebra. Then solve it using a subquery
select pizzeria
from Serves
where pizza='pepperoni'
except
select S1.pizzeria
from Serves S1, Serves S2
where S1.pizza='pepperoni'
and S2.pizza='pepperoni'
and S1.price>S2.price;

------------------------------------------------

select pizzeria
from Serves
where pizza='pepperoni'
and price=(
  select min(price)
  from Serves
  where pizza='pepperoni'
  );
