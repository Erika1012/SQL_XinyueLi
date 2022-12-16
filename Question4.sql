-- Question #4 
-- In your opinion, what is the most efficient store and why?​

-- Here, I utilize the revenue per click to represent 
-- the efficiency for each store. This metric is calculated 
-- using the sum of the revenue for each store divided 
-- by the sum of the clicks for each store. From the output we 
-- could see that a store in CA for brand 2 has the biggest 
-- revenue per click, as a result, in my opinion, 
-- the store with brand 2 in United States-CA is the most efficient store.
SELECT sr.brand_id, sr.store_location, SUM(sr.revenue)/SUM(md.clicks) AS revenuePerClick
FROM store_revenue sr
INNER JOIN marketing_data md
ON md.geo = SUBSTRING(sr.store_location, 15, 2)
AND md.date = sr.date
GROUP BY sr.brand_id, sr.store_location
Order By revenuePerClick DESC;

 