-- Q.1 Coffee Consumers Count
-- How many people in each city are estimated to consume coffee, given that 25% of the population does?
select * from city;
select * from customers;
select * from products;
select * from sales;

select city_name, 
round(
(population * 0.25 )/1000000, 2) 
as cofee_consumer_in_millions,
city_rank
from city
order by 2 desc;
	
 -- -- Q.2
-- Total Revenue from Coffee Sales
-- What is the total revenue generated from coffee sales across all cities in the last quarter of 2023?

select sum(total) as total_sales 
from sales 
where 
	year(sale_date) = 2023
	and 
	quarter(sale_date) = 4;
    
select c2.city_name, sum(s.total)
from sales s
join customers c1
on s.customer_id = c1.customer_id
join city c2
on c1.city_id = c2.city_id
where 
	year(s.sale_date) = 2023
    and 
    quarter(s.sale_date) = 4
group by 1
order by 2 desc;



-- Q.3
-- Sales Count for Each Product
-- How many units of each coffee product have been sold?

select product_name, count(sale_id) as count_product
from sales s
join products p
on s.product_id = p.product_id
group by 1
order by 2 desc;

-- Q.4
-- Average Sales Amount per City
-- What is the average sales amount per customer in each city?

-- city abd total sale
-- no cx in each these city

select c2.city_name, avg(s.total)  
from sales s
join customers c1
on s.customer_id = c1.customer_id
join city c2
on c1.city_id = c2.city_id
group by 1;

select 
c2.city_name, 
sum(s.total) total_revenue,
count(distinct c1.customer_id) total_cx,
round(sum(s.total) / (count(distinct c1.customer_id) ), 2) as avg_sale_pr_cx 

from sales s 
join customers c1
on s.customer_id = c1.customer_id
join city c2
on c1.city_id = c2.city_id
group by 1
order by 2; 

-- -- Q.5
-- City Population and Coffee Consumers (25%)
-- Provide a list of cities along with their populations and estimated coffee consumers.
-- return city_name, total current cx, estimated coffee consumers (25%)

with city_table as
(
select city_name, round((population * 0.25) / 1000000 , 2) as coffee_consumers
from city
),
customers_table 
as 
(

select c2.city_name, count( distinct c1.customer_id) as unique_cx
from sales s
join customers c1
on c1.customer_id = s.customer_id
join city c2
on c2.city_id = c1.city_id 
group by 1
)
select 
customers_table.city_name, 
city_table.coffee_consumers as cofee_consumers_million, 
customers_table.unique_cx
from city_table
join customers_table
on city_table.city_name = customers_table.city_name;

-- -- Q6
-- Top Selling Products by City
-- What are the top 3 selling products in each city based on sales volume?

select * 
from 
(
	select 
		c2.city_name, 
		p.product_name, 
		count(s.sale_id) as total_prodcts,
		dense_rank() over( partition by  c2.city_name order by count(s.sale_id) desc) as rank_
	from products p
	join sales s
	on p.product_id = s.product_id
	join customers c1
	on c1.customer_id = s.customer_id 
	join city c2
	on c2.city_id = c1.city_id
	group by 1, 2
-- order by 1, 3
) as t1
where rank_ <= 3;


-- Q.7
-- Customer Segmentation by City
-- How many unique customers are there in each city who have purchased coffee products?
select c2.city_name,  count(c1.customer_id)
from customers c1
join city c2
on c1.city_id = c2.city_id
group by 1
order by 1;

-- -- Q.8
-- Average Sale vs Rent
-- Find each city and their average sale per customer and avg rent per customer

with city_table
as
(
select 
	c2.city_name, 
	sum(s.total) as total_revenue,
    count(distinct c1.customer_id) as total_cx,
    round( (sum(s.total) /  count(distinct c1.customer_id)), 2 ) as avg_sale_per_cx
from sales s 
join customers c1
on s.customer_id = c1.customer_id
join city c2
on c2.city_id = c1.city_id
group by 1
order by 2 desc
),

city_rent
as
(select 
	city_name, 
    estimated_rent
from city
)

select 
	cr.city_name,
    cr.estimated_rent,
    ct.total_cx,
    ct.avg_sale_per_cx,
    round(cr.estimated_rent / ct.total_cx , 2) as avg_rent_per_cx
    
    from city_table ct
    join city_rent cr
    on cr.city_name = ct.city_name
    order by 4 desc;


-- Q.9
-- Monthly Sales Growth
-- Sales growth rate: Calculate the percentage growth (or decline) in sales over different time periods (monthly)
-- by each city   
with 
monthly_sale
as (
select 
	c2.city_name, 
    month(s.sale_date) as month,
    year(s.sale_date) as year,
	sum(s.total) as total_sale
    
from sales s
join customers c1
on c1.customer_id = s.customer_id
join city c2
on c1.city_id  = c2.city_id
group by 1, 2, 3
order by 1, 3, 2
),
growth_ratio
as
(
select 	
	city_name, 
    month,
    year,
    total_sale as cr_month_sale,
    lag(total_sale, 1) over(partition by city_name order by year, month) as last_mnth_sale
from monthly_sale
)
select 
	city_name, 
    month, 
    year,  
    cr_month_sale, 
    last_mnth_sale,
    round((cr_month_sale - last_mnth_sale) / last_mnth_sale * 100 , 2 ) as growth_ratio
from growth_ratio
where last_mnth_sale is not null;



-- Q.10
-- Market Potential Analysis
-- Identify top 3 city based on highest sales, return city name, total sale, total rent, total customers, estimated coffee consumer
with
city_table
as (
select 
	c2.city_name, 
	sum(s.total) as total_revenue, 
	count(distinct c1.customer_id) as  total_cx,
	round( sum(s.total) /  count(distinct c1.customer_id), 2) as avg_sale_pr_cx

from products p 
join sales s
on s.product_id = p.product_id
join customers c1
on c1.customer_id = s.customer_id
join city c2
on c2.city_id = c1.city_id 
group by 1
order by 2 desc
),

city_rent
as
(
select city_name,
	estimated_rent,
    
    round((population * 0.25)/ 1000000, 3)as estimated_cofee_consmers_in_millions
from city
)
select 
	cr.city_name,
    total_revenue,
    cr.estimated_rent as total_rent,
    ct.total_cx,
    estimated_cofee_consmers_in_millions,
    ct.avg_sale_pr_cx,
	round( cr.estimated_rent / ct.total_cx, 2) as avg_rent_per_cx
    
from city_table ct
join  city_rent cr
on ct.city_name = cr.city_name
order by 2 desc;
    
/*
-- Recomendation
City 1: Pune
	1.Average rent per customer is very low.
	2.Highest total revenue.
	3.Average sales per customer is also high.

City 2: Delhi
	1.Highest estimated coffee consumers at 7.7 million.
	2.Highest total number of customers, which is 68.
	3.Average rent per customer is 330 (still under 500).

City 3: Jaipur
	1.Highest number of customers, which is 69.
	2.Average rent per customer is very low at 156.
	3.Average sales per customer is better at 11.6k.
    */