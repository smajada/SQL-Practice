-- 1.- Write a SQL query to calculate the total purchase 
-- amount of all orders. Return total purchase amount.
select sum(pur_amt) as total_amt from orders;

-- 2. Write a SQL query to calculate the average purchase 
-- amount of all orders. Return average purchase amount.

select avg(pur_amt) as avg_pur_amt from orders;

-- 3.Write a SQL query that counts the number of salespeople. 
-- Return number of salespeople.  

select count(salesman_id) as salespeople from salesman;

-- 4. Write a SQL query to count the number of customers. 
-- Return number of customers.
select count(customer_id) as customers from customer;

-- 5.- Count the number of customers that have a value of 
-- ‘grade’ different from null.
select count(customer_id) as customers from customer where grade is not NULL;

--6. Find the maximum purchase amount.
select max(pur_amt) as max_pur from orders;

-- 7. Find the minimum purchase amount.
select min(pur_amt) as min_pur from orders;

--8.-  Write a SQL query to find the highest grade of the customers in each city. 
--Return city, maximum grade.

select city, max(grade) as max_grade
from customer
group by city;

--9.- Write a SQL query to find the highest purchase amount by each customer. 
-- Return customer ID, maximum purchase amount.
select customer_id, ord_date, max(pur_amt) from orders group by customer_id;

--10.- Write a SQL query to find the highest purchase amount by each customer on each date. 
--Return customer_id, order date and highest purchase amount.
select customer_id, ord_date, max(pur_amt) from orders group by customer_id, ord_date;

--11.- Write a SQL query to determine the highest purchase amount made by each salesperson in 2020. 
-- Return salesperson ID, purchase amount.
select salesman_id, max(pur_amt), ord_date from orders where year(ord_date) = 2020 group by salesman_id;

--12.- Find the maximum purchase amount for each customer each day. 
-- Show only  the results where the maximum purchase exceeds 5000.
select ord_date, customer_id, max(pur_amt) from orders group by customer_id having max(pur_amt) > 5000;

--13.- Find the maximum purchase amount for each customer each day. 
-- Show only  the results where the maximum purchase is between 3000 and 7000. 

select ord_date, customer_id, max(pur_amt) from orders group by customer_id having max(pur_amt) between 3000 and 7000 ;

--14.- Find the maximum purchase amount for each customer each day. 
-- Show only  the results where the maximum purchase is either 10000, 8700 or 1500. 
select ord_date, customer_id, max(pur_amt) from orders group by customer_id having max(pur_amt) =1 0000 or max(pur_amt) = 8700 or max(pur_amt) = 15000;

--15.- Find the maximum purchase amount for each customer each day. 
--Show only  the results where the customer_id is between 250 and 450. 
select customer_id, ord_date, max(pur_amt) from orders group by customer_id, ord_date having customer_id between 250 and 450;

--16.- Find the maximum order for each customer for customers with id between 200 and 400. 
--Show only the results where the maximum order is higher than 9000. Return customer id and maximum purchase amount.
SELECT customer_id, MAX(pur_amt)
FROM orders
WHERE customer_id BETWEEN 250 AND 450
GROUP BY customer_id
HAVING MAX(pur_amt) > 9000;

-- 17.- Find the maximum order for each salesman for salesmen with id between 15 and 40. 
-- Return salesperson id and maximum purchase amount.
select salesman_id, max(pur_amt)
from orders
where salesman_id between 15 and 40
group by salesman_id;

-- 18.- Count the orders on 2020-03-25.
select count(ord_no)
from orders
where ord_date = '2020-03-25';

--19.- Count the number of salesmen that have a city (City is not null).
select count(salesman_id)
from salesman
where city is not null;

--20.- List the number of orders for each salesperson and date.
select ord_date, salesman_id, count(ord_no) as count_of_orders
from orders
group by ord_date, salesman_id;