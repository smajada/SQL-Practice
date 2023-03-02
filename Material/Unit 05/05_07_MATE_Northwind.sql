--1.- Show total cost of the four most expensive orders in May 1998. 
-- Clue: price*quantity*(1-discount). 
-- +---------+------------+
-- | OrderID | total_cost |
-- +---------+------------+
-- |   11072 | 10175.1000 |
-- |   11064 |  9208.4850 |
-- |   11068 |  4650.3600 |
-- |   11070 |  3653.3250 |
-- +---------+------------+
SELECT
    orders.orderID,
    sum(UnitPrice * quantity *(1 - discount)) AS total_cost
FROM
    `order details`,
    orders
WHERE
    orders.orderid = `order details`.orderid
    AND MONTH(orderdate) = 05
    AND year(orderdate) = 1998
GROUP BY
    orders.orderid
ORDER BY
    total_cost DESC
LIMIT
    4;

--2.- Show the total sales by year. 
-- +------+----------------+
-- | year | sales_per_year |
-- +------+----------------+
-- | 1996 |    438818.2500 |
-- | 1997 |   1283858.0625 |
-- | 1998 |    915791.1360 |
-- +------+----------------+
SELECT
    year(orderdate) year,
    sum(UnitPrice * quantity *(1 - discount)) sales_per_year
FROM
    `order details`,
    orders
WHERE
    orders.orderid = `order details`.orderid
GROUP BY
    year(orderdate);

-- 3.- Total sales by country. Order by country and show the first 4 results.
-- +-------------+----------------+
-- | ShipCountry | sales_per_year |
-- +-------------+----------------+
-- | Argentina   |     15832.2450 |
-- | Austria     |    272018.4285 |
-- | Belgium     |     68513.2110 |
-- | Brazil      |    223697.4870 |
-- +-------------+----------------+
SELECT
    ShipCountry,
    sum(UnitPrice * quantity *(1 - discount)) sales_per_year
FROM
    `order details`,
    orders
WHERE
    orders.orderid = `order details`.orderid
GROUP BY
    ShipCountry
ORDER BY
    ShipCountry
LIMIT
    4;

-- 4.- Show employee sales order by sales amount descendent. Show the first four results.
-- +------------+--------------------+
-- | EmployeeID | sales_per_employee |
-- +------------+--------------------+
-- |          4 |        487859.4435 |
-- |          3 |        415097.5140 |
-- |          1 |        393351.2700 |
-- |          2 |        346611.0570 |
-- +------------+--------------------+
SELECT
    employeeid,
    sum(UnitPrice * quantity *(1 - discount)) sales_per_employee
FROM
    `order details`,
    orders
WHERE
    orders.orderid = `order details`.orderid
GROUP BY
    employeeid
ORDER BY
    sales_per_employee DESC
LIMIT
    4;

-- 5.- Show employee sales by country. Order by country ascendent and sales amount descendent. Show the first 20 rows.
-- +-------------+------------+-------------+
-- | ShipCountry | EmployeeId | salesAmount |
-- +-------------+------------+-------------+
-- | Argentina   |          8 |   5363.4750 |
-- | Argentina   |          7 |   2994.8100 |
-- | Argentina   |          4 |   2592.3300 |
-- | Argentina   |          9 |   1841.7750 |
-- | Argentina   |          1 |   1339.0650 |
-- | Argentina   |          2 |    930.1500 |
-- | Argentina   |          3 |    622.4400 |
-- | Argentina   |          6 |    148.2000 |
-- | Austria     |          7 |  57631.7625 |
-- | Austria     |          3 |  47706.4575 |
-- | Austria     |          2 |  38614.6800 |
-- | Austria     |          4 |  37384.6785 |
-- | Austria     |          1 |  35694.6525 |
-- | Austria     |          8 |  22247.5500 |
-- | Austria     |          9 |  18639.6600 |
-- | Austria     |          6 |  14098.9875 |
-- | Belgium     |          4 |  28130.3100 |
-- | Belgium     |          5 |  14964.8850 |
-- | Belgium     |          7 |   9050.9250 |
-- | Belgium     |          9 |   6379.4250 |
-- +-------------+------------+-------------+
SELECT
    Orders.ShipCountry, Employees.EmployeeID,
    sum(UnitPrice * quantity *(1 - discount)) salesAmount
FROM
    `order details`,
    orders,
    employees
WHERE
    orders.orderid = `order details`.orderid
    AND Employees.EmployeeID = Orders.EmployeeID
GROUP BY
    Orders.ShipCountry,
    Employees.EmployeeID
ORDER BY
    ShipCountry ASC,
    salesAmount DESC
LIMIT
    20;

-- 6.- Sales per category. Order by sales amount, descending. Show the first four results.
-- +------------+----------------+-------------+
-- | CategoryID | CategoryName   | salesAmount |
-- +------------+----------------+-------------+
-- |          1 | Beverages      | 558499.2075 |
-- |          4 | Dairy Products | 489632.4420 |
-- |          6 | Meat/Poultry   | 346658.2275 |
-- |          3 | Confections    | 344943.0855 |
-- +------------+----------------+-------------+

select
categories.CategoryID,
categories.CategoryName,
sum(`order details`.UnitPrice * quantity *(1 - discount)) salesAmount
from
categories,
products,
`order details`
where
    `order details`.ProductID = products.ProductID
    and products.CategoryID = categories.CategoryID

group by CategoryID
order by salesAmount desc
limit 4;


-- 7.- Number of products by category. Order by number of products, descending. Show the first four lines.
-- +------------+--------------+--------------+
-- | CategoryID | CategoryName | num_products |
-- +------------+--------------+--------------+
-- |          3 | Confections  |           13 |
-- |          1 | Beverages    |           12 |
-- |          8 | Seafood      |           12 |
-- |          2 | Condiments   |           12 |
-- +------------+--------------+--------------+

select
categories.CategoryID,
categories.CategoryName,
count(*) num_products
from
categories,
products
where
    products.CategoryID = categories.CategoryID

group by CategoryID
order by num_products desc
limit 4;


-- 8.- Order details of the order number 10248.
-- +-----------+-----------+----------+----------+
-- | ProductID | UnitPrice | Quantity | Discount |
-- +-----------+-----------+----------+----------+
-- |        11 |   27.3000 |       12 |     0.10 |
-- |        42 |   19.1100 |       10 |     0.10 |
-- |        72 |   67.8600 |        5 |     0.10 |
-- +-----------+-----------+----------+----------+

select ProductID, UnitPrice, Quantity, discount
from `order details`
where orderID = 10248;

-- 9.- Total amount for order 10248. 
-- +--------------+
-- | total_amount |
-- +--------------+
-- |     772.2000 |
-- +--------------+

select
sum(UnitPrice * quantity *(1 - discount)) total_amount
from `order details`
where orderID = 10248;


-- 10.- List the employee last name and the customer company name for order 10248. 
-- +----------+---------------------------+
-- | LastName | CompanyName               |
-- +----------+---------------------------+
-- | Buchanan | Vins et alcools Chevalier |
-- +----------+---------------------------+

SELECT
    LastName,
    CompanyName
FROM
    employees,
    orders,
    customers
WHERE
    orders.orderID = 10248
    AND orders.customerID = customers.customerID
    AND orders.employeeid = employees.employeeid;

-- 11.- Top 10 products with more units sold. 
-- +------------------------+------------+
-- | ProductName            | units_sold |
-- +------------------------+------------+
-- | Camembert Pierrot      |       1577 |
-- | Raclette Courdavault   |       1496 |
-- | Gorgonzola Telino      |       1397 |
-- | Gnocchi di nonna Alice |       1263 |
-- | Pavlova                |       1158 |
-- | Rhnbru Klosterbier     |       1155 |
-- | Guaran Fantstica       |       1125 |
-- | Boston Crab Meat       |       1103 |
-- | Tarte au sucre         |       1083 |
-- | Flotemysost            |       1057 |
-- +------------------------+------------+

SELECT productName, SUM(`order details`.Quantity) units_sold
from 
`order details`,
products
where `order details`.ProductID = products.ProductID
group by productName
order by units_sold desc
limit 10;

-- 12.- Show the distinct buy-sell prices for the products. That is, the product id, the price at which it was bought and the price at which it was sold. Show only distinct values. Order by product id. List the first four lines. The buy price can be found in the Products table and the sell price can be found in the Order Details tables.
-- +-----------+-----------+------------+
-- | ProductID | buy_price | sell_price |
-- +-----------+-----------+------------+
-- |         1 |   18.0000 |    28.0800 |
-- |         1 |   18.0000 |    35.1000 |
-- |         2 |   19.0000 |    29.6400 |
-- |         2 |   19.0000 |    37.0500 |
-- +-----------+-----------+------------+



-- 13.- Four most expensive products. 
-- +------------------------+-----------+
-- | ProductName            | UnitPrice |
-- +------------------------+-----------+
-- | Cte de Blaye           |  263.5000 |
-- | Thringer Rostbratwurst |  123.7900 |
-- | Mishi Kobe Niku        |   97.0000 |
-- | Sir Rodney's Marmalade |   81.0000 |
-- +------------------------+-----------+



-- 14.- Show the distinct tuples of (ProductName, year, profit_per unit) for the products that gave more profit per unit. Year is the year the product was sold. Profit_per_unit is the difference between the price at which the product was sold and the price at which the product was bought.
-- Show the first 6 lines.
-- +------------------------+------+-----------------+
-- | ProductName            | year | profit_per_unit |
-- +------------------------+------+-----------------+
-- | Cte de Blaye           | 1998 |        250.3250 |
-- | Cte de Blaye           | 1997 |        250.3250 |
-- | Cte de Blaye           | 1997 |        147.5600 |
-- | Cte de Blaye           | 1996 |        147.5600 |
-- | Thringer Rostbratwurst | 1997 |        117.6005 |
-- | Thringer Rostbratwurst | 1998 |        117.6005 |
-- +------------------------+------+-----------------+



-- 15. Top ten products in profit in sales. The profit in sales for a product is the sum of all the differences of the price paid for the product and the price charged for a product times the quantity of products sold.
-- +------------------------+----------------+
-- | productName            | product_profit |
-- +------------------------+----------------+
-- | Cte de Blaye           |    128308.6900 |
-- | Thringer Rostbratwurst |     78014.7025 |
-- | Raclette Courdavault   |     66497.2000 |
-- | Camembert Pierrot      |     44081.6800 |
-- | Tarte au sucre         |     43772.5050 |
-- | Manjimup Dried Apples  |     40265.2660 |
-- | Gnocchi di nonna Alice |     39992.3400 |
-- | Alice Mutton           |     31048.2900 |
-- | Carnarvon Tigers       |     28322.5000 |
-- | Rssle Sauerkraut       |     23203.9200 |
-- +------------------------+----------------+



-- 16.- Products above average price (ordered by price descendent). 
-- +---------------------------------+
-- | ProductName                     |
-- +---------------------------------+
-- | Cte de Blaye                    |
-- | Thringer Rostbratwurst          |
-- | Mishi Kobe Niku                 |
-- | Sir Rodney's Marmalade          |
-- | Carnarvon Tigers                |
-- | Raclette Courdavault            |
-- | Manjimup Dried Apples           |
-- | Tarte au sucre                  |
-- | Ipoh Coffee                     |
-- | Rssle Sauerkraut                |
-- | Schoggi Schokolade              |
-- | Vegie-spread                    |
-- | Northwoods Cranberry Sauce      |
-- | Alice Mutton                    |
-- | Queso Manchego La Pastora       |
-- | Gnocchi di nonna Alice          |
-- | Gudbrandsdalsost                |
-- | Mozzarella di Giovanni          |
-- | Camembert Pierrot               |
-- | Wimmers gute Semmelkndel        |
-- | Perth Pasties                   |
-- | Mascarpone Fabioli              |
-- | Gumbr Gummibrchen               |
-- | Ikura                           |
-- | Uncle Bob's Organic Dried Pears |
-- +---------------------------------+