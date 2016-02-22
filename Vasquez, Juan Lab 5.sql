--Juan S. Vasquez
--2/22/2016
--Lab 5: The Joins Three-quel

-- 1. Show the cities of agents booking an order for a customer whose id is 'c002'. Use joins; no subqueries.
SELECT city
FROM agents a
INNER JOIN orders o
ON a.aid = o.aid AND o.cid = 'c002';

/* 2. Show the ids of products ordered through any agent who makes at least one order for 
a customer in Dallas, sorted by pid from highest to lowest. Use joins; no subqueries. */
SELECT distinct o2.pid
FROM orders o1
INNER JOIN customers c
ON o1.cid = c.cid AND c.city = 'Dallas'
LEFT OUTER JOIN orders o2 
ON o2.aid = o1.aid
ORDER BY o2.pid DESC;

-- 3. Show the names of customers who have never placed an order. Use a subquery.
SELECT name
FROM customers
WHERE cid NOT IN (
	SELECT cid
	FROM orders
	);

-- 4. Show the names of customers who have never placed an order. Use an outer join.
SELECT c.name
FROM customers c
LEFT OUTER JOIN orders o
ON c.cid = o.cid 
WHERE o.ordnum IS NULL;

/* 5. Show the names of customers who placed at least one order through an agent in their
own city, along	with those agent(s') names. */
SELECT distinct c.name, a.name
FROM orders o
INNER JOIN customers c
ON o.cid = c.cid
LEFT OUTER JOIN agents a
ON a.aid = o.aid AND a.city = c.city
WHERE a.name IS NOT NULL;


/* 6. Show the names of customers and agents living in the same city, along with the name of
the shared city, regardless of whether or not the customer has ever placed an order with that
agent. */
SELECT c.name, a.name, c.city
FROM customers c
INNER JOIN agents a
ON c.city = a.city

/* 7. Show the name and city of customers who live in the city that makes the fewest 
different kinds of products. (Hint: Use count and group by on the Products table.) */
SELECT c.name, c.city
FROM customers c
WHERE c.city IN (
	SELECT p.city 
        FROM   products p            
        GROUP BY city
        ORDER BY count(city) ASC
        LIMIT 1
        );