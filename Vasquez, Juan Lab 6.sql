--Juan S. Vasquez
--2/27/2016
--Lab 6: Interesting and Painful Queries

/* 1. Display the name and city of customers who live in any city that makes the most different
kinds of products. (There are two cities that make the most different products. Return the name
and city of customers from either one of those.)*/
SELECT c.name, c.city
FROM customers c
WHERE c.city IN (
	SELECT p.city 
        FROM   products p            
        GROUP BY city
        ORDER BY count(city) DESC
        LIMIT 1
        );
 
/* 2. Display the names of products whose priceUSD is strictly above the average priceUSD, in
reverse-alphabetical order.*/
SELECT p1.name
FROM products p1
WHERE p1.priceUSD > (
		SELECT AVG(p2.priceUSD)
		FROM products p2
		)
ORDER BY p1.name DESC;

/* 3. Display the customer name, pid ordered, and the total for all orders, sorted by total
from high to low.*/
SELECT c.name, o.pid, o.totalUSD
FROM orders o
INNER JOIN customers c
ON o.cid = c.cid
ORDER BY o.totalUSD DESC;

/* 4. Display all customer names (in alphabetical order) and their total ordered, and nothing
more. Use coalesce to avoid showing NULLs.*/
SELECT c.name, COALESCE(SUM(o.totalUSD), 0) AS totalOrdered
FROM orders o
FULL OUTER JOIN customers c
ON o.cid = c.cid
GROUP BY c.name
ORDER BY c.name;

/* 5. Display the names of all customers who bought products from agents based in Tokyo along
with the names of the products they ordered, and the names of the agents who sold it to them.*/
SELECT c.name, p.name, a.name
FROM orders o
INNER JOIN agents a
ON o.aid = a.aid 
AND a.city = 'Tokyo'
INNER JOIN customers c
ON o.cid = c.cid
INNER JOIN products p
ON o.pid = p.pid;

/* 6. Write a query to check the accuracy of the dollars column in the Orders table. This
means calculating Orders.totalUSD from data in other tables and comparing those values to the
values in Orders.totalUSD. Display all rows in Orders where Orders.totalUSD is incorrect, if
any.*/
SELECT o.ordnum, o.mon, o.cid, o.aid, o.pid, o.qty, o.totalUSD, r.recalc
FROM orders o
INNER JOIN (
	SELECT o.ordnum , ((p.priceUSD * o.qty ) - ((p.priceUSD * o.qty )* (c.discount / 100)))
	AS recalc
	FROM orders o, customers c, agents a, products p
	WHERE o.cid = c.cid 
	AND o.aid = a.aid 
	AND o.pid = p.pid
	)
	AS r
ON o.ordnum = r.ordnum
WHERE o.totalUSD != r.recalc;

/*7. What’s the difference between a LEFT OUTER JOIN and a RIGHT OUTER JOIN? Give example
queries in SQL to demonstrate. (Feel free to use the CAP3 database to make your points here.)

So we already know the difference between an INNER JOIN and an OUTER JOIN; an INNER JOIN
gives the result of A intersect B, and an OUTER JOIN gives the result of A union B. If we
think of this in terms of a Venn diagram, an INNER JOIN would give you the inner part of
the diagram, using the parameters you give it to determine what to base the commonality on.
An OUTER JOIN, on the other hand, would be the outer parts of the Venn diagram. Because
there are multiple parts, this now gives us three options for the outer joins: LEFT OUTER
JOIN, RIGHT OUTER JOIN, and FULL OUTER JOIN.

If we use the CAP 3 table in our example, we can take a look at the customers and orders
tables. This is what happens if we use a LEFT OUTER JOIN:
*/
SELECT *
FROM orders o
LEFT OUTER JOIN customers c
ON c.cid = o.cid;
/*
As we can see in the results, a LEFT OUTER JOIN will give all the rows in orders and any
common rows in customers. Any rows from customers that are not matchable with a row in orders
are not shown. If the 'left' table (in the first example, orders) had a row that could not be
matched with a row from the 'right' table (in the first example, customers), then it would 
appear as null, like so:
*/
SELECT *
FROM customers c
LEFT OUTER JOIN orders o
ON c.cid = o.cid;
/*
Obviously, in this example, we have switched the tables around so that we can see what null
looks like. If we take the first example and apply the RIGHT OUTER JOIN to it, then we will
get a flipped version of the second example:
*/
SELECT *
FROM orders o
RIGHT OUTER JOIN customers c
ON c.cid = o.cid;
/* 
RIGHT OUTER JOIN shows all rows in the 'right' table (in this example, orders), and all rows
in the 'left' are also shown, even the ones without matches. These examples help to
illustrate the differences between RIGHT OUTER JOIN and LEFT OUTER JOIN.
*/