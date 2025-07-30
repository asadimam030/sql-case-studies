select * from order_details;
select * from orders;
select * from pizza_types;
select * from pizzas;

use pizza_sales;

/*

Advanced:
Calculate the percentage contribution of each pizza type to total revenue.
Analyze the cumulative revenue generated over time.
Determine the top 3 most ordered pizza types based on revenue for each pizza category.




*/

-- 1. Retrieve the total number of orders placed.

select * from orders;

-- 2. Calculate the total revenue generated from pizza sales.

select round(sum(pizzas.price * order_details.quantity),2) as total_sales
from pizzas
join order_details on order_details.pizza_id = pizzas.pizza_id;

-- 3. Identify the highest-priced pizza.
select pizza_types.name as name_pizza, pizzas.price as price
from pizzas
join pizza_types on pizzas.pizza_type_id = pizza_types.pizza_type_id
order by price desc
limit 1; 

-- Alternative maethod - without using top function
with cte as (
select 	
	pizza_types.name as "pizza_name", 
    cast(pizza.price as decimal(10, 2)) as "price",
rank() over (order by price desc ) as rnk
from pizzas
join pizza_types 
	on pizza_types.pizza_type_id = pizzas.pizza_type_id
)

-- 4. Identify the most common pizza size ordered.

select pizzas.size as most_common_size, sum(order_details.quantity) as quantity_orderd
from order_details
join pizzas on order_details.pizza_id = pizzas.pizza_id
group by most_common_size
order by quantity_orderd desc
limit 1;

-- 5. List the top 5 most ordered pizza types along with their quantities.

select 
	pizza_types.name as pizza_name, 
	sum(order_details.quantity) as quantity_
from order_details
join pizzas 
	on order_details.pizza_id = pizzas.pizza_id
join pizza_types
	on pizzas.pizza_type_id = pizza_types.pizza_type_id
group by pizza_types.name
order by quantity_ desc
limit 5;


-- Intermediate:

-- 6. Join the necessary tables to find the total quantity of each pizza category ordered.
select 
	pizza_types.category as category_pizza,
    sum(order_details.quantity) as quantity_cat
from pizza_types

join pizzas 
	on pizza_types.pizza_type_id = pizzas.pizza_type_id
    
join order_details
	on pizzas.pizza_id = order_details.pizza_id

group by category_pizza
order by quantity_cat desc;

-- 7. Determine the distribution of orders by hour of the day.
select 
	hour(time) as Hour_of_day, 
    count(distinct order_id) as no_of_orders
from orders
group by hour(time)
order by no_of_orders desc;

-- on the basis of time of the day
     
select 
		case 
        when hour(time) between 6 and 11 then 'MOrning'
        when hour(time) between 12 and 16 then 'Afternoon'
        when hour(time) between 17 and 20 then 'Evening'
        else 'Night'
	end as time_of_day,
    count(order_id) as no_of_orders
    from orders
    group by time_of_day
    order by no_of_orders;
    
    
   -- 8. Join relevant tables to find the category-wise distribution of pizzas.
select 
	category,  
	count(distinct pizza_type_id) as no_of_pizzas
from pizza_types
group by category;  

-- 9.  Group the orders by date and calculate the average number of pizzas ordered per day.

with cte as (
select 
	date,
    sum(quantity) as pizza_orderd
from orders
join order_details 
	on orders.order_id = order_details.order_id
group by date
)
select 
	round(avg (pizza_orderd) )as avg_no_pizza_order_pre_day 
from cte;
	

-- 10. Determine the top 3 most ordered pizza types based on revenue.

select 
	pizza_types.name as pizza_name,
	sum(pizzas.price * order_details.quantity) as revenue_of_pizza
from order_details

join pizzas 
	on order_details.pizza_id = pizzas.pizza_id

join pizza_types
	on pizzas.pizza_type_id = pizza_types.pizza_type_id
group by pizza_types.name
order by revenue_of_pizza DESC
limit 3;


-- Advanced 

-- 11. Calculate the percentage contribution of each pizza type to total revenue.


SELECT 
    pt.name AS pizza_name,
    ROUND(SUM(p.price * od.quantity), 2) AS revenue,
    ROUND((SUM(p.price * od.quantity) / 
          SUM(SUM(p.price * od.quantity)) OVER()) * 100, 2) AS revenue_percentage
FROM order_details od
JOIN pizzas p 
    ON od.pizza_id = p.pizza_id
JOIN pizza_types pt 
    ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY revenue_percentage DESC;



-- 11. Analyze the cumulative revenue generated over time.


SELECT 
    o.date,
    ROUND(SUM(p.price * od.quantity), 2) AS daily_revenue,
    ROUND(SUM(SUM(p.price * od.quantity)) 
          OVER (ORDER BY o.date ROWS UNBOUNDED PRECEDING), 2) AS cumulative_revenue
FROM orders o
JOIN order_details od 
    ON o.order_id = od.order_id
JOIN pizzas p 
    ON od.pizza_id = p.pizza_id
GROUP BY o.date
ORDER BY o.date;


-- 12. Determine the top 3 most ordered pizza types based on revenue for each pizza category.

SELECT 
    category,
    pizza_name,
    revenue
FROM (
    SELECT 
        pt.category,
        pt.name AS pizza_name,
        SUM(p.price * od.quantity) AS revenue,
        RANK() OVER (PARTITION BY pt.category ORDER BY SUM(p.price * od.quantity) DESC) AS rnk
    FROM order_details od
    JOIN pizzas p 
        ON od.pizza_id = p.pizza_id
    JOIN pizza_types pt 
        ON p.pizza_type_id = pt.pizza_type_id
    GROUP BY pt.category, pt.name
) ranked
WHERE rnk <= 3
ORDER BY category, revenue DESC;





