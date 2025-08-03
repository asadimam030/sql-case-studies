create database pizza_sales;

drop table if exists pizza_sales.orders;
create table pizza_sales.orders
	(
    order_id int, 
    date date, 
    time time
    );
alter table orders 
add constraint pk_orders primary key (order_id);

use pizza_sales;
drop table if exists order_details;
create table order_details 
	(
    order_details_id int primary key,
	order_id int,
	pizza_id varchar (25),
	quantity int
    );
    
drop table if exists pizzas;
create table pizzas 
	(
    pizza_id varchar(25) primary key,
	pizza_type_id varchar(25),
	size varchar (10),
	price float
    );
    
drop table if exists pizza_types;
create table pizza_types
	(
    pizza_type_id varchar(25) primary key,
	name varchar(55),
	category varchar(15),
	ingredients varchar(100)
    );
    
alter table order_details
add constraint fk_orderdetails_orders
foreign key (order_id) references orders(order_id);

alter table order_details
add constraint fk_orderdetails_pizzas
foreign key (pizza_id) references pizzas(pizza_id);

alter table pizzas
add constraint fk_pizzas_pizzastypes
foreign key (pizza_type_id) references pizza_types(pizza_type_id);
