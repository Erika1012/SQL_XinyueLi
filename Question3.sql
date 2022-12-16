-- Question #3 
-- Merge these two datasets so we can see 
-- impressions, clicks, and revenue together by date and geo. 
-- Please ensure all records from each table are accounted for.​

-- Here I use substring to extract geo information for store_revenue table
-- MySQL don't have full outer join, use left join and union instead
(SELECT md.date AS marketDate, sr.date AS revenueDate, 
	    md.geo, sr.store_location, md.impressions, 
	    md.clicks, sr.revenue, sr.brand_id
 FROM store_revenue sr
 LEFT OUTER JOIN marketing_data md
 ON md.geo = SUBSTRING(sr.store_location, 15, 2)
 AND md.date = sr.date)
UNION
(SELECT md.date AS marketDate, sr.date AS revenueDate, 
	    md.geo, sr.store_location, md.impressions, 
	    md.clicks, sr.revenue, sr.brand_id
 FROM marketing_data md
 LEFT OUTER JOIN store_revenue sr
 ON md.geo = SUBSTRING(sr.store_location, 15, 2)
 AND md.date = sr.date);
