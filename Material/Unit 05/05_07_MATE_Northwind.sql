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
    Orders.ShipCountry,
    Employees.EmployeeID,
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
SELECT
    categories.CategoryID,
    categories.CategoryName,
    sum(
        `order details`.UnitPrice * quantity *(1 - discount)
    ) salesAmount
FROM
    categories,
    products,
    `order details`
WHERE
    `order details`.ProductID = products.ProductID
    AND products.CategoryID = categories.CategoryID
GROUP BY
    CategoryID
ORDER BY
    salesAmount DESC
LIMIT
    4;

-- 7.- Number of products by category. Order by number of products, descending. Show the first four lines.
-- +------------+--------------+--------------+
-- | CategoryID | CategoryName | num_products |
-- +------------+--------------+--------------+
-- |          3 | Confections  |           13 |
-- |          1 | Beverages    |           12 |
-- |          8 | Seafood      |           12 |
-- |          2 | Condiments   |           12 |
-- +------------+--------------+--------------+
SELECT
    categories.CategoryID,
    categories.CategoryName,
    count(*) num_products
FROM
    categories,
    products
WHERE
    products.CategoryID = categories.CategoryID
GROUP BY
    CategoryID
ORDER BY
    num_products DESC
LIMIT
    4;

-- 8.- Order details of the order number 10248.
-- +-----------+-----------+----------+----------+
-- | ProductID | UnitPrice | Quantity | Discount |
-- +-----------+-----------+----------+----------+
-- |        11 |   27.3000 |       12 |     0.10 |
-- |        42 |   19.1100 |       10 |     0.10 |
-- |        72 |   67.8600 |        5 |     0.10 |
-- +-----------+-----------+----------+----------+
SELECT
    ProductID,
    UnitPrice,
    Quantity,
    discount
FROM
    `order details`
WHERE
    orderID = 10248;

-- 9.- Total amount for order 10248. 
-- +--------------+
-- | total_amount |
-- +--------------+
-- |     772.2000 |
-- +--------------+
SELECT
    sum(UnitPrice * quantity *(1 - discount)) total_amount
FROM
    `order details`
WHERE
    orderID = 10248;

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
SELECT
    productName,
    SUM(`order details`.Quantity) units_sold
FROM
    `order details`,
    products
WHERE
    `order details`.ProductID = products.ProductID
GROUP BY
    productName
ORDER BY
    units_sold DESC
LIMIT
    10;

-- 12.- Show the distinct buy-sell prices for the products. That is, the product id, the price at which it was bought and the price at which it was sold. Show only distinct values. Order by product id. List the first four lines. The buy price can be found in the Products table and the sell price can be found in the Order Details tables.
-- +-----------+-----------+------------+
-- | ProductID | buy_price | sell_price |
-- +-----------+-----------+------------+
-- |         1 |   18.0000 |    28.0800 |
-- |         1 |   18.0000 |    35.1000 |
-- |         2 |   19.0000 |    29.6400 |
-- |         2 |   19.0000 |    37.0500 |
-- +-----------+-----------+------------+
SELECT
    DISTINCT products.ProductID,
    `order detail`.UnitPrice buy_price,
    product.UnitPrice sell_price
FROM
    products,
    `order details`
WHERE
    Products.ProductID = OrderDetails.ProductID
ORDER BY
    products.ProductID
LIMIT
    4;

-- 13.- Four most expensive products. 
-- +------------------------+-----------+
-- | ProductName            | UnitPrice |
-- +------------------------+-----------+
-- | Cte de Blaye           |  263.5000 |
-- | Thringer Rostbratwurst |  123.7900 |
-- | Mishi Kobe Niku        |   97.0000 |
-- | Sir Rodney's Marmalade |   81.0000 |
-- +------------------------+-----------+
SELECT
    productName,
    UnitPrice
FROM
    products
ORDER BY
    UnitPrice DESC
LIMIT
    4;

-- 14.- Show the distinct tuples of (ProductName, year, profit_per unit) for the products that gave more profit per unit. 
--Year is the year the product was sold. 
--Profit_per_unit is the difference between the price at which the product was sold and the price at which the product was bought.
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
SELECT
    DISTINCT productName,
    year(orders.orderdate) year,
    (`order detail`.UnitPrice - product.UnitPrice) profit_per_unit
FROM
    products,
    orders,
    `order detail`
WHERE
    Products.ProductID = OrderDetails.ProductID
    AND Orders.OrderID = OrderDetails.OrderID
ORDER BY
    profit_per_unit DESC
LIMIT
    6;

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
SELECT
    productName,
    sum(
        (`order details`.UnitPrice - Products.UnitPrice) * `order details`.Quantity
    ) AS ProductProfit
FROM
    `order details`,
    products,
    orders
WHERE
    Products.ProductID = OrderDetails.ProductID
    AND Orders.OrderID = OrderDetails.OrderID
GROUP BY
    ProductID
ORDER BY
    product_profit DESC
LIMIT
    10;

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
SELECT
    productName
FROM
    products
WHERE
    UnitPrice > (
        SELECT
            AVG(UnitPrice)
        FROM
            Products
    )
ORDER BY
    UnitPrice DESC;

-- 18.- Top 10 suppliers with more products in our system ordered by number of products descendent and company name ascendent. Show the first four lines.
-- +---------------------------------+--------------+
-- | CompanyName                     | num_products |
-- +---------------------------------+--------------+
-- | Pavlova, Ltd.                   |            5 |
-- | Plutzer Lebensmittelgromrkte AG |            5 |
-- | New Orleans Cajun Delights      |            4 |
-- | Specialty Biscuits, Ltd.        |            4 |
-- +---------------------------------+--------------+
SELECT
    CompanyName,
    count(ProductID) AS num_products
FROM
    suppliers,
    products
WHERE
    Suppliers.SupplierID = Products.SupplierID
GROUP BY
    Suppliers.CompanyName
ORDER BY
    NumberProducts DESC,
    CompanyName ASC
LIMIT
    4;

-- 19.- Number of customers from Barcelona. 
-- +--------------------+
-- | customers_from_BCN |
-- +--------------------+
-- |                  1 |
-- +--------------------+
SELECT
    COUNT(*) AS CustomersFromBCN
FROM
    Customers
WHERE
    City = "Barcelona";

-- 20.- Make a complete list of customers with more than 25 orders placed.
-- +--------------------+------------+
-- | CompanyName        | num_orders |
-- +--------------------+------------+
-- | Ernst Handel       |         30 |
-- | QUICK-Stop         |         28 |
-- | Save-a-lot Markets |         31 |
-- +--------------------+------------+ 
SELECT
    CompanyName,
    COUNT(*) AS NumOrders
FROM
    Customers,
    Orders
WHERE
    Customers.CustomerID = Orders.CustomerID
GROUP BY
    Customers.CompanyName
HAVING
    NumOrders > 25;

-- 21.- Customer who has placed the maximum number of orders. 
-- +--------------------+------------+
-- | CompanyName        | num_orders |
-- +--------------------+------------+
-- | Save-a-lot Markets |         31 |
-- +--------------------+------------+
SELECT
    CompanyName,
    COUNT(*) AS NumOrders
FROM
    Customers,
    Orders
WHERE
    Customers.CustomerID = Orders.CustomerID
GROUP BY
    Customers.CompanyName
ORDER BY
    NumOrders DESC
LIMIT
    1;

-- 22.- Make a list of shippers and the number of orders handled by each. The actual database does not correspond to the diagram at the beginning of this document. Sorry. 
-- +-----------+------------------+----------------+------------+
-- | ShipperID | CompanyName      | Phone          | num_orders |
-- +-----------+------------------+----------------+------------+
-- |         1 | Speedy Express   | (503) 555-9831 |        249 |
-- |         2 | United Package   | (503) 555-3199 |        326 |
-- |         3 | Federal Shipping | (503) 555-9931 |        255 |
-- +-----------+------------------+----------------+------------+
SELECT
    ShipperID,
    CompanyName,
    Phone,
    COUNT(*)
FROM
    Shippers,
    Orders
WHERE
    Shippers.ShipperID = Orders.ShipVia
GROUP BY
    ShipperID;

-- 23. Make a list of the employees (full name) and for each employee show the number of times that employee has used each of the shippers. 
-- Order by number of orders (number of shipments). Descending. Show the first 4 results.
-- +-----------+------------------+-----------+-----------+------------+
-- | ShipperID | CompanyName      | FirstName | LastName  | num_orders |
-- +-----------+------------------+-----------+-----------+------------+
-- |         2 | United Package   | Margaret  | Peacock   |         70 |
-- |         2 | United Package   | Laura     | Callahan  |         48 |
-- |         1 | Speedy Express   | Margaret  | Peacock   |         46 |
-- |         3 | Federal Shipping | Janet     | Leverling |         46 |
-- +-----------+------------------+-----------+-----------+------------+
SELECT
    Shippers.ShipperID,
    Shippers.CompanyName,
    Employees.FirstName,
    Employees.LastName,
    COUNT(*) AS num_orders
FROM
    Shippers,
    Orders,
    Employees
WHERE
    Shippers.ShipperID = Orders.ShipVia
    AND Employees.EmployeeID = Orders.EmployeeID
GROUP BY
    Shippers.ShipperID,
    Shippers.CompanyName,
    Employees.FirstName,
    Employees.LastName
ORDER BY
    num_orders DESC
LIMIT
    4;

-- 24. Make a list of products that are out of stock.
-- +-----------+------------------------+
-- | ProductId | ProductName            |
-- +-----------+------------------------+
-- |         5 | Chef Anton's Gumbo Mix |
-- |        17 | Alice Mutton           |
-- |        29 | Thringer Rostbratwurst |
-- |        31 | Gorgonzola Telino      |
-- |        53 | Perth Pasties          |
-- +-----------+------------------------+
SELECT
    ProductID,
    ProductName
FROM
    Products
WHERE
    UnitsInStock = 0;

-- 25. Make a list of products that are out of stock and have not been discontinued. Include the suppliers’ names. 
-- +-----------+-------------------+-------------------------+
-- | ProductId | ProductName       | CompanyName             |
-- +-----------+-------------------+-------------------------+
-- |        31 | Gorgonzola Telino | Formaggi Fortini s.r.l. |
-- +-----------+-------------------+-------------------------+
SELECT
    Products.ProductID,
    Products.ProductName,
    Suppliers.CompanyName
FROM
    Products,
    Suppliers
WHERE
    Products.SupplierID = Suppliers.SupplierID
    AND (
        UnitsInStock = 0
        AND Discontinued = "%0"
    );

-- 26.- Make a list of products that need to be re-ordered i.e. where the units in stock (the number you have) and the units on order (the number you have coming) is less than the reorder level (the number that prompts you to order more). 
-- +-----------+-----------------------+--------------+--------------+--------------+
-- | ProductId | ProductName           | UnitsInStock | UnitsOnOrder | ReorderLevel |
-- +-----------+-----------------------+--------------+--------------+--------------+
-- |        30 | Nord-Ost Matjeshering |           10 |            0 |           15 |
-- |        70 | Outback Lager         |           15 |           10 |           30 |
-- +-----------+-----------------------+--------------+--------------+--------------+
SELECT
    ProductID,
    ProductName,
    UnitsInStock,
    UnitsOnOrder,
    ReorderLevel
FROM
    Products
WHERE
    (UnitsInStock + UnitsOnOrder) < ReorderLevel;

-- 27. Top 4 orders with bigger discount (as an amount).
-- +---------+-----------+-----------------+------------------------+
-- | OrderID | subtotal  | discount_amount | subtotal_with_discount |
-- +---------+-----------+-----------------+------------------------+
-- |   10305 | 8106.1500 |       1215.9225 |              6890.2275 |
-- |   10283 | 2758.8600 |        275.8860 |              2482.9740 |
-- |   11077 | 2680.4700 |        262.9770 |              2417.4930 |
-- |   10292 | 2527.2000 |        252.7200 |              2274.4800 |
-- +---------+-----------+-----------------+------------------------+
SELECT
    OrderID,
    SUM(UnitPrice * Quantity) AS Subtotal,
    SUM(UnitPrice * Quantity * Discount) AS discount_amount,
    SUM(UnitPrice * Quantity * (1 - Discount)) AS subtotal_with_discount
FROM
    OrderDetails
GROUP BY
    OrderID
ORDER BY
    discount_amount DESC
LIMIT
    4;