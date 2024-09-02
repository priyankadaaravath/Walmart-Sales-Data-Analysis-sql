SELECT * FROM walmart.w_sales;  

#FEATURE_ENGINEERING  
select time,
(Case 
when 'time' between '00:00:00' and '12:00:00' then 'Morning'
when 'time' between '12:01:00' and '16:00:00' then 'Afternoon'
else 'Evening'
end ) as time_of_date
 from walmart.w_sales;    
 
 SHOW COLUMNS FROM walmart.w_sales; 
 ALTER TABLE walmart.w_sales ADD COLUMN time_of_day VARCHAR(20);

-- Run your UPDATE query
 update walmart.w_sales 
 set time_of_day = (Case 
when 'time' between '00:00:00' and '12:00:00' then 'Morning'
when 'time' between '12:01:00' and "16:00:00" then 'Afternoon'
else 'Evening'
end );  

#DAY_NAME 
select date, dayname(date)  
from walmart.w_sales 

alter table walmart.w_sales modify column day_name varchar(10);   
update walmart.w_sales set day_name= dayname(date); 

UPDATE walmart.w_sales 
SET date = STR_TO_DATE(date, '%d-%m-%Y') 
WHERE date REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{4}$'; 
UPDATE walmart.w_sales 
SET day_name = DAYNAME(date); 

#MONTH_NAME 
select date, 
monthname(date) from walmart.w_sales; 

alter table walmart.w_sales add column month_name varchar(10);
 
 update walmart.w_sales  
 set month_name= monthname(date);

#GENERIC QUESTIONS 
#How many unique cities does the data have? 
select distinct city from walmart.w_sales; 

# In which city each branch? 
select distinct city, branch from walmart.w_sales; 
 
 #PRODUCT 
 #1. How many unique products lines does the data have? 
 select count(distinct product_line) from walmart.w_sales; 
 
#2. what is the most common payment method?  
select payment, count(payment) from walmart.w_sales group by payment;  

#3. what is the most selling product line? 
select product_line, count(product_line) as cnt 
from walmart.w_sales group by product_line 
order by cnt desc; 
 
#4. What is the total revenue by month? 
select month_name as month, 
sum(total) as total_revenue 
from walmart.w_sales group by month_name order by total_revenue desc;

#5. what month had the largest COGS? 
select month_name as month, 
sum(cogs) as cogs from walmart.w_sales 
group by month_name order by cogs desc; 

#6.what product line had the largest revenue? 
select product_line, 
sum(total) as total_revenue from walmart.w_sales 
group by product_line order by total_revenue desc; 

#7.what is the city with the largest revenue? 
select branch, city, sum(total) as total_revenue 
from walmart.w_sales group by city, branch
order by total_revenue desc; 

#8.what product line had the largest VAT? 
select product_line, avg(VAT) as avg_tax 
from walmart.w_sales group by product_line 
order by avg_tax desc; 

#9.Fetch each product line and add a column to those product line showing "Good",
#"Bad". Good if its greater than average sales 
select avg(quantity) as avg_qnty from walmart.w_sales; 
select product_line, 
case 
when avg(quantity) > 6 then "Good" else "Bad" 
end 
as remark from walmart.w_sales group by product_line; 

#10.Which branch sold more products than average product sold? 
select branch, sum(quantity) as qnty from walmart.w_sales
group by branch having sum(quantity)> (select avg(quantity) from walmart.w_sales); 

#11.What is the most common product line by gender? 
select gender, product_line, count(gender) as total_cnt 
from walmart.w_sales group by gender, product_line 
order by total_cnt desc;

#12.What is the average rating of each product line? 
select round(avg(rating),2) as avg_rate,  
product_line from walmart.w_sales 
group by product_line order by avg_rate desc; 
 
 #SALES 
 #1. Number of sales made in each time of the day per weekday 
 select time_of_day,
 count(*) as total_sales  
 from walmart.w_sales where day_name= "Sunday"  
 group by time_of_day order by total_sales desc;  
 
 #2. Which of the customer types brings the most revenue? 
 select customer_type, sum(total) as total_revenue from walmart.w_sales 
 group by customer_type order by total_revenue;
 
 #3. Which city has the largest tax percent/ VAT (Value Added Tax)? 
 select city, round(avg(VAT), 2) as avg_tax 
 from walmart.w_sales group by city order by avg_tax desc;
 
 #4. Which customer type pays the most in VAT? 
 select customer_type,  
 avg(VAT) as total_tax from walmart.w_sales 
 group by customer_type order by total_tax; 
 
 #CUSTOMER 
 #1. How many unique customer types does the data have? 
 select distinct customer_type from walmart.w_sales; 
 
 #2. How many unique payment methods does the data have? 
 select distinct payment from walmart.w_sales;  
 
 #3. What is the most common customer type? 
 select customer_type, count(*) as count from walmart.w_sales 
 group by customer_type order by count desc; 
 
 #4. Which customer type buys the most? 
 select customer_type, count(*) from walmart.w_sales 
 group by customer_type;
 
 #5. What is the gender of most of the customers? 
 select gender, count(*) as gdr_cnt from walmart.w_sales  group by gender  
 order by gdr_cnt desc; 
 
 #6. What is the gender distribution per branch? 
 select gender, count(*) from walmart.w_sales where branch= "C" group by gender 
 order by gender desc; 
  select gender, count(*) from walmart.w_sales where branch= "A" group by gender 
 order by gender desc; 
  select gender, count(*) from walmart.w_sales where branch= "B" group by gender 
 order by gender desc;
 
 #7. Which time of the day do customers give most ratings? 
 select time_of_day, avg(rating) as avg_rate from walmart.w_sales 
 group by time_of_day order by avg_rate desc; 
 
 #8. Which time of the day do customers give most ratings per branch? 
 select time_of_day, avg(rating) as avg_rate from walmart.w_sales 
 where branch= "A" group by time_of_day order by avg_rate desc; 
 
  select time_of_day, avg(rating) as avg_rate from walmart.w_sales 
 where branch= "B" group by time_of_day order by avg_rate desc; 
 
  select time_of_day, avg(rating) as avg_rate from walmart.w_sales 
 where branch= "C" group by time_of_day order by avg_rate desc; 
 
 #9. Which day fo the week has the best avg ratings? 
 select day_name, avg(rating) as avg_rate from walmart.w_sales  
 group by day_name order by avg_rate desc; 
 
 #10.Which day of the week has the best average ratings per branch? 
 select day_name, count(day_name) total_Sales 
 from walmart.w_sales where branch= "A" group by day_name order by total_Sales desc;
 
  select day_name, count(day_name) total_Sales 
 from walmart.w_sales where branch= "B" group by day_name order by total_Sales desc; 
 
  select day_name, count(day_name) total_Sales 
 from walmart.w_sales where branch= "C" group by day_name order by total_Sales desc;
 
 
 
 
 
 
 
 
 
 
 
 
 
 
  
  
  
  
  

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 















