create database Walmart;

create table W_sales 
(invoice_id varchar(30) not null primary key, 
branch varchar(5) not null, 
city varchar(30) not null,  
customer_type varchar(30) not null, 
gender varchar(30) not null, 
product_line varchar(100) not null,
unit_price decimal (10,2) not null, 
quantity int not null, 
tax_pct float(6,4) not null, 
total decimal (12,4) not null, 
date datetime not null, 
time time not null, 
payment varchar (20) not null, 
cogs decimal (10,2) not null, 
gross_margin_pct float (11,9), 
gross_income decimal (12,4), 
rating float(2,1));










