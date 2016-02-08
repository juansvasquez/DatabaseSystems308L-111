
--Juan S. Vasquez
--2/8/2016
--Lab 3: Getting Started with SQL Queries

SELECT ordnum, totalUSD FROM orders;

SELECT name, city FROM agents WHERE name = 'Smith';

SELECT pid, name, priceUSD FROM products WHERE quantity > 208000;

SELECT name, city FROM customers WHERE city = 'Dallas';

SELECT name FROM agents WHERE city != 'New York' AND city != 'Tokyo';

SELECT * FROM products WHERE city != 'Dallas' AND city != 'Duluth' AND priceUSD >= 1.00;

SELECT * FROM orders WHERE mon = 'jan' OR mon = 'mar';

SELECT * FROM orders WHERE mon = 'feb' AND totalUSD < 500;

SELECT * FROM orders WHERE cid = 'C005';