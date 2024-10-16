SELECT * FROM walmart_sales.`walmartsalesdata.csv`;

-- feature engineering--
-- time_of_day

select time,
case
  when `time` between '00:00:00' and '12:00:00' then 'MORNING'
  when `time` between '12:01:00' and '16:00:00' then 'AFTERNOON'
  else 'EVENING'
end as time_of_date
from `walmartsalesdata.csv`;

alter table `walmartsalesdata.csv`
add column time_of_date varchar(20);

update `walmartsalesdata.csv`
set time_of_date = (case
  when `time` between '00:00:00' and '12:00:00' then 'MORNING'
  when `time` between '12:01:00' and '16:00:00' then 'AFTERNOON'
  else 'EVENING'
end);

-- day_name--

select date, dayname(date)
from `walmartsalesdata.csv`;

alter table `walmartsalesdata.csv`
add column day_name varchar(20);

update `walmartsalesdata.csv`
set day_name = dayname(date)
;

-- month_name--

select date, monthname(date)
from `walmartsalesdata.csv`;

alter table `walmartsalesdata.csv`
add column month_name varchar(30);

update `walmartsalesdata.csv`
set month_name = monthname(date);

-- generic--

-- 1.How many unique product lines does the data have?
select distinct city
from `walmartsalesdata.csv`;

-- 2.In which city is each branch?
select distinct branch
from `walmartsalesdata.csv`;

select 
distinct city,
branch
from `walmartsalesdata.csv`;

-- product--
-- 1. How many unique product lines does the data have?
SELECT count(distinct `Product line`) FROM `walmart_sales`.`walmartsalesdata.csv`;

-- 2. What is the most common payment method?
select payment, count(payment) as cnt
from `walmartsalesdata.csv`
group by payment
order by cnt desc;

-- 3. What is the most selling product line?
select `product line`, count(`product line`) as cnt
from `walmartsalesdata.csv`
group by `product line`
order by cnt desc;

-- 4. What is the total revenue by month?
select month_name as month,
sum(total) as total_revenue
from `walmartsalesdata.csv`
group by month_name
order by total_revenue desc;

-- 5. What month had the largest COGS?
select  sum(cogs) as cogs, month_name
from `walmartsalesdata.csv`
group by month_name
order by cogs desc;

-- 6.What product line had the largest revenue?
select  sum(total) as total_revenue, `product line`
from `walmartsalesdata.csv`
group by `product line`
order by total_revenue desc;

-- 7. What is the city with the largest revenue?
select  sum(total) as total_revenue, city
from `walmartsalesdata.csv`
group by city
order by total_revenue desc;

-- 8. What product line had the largest VAT?
select `product line`,
avg(`Tax 5%`) as avg_tax
from `walmartsalesdata.csv`
group by `product line`
order by avg_tax desc;

-- 9. Which branch sold more products than average product sold?
select branch, sum(quantity) as qty
from `walmartsalesdata.csv`
group by branch
having sum(quantity) > (select avg(quantity) from `walmartsalesdata.csv`);

-- 10. What is the most common product line by gender?
select gender, `product line`, count(gender) as total_cnt
from `walmartsalesdata.csv`
group by gender, `product line`
order by total_cnt desc;

-- 11. What is the average rating of each product line?
select `product line`, avg(rating)
from `walmartsalesdata.csv`
group by `product line`;

-- sales--
-- 1. Number of sales made in each time of the day per weekday?
select time_of_date, count(*) as total_sales
from `walmartsalesdata.csv`
group by time_of_date;

-- 2. Which of the customer types brings the most revenue?
select `customer type` , sum(total) as total_revenue
from `walmartsalesdata.csv`
group by `customer type`
order by total_revenue desc;

-- 3. Which city has the largest tax percent/ VAT (Value Added Tax)?
select city, avg(`tax 5%`)
from `walmartsalesdata.csv`
group by city
order by avg(`tax 5%`) desc;

-- 4. Which customer type pays the most in VAT?
select `customer type`, avg(`tax 5%`)
from `walmartsalesdata.csv`
group by `customer type`
order by avg(`tax 5%`) desc;

-- customer--
-- 1. How many unique customer types does the data have?
select distinct `customer type`
from `walmartsalesdata.csv`
;

-- 2. How many unique payment methods does the data have?
select distinct payment  
from `walmartsalesdata.csv`;

-- 3. What is the most common customer type?
select distinct `customer type`, count(`customer type`)
from `walmartsalesdata.csv`
group by `customer type`;

-- 4. Which customer type buys the most?
select `customer type`, count(*) as cstm_cnt
from `walmartsalesdata.csv`
group by `customer type`
order  by cstm_cnt desc;

-- 5. What is the gender of most of the customers?
select gender,  count(*)
from `walmartsalesdata.csv`
group by gender;

-- 6. What is the gender distribution per branch?
select gender,  count(*)
from `walmartsalesdata.csv`
where branch = 'C'
group by gender;

-- 7. Which time of the day do customers give most ratings?
select time_of_date, avg(rating) as avg_rating
from `walmartsalesdata.csv`
group by time_of_date
order by avg_rating desc;

-- 8. Which time of the day do customers give most ratings per branch?
select time_of_date, avg(rating) as avg_rating, branch 
from `walmartsalesdata.csv`
where branch = 'c'
group by time_of_date
order by avg_rating desc;

-- 9. Which day of the week has the best avg ratings?
select day_name, avg(rating) as avg_rating 
from `walmartsalesdata.csv`
group by day_name
order by avg_rating desc;

-- 10. Which day of the week has the best average ratings per branch?
select day_name, avg(rating) as avg_rating, branch 
from `walmartsalesdata.csv`
where branch = 'c'
group by day_name
order by avg_rating desc;
