# SQL Challenge

The database contains two tables, store_revenue and marketing_data.  Refer to the two CSV
files, store_revenue and marketing_data to understand how these tables have been created.

store_revenue contains revenue by date, brand ID, and location:

 >  create table store_revenue (
 >     id int not null primary key auto_increment,
 >    date datetime,
 >    brand_id int,
 >    store_location varchar(250),
 >    revenue float  
 >  );

marketing_data contains ad impression and click data by date and location:

> create table marketing_data (
>  id int not null primary key auto_increment,
>  date datetime,
>  geo varchar(2),
>  impressions float,
>  clicks float
> );

### Please provide a SQL statement under each question.

* Question #0 (Already done for you as an example)
 Select the first 2 rows from the marketing data

>  select *
>  from marketing_data
> limit 2;

*  Question #1
 Generate a query to get the sum of the clicks of the marketing data
 ```
SELECT SUM(clicks) AS clickSum
FROM marketing_data;
```

*  Question #2
 Generate a query to gather the sum of revenue by store_location from the store_revenue table
 ```
SELECT store_location, SUM(revenue) AS revenueSum
FROM store_revenue
GROUP BY store_location;
```

*  Question #3
 Merge these two datasets so we can see impressions, clicks, and revenue together by date
and geo.
 Please ensure all records from each table are accounted for.

Here I use substring to extract geo information for store_revenue table.
MySQL don't have full outer join, use left join and union instead
```
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
```
* Question #4
 In your opinion, what is the most efficient store and why?

Here, I utilize the revenue per click to represent the efficiency for each store. This metric is calculated using the sum of the revenue for each store divided by the sum of the clicks for each store. From the output we could see that a store in CA for brand 2 has the biggest revenue per click, as a result, in my opinion, the store with brand 2 in United States-CA is the most efficient store.
```
SELECT sr.brand_id, sr.store_location, SUM(sr.revenue)/SUM(md.clicks) AS revenuePerClick
FROM store_revenue sr
INNER JOIN marketing_data md
ON md.geo = SUBSTRING(sr.store_location, 15, 2)
AND md.date = sr.date
GROUP BY sr.brand_id, sr.store_location
Order By revenuePerClick DESC;
```
* Question #5 (Challenge)
 Generate a query to rank in order the top 10 revenue producing states
 ```
SELECT store_location, SUM(revenue) AS revenueSum
FROM store_revenue
GROUP BY store_location
ORDER BY revenueSum DESC
LIMIT 10;
```
As there are only 3 states in this dataset, the sql code could be applied to a larger dataset.
