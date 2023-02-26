-- Practice Exercise #1:
SELECT
    *
FROM
    employees
WHERE
    salary <= 52500;

-- Practice Exercise #2:
SELECT
    DISTINCT city
FROM
    suppliers
WHERE
    state = "California"
ORDER BY
    city DESC;

-- Practice Exercise #3:
SELECT
    customers.customer_id,
    last_name,
    order_date
FROM
    customers,
    orders
WHERE
    customers.customer_id = orders.customer_id
ORDER BY
    customer_id DESC;

-- Practice Exercise #4:
SELECT
    customers.customer_id,
    customers.last_name
FROM
    customers,
    orders
WHERE
    (customers.customer_id = orders.customer_id)
ORDER BY
    last_name,
    customer_id DESC;

-- Practice Exercise #5:
SELECT
    DISTINCT customer_id
FROM
    orders
WHERE
    order_date BETWEEN "2016-04-01"
    AND "2016-04-31";

-- Practice Exercise #6:
SELECT
    last_name
FROM
    customers,
    orders
WHERE
    customers.customer_id = orders.customer_id
    AND (MONTH(order_date), year(order_date)) =(4, 2016);

-- Practice Exercise #7:
-- El uso de los paréntesis, en la primera query, indica que