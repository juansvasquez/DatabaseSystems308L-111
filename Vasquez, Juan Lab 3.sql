
--Juan S. Vasquez
--2/8/2016
--Lab 3: Getting Started with SQL Queries

--1. List the order number and total dollars of	all orders.

SELECT ordnum, totalUSD 
FROM orders;

--2. List the name and city of agents named Smith.

SELECT name, city 
FROM agents 
WHERE name = 'Smith';

--3. List the id, name, and priceUSD of	products with quantity more than 208,000.

SELECT pid, name, priceUSD 
FROM products 
WHERE quantity > 208000;

--4. List the names and cities of customers in Dallas.

SELECT name, city 
FROM customers 
WHERE city = 'Dallas';

--5. List the names of agents not in New York and not in Tokyo.

SELECT name 
FROM agents 
WHERE city NOT IN ('New York','Tokyo');

--6. List all data for products not in Dallas or Duluth that cost US$1 or more.

SELECT * 
FROM products 
WHERE city NOT IN ('Dallas','Duluth') AND priceUSD >= 1.00;

--7. List all data for orders in January or March.

SELECT * 
FROM orders 
WHERE mon = 'jan' OR mon = 'mar';

--8. List all data for orders in February less than us$500.

SELECT * 
FROM orders 
WHERE mon = 'feb' AND totalUSD < 500;

--9. List all orders from the customer whose cid is C005.

SELECT * 
FROM orders 
WHERE cid = 'C005';