drop table if exists zepto;

create table zepto (
sku_id SERIAL PRIMARY KEY,
category VARCHAR(120),
name VARCHAR(150) NOT NULL,
mrp NUMERIC(8,2),
discountPercent NUMERIC(5,2),
availableQuantity INTEGER,
discountedSellingPrice NUMERIC(8,2),
weightInGms INTEGER,
outOfStock BOOLEAN,	
quantity INTEGER
);

select * from zepto;

select count(*) from zepto;

select distinct category from zepto;
select count(distinct name) from zepto;



-- Q1. Find the top 10 best-value products based on the discount percentage.

select 
	category,
	name, 
	mrp,
	discountpercent
from zepto
order by 3 desc
limit 10; 


--Q2.What are the Products with High MRP but Out of Stock

select name, mrp, outofstock
from zepto 
where outofstock = 'false'
order by 2 desc
limit 10 ;


--Q3.Calculate Estimated Revenue for each category

select 
	category,
	sum(discountpercent * mrp) as estimated_revenue
from zepto
group by 1;

-- Q5. Identify the top 5 categories offering the highest average discount percentage.

select category, 
	avg(discountpercent) as avg_discount_perc	
from zepto 
group by 1
order by 2 desc;


-- Q6. Find the price per gram for products above 100g and sort by best value.
select name,  
	weightingms,
	discountedSellingPrice,
	round((discountedsellingprice / weightingms), 2) as price_per_gram
from zepto 
where weightingms > 100
order by 4  desc;

--Q7.Group the products into categories like Low, Medium, Bulk.
select distinct name, weightingms, 
case when weightingms < 1000 then 'low'
	when weightingms < 5000 then 'medium'
	else 'bulk'
	end  as weight_category
from zepto
order by 2 desc;


--Q8.What is the Total Inventory Weight Per Category 
select 
	category, 
	sum(weightingms * availablequantity)as inventory_weight
from zepto 

group by 1
order by 2;
