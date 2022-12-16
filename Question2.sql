-- Question #2 
-- Generate a query to gather the sum of revenue 
-- by store_location from the store_revenue table​

SELECT store_location, SUM(revenue) AS revenueSum
FROM store_revenue
GROUP BY store_location;