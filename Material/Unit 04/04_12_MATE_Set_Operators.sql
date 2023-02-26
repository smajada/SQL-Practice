-- Find all the names of all the salesmen and customers.
(
    SELECT
        name
    FROM
        salesman
)
UNION
(
    SELECT
        cust_name
    FROM
        customer
);

-- Find all the cities where there are salesmen and all the cities where there are customers. Include duplicates.
(
    SELECT
        city
    FROM
        salesman
)
UNION
ALL (
    SELECT
        city
    FROM
        customer
);

-- Find all the cities where there are salesmen and customers.
(
    SELECT
        city
    FROM
        salesman
)
INTERSECT
(
    SELECT
        city
    FROM
        customer
);

-- Find the cities where there are customers and there are no salesmen.
(
    SELECT
        city
    FROM
        customer
)
EXCEPT
    (
        SELECT
            city
        FROM
            salesman
    );

-- Find all the customers and salesmen that live in Bengalore. 
-- Label the column customers_and_salesmen.
(
    SELECT
        cust_name AS customers_and_salesmen
    FROM
        customer
    WHERE
        city = 'Bengalore'
)
UNION
(
    SELECT
        name
    FROM
        salesman
    WHERE
        city = 'Bengalore'
);

-- Find all the cities in which there is either a customer 
-- or a salesman involved in an order.
(
    SELECT
        city
    FROM
        customer,
        orders
    WHERE
        customer.customer_id = orders.customer_id
)
UNION
(
    SELECT
        city
    FROM
        salesman,
        orders
    WHERE
        salesman.salesman_id = orders.salesman_id
);

-- Provide an output as follows using “union”:
insert into students (name, grade) values ("Jaume", 5);
insert into students (name, grade) values ("Maria", 6);
insert into students (name, grade) values ("Pere", 4);

create table students (
    name varchar(25),
    grade int
);

insert into grade_result (grade, result) values (4, "fail");
insert into grade_result (grade, result) values (5, "pass");
insert into grade_result (grade, result) values (6, "pass");

(SELECT name, "pass" as result from students where grade >= 5) UNION
(SELECT name, "fail" as result from students where grade < 5);
