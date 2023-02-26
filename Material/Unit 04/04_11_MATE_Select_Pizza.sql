-- Find all pizzerias frequented by at least one person under the age of 18.
SELECT
    pizzeria
FROM
    frequents,
    person
WHERE
    frequents.name = person.name
    AND age < 18;

-- Find the names of all females who eat either mushroom or pepperoni 
-- pizza (or both).
SELECT
    person.name,
    pizza
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

-- Find the names of all females who eat both mushroom and pepperoni 
-- pizza.
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

-- Find all pizzerias that serve at least one pizza that Amy eats for 
-- less than $10.00.
SELECT
    DISTINCT pizzeria
FROM
    eats,
    serves
WHERE
    name = 'Amy'
    AND price < 10;

-- Find all pizzerias that are frequented by only females or only males.
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

-- For each person, find all pizzas the person eats that are not 
-- served by any pizzeria the person frequents. Return all such person (name) / pizza pairs.
-- Find the names of all people who frequent only pizzerias serving 
-- at least one pizza they eat.
-- Find the names of all people who frequent every pizzeria serving 
-- at least one pizza they eat.
-- Find the pizzeria serving the cheapest pepperoni pizza. In the 
-- case of ties, return all of the cheapest-pepperoni pizzerias.