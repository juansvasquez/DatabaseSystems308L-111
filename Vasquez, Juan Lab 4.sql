--Juan S. Vasquez
--2/15/2016
--Lab 4: The Subqueries Sequel

--1. Get the cities of agents booking an order for a customer whose cid is 'c002'.
SELECT city
FROM agents
WHERE aid IN (
	SELECT aid
	FROM orders
	WHERE cid = 'c002'
)
;

/* 2. Get the ids of products ordered through any agent who takes at least
one order from a customer in Dallas, sorted by pid from highest to lowest.
(This is not the same as asking for ids of products ordered by customers in Dallas.) */
SELECT distinct pid
FROM orders
WHERE aid IN (
	SELECT aid
	FROM orders
	WHERE cid in (
		SELECT cid
		FROM customers
		WHERE city = 'Dallas'
	)
)
ORDER BY pid DESC;

--3. Get the ids and names of customers who did not place an order through agent a01.
SELECT cid, name
FROM customers
WHERE cid NOT IN (
	SELECT cid
	FROM orders
	WHERE aid = 'a01'
)
;

--4. Get the ids of customers who ordered both product p01 and p07.
SELECT distinct cid
FROM orders
WHERE pid = 'p01'
AND cid IN (
	SELECT cid
	FROM orders
	WHERE pid = 'p07'
)  
;

/* 5. Get the ids of products not ordered by any customers who placed any order 
through agent a07 in pid order from highest to lowest. */
SELECT distinct pid
FROM orders
WHERE pid NOT IN (
	SELECT pid
	FROM orders
	WHERE aid = 'a07'
)
ORDER BY pid DESC;

/* 6. Get the name, discounts, and city for all customers who place orders 
through agents in London or New York. */
SELECT name, discount, city
FROM customers
WHERE cid IN (
	SELECT cid
	FROM orders
	WHERE aid IN(
		SELECT aid
		FROM agents
		WHERE city IN ('London', 'New York')
	)
)
;

--7. Get all customers who have the same discount as that of any customers in Dallas or	London.
SELECT *
FROM customers
WHERE discount IN(
	SELECT discount
	FROM customers
	WHERE city IN ('Dallas', 'London')
)

/*
8. Tell me about check constraints: What are they? What are they good for? 
What’s the advantage of putting that sort of thing inside the database? 
Make up	some examples of good uses of check constraints and some examples of 
bad uses of check constraints. Explain the differences in your examples and argue your case.

Check constraints are used to limit the value range that can be placed in a column. The advantage
to putting check constraints inside of the database is that you can specify what kind of requirement
you want each row to meet. Good constraints are concise and help keep data simple, while bad constraints
are unnecessary and can slow the database down, or are too complicated. Another example of a bad
constraint could be one that does not allow for future expansion and can become outdated eventually,
of the database's requirements change.
*/