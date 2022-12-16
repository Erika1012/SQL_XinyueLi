-- Question #5 (Challenge) 
-- Generate a query to rank in order 
-- the top 10 revenue producing states​

SELECT store_location, SUM(revenue) AS revenueSum
FROM store_revenue
GROUP BY store_location
ORDER BY revenueSum DESC
LIMIT 10;