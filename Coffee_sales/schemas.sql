create database cofeeSales;
use cofeeSales;

drop table if exists city;
drop table if exists customers;
drop table if exists products;
drop table if exists sales;

create table city (
city_id int primary key,
city_name varchar(20),
population bigint,	
estimated_rent float, 
city_rank int
);


create table customers (
customer_id	int primary key,
customer_name varchar(20),
city_id int,
CONSTRAINT fk_city FOREIGN KEY (city_id) REFERENCES city(city_id)
);

create table products (
product_id int primary key,
product_name varchar(100),
price float
);

create table sales (
sale_id	int primary key, 
sale_date date,
product_id	int,
customer_id int,	
total float,
rating int,
constraint fk_products foreign key (product_id) references products(product_id),
constraint fk_customers foreign key (customer_id) references customers(customer_id)
); 

