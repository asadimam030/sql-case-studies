create database retail_sales_analysis;

drop table if exists retail_sales_analysis.retail_sales;
create table retail_sales_analysis.retail_sales(
	transactions_id int primary key,
	sale_date date,
	sale_time time,
	customer_id int,
	gender varchar(15),
	age int,
	category varchar(15) ,
	quantiy int,
	price_per_unit float ,
	cogs float,
	total_sale float
);

select * from retail_sales;

select * from retail_sales
limit 10;

select count(*) from retail_sales;

-- 
select * from retail_sales
where transactions_id is null;

select * from retail_sales
where sale_date is null;

select * from retail_sales
where sale_time is null;

select * from retail_sales
where
	transactions_id is null
    or
    sale_date is null
    or
    sale_time is null
        or 
    gender is null
    or 
    category is null
    or 
    cogs is null
    or
    total_sale is null;
    
-- 
delete from retail_sales
where 
	transactions_id is null
    or
    sale_date is null
    or
    sale_time is null
        or 
    gender is null
    or 
    category is null
    or 
    cogs is null
    or
    total_sale is null;
    
-- Data Exploration 
    
-- How many sales we have?
select count(*) as total_sales from retail_sales;

-- hOW MANY unique CUSTOMERS WE HAVE?
select count(distinct customer_id)  as total_sales from retail_sales;

-- How many categories we have? 
select count(distinct(category)) as count_category from retail_sales;
select distinct(category)as unique_category from retail_sales;

-- Data Analysis & Buisness key problems 

/*









Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
*/



-- 1.Write a SQL query to retrieve all columns for sales made on '2022-11-05' 
select * from retail_sales
where sale_date = '2022-11-05';  

-- 2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

select * from retail_sales
where 
	category = "Clothing" 
	and
    DATE_FORMAT(sale_date, '%Y-%m') = '2022-11' 
    and
    quantiy >= 4;
    
-- 3. Write a SQL query to calculate the total sales (total_sale) for each category.:
select category, sum(total_sale), count(quantiy) from retail_sales
group by category;

-- 4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
select category, round(avg(age), 2) from retail_sales
group by category
having category = "Beauty";

-- 5. Write a SQL query to find all transactions where the total_sale is greater than 1000.:
select transactions_id, total_sale from retail_sales
where total_sale > 1000;

-- 6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
select category, gender,  count(transactions_id) as total_transaction 
from 
retail_sales
group by category, gender
order by category;

-- 7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

select date_format(sale_date, '%Y-%m') as date_ , sum(total_sale) as total_sale
from retail_sales
group by date_ 
order by total_sale desc;



-- 8. Write a SQL query to find the top 5 customers based on the highest total sales **

select customer_id, sum(total_sale) as total_sale
from retail_sales
group by customer_id
order by total_sale desc
limit 5;

-- 9. Write a SQL query to find the number of unique customers who purchased items from each category.:
select count(distinct customer_id), category 
from retail_sales
group by category;

-- 10. 
